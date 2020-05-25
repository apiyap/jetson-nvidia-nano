#change the mode to MAX-N, issue
sudo nvpmodel -m 0

set -e
#install Swapfile
SWAPDIRECTORY="/mnt"
# Ubuntu recommends 6GB for 4GB of memory when using suspend
# You can use 1 or 2 if need be
SWAPSIZE=6
echo "Creating Swapfile at: " $SWAPDIRECTORY
echo "Swapfile Size: " $SWAPSIZE"G"
#Create a swapfile for Ubuntu at the current directory location
sudo fallocate -l $SWAPSIZE"G" $SWAPDIRECTORY"/swapfile"
cd $SWAPDIRECTORY
#List out the file
ls -lh swapfile
# Change permissions so that only root can use it
sudo chmod 600 swapfile
#List out the file
ls -lh swapfile
#Set up the Linux swap area
sudo mkswap swapfile
#Now start using the swapfile
sudo swapon swapfile
#Show that it's now being used
swapon -s
echo "Modifying /etc/fstab to enable on boot"
SWAPLOCATION=$SWAPDIRECTORY"/swapfile"
echo $SWAPLOCATION
sudo sh -c 'echo "'$SWAPLOCATION' swap swap defaults 0 0" >> /etc/fstab'
echo "Swap file has been created"
echo "Please reboot to make sure changes are in effect"

