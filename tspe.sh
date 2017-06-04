#!/bin/bash

# Telepítési Script-ek Előtelepítési Környezet
# Készítette: Winizsol
# Licensz: GNU GPLv3

echo "Telepítési Script-ek Előtelepítési Környezet"
echo
echo "Szoftverek és betűjeleik listája: https://github.com/Winizsol/telepitesi-scriptek/blob/master/SZOFTVEREK.md"
read -p "Melyik szoftvert szeretné telepíteni? (betűjel) " choice
case "$choice" in 
  a|A ) cd ~ && mkdir winizsol && cd winizsol && mkdir telepitesi-scriptek && cd telepitesi-scriptek && wget -O winehq https://raw.githubusercontent.com/Winizsol/telepitesi-scriptek/master/wine.sh && chmod +x winehq && ./winehq && chmod -x winehq;;
  * ) echo "Érvénytelen válasz!";;
esac

# Források:
# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
