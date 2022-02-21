nmap -sP -n 172.16.13.0/24 | grep 172.16.13.* | awk {print } > /etc/subnet13
