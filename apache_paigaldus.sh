#!/bin/bash
# Apache paigaldusskript
# Skript kontrollib, kas teenus Apache on installitud.
# Kui vastus on 0, siis skript alustab Apache installimisega.
# Kui vastus on 1, skript väljastab teate, et Apache on installitud ja seda uuesti installima ei hakka.

APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'install ok installed')

# Kui vastus on 0, siis skript alustab Apache installimisega.
if [ $APACHE2 -eq 0 ]; then
    echo "Paigaldan Apache2"
    apt update
    apt install -y apache2
    echo "Apache2 on edukalt installitud"
# Kui vastus on 1, skript väljastab teate, et Apache on installitud ja seda uuesti installima ei hakka.
elif [ $APACHE2 -eq 1 ]; then
    echo "Apache2 on juba paigaldatud"
    service apache2 start
    service apache2 status
fi
