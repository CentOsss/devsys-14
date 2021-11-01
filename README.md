
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="text/css" http-equiv="Content-Style-Type">
<title>101-500</title>
</head>
<body>
<h1 align="center" class="root">
<a name="7ht4h8faap0mcp8ed3k6jic8h8">101-500</a>
</h1>
<div align="center" class="globalOverview">
<img src="101-500_files/images/101-500 3.jpg"></div>
<h2 class="topic">
<a name="7lom5l8mhrvr6j8pd1vlqjuinr">101</a>
</h2>
<h3 class="topic">
<a name="0jc721lfbu0vbnr0cbdg2msiq2">&nbsp;101.1  Determine and configure hardware settings</a>
</h3>
<h3 class="topic">
<a name="7u16r1b90nu1guarsphc52q77n">&nbsp;&nbsp;/sys</a>
</h3>
<h3 class="topic">
<a name="4h2nobmb4omj7nl626cbimlml3">&nbsp;&nbsp;&nbsp;/devices - устройства ядра</a>
</h3>
<h3 class="topic">
<a name="0j41bs467frf7u5h4tk54arro9">&nbsp;&nbsp;&nbsp;/bus - перечень шин</a>
</h3>
<h3 class="topic">
<a name="59o1mft1mm1gvljkf7c4dfmm1l">&nbsp;&nbsp;&nbsp;/drivers - каталоги драйверов</a>
</h3>
<h3 class="topic">
<a name="3f7ocl3l1t6otlh5a27eibvoqg">&nbsp;&nbsp;&nbsp;/block - блочные устройства</a>
</h3>
<h3 class="topic">
<a name="704kpbaaru554qrtbahhk9252m">&nbsp;&nbsp;&nbsp;/class</a>
</h3>
<h3 class="topic">
<a name="2mraj7hb7701apvepj1lqi8ets">&nbsp;&nbsp;&nbsp;&nbsp;разбиение устройств по класссам</a>
</h3>
<h3 class="topic">
<a name="112q33c950kh5hdg7ec2apas80">&nbsp;&nbsp;/proc</a>
</h3>
<h3 class="topic">
<a name="1pa9e4jfbqecs8mp8l9mv7lov7">&nbsp;&nbsp;&nbsp; - текущие настройки и процессы системы</a>
</h3>
<h3 class="topic">
<a name="1biot61vs4s441lm5vgnd184gv">&nbsp;&nbsp;&nbsp;/sys</a>
</h3>
<h3 class="topic">
<a name="0bsvsb9vje3t669351phbtfrl4">&nbsp;&nbsp;&nbsp;&nbsp;/fs - текущие настройи фс = max_file ...</a>
</h3>
<h3 class="topic">
<a name="5dbscqqrsfim0hqgdmd9aovetd">&nbsp;&nbsp;&nbsp;&nbsp;/net - настройки сети ip_forward...</a>
</h3>
<h3 class="topic">
<a name="0rgqdee0dsq2iokb7unn4da831">&nbsp;&nbsp;&nbsp;/proc/cpuinfo</a>
</h3>
<h3 class="topic">
<a name="2iocsbdhqi0b6ilccckdm4plv7">&nbsp;&nbsp;&nbsp;&nbsp;Lists detailed information about the CPU(s) found by the operating system.</a>
</h3>
<h3 class="topic">
<a name="0iv1nq07gub0hgh970pmh8kp20">&nbsp;&nbsp;&nbsp;/proc/interrupts</a>
</h3>
<h3 class="topic">
<a name="6cpdhovrmju4qe6h1vqhrse60h">&nbsp;&nbsp;&nbsp;&nbsp;A list of numbers of the interrupts per IO device for each CPU.</a>
</h3>
<h3 class="topic">
<a name="4mhp815onqkb4rlrjs8d2o41p5">&nbsp;&nbsp;&nbsp;/proc/ioports</a>
</h3>
<h3 class="topic">
<a name="35jni8f0uhlts5qpg4ji5osjm9">&nbsp;&nbsp;&nbsp;&nbsp;Lists currently registered Input/Output port regions in use.</a>
</h3>
<h3 class="topic">
<a name="4menhaisg537u3rp12usgk0u16">&nbsp;&nbsp;&nbsp;/proc/dma</a>
</h3>
<h3 class="topic">
<a name="6b8g5u8p8g7n4v73h8a7ppci2e">&nbsp;&nbsp;&nbsp;&nbsp;Lists the registered DMA (direct memory access) channels in use.</a>
</h3>
<h3 class="topic">
<a name="5toppbgcmqkfl0v9sabunvj3f7">&nbsp;&nbsp;/dev</a>
</h3>
<h3 class="topic">
<a name="6fq8e47lbe5c8n9i728hd57a2h">&nbsp;&nbsp;&nbsp;Every file inside /dev is associated with a system device, particularly storage devices.</a>
</h3>
<h3 class="topic">
<a name="711cr7i9f7uae79g8dnqq402en">&nbsp;&nbsp;&nbsp;In Linux, storage devices are generically referred as block devices, because data is read to and from these devices in blocks of buffered data with different sizes and positions. Every block device is identified by a file in the /dev directory, with the name of the file depending on the device type</a>
</h3>
<h3 class="topic">
<a name="098ooihg4njqu28renhot17mu3">&nbsp;&nbsp;udev</a>
</h3>
<h3 class="topic">
<a name="522ud3tr0mq8j63hqjlel1292n">&nbsp;&nbsp;&nbsp;The Linux kernel captures the hardware detection event and passes it to the udev process, which then identifies the device and dynamically creates corresponding files in /dev, using pre-defined rules.</a>
</h3>
<h3 class="topic">
<a name="0u0oqg6ffgiafkjm022q4l46mi">&nbsp;&nbsp;&nbsp;udev is responsible for the identification and configuration of the devices already present during machine power-up (coldplug detection) and the devices identified while the system is running (hotplug detection). </a>
</h3>
<h3 class="topic">
<a name="6598c9m66nkr3dc1g8a60as2qk">&nbsp;&nbsp;&nbsp;Udev relies on SysFS, the pseudo filesystem for hardware related information mounted in /sys.</a>
</h3>
<h3 class="topic">
<a name="2v102pl8m4l4la3p5fgbe5da3a">&nbsp;&nbsp;&nbsp;As new devices are detected, udev searches for a matching rule in the pre-defined rules stored in the directory /etc/udev/rules.d/. The most important rules are provided by the distribution, but new ones can be added for specific cases.</a>
</h3>
<h3 class="topic">
<a name="5dd83igeoatci5nt3h76nvpsop">&nbsp;&nbsp;module</a>
</h3>
<h3 class="topic">
<a name="3e696ta4ao2qnrk14i5ol67bsv">&nbsp;&nbsp;&nbsp;lsmod</a>
</h3>
<h3 class="topic">
<a name="5ek17h53m2qkrp8mbrljvbhdsq">&nbsp;&nbsp;&nbsp;&nbsp;shows all currently loaded modules:в последней строке указывается зависимость от модуля</a>
</h3>
<h3 class="topic">
<a name="2fdatu8613hiqihpljc23ufofl">&nbsp;&nbsp;&nbsp;modprobe</a>
</h3>
<h3 class="topic">
<a name="496jpm5u7kkan4srmoqnncbqtf">&nbsp;&nbsp;&nbsp;&nbsp;modprobe -r - unload module</a>
</h3>
<h3 class="topic">
<a name="2iujr0v6j72722ac7qebqb61nl">&nbsp;&nbsp;&nbsp;modinfo</a>
</h3>
<h3 class="topic">
<a name="69815kcvt709o8fsunf940crb9">&nbsp;&nbsp;&nbsp;&nbsp;shows a description, the file, the author, the license</a>
</h3>
<h3 class="topic">
<a name="5ncuat6itv8b923ql0v0brm086">&nbsp;&nbsp;&nbsp;&nbsp;/etc/modprobe.conf&#13;
/etc/modprobe.d/&#13;
/etc/modprobe.d/blacklist.conf</a>
</h3>
<h3 class="topic">
<a name="5kkkof6kh38vcm02o542a3ie0j">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customized parameters for a module &#13;
used to block the loading of the module</a>
</h3>
<h3 class="topic">
<a name="0sljbcj206ifr5k9h5e1bmvqb2">&nbsp;&nbsp;&nbsp;&nbsp;modinfo -p </a>
</h3>
<h3 class="topic">
<a name="1rq3s09b223u437anj1r9q7qug">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;show options determine for module in /etc/modprobe</a>
</h3>
<h3 class="topic">
<a name="5u1d7fs6rpim6b5fkr9pfsmvme">&nbsp;&nbsp;lspci -s 04:02.0 -v [-k] - verbosse info. kernel module use of device</a>
</h3>
<h3 class="topic">
<a name="42m3tubdnl1fsb6gsnbpa3hcgf">&nbsp;&nbsp;dbus - программная шина общения процессов</a>
</h3>
<h3 class="topic">
<a name="0vnu0a5629drhq54jbetv20eq9">&nbsp;&nbsp;Эти каталоги являются точками монтирования к файловым системам, не присутствующим в разделе устройства, но только в пространстве оперативной памяти, используемом ядром для хранения конфигурации среды выполнения и информации о запущенных процессах.&#13;
/sys - информации об устройстве и данных ядра, связанных с оборудованием&#13;
/proc также содержит информацию о различных структурах данных ядра, включая запущенные процессы и конфигурацию.</a>
</h3>
<p class="summary">(<a href="#7u16r1b90nu1guarsphc52q77n">/sys</a>, <a href="#112q33c950kh5hdg7ec2apas80">/proc</a>)</p>
<h3 class="topic">
<a name="52nmnc2oqnjhdbhp9lknbi93c4">&nbsp;&nbsp;при обнаружении на шине /bus нового устройства(которое мониторит ядро ОС и передает управление демону udev) </a>
</h3>
<p class="summary">(<a href="#098ooihg4njqu28renhot17mu3">udev</a>)</p>
<h3 class="topic">
<a href="https://learning.lpi.org/en/learning-materials/101-500/101/101.2/101.2_01/" name="51vmbb209cvphb79lt0hp8thk1">&nbsp;101.2 Boot the system (101.2 Lesson 1)&#13;
https://learning.lpi.org/en/learning-materials/101-500/101/101.2/101.2_01/</a>
</h3>
<h3 class="topic">
<a name="6i05dunv8t3jlrrpogdbqf3s77">&nbsp;&nbsp;BIOS</a>
</h3>
<h3 class="topic">
<a name="00ihjmfuv4vtomgupqah6imjjn">&nbsp;&nbsp;&nbsp;BIOS Reading CMOS&#13;
bootloader loaded by a pre-installed firmware such as BIOS or UEFI.&#13;
load kernel, setting hardware&#13;
load INIT process</a>
</h3>
<h3 class="topic">
<a name="2oqls4l1jv2rr2kgok63pr7q2h">&nbsp;&nbsp;&nbsp;steps to boot a system equipped with BIOS are:</a>
</h3>
<h3 class="topic">
<a name="7khtck1q2sp3jje09gi2vkbtp6">&nbsp;&nbsp;&nbsp;&nbsp;The POST (power-on self-test) process is executed to identify simple hardware failures as soon as the machine is powered on.</a>
</h3>
<h3 class="topic">
<a name="17p11kjrn64npte2e4qqa4a714">&nbsp;&nbsp;&nbsp;&nbsp;The BIOS activates the basic components to load the system, like video output, keyboard and storage media.</a>
</h3>
<h3 class="topic">
<a name="640u0889s7il47m4ufvc2rv94i">&nbsp;&nbsp;&nbsp;&nbsp;The BIOS loads the first stage of the bootloader from the MBR (the first 440 bytes of the first device, as defined in the BIOS configuration utility).</a>
</h3>
<h3 class="topic">
<a name="2adlr3311g2gdotcaikssc5ef2">&nbsp;&nbsp;&nbsp;&nbsp;The first stage of the bootloader calls the second stage of the bootloader, responsible for presenting boot options and loading the kernel.</a>
</h3>
<h3 class="topic">
<a name="4sr702e3mmsn7618qd6uvnaq58">&nbsp;&nbsp;UEFI</a>
</h3>
<h3 class="topic">
<a name="0r566loo4qpgijb61m8d74ek5j">&nbsp;&nbsp;&nbsp;setting from NVRAM</a>
</h3>
<h3 class="topic">
<a name="3luuu78hehjoc6lnod2lcqd7bd">&nbsp;&nbsp;&nbsp;&nbsp;Каталог EFI в разделе ESP содержит приложения, на которые указывают записи, сохраненные в NVRAM.</a>
</h3>
<h3 class="topic">
<a name="7npu2cd3q2643b3nu51j9o2lqr">&nbsp;&nbsp;&nbsp;EFI applications(bootloader, select OS, diagnnostic) on device partirion</a>
</h3>
<h3 class="topic">
<a name="7srt1pjafvpgeetciacv8tpibp">&nbsp;&nbsp;&nbsp;ESP EFI System Partition  - partitions with EFI applictions</a>
</h3>
<h3 class="topic">
<a name="2r4665b548bues89qfrcv4vmjt">&nbsp;&nbsp;&nbsp;system boot steps on a system with UEFI are:</a>
</h3>
<h3 class="topic">
<a name="2p6m26b9g6di9clp4fni4jt75k">&nbsp;&nbsp;&nbsp;&nbsp;The POST (power-on self-test) process is executed to identify simple hardware failures as soon as the machine is powered on.</a>
</h3>
<h3 class="topic">
<a name="24qrbr1bkrtbrit8o4uq2fni9o">&nbsp;&nbsp;&nbsp;&nbsp;The UEFI activates the basic components to load the system, like video output, keyboard and storage media.</a>
</h3>
<h3 class="topic">
<a name="0uav6c95p55loaetmgq3s4p1mq">&nbsp;&nbsp;&nbsp;&nbsp;UEFI&rsquo;s firmware reads the definitions stored in NVRAM to execute the pre-defined EFI application stored in the ESP partition&rsquo;s filesystem. Usually, the pre-defined EFI application is a bootloader.</a>
</h3>
<h3 class="topic">
<a name="351ivr77frd2dvtrh3foqlt1gm">&nbsp;&nbsp;&nbsp;&nbsp;If the pre-defined EFI application is a bootloader, it will load the kernel to start the operating system.</a>
</h3>
<h3 class="topic">
<a name="7okvmo2nnrcma9ofsfsq6qakga">&nbsp;&nbsp;&nbsp;The UEFI standard also supports a feature called Secure Boot,</a>
</h3>
<h3 class="topic">
<a name="7pm19439q648da5lg0g344rp9k">&nbsp;&nbsp;The Bootloader</a>
</h3>
<h3 class="topic">
<a name="4ti097gkmq387qnvvus608hjjb">&nbsp;&nbsp;&nbsp;GRUB 2</a>
</h3>
<h3 class="topic">
<a name="2f0ont79f9mi45k7odepf71b2h">&nbsp;&nbsp;&nbsp;&nbsp;pass new parameters</a>
</h3>
<h3 class="topic">
<a name="39rccish6mmh49tadh0e0qklgl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;option=value</a>
</h3>
<h3 class="topic">
<a name="0f1s013hlepf75r8qgs12mpf4e">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;acpi</a>
</h3>
<h3 class="topic">
<a name="6ohlsft0g2dcn3cgqlcmjgtgfg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enables/disables ACPI support. acpi=off will disable support for ACPI.</a>
</h3>
<h3 class="topic">
<a name="76h7l1pcpjqt39um9gaj68bjit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init</a>
</h3>
<h3 class="topic">
<a name="4bfte2aqgcalhdcd7co3itta6i">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sets an alternative system initiator. For example, init=/bin/bash will set shell Bash as the initiator. This means that a shell session will start just after the kernel boot process.</a>
</h3>
<h3 class="topic">
<a name="3g8kr5jp7offk4vrf169lomdcp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;systemd.unit</a>
</h3>
<h3 class="topic">
<a name="7v33c1hce3g8rrsoh8opirmu6o">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sets the systemd target to be activated. For example, systemd.unit=graphical.target.</a>
</h3>
<h3 class="topic">
<a name="7gva6tiijo9727i3a1tb9hbg15">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mem</a>
</h3>
<h3 class="topic">
<a name="2afcqbuivmv1krfdeub64183c7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sets the amount of available RAM for the system.</a>
</h3>
<h3 class="topic">
<a name="17783k1jt9ae3fj6qrt0u3ulbi">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;maxcpus</a>
</h3>
<h3 class="topic">
<a name="6dn8vmpkpgh1qf9j3uul1s4v4o">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;quiet</a>
</h3>
<h3 class="topic">
<a name="03rte9bn45rkgu895cll9h06oa">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hides most boot messages.</a>
</h3>
<h3 class="topic">
<a name="73om0j6f2on8r7nv01e9krss1u">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vga</a>
</h3>
<h3 class="topic">
<a name="7k8fhir4p4id8hccbgtfmrj14d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Selects a video mode. The parameter vga=ask will show a list of the available modes to choose from.</a>
</h3>
<h3 class="topic">
<a name="3n9063j66hgbf33v1qe0a3qn1d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;root</a>
</h3>
<h3 class="topic">
<a name="01ohpf26el94c1qjkf8e2ib4q3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sets the root partition, distinct from the one pre-configured in the bootloader. For example, root=/dev/sda3.</a>
</h3>
<h3 class="topic">
<a name="29shdksfp5lg0f17vl3ovp3k5o">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rootflags</a>
</h3>
<h3 class="topic">
<a name="3dis4k4jd3etjg5olq915aap3v">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mount options for the root filesystem.</a>
</h3>
<h3 class="topic">
<a name="69eb9a87oorkhalf8rs5t07oq1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/etc/default/grub</a>
</h3>
<h3 class="topic">
<a name="1hhqd6pcl84g5st747o0g8u3n0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/etc/default/grub</a>
</h3>
<h3 class="topic">
<a name="7kdvppvdvpimqkmqj8vb23ubvc">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;grub-mkconfig -o /boot/grub/grub.cfg</a>
</h3>
<h3 class="topic">
<a name="0qv25clvvm6ibn4ekn37iq9p1r">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/proc/cmdline</a>
</h3>
<h3 class="topic">
<a name="52aluomig0p4hokeoldpa6c7nn">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kernel parameters used for loading the current session are available for reading in the file /proc/cmdline</a>
</h3>
<h3 class="topic">
<a name="06hql1hk1mcsr7tej34ns83tjl">&nbsp;&nbsp;&nbsp;&nbsp;choose which one of the installed kernels should be loaded</a>
</h3>
<h3 class="topic">
<a name="4s7mi3fls3m5kgqoisi43kgev0">&nbsp;&nbsp;System Initialization</a>
</h3>
<h3 class="topic">
<a name="5f35p19quavvl2muomhacgl6oh">&nbsp;&nbsp;&nbsp;bootloader loads the kernel into RAM</a>
</h3>
<h3 class="topic">
<a name="4lgqa4gkem9mn4a3tk8v4dmmvq">&nbsp;&nbsp;&nbsp;The kernel will then open the initramfs (initial RAM filesystem). </a>
</h3>
<h3 class="topic">
<a name="0vlg3gli3d05ufqs3luil1a8vm">&nbsp;&nbsp;&nbsp;kernel will mount all filesystems configured in /etc/fstab and then will execute the INIT</a>
</h3>
<h3 class="topic">
<a name="6e1bjhcnm1uank2ctmpq4cpkk1">&nbsp;&nbsp;&nbsp;&nbsp;SysV standard</a>
</h3>
<h3 class="topic">
<a name="611dtbvqtvj57v8upvm3bjmtko">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;runlevels</a>
</h3>
<h3 class="topic">
<a name="7a161ksuonj62eo9g6q15f6dld">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;etc/init.d/* - services</a>
</h3>
<h3 class="topic">
<a name="489efhh0gerer9u5ctk683id2q">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;service * status/stop/start</a>
</h3>
<h3 class="topic">
<a name="5fc9r2gm38v2sa5p8u25n3ir3p">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;etc/inittab - default runlevel</a>
</h3>
<h3 class="topic">
<a name="02l19ladnocontbvsieka60udu">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc.* - скрипты управляения процессами для разных уровней загрузки&#13;
S90 - start, K60 -stop - 90 - порядок загрузки</a>
</h3>
<h3 class="topic">
<a name="4q11r4pl2huql5meb52dm0quke">&nbsp;&nbsp;&nbsp;&nbsp;systemd</a>
</h3>
<h3 class="topic">
<a name="74iftcniv80r90tdfr37pdp2t0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib/systemd/* - unit files</a>
</h3>
<h3 class="topic">
<a name="730tul6m6nud67cjrrjhnvtv3s">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unit </a>
</h3>
<h3 class="topic">
<a name="6p07orlv3qp3ahqdvjp7c0qs96">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;target</a>
</h3>
<h3 class="topic">
<a name="4scsi7gp5lamprb88g2rk58lll">&nbsp;&nbsp;&nbsp;&nbsp;Upstart</a>
</h3>
<h3 class="topic">
<a name="13mrsm6egql2na0opuk8i7s80m">&nbsp;&nbsp;&nbsp;Initialization Inspection</a>
</h3>
<h3 class="topic">
<a name="1u3dv3gmfsuvp97450s2m5b969">&nbsp;&nbsp;&nbsp;&nbsp;kernel ring buffer</a>
</h3>
<h3 class="topic">
<a name="7okalf5hra1v9a1gusegai6i65">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dmesg - show kernel ring buffer&#13;
dmesg --clear</a>
</h3>
<h3 class="topic">
<a name="40hldr4rlfs1uu2ru3e7mn83r7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[    5.705384] -time from start boot</a>
</h3>
<h3 class="topic">
<a name="78r8kof3co0uov7e8klk8i39il">&nbsp;&nbsp;&nbsp;&nbsp; journalctl  -b, --boot, -k or --dmesg</a>
</h3>
<h3 class="topic">
<a name="006vlukabdrnl5phu8pj47nkt4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;show the initialization messages</a>
</h3>
<h3 class="topic">
<a name="1hvn3lb7uav6irbnq4q1t8te39">&nbsp;&nbsp;&nbsp;&nbsp; journalctl --list-boots</a>
</h3>
<h3 class="topic">
<a name="4s00jfih9p3p4bpo5llhio1h8p">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;shows a list of boot numbers relative to the current boot</a>
</h3>
<h3 class="topic">
<a name="7vqr7iukrblkgsba4q3khrq1qp">&nbsp;&nbsp;&nbsp;&nbsp; journalctl -D --directory /var/log/journal/</a>
</h3>
<h3 class="topic">
<a name="09r0ivqiva6rgk18brus8buspq">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;log initialization</a>
</h3>
<h3 class="topic">
<a href="https://www.ibm.com/developerworks/ru/library/l-lpic1-v3-101-3/index.html?ca=drs-" name="27k3uc21dnlcp9d3bgkmb3ent2">&nbsp;101.3 Change runlevels / boot targets and shutdown or reboot system</a>
</h3>
</body>
</html>

