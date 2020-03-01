#!/bin/bash

#############
# Functions #
#############

show_vmsettings() {
    # Show current settings of VM
    echo "---------------------------------------------------"
    echo "VBox settings for $name"
    echo "---------------------------------------------------"
    VBoxManage showvminfo "$name" | grep "Name:"
    VBoxManage showvminfo "$name" | grep "Groups:"
    groups=$(VBoxManage showvminfo "$name" | grep "Groups:" | sed "s/Groups://" | tr -d " ")
    VBoxManage showvminfo "$name" | grep "Memory size"
    memsize=$(VBoxManage showvminfo "$name" | grep "Memory size" | tr -d "Memory size:B")
    VBoxManage showvminfo "$name" | grep "CPU exec cap"
    cpucap=$(VBoxManage showvminfo "$name" | grep "CPU exec cap"| tr -d "CPU exec cap:%")
    VBoxManage showvminfo "$name" | grep "Number of CPUs"
    cpunr=$(VBoxManage showvminfo "$name" | grep "Number of CPUs" |tr -d "Number of CPUs:")
    VBoxManage showvminfo "$name" | grep "NIC 1"
    echo "---------------------------------------------------"
}

# List VMs:
echo "---------------------------------------------------"
echo "List of Virtual Machines:"
echo "---------------------------------------------------"
VBoxManage list vms
echo "---------------------------------------------------"

# Ask for name
read -e -i "$1" -p "Enter name of the VM you'd like to edit:" input
name=${input:-"$1"}

# Show the settings of the selected VM
show_vmsettings

# Propose command to poweroff VM
echo "Please poweroff the machine."
echo "This command should do the trick:"
echo "VBoxManage controlvm "$name" acpipowerbutton"


# Change Name
echo "---------------------------------------------------"
read -e -i "$name" -p "Change name: " input
newname=${input:-"$name"}
VBoxManage modifyvm "$name" --name "$newname"
name="$newname"
show_vmsettings # Update settings with new name

# Change groups
echo "---------------------------------------------------"
groups="$groups"
read -e -i "$groups" -p "Change groups (format: \"/group\" default: \"/\"): " input
groups=${input:-"$groups"}
VBoxManage modifyvm "$name" --groups "$groups"

# Change memory
echo "---------------------------------------------------"
memsize="$memsize"
read -e -i "$memsize" -p "New memory size (MB): " input
memsize=${input:-"$memsize"}
VBoxManage modifyvm "$name" --memory "$memsize"

# Change CPU exec cap
echo "---------------------------------------------------"
cpucap="$cpucap"
read -e -i "$cpucap" -p "New CPU exec cap (%): " input
cpucap=${input:-"$cpucap"}
VBoxManage modifyvm "$name" --cpuexecutioncap "$cpucap"

# Change Amount of CPU's
echo "---------------------------------------------------"
cpunr="$cpunr"
read -e -i "$cpunr" -p "New amount of CPU's: " input
cpunr=${input:-"$cpunr"}
VBoxManage modifyvm "$name" --cpus "$cpunr"

# Change adapter
echo "---------------------------------------------------"
echo "Change network adapter?"
oslist=(
    "Skip"
    "NAT"
    "Bridged"
)
select ostype in "${oslist[@]}"
do
    case $ostype in
        "Skip")
            break;;
        "NAT")
            VBoxManage modifyvm "$name" --nic1 nat
            break;;
        "Bridged")
            echo "Use \"ip a\" to list adapters"
            # Prompt for adapter number
            adapternr="1"
            read -e -i "$adapternr" -p "Adapter number: " input
            adapternr=${input:-"$adapternr"}
            "Prompt for adapter"
            adapternr="eth0"
            read -e -i "$adapternr" -p "Adapter: " input
            adapter=${input:-"$adapter"}
            VBoxManage modifyvm "$name" --nic1 bridged --bridgeadapter$adapternr "$adapter"
            break;;
        *)  break;;
    esac
done

# Show the new settings of the selected VM
show_vmsettings

# Show start command
echo "Use the following command to start your VM headless"
echo "VBoxManage startvm "$name" --type headless"