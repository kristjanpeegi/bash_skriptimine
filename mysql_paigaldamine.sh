#!/bin/bash
# MySQL serveri paigaldusskript koos eeltööga
# Eeltöö: Uuenda MySQL versioonid apt repositooriumis
wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
dpkg -i mysql-apt-config*
# Taaskäivita apt, et lugeda sisse uued versioonid
apt update
# Kontrollime, kas MySQL-Server on juba installitud
if [ -x "$(command -v mysql)" ]; then
    echo "MySQL-Server on juba paigaldatud"
    # Kontrollime olemasolu
    mysql --version
    mysql
else
    # Paigaldame MySQL-Serveri
    echo "Paigaldame MySQLi ja vajalikud lisad"
    apt install -y default-mysql-server
    echo "MySQL on paigaldatud"
    # Lisame võimaluse kasutada mysql käsku ilma kasutaja ja parooli lisamiseta
    echo "[client]" >> $HOME/.my.cnf
    echo "host = localhost" >> $HOME/.my.cnf
    echo "user = root" >> $HOME/.my.cnf
    echo "password = Minukeerulineparool159!" >> $HOME/.my.cnf
    # Taaskäivita MySQL teenus, et see tunneks ära .my.cnf faili
    systemctl restart mysql
fi

# Skripti lõpp
