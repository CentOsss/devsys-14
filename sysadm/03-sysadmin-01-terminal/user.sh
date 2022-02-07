#!/bin/bash
groupadd prog
for user in $(cat ./users) # list of users
do
  useradd -g prog -p $(openssl passwd 12348765) $user #set default passwd
  chage -d 0 $user #
  echo "$user ALL=(ALL:ALL)" ALL >> /etc/sudoers
  done
