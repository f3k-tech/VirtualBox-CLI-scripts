#!/bin/bash

# Ask for the name of the VBox they'd like to change
read -p "Enter the name of the VBox you'd like to use:" name

# Prompt to create HDD
echo "Would you like to add a harddrive to the VBox?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
        # Prompt for HD filepath and name
        filename="/home/$USER/VirtualBox VMs/$name/$name.vmdk"
        read -e -i "$filename" -p "Filename of the HDD: " input
        filename=${input:-"$filename"}
        VBoxManage createhd --filename $filename --size 5120 --variant Standard
        break;;
    No ) break;;
esac
done


# Prompt to create HDD
echo "Would you like to add an installation medium (image)?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
        # prompt for installation medium and path
        filename="/home/$USER/VirtualBox VMs/installation-medium.iso"
        read -e -i "$filename" -p "Provide full path to the image (iso/vmdk etc): " input
        filename=${input:-"$filename"}

        VBoxManage storagectl "$name" --name "SATA" --add sata
        VBoxManage storageattach "$name"--storagectl "SATA" --medium "$filename"

        break;;
    No ) exit;;
esac
done

echo "The following image is attached:"
VBoxManage showvminfo OracleLinux6Test | grep "$name"
echo ""
echo "Start your Vbox with the following command:"
echo "VBoxManage startvm $name"