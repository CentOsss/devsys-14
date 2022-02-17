CREATE DATABASE test_db;

CREATE ROLE "test-admin-user" WITH LOGIN PASSWORD 'test';

GRANT ALL ON table public.orders,public.clients TO "test-admin-user";

CREATE ROLE "simple-test-user" WITH LOGIN PASSWORD 'test';

GRANT SELECT,INSERT,UPDATE,DELETE ON table public.orders,public.clients TO "simple-test-user";


CREATE TABLE orders
(
    Id SERIAL PRIMARY KEY,
    name VARCHAR,
    price INT
);


CREATE TABLE clients            (
    Id SERIAL PRIMARY KEY,
    lastname VARCHAR,
    country VARCHAR,
    order_number INT,
    FOREIGN KEY (order_number) REFERENCES orders (Id)
);

select * from clients


SELECT rolname FROM pg_roles;

SELECT datname,datcollate,datctype,datacl  FROM pg_database;

SELECT grantee,table_name,privilege_type
FROM information_schema.role_table_grants
WHERE table_name='clients' or table_name='orders'


