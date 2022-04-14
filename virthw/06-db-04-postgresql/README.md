# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

```

version: '3.1'


volumes:
  pg_db: {}
  pg_backup: { }

services:
  pg_db:
    image: postgres:13
    restart: always
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_DB=postgres
    volumes:
      - pg_db:/var/lib/postgresql/data
      - pg_backup:  /var/lib/postgresql/backup
    ports:
      - ${POSTGRES_PORT:-5432}:5432

```

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```
\l
```
- подключения к БД
```
\c
```
- вывода списка таблиц
```
\d
```
- вывода описания содержимого таблиц
```
\d $TABLE
```
- выхода из psql
```
\q
```

## Задача 2

Используя `psql` создайте БД `test_database`.

```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

```
psql -U postgres -f ./pg_backup.sql test_database
```

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
postgres=# \c test_database
test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

```
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width 
-----------
         4
        16
         4
```

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```
Т.к. преобразовать существующую таблицу в партиционированную нельзя пересоздадим таблицу:
test_database=# alter table orders rename to orders_old;

Создадим таблицу указав метод разбиения RANGE по столбцу price:
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);

И сами секции:
test_database=# create table orders_less499 partition of orders for values from (0) to (499);
test_database=# create table orders_more499 partition of orders for values from (499) to (999999999);

Заполним новую таблицу:
test_database=# insert into orders (id, title, price) select * from orders_old;
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

```
Да, спроектировав таблицу как секционнированную.
```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```
root@node01:/home/centos# docker exec -i postgres_pg_db_1 sh -c 'pg_dump -U postgres  > \
-d test_database > /var/lib/postgresql/backup/test_database_bckp.sql'
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

```
Задать ограничение UNIQUE для столбца
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
