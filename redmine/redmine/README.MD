<h1>Redmine</h1>

<p>Директория приложения и все необходимы файлы находится на файловой системе хост-машины по пути /sharedock/*. <a href="/projects/retail2/wiki/Резервное_копировани_и_восстановление">Резервные копии</a> хранятся на сервер nasn44 (192.168.204.5) по пути&nbsp;admin@192.168.204.5:/share/CACHEDEV1_DATA/backup/redmine_stack или \\192.168.204.5\backup&nbsp;</p>

<div style="background: rgb(238, 238, 238); border: 1px solid rgb(204, 204, 204); padding: 5px 10px; margin-left: 40px;">
<p>&nbsp; &nbsp; В качестве&nbsp;ITSM используется веб-приложение Redmine в связке с Oxidized. и GIT.&nbsp;&nbsp;Сервис развернут на виртуальном хосте 192.168.204.4.<br />
Представляет собой стэк микросервисов на базе docker-контейнеризации.</p>

<p>Состоит из 4&nbsp;контейнеров - базы&nbsp;данных mysql, веб-приложения&nbsp;redmine, системы управления конфигурациями сетевого оборуования oxidiized, системы&nbsp;контроля версий GIT и реверсивного&nbsp;прокси сервера nginx.<br />
Хранение&nbsp;базы&nbsp;и файлов приложения вынесено на хост машину dbit.nord.ru путем монтирования папок внутрь контейнера. Пути описаны ниже в файле redmine.yml.&nbsp;<br />
Стек поднимается с помощью docker-compose и описан&nbsp; файлом docker-compose.yml</p>

<pre>
<em>REDMINE.yml

 version: &#39;3.1&#39;
# edit /redmine/app_volume/config/database.yml for connect redmine with DB instance
&nbsp; # &nbsp;host: 172.16.13.5 &nbsp;change IP-address to host with DB

services:

&nbsp; mysql:
&nbsp; &nbsp; image: mysql:5.7.32
&nbsp; &nbsp; volumes:
&nbsp; &nbsp; &nbsp; # mount directory to container &nbsp;- host:container
&nbsp; &nbsp; &nbsp; - /mysql:/var/lib/mysql/
&nbsp; &nbsp; ports:
&nbsp; &nbsp; &nbsp; - 3306:3306
&nbsp; &nbsp; restart: always
&nbsp; &nbsp; environment:
&nbsp; &nbsp; &nbsp; MYSQL_ROOT_PASSWORD: 
&nbsp; &nbsp; &nbsp; MYSQL_DATABASE: 
&nbsp; &nbsp; &nbsp; MYSQL_USER: 
&nbsp; &nbsp; &nbsp; MYSQL_PASSWORD: 

&nbsp; redmine:
&nbsp; &nbsp; image: nordit/redmine:1
# mount directory to container &nbsp;- host:container
&nbsp; &nbsp; volumes:
&nbsp; &nbsp; &nbsp; - /sharedock/redmine/app_volume:/usr/src/redmine/
&nbsp; &nbsp; &nbsp; - /sharedock:/sharedock/
&nbsp; &nbsp; &nbsp; - /sharedock/redmine/files:/usr/src/redmine/files/
&nbsp; &nbsp; restart: always
&nbsp; &nbsp; environment:
&nbsp; &nbsp; &nbsp; REDMINE_DB_MYSQL: 
&nbsp; &nbsp; &nbsp; REDMINE_DB_USERNAME: 
&nbsp; &nbsp; &nbsp; REDMINE_DB_PASSWORD: 
&nbsp; &nbsp; ports:
&nbsp; &nbsp; &nbsp; - 80:3000

#After deploy container download backup dump DB redmine
# docker exec -it &lt;ID_CONTAINER&gt; bash
# &nbsp; mysql -u root -p redmine &lt; redmine.sql &nbsp;c
</em>

</pre>

<p>&nbsp; &nbsp; В стеке используется docker-образ nordretail/remine:1 расположенный на <a href="http://dockerhub.com">dockerhub.com</a><br />
Сам docker-compose.yml и папка с приложениями&nbsp;sharedock.tgz&nbsp;расположены в репозитории <a href="http://github.com/nordretail/redmine.git">GitHub</a>&nbsp;и на&nbsp;NASN44<br />
Для сборки сервиса необходимо клонировать Git-репозиторий (или скопировать архив sharedock.tgz),&nbsp;распаковать данные из архива&nbsp;sharedock.tgz на хостовой машине по пути /sharedock/*<br />
И выполнить команду:</p>

<pre>
<em>/bin/bash
docker-compose -f redmine.yml up -d </em>
</pre>

<p>&nbsp; &nbsp; После поднятия сервиса необходимо загрузить актуальный дамп базы. </p>

<pre>
# docker exec -it ID_CONTAINER bash
# mysql -u root -p redmine &lt; redmine.sql 
или </pre>

<pre>
<code>docker exec -i mysql sh -c &#39;exec mysql -uroot -p&quot;$MYSQL_ROOT_PASSWORD&quot;&#39; &lt; /sharedock/mysql/all-databases.sql</code></pre>

<p>При вознимкновении ошибок ERRNO_ACCESS DENIE во время деплоя стека необходимо изменить владельца на папку</p>

<pre>
  # chown -R 999:docker /sharedock/redmine/app/tmp</pre>

<p>&nbsp;</p>
</div>

<p>&nbsp;</p>

