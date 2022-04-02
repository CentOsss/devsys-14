# devpy14
complete task from Astra

Частично Общая схема выглядит так:

 ![image](https://user-images.githubusercontent.com/44666536/151700230-3ddcfe4b-5d85-497c-bae5-a1e34ad4e36a.png)
           
В качестве площадки для разворачнивания стека приложений выбран yandex.cloud. Работа разделена на два этапа:

#### 1. Terraform'ом создаем в яндеск облаке ноду и указываем необходимое количество ресурсов. 
На этом же этапе деплоим ssh-ключи на удаленные хосты. Далее перед выполнением terraform команд будет необходимо сгенерировать json-ключ для доступа к api-облака,
и настроить в файле variables.tf свои идентификаторы доступа к облаку. Так же можно с помощью packer создать образ, но я 
ограничился имеющемся в общем доступе Centos7. Все подробно приведено внизу в качестве bash-history. После этого можно будет выполнить 

```
terraform plan
terraform apply -auto-approve
```
На выходе получим IP-адреса и переменные.

#### 2. Далее в папке ansible необходимо указывать в файле inventory ip-адреса node01.
(На данном этапе, при желании,возможно создание terraform-inventory файл который будет использоваться Ansible'ом в качестве своего inventоry, что 
позволит исключить ручную работу по добавлению ip-адресов для.)
И запустить:
```
ansible-playbook provision.yml
```
Будет установлен docker, docker-compose, настроено дополнительное окружение и скопированы необходимые файлы во внутрь 
файловой системы хоста:docker-compose.yml, конфиги, дашборды, прочие зависисмости и т.д. Запустится команда docker-compose up и будут подняты
все контейнеры (prometheus, grafana, node-exporter(с пределенными параметрами взаимодействии с локолхостом, т.к. запускаю его тоже в контейнере), также запустятся
контейнеры с  aletrmanager, cadvisor(для мониторинга самих контейнеров), pushegateway.  После успешного заверещения контейнер с grafana будет доступен на 3000-ом порту внешнего
ip-адреса который проксируется небольшим сервером caddy, как и другие доступные через него порты до altermanager 9093, pushgateway 9091, promethes 9090. Пароль admin/admin. К графане прикручены несколько даш-бордов - мониторинг контейнеров, мониторинг самого прометеуса и конечно же тот, что упоминался в задании.
Все необходимые файлы для поднятния стэка находятся в src репозитории с комментариями в коде.


Привожу параметры окружения, выполняемые команды и версии используемых инструментов:
```

Oracle Linux Server release 8.5
Terraform v1.1.4 on linux_amd64
ansible 2.9.27

#install yandex cloud yc

curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
exec -l $SHELL
yc init

# create network можно не создавать вручную. все будет создано автоматически Terrafom
yc vpc network create \
--name net \
--labels my-label=yc-net \
--description "net for vm"

#create subnet можно не создавать вручную. все будет создано автоматически Terrafom
yc vpc subnet create \
--name subnet-a \
--zone ru-central1-a \
--range 10.1.2.0/24 \
--network-name net \
--description "subnet-a"

# create image with packer можно вместо этого использовать готовый образ Centos7
wget https://releases.hashicorp.com/packer/1.6.1/packer_1.6.1_linux_amd64.zip
unzip packer_1.6.1_linux_amd64.zip
./packer validate centos-7-base.json # edit cloud, network id ...
./packer build centos-7-base.json


# посмотреть необходимы переменные для terrarom inventory
yc compute image list (если создавался совй image, в ином случае имя и ID взять из маркета яндекса)


# Terraform install
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
git clone https://github.com/CentOsss/devpy14.git && cd devpy14/astra_tz/terraform

# узнать идентификатор resource folder, 
yc resource-manager folder list  # посмотреть список папок 
yc resource-manager folder get $MY-FOLDER # получить идентификатор ресурсной папки
# идентификатор cloud можно пеосмотреть через web-console

# создать пользователя и  сгенерировать ключ для яндекс-клоуд # назначить роль сервисному аккаунту
yc iam service-account create default-sa
yc iam key create --service-account-name default-sa --output key.json # key.json должен лежать в папке terraform)

# настроить ID'шники облака, папки в файле variables.tf. после этого можно запускать создание нод

terraform init
# на новом аккаунте яндекс-облака есть ограничение на количество одновременно используемых сетей -
# варианты решения:  запросить в поддержке увеличение кол-ва сетей
# удалить созданную сеть
yc vpc subnet delete --name my-subnet-a && yc vpc network delete --name net

# после инифиализации хоста с помощью терааформ профижим готовый хост запуская ansible
yum install ansible
cd ../ansible
# необходимо указывать в файле inventory ip-адреса node(ip адрес будет в output terraform.
ansible-playbook provision.yml
# после успешного поднятия стека приложений grafana будет доступе по внешнему адресу:3000
# остновить у удалить все созданные ресурсы можно командой
terraform destroy
```


