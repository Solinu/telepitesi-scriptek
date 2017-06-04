#!/bin/bash

# Készítette: Winizsol
# Licensz: GNU GPLv3

echo "==================== Wine Telepítési Script ===================="
echo "A telepítés követelményei:"
echo " - Ubuntu vagy Ubuntu-alapú Linux-disztibúció (Linux Mint nem megfelelő)"
echo " - Internetkapcsolat"
echo " - Legalább 1 GB szabad tárhely (kevesebb, mint 1 GB lesz felhasználva)"
echo
echo "NAGYON FONTOS"
echo " - Mivel a Wine képes Windows bináris kódot futtatni, ezért Unix-szerű operációs rendszereket is érintű vírusok futtatására is alkalmas. A Wine a legtöbb vírust futtatni tudja a bejelentkezett falhasználó jogosultságaival, és ezért a legtöbb következményt meg tudja gátolni. Ezért a Wine fejlesztői azt javasolják, hogy SOHA NE FUTTASSUK A WINE-T SUPERUSER/ROOT-KÉNT!"
echo " - A GCC is telepítésre kerül, hogy a 64-bites számítógépeken 64-bites Windows alkalmazások futtatására is alkalmas legyen a Wine."
echo " - Erre a script-re a GNU General Public License 3-as verziója, vagy újabb vonatkozik. Egyéb információ a script GitHub-oldalán."
# Visszaigazolás kérése a felhasználótól
read -p "Szeretné telepíteni a Wine-t és megfelel a követelményeknek? (y/n) " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Terminál tartalmának törlése
    clear
    # Architektúra észlelése
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
        # 32-bites kompatibilitás engedélyezése
        sudo dpkg --add-architecture i386 
    fi
    # Kulcs letöltése
    wget -nc https://dl.winehq.org/wine-builds/Release.key
    # Letöltött kulcs beimportálása
    sudo apt-key add Release.key
    # Wine Ubuntu Repo hozzáadása
    sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
    # Repo-k frissítése
    sudo apt update
    # Terminál tartalmának törlése
    clear
    # Figyelmeztetés a Wine telepítése előtt
    echo "FIGYELMEZTETÉS"
    echo "Előfordulhat, hogy az apt problémázni fog nem telepített függőségek miatt. Ebben az esetben manuálisan kell telepíteni a függőségeket és ezért a Wine telepítés naplói nem kerülnek törlésre a Terminálból, de minden másé igen."
    read -p "Nyomja meg Enter/Return gombot a folytatáshoz vagy a Ctrl+C billentyűkombinációt a megszakításhoz!"
    # Terminál tartalmának törlése
    clear
    # GCC telepítése
    sudo apt install -y gcc
    # Terminál tartalmának törlése
    clear
    # A legújabb stabil Wine telepítése.
    sudo apt install --install-recommends -y winehq-stable
    # Kitakarítás
    sudo apt autoremove -y
    # Vége
    echo "Köszönjük, hogy ezt a script-et használta!"
fi

# Források:
# Visszaigazolások: https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
# Architektúra megkülönböztető: https://stackoverflow.com/questions/106387/is-it-possible-to-detect-32-bit-vs-64-bit-in-a-bash-script
# Gombnyomás a folytatáshoz: https://unix.stackexchange.com/questions/293940/bash-how-can-i-make-press-any-key-to-continue
# Parancsok a telepítéshez: https://wiki.winehq.org/Ubuntu
# Figyelmeztetés: https://en.wikipedia.org/wiki/Wine_%28software%29
