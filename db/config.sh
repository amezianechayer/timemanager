#!/bin/bash
service postgresql start
echo "listen_addresses = '*'" >> /etc/postgresql/17.0.1/main/postgresql.conf
echo "port = 5432" >> /etc/postgresql/17.0.1/main/postgresql.conf
echo "host    all             all             192.168.1.0/24          md5" >> /etc/postgresql/17.0.1/main/pg_hba.conf
service postgresql restart
