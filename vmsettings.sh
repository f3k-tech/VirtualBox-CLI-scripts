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
echo "---------------------------------------------------"
echo "Please poweroff the machine."
echo "This command should do the trick:"
echo "VBoxManage controlvm "$name" acpipowerbutton"
echo "---------------------------------------------------"

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

# Show the new settings of the selected VM
show_vmsettings

# Show start command
echo "Use the following command to start your VM headless"
echo "VBoxManage startvm "$name" --type headless"