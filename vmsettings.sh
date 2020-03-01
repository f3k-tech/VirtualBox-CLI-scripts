#!/bin/bash

# Ask for name
read -e -i "$1" -p "Enter name of the new VBox:" input
name=${input:-"$1"}