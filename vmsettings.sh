#!/bin/bash

# List VBoxes:
echo "List of Virtual Machines:"
VBoxManage list vms

# Ask for name
read -e -i "$1" -p "Enter name of the VBox you'd like to edit:" input
name=${input:-"$1"}

