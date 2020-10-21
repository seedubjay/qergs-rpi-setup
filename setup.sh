#! /usr/bin/sh

wget http://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm -O /usr/sbin/vhusbdarm
chmod +x /usr/sbin/vhusbdarm

echo '
[Unit]
Description=Announce IP
Requires=networking.service
After=networking.service
[Service]
ExecStart=sh -c "curl -X POST https://frozen-island-91924.herokuapp.com/$(hostname)/$(ip -4 addr show wlan0 | grep -oP '\''(?<=inet\s)\d+(\.\d+){3}'\'')"
Type=oneshot
' > /etc/systemd/system/announce-ip.service

echo "
[Unit]
Description=Announce IP Timer
[Timer]
OnUnitActiveSec=10s
OnBootSec=10s

[Install]
WantedBy=timers.target
" > /etc/systemd/system/announce-ip.timer

systemctl disable virtualhere
systemctl stop virtualhere

echo "
[Unit]
Description=VirtualHere USB Sharing
Requires=networking.service
After=networking.service
[Service]
ExecStart=/usr/sbin/vhusbdarm -c /etc/vhusbd.conf
Type=idle
[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/virtualhere.service

echo 'ServerName=$HOSTNAME$' > /etc/vhusbd.conf

systemctl daemon-reload

systemctl enable announce-ip.timer
systemctl start announce-ip.timer

systemctl enable virtualhere
systemctl start virtualhere
