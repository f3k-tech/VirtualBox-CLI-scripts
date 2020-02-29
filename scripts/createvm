#!/bin/bash

# Ask for name
read -p "Enter name of the new VBox:" name

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
            echo "Enter os ID (use "VBoxManage list ostypes" to list os types):"
            read os
            break;;
        *)  break;;
    esac
done

# Prompt for folder
basefolder="/home/$USER/VirtualBox VMs/"
read -e -i "$basefolder" -p "Path of basefolder: " input
basefolder=${input:-"$basefolder"}

# Prompt for group
read -p "Add group ID (leave empty if no group):" groupid
if [-n "$groupid"];
then
    groupcmd="--groups $groupid"
fi

# Prompt for installation file
read "What type of medium will you use for installation?"
mediumlist=(
    "disk"
    "dvd"
    "floppy"
)

# Prompt for confirmation
echo ""
echo "--------------------------------------------------------------------"
echo "Are you sure you wish to install a VBox with the following settings?"
echo "--------------------------------------------------------------------"
echo "Name:         $name"
echo "OS:           $ostype"
echo "Basefolder:   $basefolder"
echo "Group ID      $groupid"
echo "--------------------------------------------------------------------"
echo ""
select yn in "Yes" "No"; do
    case $yn in
    Yes ) break;;
    No ) exit;;
esac
done

# Create VBox and register
VBoxManage createvm --name "$name" $groupcmd --ostype $ostype --register --basefolder "$basefolder"  --default

