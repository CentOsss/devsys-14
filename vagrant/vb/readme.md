
запускается на машине под управлением Linux ubuntu-20: 


```
apt-get install ansible virtualbox vagrant
apt-get install dkms build-essential linux-headers-`uname -r`
apt install -f
/sbin/vboxconfig

sudo apt-get install cpu-checker
sudo kvm-ok


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

