# VirtualBox-CLI-scripts

Install and Edit Virtualbox virtual machines from the command line.

## Important notes

* Don't quote paths.
* Escape with backslashes is allowed but not needed.

## createvm.sh

This simple script creates a minimal and standard virtual machine:

* Creates virtual machine
* Sets the OS type
* Sets groupID (Optional)
* Creates and adds virtual harddrive (Optional)
* Adds installation image (Optional)

The script is quite simple so it should be easy to adapt to your own needs. Feel free to contribute if you have any improvements.

## What's supported?

The following setups have been tested, but I'm quite confident it will work with other setups as well.

| Host OS      | Guest OS     | Install medium | HDD   | VBox Version |
| :----------- | :----------- | :------------: | :---: | :----------: |
| Ubuntu 18.04 | Windows 10   | ISO            | vmdk  | 6.1          |
| Ubuntu 18.04 | Ubuntu 18.04 | ISO            | vmdk  | 6.1          |
