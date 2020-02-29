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
        VBoxManage createhd --filename "$filename" --size 5120 --variant Standard
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

        #VBoxManage storagectl "$name" --name "SATA" --add sata
        VBoxManage storageattach "$name" --storagectl "SATA" --port 0  --device 0 --type dvddrive --medium "$filename"

        break;;
    No ) break;;
esac
done

echo ""
echo "Start your Vbox with the following command:"
echo "VBoxManage startvm $name"