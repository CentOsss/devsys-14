#!/bin/bash
ssh-keygen -t rsa
ssh-copy-id root@172.16.0.36
ssh-copy-id rabid@bsd
ssh-copy-id rabid@intra
ssh-copy-id root@domino

