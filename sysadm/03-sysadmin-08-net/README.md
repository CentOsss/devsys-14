# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

```
Получаю ошибку на вывод маршрутов если указываю любую маску:
route-views>show ip route 91.190.86.125/32
                                       ^
% Invalid input detected at '^' marker.

Без указания маски получил вот такой результат:

route-views>show ip route 91.190.86.125
Routing entry for 91.190.80.0/21
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 1w2d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 1w2d ago
      Route metric is 0, traffic share count is 1
      AS Hops 2
      Route tag 6939
      MPLS label: none

route-views>show bgp 91.190.86.125
BGP routing table entry for 91.190.80.0/21, version 311627825
Paths: (23 available, best #22, table default)
 
  Refresh Epoch 1
  1351 20764 20764 20764 20764 20764 20764 20764 31376 31376
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE0449B6F78 RPKI State valid
      rx pathid: 0, tx pathid: 0
...//

```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

```
Подгружаем модуль.
root@DBIT:~# echo "dummy" >> /etc/modules && echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf

# создаем интерфейс dummy.
root@DBIT:~# vi /etc/network/interfaces

auto dummy0
iface dummy0 inet static
 address 10.4.4.4/32
 pre-up ip link add dummy0 type dummy
 post-down ip link del dummy0

# перезапускаем сеть и проверяем поднялся ли интерфейс
root@DBIT:~# systemctl restart networking.service
root@DBIT:~# ip link set dummy0 up

# Добавляем несколько статических маршрутов через созданный интерфейс
root@DBIT:~# ip route add 100.64.0.0/10 via 10.4.4.4
root@DBIT:~# ip route add 100.100.0.0/29 dev dummy0

# Проверяем таблицу маршрутизации
root@DBIT:~# ip -br route
default via 172.16.0.1 dev eth0 onlink
100.64.0.0/10 via 10.4.4.4 dev dummy0
100.100.0.0/29 dev dummy0 scope link
172.16.0.0/16 dev eth0 proto kernel scope link src 172.16.0.200
172.30.0.0/16 dev docker0 proto kernel scope link src 172.30.0.1
192.168.123.0/24 dev virbr0 proto kernel scope link src 192.168.123.1 linkdown

```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```
netstat -ln4
На внутреннем интерфейсе ЛВС открыты и находятся в состояние прослушивания, 
т.е. готовы принимать подключения 139 и 445 tcp порты SAMBA сервера

tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:445             0.0.0.0:*               LISTEN

На всех интерфейсах в системе открыт и находяится в состояние прослушивания, 
т.е. готов принимать подключения 22 tcp порт SSH сервера
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN  


```

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

```
На внутреннем интерфейсе ЛВС открыт 53 UDP порт DNS сервера 
udp        0      0 192.168.123.1:53        0.0.0.0:*

и 138 UDP порт службы датаграмм NetBIOS

```

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 

![image](https://user-images.githubusercontent.com/44666536/155854090-15ca374f-4b27-4fe3-b6c8-024b9c5c95aa.png)

 ---
## Задание для самостоятельной отработки (необязательно к выполнению)

6*. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

7*. Установите bird2, настройте динамический протокол маршрутизации RIP.

8*. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

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

Любые вопросы по решению задач задавайте в чате учебной группы.

---

