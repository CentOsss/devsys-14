# Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

1. Установите средство виртуализации [Oracle VirtualBox](https://www.virtualbox.org/).

```
Развернул Vagrant  на своем лабароторном стенде под управлением Hyper-V Core 2019: 
```

1. Установите средство автоматизации [Hashicorp Vagrant](https://www.vagrantup.com/).

```
PS V:\vm\vagrant\ubuntu> C:\HashiCorp\Vagrant\bin\vagrant.exe --version
Vagrant 2.2.14
```

1. В вашем основном окружении подготовьте удобный для дальнейшей работы терминал. Можно предложить:

	* iTerm2 в Mac OS X
	* Windows Terminal в Windows
	* выбрать цветовую схему, размер окна, шрифтов и т.д.
	* почитать о кастомизации PS1/применить при желании.

	Несколько популярных проблем:
	* Добавьте Vagrant в правила исключения перехватывающих трафик для анализа антивирусов, таких как Kaspersky, если у вас возникают связанные с SSL/TLS ошибки,
	* MobaXterm может конфликтовать с Vagrant в Windows,
	* Vagrant плохо работает с директориями с кириллицей (может быть вашей домашней директорией), тогда можно либо изменить [VAGRANT_HOME](https://www.vagrantup.com/docs/other/environmental-variables#vagrant_home), либо создать в системе профиль пользователя с английским именем,
	* VirtualBox конфликтует с Windows Hyper-V и его необходимо [отключить](https://www.vagrantup.com/docs/installation#windows-virtualbox-and-hyper-v),
	* [WSL2](https://docs.microsoft.com/ru-ru/windows/wsl/wsl2-faq#does-wsl-2-use-hyper-v-will-it-be-available-on-windows-10-home) использует Hyper-V, поэтому с ним VirtualBox также несовместим,
	* аппаратная виртуализация (Intel VT-x, AMD-V) должна быть активна в BIOS,
	* в Linux при установке [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads) может дополнительно потребоваться пакет `linux-headers-generic` (debian-based) / `kernel-devel` (rhel-based).

1. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:

	* Создайте директорию, в которой будут храниться конфигурационные файлы Vagrant. В ней выполните `vagrant init`. Замените содержимое Vagrantfile по умолчанию следующим:

		```bash
		Vagrant.configure("2") do |config|
			config.vm.box = "bento/ubuntu-20.04"
		end
		```
```

Поднял VM с CentOS и развернул в ней PostgreSQL инстанс:

Vagrant.configure("2") do |config|
  config.vm.provider :hyperv do |hv|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "src/", "/srv/website", disabled: true
    hv.vmname = "vm-postgresql_1c"
    hv.enable_checkpoints = true
    hv.linked_clone = true
    hv.auto_start_action = "StartIfRunning"
    hv.auto_stop_action = "Save"
  end
  config.vm.provision "shell", inline: <<-SHELL
    echo "Europe/Moscow" > /etc/timezone
    echo "PATH=/usr/bin/:/opt/pgpro/1c-14/bin/" >> /etc/environment
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
    echo "1csrv03.nord.ru" > /etc/hostname
    setenforce 0
    systemctl stop firewalld
    systemctl disable firewalld
    yum update
    yum install -y ssh sudo
    useradd -m -s /bin/bash admin
    echo 'admin:admin' | chpasswd
    #adduser onetrix sudo
    echo 'admin   ALL=NOPASSWD: ALL' >> /etc/sudoers
    sudo localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
    sudo localectl set-locale LANG=ru_RU.utf8
    rpm -i https://repo.postgrespro.ru/pg1c-14/keys/centos.rpm
    yum makecache
    sudo yum install -y postgrespro-1c-14-contrib
    /opt/pgpro/1c-14/bin/pg-setup initdb --locale=ru_RU.UTF8
    /opt/pgpro/1c-14/bin/pg-setup service enable
    /opt/pgpro/1c-14/bin/pg-setup service start
  SHELL
end
```

```
PS V:\vm\vagrant\ubuntu> C:\HashiCorp\Vagrant\bin\vagrant.exe suspend
==> default: Suspending the machine...

```



1. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

```
По умолчяанию выделяется 1GB RAM и 1 виртуальный процессор
```

1. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: [документация](https://www.vagrantup.com/docs/providers/virtualbox/configuration.html). Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
```
В файле провижинга можно указать параметры (к примеру):
    hv.cpus = 10
    hv.memory = 32768
```

1. Команда `vagrant ssh` из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.

```
PS V:\vm\vagrant\ubuntu> C:\HashiCorp\Vagrant\bin\vagrant.exe ssh
Last login: Fri Feb 25 03:20:01 2022 from 172.16.13.101
[vagrant@localhost ~]$
```

1. Ознакомиться с разделами `man bash`, почитать о настройках самого bash:
    * какой переменной можно задать длину журнала `history`, и на какой строчке manual это описывается?
   
```
HISTSIZE
 Manual page bash(1) line 692 
```
    
    что делает директива `ignoreboth` в bash?

```
Не хранито в истории дупликаты команд и команды начинающиеся с пробела
```
1. В каких сценариях использования применимы скобки `{}` и на какой строчке `man bash` это описано?
```
чикличное выполнение команд в текущей сессии  (не порождает дочерний процесс )
```

1. Основываясь на предыдущем вопросе, как создать однократным вызовом `touch` 100000 файлов? А получилось ли создать 300000? Если нет, то почему?

```
touch {1..100000}
Не получится. Ограничение на максимальное кол-уо открытых файлов процессом
```
1. В man bash поищите по `/\[\[`. Что делает конструкция `[[ -d /tmp ]]`
```
Проверка условия. В данном случае проверяется наличие директории /tmp и возращается  результат 0 или 1 
```
1. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:

	```bash
	bash is /tmp/new_path_directory/bash
	bash is /usr/local/bin/bash
	bash is /bin/bash
	```

	(прочие строки могут отличаться содержимым и порядком)
    В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.

```
vagrant@localhost:~$ mkdir /tmp/new_path_dir/
vagrant@localhost:~$ cp /bin/bash /tmp/new_path_dir/
vagrant@localhost:~$ type -a bash
bash is /usr/bin/bash
bash is /bin/bash
vagrant@localhost:~$ PATH=/tmp/new_path_dir/:$PATH
vagrant@localhost:~$ type -a bash
bash is /tmp/new_path_dir/bash
bash is /usr/bin/bash
bash is /bin/bash
  
```
1. Чем отличается планирование команд с помощью `batch` и `at`?
```
at запускается в указанное время, a batch - выполняет команды, когда уровень нагрузки на систему это позволяет
```
1. Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.

```
PS V:\vm\vagrant\ubuntu> C:\HashiCorp\Vagrant\bin\vagrant.exe destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Stopping the machine...
==> default: Deleting the machine...
```
 ---

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".

Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.

[Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop)

[Как запустить chrome в режиме инкогнито ](https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&hl=ru)

[Как запустить  Safari в режиме инкогнито ](https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac)

Любые вопросы по решению задач задавайте в чате Slack.

---
