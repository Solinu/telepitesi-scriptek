#!/bin/bash

# Készítette: Winizsol
# Licensz: GNU GPLv3
# Ez a script a Telepítési Scriptek repository része. https://github.com/Winizsol/telepitesi-scriptek

echo "LAMP Server Telepítési Script"
echo "A telepítés követelményei:"
echo " - Debian-alapú vagy Red Hat-alapú (legalább Red Hat 7.x) Linux-disztribúció"
read -p "Szeretné telepíteni a LAMP Server-t? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	clear
	# Ha a disztribúció használja az APT-et... aka. Debian-alapú
	if [ "$(command -v apt)" ]; then
		read -p "A telepítés során többször fog adatokat bekérni a telepítő. Ilyenkor kövesse a képernyőn megtalálható utasításokat! Szeretné folytatni? Ha igen, nyomja meg az Enter/Return billentyűt!"
		# Repo-k frissítése
		sudo apt update
		clear
		# cURL telepítése
		sudo apt install curl
		clear
		# Apache2 telepítése
		sudo apt install apache2
		clear
		# Apache engedélyezése a tűzfalon
		sudo ufw allow in "Apache Full"
		clear
		# MySQL szerver telepítése
		sudo apt install mysql-server
		clear
		# MySQL biztonsági telepítés elindítása
		sudo mysql_secure_installation
		clear
		# PHP, PHP LibApache2 mod, PHP MCrypt mod és PHP MySQL mod telepítése
		sudo apt install php libapache2-mod-php php-mcrypt php-mysql
		clear
		read -p "A telepítés nagy részével elkészültünk, de még néhány dolgot be kell állítani. Nyomja meg az Enter/Return billentyűt a folytatáshoz!"
		clear
		echo "Elsőként be kell írni a szerver címét. Most megnyitjuk az Apache konfigurációt. Keresse meg a ServerName részt vagy ha még nincs, akkor a fájl végére írja és írja be a szerver címét."
		echo "Példa:"
		echo "ServerName 192.168.1.2"
		echo "Lejjebb megtalálhatja a számítógépe/szervere által megállapított IP-cím(ek)et és a nyilvános IP-címét. Ha ezt egy nyilvános weboldalhoz szeretné használni, akkor a lenti címet használja. Ha például teszteléshez szeretné használni akkor a fentibbek közül valamelyiket, de nem biztos, hogy mind működni fog. Most csak egyet próbálhat ki. Egyébként ezek általában 192.168-cal kezdődnek, de ez nem mindig így van."
		# Helyi IP-cím kiírása
		ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
		# Publikus IP-cím kiírása
		curl http://icanhazip.com
		read -p "Nyomja meg az Enter/Return billentyűt a folytatáshoz!"
		# Apache2 konfiguráció megnyitása nano-ban
		sudo nano /etc/apache2/apache2.conf
		# Konfiguráció letesztelése
		sudo apache2ctl configtest
		# Apache2 újraindítása
		sudo systemctl restart apache2
		echo "Most az lesz a dolga, hogy a PHP konfigurációban keresse meg ezt: <IfModule mod_dir.c> DirectoryIndex"
		echo "Utána az index.php-t törölje ki és írja egy szóközzel a DirectoryIndex után!"
		read -p "Nyomja meg az Enter/Return billentyűt a folytatáshoz!"
		# Apache2 konfiguráció megnyitása nano-ban
		sudo nano /etc/apache2/mods-enabled/dir.conf
		# Apache2 újraindítása
		sudo systemctl restart apache2
		clear
		echo "A telepítéssel és a konfigurációval végeztünk. Most a teszteléshez szükséges fájlokat beszerezzük."
		# Belépés a /var/www/html mappába
		cd /var/www/html
		# winizsol-testing mappa létrehozása
		sudo mkdir winizsol-testing
		# Belépés a létrehozott mappába
		cd winizsol-testing
		# Teszteléshez szükséges fájlok letöltése
		sudo wget -O apache.html https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/apache_test.html
		sudo wget -O php.php https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/php_test.php
		sudo wget https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/style.css
	elif [ "$(command -v yum)" ]; then
		read -p "A telepítés során többször fog adatokat bekérni a telepítő. Ilyenkor kövesse a képernyőn megtalálható utasításokat! Szeretné folytatni? Ha igen, nyomja meg az Enter/Return billentyűt!"
		# Repo-k frissítése
		sudo yum update
		clear
		# HTTPD/Apache telepítése
		sudo yum install httpd
		# HTTPD elindítása
		sudo systemctl start httpd.service
		# HTTPD engedélyezése
		sudo systemctl enable httpd.service
		clear
		# MariaDB(MySQL), MariaDB szerver telepítése
		sudo yum install mariadb-server mariadb
		# MariaDB elindítása
		sudo systemctl start mariadb
		clear
		# MySQL biztonsági telepítés elindítása
		sudo mysql_secure_installation
		clear
		# MariaDB engedélyezése
		sudo systemctl enable mariadb.service
		clear
		# PHP és PHP MySQL mod telepítése
		sudo yum install php php-mysql
		# HTTPD újraindítása
		sudo systemctl restart httpd.service
		# Belépés a /var/www/html mappába
		cd /var/www/html
		# winizsol-testing mappa létrehozása
		sudo mkdir winizsol-testing
		# Belépés a létrehozott mappába
		cd winizsol-testing
		# Teszteléshez szükséges fájlok letöltése
		sudo curl -o apache.html -L https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/apache_test.html
		sudo curl -o php.php -L https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/php_test.php
		sudo curl -o style.css -L https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/eszkozok/style.css
	else
		echo "Sajnos a LAMP Szerver telepítő még nem elérhető erre a Linux-disztribúcióra vagy Ön nem egy Linux-disztribúciót használt!"
	fi
	cd ~
	clear
	echo "Tesztelési fájlok beszerezve. Hogy letesztelje az Apache-t, írja be egy böngészőbe: szervercim/winizsol-testing/apache.html Hogy letesztelje a PHP-t, írja be egy böngészőbe: szervercim/winizsol-testing/php.php"
	echo "A telepítés befejeződött. Ha valamilyen probléma merülne fel, jelentse itt: https://github.com/Winizsol/telepitesi-scriptek/issues"
	echo "Köszönöm, hogy a script-emet használta,"
	echo "Winizsol."
fi

# Források:
# Disztribúció-felismerés: https://github.com/quidsup/flashless-extras
# LAMP telepítés CentOS: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7
# LAMP telepítés Ubuntu: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04