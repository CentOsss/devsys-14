
запускается на машине под управлением Linux ubuntu-20: 


```
apt-get install ansible virtualbox vagrant
ssh-keygen
cd vb/Docker && vagrant init 
cat VagrantfileDocker > Vagrantfile
vagrant up
vagrant ssh 
# авторизация по ключу ( юзер centos / vagrant )
```


- Vagrant
```
# vagrant -v
Vagrant 2.2.19
```
- Ansible
```
# ansible --version
ansible 2.9.6
```

