# VirtualBox-CLI-scripts

Install and Edit Virtualbox virtual machines from the command line.

## Important notes

* Don't quote paths.
* Escape with backslashes is allowed but not needed.

## vmcreate.sh

This simple script creates a virtual machine with standard settings:

* Creates virtual machine
* Sets the OS type
* Sets groupID (Optional)
* Creates and adds virtual harddrive (Optional)
* Adds installation image (Optional)

The script is quite simple so it should be easy to adapt to your own needs. Feel free to contribute if you have any improvements.

## vmsettings.sh

You can change the following basic settings with this script:

* Change name
* Change groups
* Change memory
* Change amount of CPU's
* Change CPU exec cap
* Choose between NAT and Bridged Adapter

More features are expected soon.

## What's supported?

The following setups have been tested, but I'm quite confident it will work with other setups as well.

| Host OS      | Guest OS     | Installation Medium | HDD   | VBox Version |
| :----------- | :----------- | :-----------------: | :---: | :----------: |
| Ubuntu 18.04 | Windows 10   | ISO                 | vmdk  | 6.1          |
| Ubuntu 18.04 | Ubuntu 18.04 | ISO                 | vmdk  | 6.1          |
