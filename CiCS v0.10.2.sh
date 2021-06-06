#!/bin/bash
#CiCS v0.10.2 Menu
#Caras iPhone Connection System
me="$(whoami)"
options[0]="Install CiCS Dependencies"
options[1]="Connect to iPhone"
options[2]="Disconnect from iPhone"
options[3]="Backup iPhone Music to your Computer"
options[4]="Backup iPhone photos to your Computer"
options[5]="Sync Computer photos to your iPhone-DO NOT USE-NOT WORKING YET."
options[6]="Exit"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
    echo "Please hit enter and type your password"
    sudo apt update
    
function work-list () {

echo "# Creating iBackup Folder on your desktop"
echo "1"
mkdir /home/$me/Desktop/iBackup || true

echo "# Creating sub-directory iBackup/iMusic"
echo "5"
mkdir /home/$me/Desktop/iBackup/iMusic || true

echo "# Creating sub-directory iBackup/iPhotos"
echo "10"
mkdir /home/$me/Desktop/iBackup/iPhotos || true

echo "# Installing libgcrypt20-doc" 
echo "15"
sudo apt install libgcrypt20-doc || true

echo "# Installing gmp-doc" 
echo "20"
sudo apt install gmp-doc || true

echo "# Installing libgmp10-doc" 
echo "25"
sudo apt install libgmp10-doc || true

echo "# Installing libmpfr-dev" 
echo "30"
sudo apt install libmpfr-dev || true

echo "# Installing gnutls-bin"
echo "35"
sudo apt install gnutls-bin || true

echo "# Installing gnutls-doc"
echo "40"
sudo apt install gnutls-doc || true

echo "# Installing ideviceinstaller"
echo "45"
sudo apt install ideviceinstaller || true

echo "# Installing python-imobiledevice"
echo "50"
sudo apt install python-imobiledevice || true

echo "# Instlling libimobiledevice-utils"
echo "55"
sudo apt install libimobiledevice-utils || true

echo "# Installing libimobiledevice"
echo "60"
sudo apt install libimobiledevice6 || true

echo "# Installing libimobiledevice-dev"
echo "100"
sudo apt install libimobiledevice-dev || true

echo "# Installing libplist3"
echo "65"
sudo apt install libplist3 || true

echo "# Installing python3-plist"
echo "70"
sudo apt install python3-plist || true

echo "# Installing ifuse"
echo "75"
sudo apt install ifuse || true

echo "# Installing usbmuxd"
echo "80"
sudo apt install usbmuxd || true

echo "# Updating APT"
echo "90"
sudo apt update || true

echo "# creating additional directories"
echo "100"
sudo mkdir /media/iPhone
sudo chmod 777 /media/iPhone

}

work-list | zenity --progress --title "Installing CiCS Dependencies" --auto-close

exit 0
    fi
    if [[ ${choices[1]} ]]; then
	idevicepair pair || true
	zenity --info --width 300 --text "Unlock your iPhone and touch 'Trust' Connection, than hit the Enter key"
	idevicepair pair
	ifuse /media/iPhone
    fi
    if [[ ${choices[2]} ]]; then
	fusermount -u /media/iPhone || true
	zenity --info --width 300 --text "Your iPhone Has Succesfully been unmounted. you may now disconnect it from your Computer"
    fi
    if [[ ${choices[3]} ]]; then
    	zenity --info --width 300 --text "You selected: Backup iPhone Music to your Computer."
    	cd /media/iPhone
	find /media/iPhone \( -name "*.m4a" -o -name "*.mp3" \) -exec cp -r {} /home/$me/Desktop/iBackup/iMusic \;
	zenity --info --width 300 --text "Your purchased Tracks have been placed in a folder named 'iMusic' within th folder dubbed 'iBackup', on your Desktop"
    fi
    if [[ ${choices[4]} ]]; then
        zenity --info --width 300 --text "You selected: Backup iPhone photos to your Computer"
	cd /media/iPhone
	find /media/iPhone \( -name "*.JPG" -o -name "*.PNG" -o -name "*.JPEG" -o -name "*.GIF" \) -exec cp -r {} /home/$me/Desktop/iBackup/iPhotos \;
    fi
    if [[ ${choices[5]} ]]; then #iPhones rename all saved images and (I beleive) stores them in hidden subfolders within DCIM script a way to auto/bulk re-name files and this option SHOULD work. (the same could THEORETICALLY be used to copy your music to your iPhone too :P
	find /home/$me/Desktop/iBackup/iPhotos \( -name "*.JPG" -o -name "*.PNG" -o -name "*.JPEG" -o -name "*.GIF" \) -exec cp {} /media/iPhone/DCIM/100APPLE \;
        echo "You selected: Sync Computer photos to your iPhone"
    fi #Apple does something weird when saving photos, so while this SHOULD work, images dont show up on the iphone. I think its similair to the .m4a/plist issue. could also be a image name-needs-to-be-a-date issue.
    if [[ ${choices[6]} ]]; then
	read -p "Bye!"
    fi
}

#Variables 
ERROR= ""

#Clear screen for menu
clear

#Menu function
function MENU {
    echo "CiCS v0.10.2 Menu"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop (idk what to do with this bit honestly x.x"...)
while MENU && read -e -p "Please make a choice.. " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
