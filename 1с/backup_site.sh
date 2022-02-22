#!/bin/bash

##script automatic data backup and notification on Telegram
API=

infra_DB_false="PROBPLEM:infra_DB:$(date)"
cp -rn /mnt/backups/servicedesk/ /mnt/raid/winbackups
find /mnt/raid/winbackups/servicedesk -mindepth 1 -cmin 1  | wc -l > /tmp/pryan1c_dump.log
find /mnt/raid/winbackups/servicedesk -mindepth 1 -cmin 1  | mail os@tort.spb.ru
read RESULT1C < /tmp/pryan1c_dump.log
if [[ $RESULT1C = 0 ]]
then
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=491455655 -F text=$infra_DB_false
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=157914816 -F text=$infra_DB_false
fi


#jobs for copy mysqldump
dump_false="PROBLEM:Backup_dump.sql:"$(date)
scp ittortwz@ittortwz.beget.tech:/home/i/ittortwz/dump-*.sql.gz /mnt/raid/winbackups/sever-metropol.site
find /mnt/raid/winbackups/sever-metropol.site/ -mindepth 1 -cmin 1  | wc -l > /tmp/mysql_dump.log
find /mnt/raid/winbackups/sever-metropol.site/ -mindepth 1 -cmin 1  | mail os@tort.spb.ru
read RESULTDUMP < /tmp/mysql_dump.log
if [[ $RESULTDUMP = 0 ]]
then
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=491455655 -F text=$dump_false
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=157914816 -F text=$dump_false
fi



#jobs for copy site
site_false="PROBLEM:Backup_sites:sm.ru,renardi.ru:$(date)"
scp ittortwz@ittortwz.beget.tech:/home/i/ittortwz/site-*.tar.gz  /mnt/raid/winbackups/sever-metropol.site/
find /mnt/raid/winbackups/sever-metropol.site/ -mindepth 1 -cmin 1  | wc -l > /tmp/site_dump.log
find /mnt/raid/winbackups/sever-metropol.site/ -mindepth 1 -cmin 1  | mail os@tort.spb.ru
read RESULTSITE < /tmp/site_dump.log
if [[ $RESULTDUMP = 0 ]]
then
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=491455655 -F text=$site_false
curl -s -X POST "https://api.telegram.org/bot$API/sendMessage" -F chat_id=157914816 -F text=$site_false
fi




#clear old backup files
find /mnt/raid/winbackups/ -mindepth 1 -mtime +7 -delete
find /mnt/backups/servicedesk/ -mindepth 1 -mtime +7 -delete

rm /tmp/site_dump.log /tmp/mysql_dump.log /tmp/pryan1c_dump.log

