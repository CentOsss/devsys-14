 ## 1. На лекции мы познакомились с [node_exporter]
    * поместите его в автозагрузку,
    * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`),
    * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
   
 #####  Скачиваем, распаковываем и перемещаем скрипт
 
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
 tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
 cd node_exporter-1.3.1.linux-amd64/
 mv node_exporter /usr/sbin/
```
 ##### Создаем конфиг. Привожу листинг созданного конфига
 
```/etc/systemd/system/node_exporter.service
systemctl cat node_exporter.service

[Unit]
Description=Node Exporter

[Service]
ExecStart=/usr/sbin/node_exporter
EnvironmentFile=/etc/sysconfig/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
```
##### Перечитываем конфиги, запускаем и включаем Unit
```  
systemctl daemon-reload
systemctl enable --now node_exporter.service
```

Сервис запустился, метрики доступны. 
Проверены режимы останова сервиса и запуска. 
После перезагрузки модуль не стартовал с 200ой EXEC ошибкой. Без отклбчения SeLinux на OraclLinux8 добиться запуска юнита так и не смог. Предпологаяю, что необходимо по другому описывать раздел [Install] если на сервере планируется использование SeLinux/
С отключенным SeLinux созданный модуль node_exporter прекрасно стартует. 

## 2. Ознакомьтесь с опциями node_exporter и выводом `/metrics` по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
```
CPU:
    node_cpu_seconds_total{cpu="0",mode="idle"} 2238.49
    node_cpu_seconds_total{cpu="0",mode="system"} 16.72
    node_cpu_seconds_total{cpu="0",mode="user"} 6.86
    process_cpu_seconds_total
    
Memory:
    node_memory_MemAvailable_bytes 
    node_memory_MemFree_bytes
    
Disk(если несколько дисков то для каждого):
    node_disk_io_time_seconds_total{device="sda"} 
    node_disk_read_bytes_total{device="sda"} 
    node_disk_read_time_seconds_total{device="sda"} 
    node_disk_write_time_seconds_total{device="sda"}
    
Network(так же для каждого активного адаптера):
    node_network_receive_errs_total{device="eth0"} 
    node_network_receive_bytes_total{device="eth0"} 
    node_network_transmit_bytes_total{device="eth0"}
    node_network_transmit_errs_total{device="eth0"}
```
## 3. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). После успешной установки:
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере *на своем ПК* (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.
    
 
 
##### Установил netdata на лабораторный хост с OracleLinux 8. Закомментировал в конфиги опцию, которая привязывала прослушвание на подключение к определенному интерфейсу.
##### bind to = localhost
##### Порт доступен на всех сетевых интерфейсах. 
##### Очень большой набор метрик - цпу, память, диск, ошибки, сеть и т.д. и удобный визуальный интерфейс. 

## 4. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
#### Да это можно понять, т.к. ядро использует модули для работы с виртуализацией.  
   ````
   1.284172] hv_vmbus: Vmbus version:5.0
[    1.304313] hv_vmbus: registering driver hid_hyperv
[    1.304765] hv_vmbus: registering driver hyperv_keyboard
[    1.305744] hv_vmbus: registering driver hyperv_fb
[    1.311584] hv_vmbus: registering driver hv_storvsc
[    1.316960] hv_vmbus: registering driver hv_netvsc
[    4.460247] hv_vmbus: registering driver hv_balloon
[    4.462154] hv_vmbus: registering driver hv_utils
[    4.722693] KVM: vmx: using Hyper-V Enlightened VMCS

````

## 5. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?
```
[root@ORO os2]# sysctl -a | grep fs.nr_open
fs.nr_open = 1048576
```
Этот параметр означает максимальное число файловых дескрипторов, которое может выделить процесс. Фактический лимит зависит от лимита ресурсов RLIMIT_NOFILE - максимального количества открытых файлов в системе и максимального количества открытых файлов в одном процессе. 
Для пользователя есть лимиты на кол-во открытых файлов, которые можно увеличить (мягкие)
```
[root@ORO os2]# ulimit -Sn
1024
```
И жесткие, которые увеличить нельзя
```
ulimit -Hn
262144
```

## 6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

```
root@ORO os2]# unshare -f --pid --mount-proc /bin/bash
root@ORO os2]# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.2  0.0  27572  5412 pts/0    S    12:06   0:00 /bin/bash
root          18  0.0  0.0  58720  3936 pts/0    R+   12:06   0:00 ps aux
```
Узнаем ID процесса из хостовой системы
```
[root@ORO ~]# ps aux | grep bash
root        1341  0.0  0.0  29084  6876 pts/0    Ss   янв16   0:00 -bash
root       13929  0.0  0.0  27532  5216 pts/1    Ss   12:06   0:00 -bash
root       13967  0.0  0.0   7300   864 pts/0    S    12:06   0:00 unshare -f --pid --mount-proc /bin/bash
root       13968  0.0  0.0  27572  5412 pts/0    S+   12:06   0:00 /bin/bash
root       14005  0.0  0.0  12128  1160 pts/1    S+   12:08   0:00 grep --color=auto bash
```

Заходим с возданный namespace
```
nsenter --target 13967  --pid --mount
 ```

## 7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

Форк-бомба. Функция параллельно пускает два своих экземпляра. Каждый пускает ещё по два и т.д. 
При отсутствии лимита на число процессов машина быстро исчерпывает физическую память и уходит в своп. На моей машине стабилизации так и не произошло.
bash: fork: Resource temporarily unavailable
-bash: fork: Resource temporarily unavailable
