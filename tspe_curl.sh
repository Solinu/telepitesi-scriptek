#!/bin/bash

# Telepítési Script-ek Előtelepítési Környezet
# Készítette: Winizsol
# Licensz: GNU GPLv3

echo "Telepítési Script-ek Előtelepítési Környezet"
echo
echo "Szoftverek és betűjeleik listája: https://github.com/Winizsol/telepitesi-scriptek/blob/master/SZOFTVEREK.md"
read -p "Melyik szoftvert szeretné telepíteni? (betűjel) " choice
case "$choice" in 
  a|A ) cd ~/winizsol && curl -o winehq -L https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/wine.sh && chmod +x winehq && ./winehq && chmod -x winehq;;
  #b|B ) cd ~/winizsol && curl -o lamp -L https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/lamp.sh && chmod +x lamp && ./lamp && chmod -x lamp;;
  * ) echo "Érvénytelen válasz!";;
esac

# Források:
# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
