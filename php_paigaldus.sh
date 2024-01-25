#!/bin/bash


# Skript kontrollib kas PHP on juba paigaldatud. Kui ei ole siis paigaldab selle.
# Lisaks kontrollib kas lisamoodulid on paigaldatud. Kui ei ole siis paigaldab need.
# Apache teenuse olemasolul käivitab selle.

# Funktsioon kontrollib, kas pakett on juba paigaldatud
is_package_installed() {
    dpkg -l | grep -q "^ii\s*$1"
}

# Paigaldan PHP teenus
if is_package_installed php7.3; then
    echo "PHP 7.3 on juba paigaldatud."
else
    echo "PHP 7.3 ei ole paigaldatud. Paigaldame..."
    apt update
    apt install -y php7.3
fi

# Paigaldan libapache2-mod-php7.3
if is_package_installed libapache2-mod-php7.3; then
    echo "libapache2-mod-php7.3 on juba paigaldatud."
else
    echo "libapache2-mod-php7.3 ei ole paigaldatud. Paigaldame..."
    apt install -y libapache2-mod-php7.3
fi

# Paigaldan php7.3-mysql
if is_package_installed php7.3-mysql; then
    echo "php7.3-mysql on juba paigaldatud."
else
    echo "php7.3-mysql ei ole paigaldatud. Paigaldame..."
    apt install -y php7.3-mysql
fi

# Skript kontrollib, kas Apache teenus on paigaldatud enne selle taaskäivitamist
if is_package_installed apache2; then
    # Taaskäivita Apache teenus
    systemctl restart apache2
    echo "Apache teenus on taaskäivitatud."
else
    echo "Apache teenus ei ole paigaldatud, seega taaskäivitamist ei tehta."
fi

echo "PHP teenus on paigaldatud koos vajalike pakettidega."
