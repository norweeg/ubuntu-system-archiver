#!/bin/bash
#Default values.
RETURN_DIR=$(pwd)
CURRENT_SYSTEM_RELEASE_CODENAME=$(lsb_release -sc)
CURRENT_SYSTEM_VERSION=$(lsb_release -sr)
CURRENT_SYSTEM_DESCRIPTION=$(lsb_release -sd)
TEMP_WORKING_DIR="$HOME/.$HOSTNAME-backup"
OUTPUT_FILE="$HOME/$HOSTNAME-backup.tar.gz"
CONFIGS_TO_ARCHIVE="/etc/apt/ /etc/minidlna.conf /etc/samba/smb.conf /etc/fstab"
echo "Creating backup of $HOSTNAME running $CURRENT_SYSTEM_DESCRIPTION ($CURRENT_RELEASE_CODENAME)"
#creating temporary working directory
mkdir -p $TEMP_WORKING_DIR && cd "$_"
#getting the codename for the current system being backed up.  Need this for
#comparison on
echo "Writing backup system information to file..."
echo $CURRENT_RELEASE_CODENAME > backup-system-codename
echo $CURRENT_SYSTEM_VERSION >backup-system-version
#create an archive configuration files/directories
echo "Archiving configuration directories..."
mkdir -p ./config-archive && cp -at ./config-archive $CONFIGS_TO_ARCHIVE
#get all package markings
echo "Getting installed packages..."
dpkg --get-selections > installed-packages
#compress everything into tarball
echo "Compressing backup file..."
cd `dirname $TEMP_WORKING_DIR`
tar -czf $OUTPUT_FILE `basename $TEMP_WORKING_DIR`
#cleanup TEMP_WORKING_DIR
echo "Cleaning up..."
rm -Rf $TEMP_WORKING_DIR
echo "Done!  Backup stored in $OUTPUT_FILE."
cd $RETURN_DIR
