

docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -pPassword > /var/lib/mysql/databases.sql'
tar -zcf /sharedock/redmine_stack.tgz /sharedock 
scp /sharedock/redmine_stack.tgz admin@192.168.204.5:/share/CACHEDEV1_DATA/backup/


