#!/bin/bash

# Ask for name
read -e -i "$1" -p "Enter name of the new VBox:" input
name=${input:-"$1"}

# Choose OS type
echo "What OS are you going to install?"
oslist=(
    "Ubuntu"
    "Ubuntu_64"
    "Windows10"
    "Windows10_64"
    "Other"
)
select ostype in "${oslist[@]}"
do
    case $ostype in
        "Other")
            echo "Enter os ID (use \"VBoxManage list ostypes\" to list os types):"
            read os
            break;;
        *)  break;;
    esac
done

# Prompt for folder
basefolder="/home/$USER/VirtualBox VMs"
read -e -i "$basefolder" -p "Path of basefolder: " input
basefolder=${input:-"$basefolder"}

# Prompt for group
read -p "Add group ID (leave empty if no group):" groupid
if [-n "$groupid"];
then
    groupcmd="--groups $groupid"
fi

# Create VM
VBoxManage createvm --name "$name" $groupcmd --ostype $ostype --register --basefolder "$basefolder"  --default

# Prompt to create HDD
echo "Would you like to add a harddrive to the VBox?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
        # Prompt for HD filepath and name
        hdname="$basefolder/$name/$name.vmdk"
        read -e -i "$hdname" -p "Filename of the HDD: " input
        hdname=${input:-"$hdname"}
        VBoxManage createhd --filename "$hdname" --size 25600 --variant Standard
        VBoxManage storageattach "$name" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$hdname"
        break;;
    No ) break;;
esac
done


# Prompt to attach image
echo "Would you like to add an image (e.g. installation dvd)?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
        # prompt for installation medium and path
        imgname="$basefolder/image.iso"
        read -e -i "$imgname" -p "Provide full path to the image (iso/vmdk etc): " input
        imgname=${input:-"$imgname"}
        VBoxManage storageattach "$name" --storagectl "SATA" --port 1  --device 0 --type dvddrive --medium "$imgname"
        break;;
    No ) break;;
esac
done

# Prompt for confirmation
echo ""
echo "--------------------------------------------------------------------"
echo "Summery:"
echo "--------------------------------------------------------------------"
echo "Name:         $name"
echo "OS:           $ostype"
echo "Basefolder:   $basefolder"
echo "Group ID:     $groupid"
echo "HardDrive:    $hdname"
echo "Image:        $imgname"
echo "--------------------------------------------------------------------"


echo ""
echo "Start your Vbox with the following command:"
echo "VBoxManage startvm $name"

