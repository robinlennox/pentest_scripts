#!/bin/bash

#Global Variables
TOOLSDIRECTORY=~/Desktop/tools
HIGHLIGHT="#############################################################"

# Check Running as bash
check_running_bash=$(hash)

if [ -z ${check_running_bash} ] &>/dev/null ; then
	clear
	echo "Not running as bash - Try bash filename.sh not sh filename.sh"
	exit;
fi

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly PWD #Prevent changing PWD from CD in scripts

# Import Function
source ${PWD}/includes/nice_print.sh

# Disable GNOME Keyring Control
unset GNOME_KEYRING_CONTROL

#Disable Output
exec 1>/dev/null 2>/dev/null

# Script prerequisites
for DEPENDPKG in build-essential curl git make subversion
do
	dpkg -s ${DEPENDPKG} 2>&1 | grep -o Installed-Size
	if [ $? != 0 ] ; then
		PRINT_GOOD "Install Script Dependency - ${DEPENDPKG}"
		sudo apt-get -y install ${DEPENDPKG}
	fi
done

PRINT_MESSAGE "Update Tools Script"
source ${PWD}/includes/check_internet.sh
source ${PWD}/includes/check_root.sh
source ${PWD}/includes/ubuntu_update.sh
source ${PWD}/includes/keepassx.sh