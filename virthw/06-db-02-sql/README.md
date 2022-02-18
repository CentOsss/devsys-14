# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```
version: '3.1'

volumes:
  pg_db:
  pg_backup:

services:
  pg_db:
    image: postgres:12
    restart: always
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_DB=postgres
    volumes:
      - pg_db:/var/lib/postgresql/data
      - pg_backup:/var/lib/postgresql/backup
    ports:
      - ${POSTGRES_PORT:-5432}:5432
```
## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
```
CREATE DATABASE test_db;
CREATE ROLE "test-admin-user" WITH LOGIN PASSWORD 'test';
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)
```
CREATE TABLE orders                                   
(
    Id SERIAL PRIMARY KEY,
    name VARCHAR,
    price INT
);
 
CREATE TABLE clients
(
    Id SERIAL PRIMARY KEY,
    lastname VARCHAR, 
    country VARCHAR,
    order_number INT, 
    FOREIGN KEY (order_number) REFERENCES orders (Id)
);
```

- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```
GRANT ALL ON table public.orders,public.clients TO "test-admin-user";
```
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```
CREATE ROLE "simple-test-user" WITH LOGIN PASSWORD 'test';
GRANT SELECT,INSERT,UPDATE,DELETE ON table public.orders,public.clients TO "simple-test-user";
```


Приведите:
- итоговый список БД после выполнения пунктов выше,
```
SELECT datname,datcollate,datctype,datacl  FROM pg_database;

datname  |datcollate|datctype  |datacl                                                             |
---------+----------+----------+-------------------------------------------------------------------+
postgres |en_US.utf8|en_US.utf8|NULL                                                               |
template1|en_US.utf8|en_US.utf8|{=c/postgres,postgres=CTc/postgres}                                |
template0|en_US.utf8|en_US.utf8|{=c/postgres,postgres=CTc/postgres}                                |
test_db  |en_US.utf8|en_US.utf8|{=Tc/postgres,postgres=CTc/postgres,"test-admin-user"=CTc/postgres}|

test_db-# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
```
- описание таблиц (describe)
```
test_db-# \d clients
                                    Table "public.clients"
    Column    |       Type        | Collation | Nullable |               Default
--------------+-------------------+-----------+----------+-------------------------------------
 id           | integer           |           | not null | nextval('clients_id_seq'::regclass)
 lastname     | character varying |           |          |
 country      | character varying |           |          |
 order_number | integer           |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "ctry" btree (country)
Foreign-key constraints:
    "clients_order_number_fkey" FOREIGN KEY (order_number) REFERENCES orders(id)
```
```
test_db-# \d orders
                                 Table "public.orders"
 Column |       Type        | Collation | Nullable |              Default
--------+-------------------+-----------+----------+------------------------------------
 id     | integer           |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying |           |          |
 price  | integer           |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_number_fkey" FOREIGN KEY (order_number) REFERENCES orders(id)
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
SELECT grantee,table_name,privilege_type,is_grantable
FROM information_schema.role_table_grants 
WHERE table_name='clients' or table_name='orders'
;
```
- список пользователей с правами над таблицами test_db
```grantee         |table_name|privilege_type|is_grantable|
----------------+----------+--------------+------------+
postgres        |orders    |INSERT        |YES         |
postgres        |orders    |SELECT        |YES         |
postgres        |orders    |UPDATE        |YES         |
postgres        |orders    |DELETE        |YES         |
postgres        |orders    |TRUNCATE      |YES         |
postgres        |orders    |REFERENCES    |YES         |
postgres        |orders    |TRIGGER       |YES         |
simple-test-user|orders    |INSERT        |NO          |
simple-test-user|orders    |SELECT        |NO          |
simple-test-user|orders    |UPDATE        |NO          |
simple-test-user|orders    |DELETE        |NO          |
test-admin-user |orders    |INSERT        |NO          |
test-admin-user |orders    |SELECT        |NO          |
test-admin-user |orders    |UPDATE        |NO          |
test-admin-user |orders    |DELETE        |NO          |
test-admin-user |orders    |TRUNCATE      |NO          |
test-admin-user |orders    |REFERENCES    |NO          |
test-admin-user |orders    |TRIGGER       |NO          |
postgres        |clients   |INSERT        |YES         |
postgres        |clients   |SELECT        |YES         |
postgres        |clients   |UPDATE        |YES         |
postgres        |clients   |DELETE        |YES         |
postgres        |clients   |TRUNCATE      |YES         |
postgres        |clients   |REFERENCES    |YES         |
postgres        |clients   |TRIGGER       |YES         |
simple-test-user|clients   |INSERT        |NO          |
simple-test-user|clients   |SELECT        |NO          |
simple-test-user|clients   |UPDATE        |NO          |
simple-test-user|clients   |DELETE        |NO          |
test-admin-user |clients   |INSERT        |NO          |
test-admin-user |clients   |SELECT        |NO          |
test-admin-user |clients   |UPDATE        |NO          |
test-admin-user |clients   |DELETE        |NO          |
test-admin-user |clients   |TRUNCATE      |NO          |
test-admin-user |clients   |REFERENCES    |NO          |
test-admin-user |clients   |TRIGGER       |NO          |
```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

```
insert into orders (name, price) values 
    ('Книга', 500), 
    ('Монитор', 7000), 
    ('Гитара', 4000);
```
Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

```
insert into clients (lastname, country) values 
    ('Иванов Иван Иванович', 'USA'),  
    ('Петров Петр Петрович', 'Canada'), 
    ('Иоганн Себастьян Бах', 'Japan'),
    ('Ронни Джеймс Дио', 'Russia'),
    ('Ritchie Blackmore', 'Russia');
```
Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
```
select count(*) from clients;

count|
-----+
    5|
select count(*) from orders;

count|
-----+
    5|
```
    - результаты их выполнения.

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
```
update clients set order_number = 3 where id = 3;
update clients set order_number = 4 where id = 4;
update clients set order_number = 5 where id = 5;
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 ```
select * from clients where order_number is not null;
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
```
explain (FORMAT JSON) select * from clients where country  is not null;

[
  {
    "Plan": {
      "Node Type": "Seq Scan",
      "Parallel Aware": false,
      "Relation Name": "clients",
      "Alias": "clients",
      "Startup Cost": 0.00,
      "Total Cost": 18.10,
      "Plan Rows": 806,
      "Plan Width": 72,
      "Filter": "(country IS NOT NULL)"
    }
  }
]
```
```
В данном случае мы видим, что планировщик запросов выбрал план из одного этапа -
последовательное сканирование("Node Type": "Seq Scan",).
В качестве фильтра будет применено условие("Filter": "(country IS NOT NULL)") на
которое будет проверяться каждая обработанная строка. Мы видим примерную оценку
стоимости запуска запроса ("Startup Cost": 0.00) и примерную оценку выполнения
всего запроса ("Total Cost": 18.10). "Plan Rows": 806 и "Plan Width": 72 означа-
ют ожидаемое число строк которое должен вывести план и размер строк в байтах соответсвенно.
```


## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---
```
# выгружаем дамп всех бах и существующие роли

docker exec -i root_pg_db_1 sh -c 'pg_dumpall -U postgres  > \
/var/lib/postgresql/backup/test_db.dump'


# останавливаем и удаляем работающий контейнер

docker-compose down 

# поднимаем новый контейнер и подключаем 
# новый volume хранения данных: pg_db2:/var/lib/postgresql/data
# и старый с нашим бэкапом: pg_backup:/var/lib/postgresql/backup
# запускаем новый контейнер с чистой базой 

docker-compose -f docker-compose2.yml up -d 

# восстанавливаем кластер со всеми ролями и базами данных

docker exec -i root_pg_db2_1 sh -c \
'psql -U postgres -f /var/lib/postgresql/backup/test_db.dump postgres'


```

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
