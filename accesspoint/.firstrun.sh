#variables!
USER=pi
#applications!
echo "installing applications.."
apt install hostapd dnsmasq -yq > /dev/null 2>&1

#backup!
echo "making backup.."
mkdir logs 
mkdir backup
cd backup
mkdir packages
aptitude download wpasupplicant wicd wicd-client wicd-curses wicd-gtk > ../logs/backup.log 2>&1
echo "if you don't wish to use this accesspoint anymore you can install the applications in the backup/packages folder with the command: 'dpkg -i *' after navigating to the back folder." 
sleep 3
cp /home/$USER/.bashrc .bashrc.old
cd ..



#alias
echo "setting up start and stop commands.."

echo "alias startap='sudo /etc/init.d/accesspoint'" >> /home/$USER/.bashrc
echo "alias stopap='sudo kill \`pidof dnsmasq hostapd\`'" >> /home/$USER/.bashrc
echo "the command to start the accesspoint is 'startap', and the command to kill it is 'stopap'."
sleep 3
. /home/$USER/.bashrc

#persistence!

head -n -1 /etc/rc.local > temp; mv temp /etc/rc.local
echo "/home/$RUNUSER/accesspoint/start.sh &" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
echo "script is now persistent and will run on boot."


#finish

touch .firstrun.check
echo "first setup is complete!"
sleep 5

