#variables!
RUNUSER=pi
if [ ! -e /home/$RUNUSER/accesspoint/.firstrun.check ]
then
    sudo /home/$RUNUSER/accesspoint/.firstrun.sh
fi
echo "configuring access point.."
mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.bak
cp /home/$RUNUSER/accesspoint/hostapd.conf /etc/hostapd/hostapd.conf
echo "you can change the SSID and password with 'sudo nano /etc/hostapd/hostapd.conf'"

echo "configuring dhcp.."
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
cp /home/$RUNUSER/accesspoint/dnsmasq.conf /etc/dnsmasq.conf

echo "starting services.."
ifconfig wlan0 192.168.100.1
kill `pidof dnsmasq`
dnsmasq > /home/$RUNUSER/accesspoint/logs/dns.log 2>&1
kill `pidof hostapd`
#perhaps change this in the hostapd daemon file for cleannes
hostapd /etc/hostapd/hostapd.conf & > /home/$RUNUSER/accesspoint/logs/AP.log 2>&1

