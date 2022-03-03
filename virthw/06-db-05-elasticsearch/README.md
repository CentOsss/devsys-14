# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```
FROM centos:7

RUN groupadd elasticsearch && \
         useradd -g elasticsearch elasticsearch

RUN yum install wget -y && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        mkdir /usr/share/elasticsearch/ /var/lib/logs /var/lib/data && \
        tar -xf elasticsearch-8.0.1-linux-x86_64.tar.gz -C /usr/share/elasticsearch --strip-components 1 && \
        rm -f elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
        chown elasticsearch:elasticsearch /var/lib/data /var/lib/logs

EXPOSE 9200/tcp 9300/tcp

USER elasticsearch

ENV PATH=/usr/share/elasticsearch/bin:$PATH

COPY . /usr/share/elasticsearch/config/

WORKDIR /usr/share/elasticsearch/bin

CMD ["elasticsearch"]
```
- ссылку на образ в репозитории dockerhub
```
https://hub.docker.com/repository/docker/nordit/elasticsearch
```
- ответ `elasticsearch` на запрос пути `/` в json виде

```
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "BljPd-uxQ8CuUqGPtqgV5Q",
  "version" : {
    "number" : "8.0.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "801d9ccc7c2ee0f2cb121bbe22ab5af77a902372",
    "build_date" : "2022-02-24T13:55:40.601285296Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}

```

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

```
curl -u elastic -k -X PUT https://localhost:9200/ind-3 -H 'Content-Type: application/json' -d '{"settings": {"number_of_shards": 4, "number_of_replicas": 2 } }'
```

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

```
curl -k -u elastic -X GET 'https://localhost:9200/_cat/indices?v'

health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 arTBp5-QRmO_bmee4z9wbg   1   0          0            0       225b           225b
yellow open   ind-3 JpaB3hCbQ8Cp8V6R3e2hAg   4   2          0            0       900b           900b
yellow open   ind-2 hAOEGgqFRNqncGZOy5aIpg   2   1          0            0       450b           450b
```
```
[root@ORO ~]# curl -u elastic -k -X GET 'https://localhost:9200/_cluster/health/ind-1?pretty'
Enter host password for user 'elastic':
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```
```
root@ORO ~]# curl -u elastic -k -X GET 'https://localhost:9200/_cluster/health/ind-2?pretty'
Enter host password for user 'elastic':
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
```
[root@ORO ~]# curl -u elastic -k -X GET 'https://localhost:9200/_cluster/health/ind-3?pretty'
Enter host password for user 'elastic':
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}

```

Получите состояние кластера `elasticsearch`, используя API.

```
[root@ORO ~]# curl -k -u elastic -X GET https://localhost:9200/_cluster/health/?pretty
Enter host password for user 'elastic':
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}

```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```
В данной конфигурации мы имеем всего лишь одну ноду в кластере. Шарды ind-2, ind-3 индексов не реплицированы и находятся в состоянии 
в состоянии unassigned. При добавлении в кластер второй ноды и реплицировании шардов на нее статус кластера изменится на зеленый.
```

Удалите все индексы.

```
curl -k -u elastic -X DELETE https://localhost:9200/ind-1
```
**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
