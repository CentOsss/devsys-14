![image](https://user-images.githubusercontent.com/44666536/151700230-3ddcfe4b-5d85-497c-bae5-a1e34ad4e36a.png)



Работа разделена на два этапа:
1. Terraform'ом создаем в облаке несколько нод и указываем необходимое количество ресурсов. На этом же этапе деплоим ssh-ключи 
на удаленные хосты. На этом этапе необходимо сгенерировать json-ключ для доступа к api-облака. И настроить в файле variables.tf свои
идентификаторы доступа к облаку.
```
# сгенерировать ключ
yc iam service-account create default-sa
yc iam key create --service-account-name default-sa --output key.json
# назначить роль сервисному аккаунту

# на новом аккаунте яндекс-облака есть ограничение на количество одновременно используемых сетей -
# варианты решения:  запросить в поддержке увеличение кол-ва сетей
# удалить созданную сеть


Созданный ключ key.json должен находится в папке с terraform. После зодния ключа можно запустить инициализацию создания хостов.
```
  - в папке terraform выполням 
```
terraform plan
terraform apply -auto-approve
```
На выходе получим IP-адреса и переменные.

2. Далее в папке  ansible указываем в файле inventory наши адреса и выполняем
```
ansible-playbook provision.yml
```
Будет установлен docker, compos, настроено дополнительное окружение и скопированы необходимые файлы во внутрь файловой системы хостов:
docker-compose.yml и прочие зависисмости. После успешного заверещения grafana доступна на 3000ом порту внешенего ip-адреса. Пароль admin/admin.
К графане прикручены несколько даш-бордов и конечно же тот, что упомянался в задании. Так же настроен сбор местрик со второго хоста внутренней сети.


#!/bin/bash
# CentOS Linux release 7.9.2009 (Core)
#install ycloud

curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
exec -l $SHELL
yc init
# create network
yc vpc network create \
--name net \
--labels my-label=yc-net \
--description "net for vm"
#create subnet
yc vpc subnet create \
--name subnet-a \
--zone ru-central1-a \
--range 10.1.2.0/24 \
--network-name net \
--description "subnet-a"
# create image with packer
wget https://releases.hashicorp.com/packer/1.6.1/packer_1.6.1_linux_amd64.zip
unzip packer_1.6.1_linux_amd64.zip
./packer validate centos-7-base.json # edit cloud, network id ...
./packer build centos-7-base.json
yc compute image list
yc iam service-account --folder-id $FOLDER_ID list
yc iam service-account create default-sa
yc iam key create --service-account-name default-sa --output key.json
# Terraform
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
cd /src/terraform && terraform init
# сгенерировать ключ
yc iam service-account create default-sa
yc iam key create --service-account-name default-sa --output key.json
# назначить роль сервисному аккаунту

# на новом аккаунте яндекс-облака есть ограничение на количество одновременно используемых сетей -
# варианты решения:  запросить в поддержке увеличение кол-ва сетей
# удалить созданную сеть
yc vpc subnet delete --name my-subnet-a && yc vpc network delete --name net
yum install ansible
cd ../ansible
ansible-playbook provision.yml

terraform destroy


2. 