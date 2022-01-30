#!/bin/bash

# CentOS Linux release 7.9.2009 (Core)
#install yc

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
terraform plan
terraform apply -auto-approve
# на новом аккаунте яндекс-облака есть ограничение на количество одновременно используемых сетей -
# варианты решения:  запросить в поддержке увеличение кол-ва сетей
# удалить созданную сеть
yc vpc subnet delete --name my-subnet-a && yc vpc network delete --name net
yum install ansible
cd ../ansible
ansible-playbook provision.yml

terraform destroy



