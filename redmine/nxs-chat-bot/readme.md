## Nxs-bot-srv
Представляет собой приложение в виде демона написанное на C++. 
#Разворачивается на CentOS 7 build. Для корректной работы должны быть развернуты Redis
#(для хранения сессиий пользователей телеграм-бота) и база данных MySQL (предоставить базу и пользователя). 
#Для интеграции с Redmine должен быть установлен plugin https://github.com/nixys/nxs-chat-redmine


```Установка:

#install chat bot
rpm --import http://packages.nixys.ru/centos/repository.gpg.key
yum install nxs-chat-srv
systemctl enable nxs-chat-srv
#generate cert
openssl req -newkey rsa:2048 -sha256 -nodes -keyout help.key -x509 -days 365 -out help.pem -subj 
"/C=RU/ST=SaintPetersburg/L=Nevsky44/O=SMRetail/CN=$YOURDOMAINNAME.BOT"
mv help.* /etc//etc/nxs-chat-srv/ssl/
#initialization nxs_chat_bot with self-signe cert
nxs-chat-srv -i set_webhook_self_signed_certificate
tail -f /var/log/nxs-chat-srv/nxs-chat-srv.log
nxs-chat-srv
nxs-chat-srv -i create_tables```
