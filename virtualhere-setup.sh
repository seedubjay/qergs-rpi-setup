#! /usr/bin/sh

wget http://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm -O /usr/sbin/vhusbdarm
chmod +x /usr/sbin/vhusbdarm

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

systemctl enable virtualhere
systemctl restart virtualhere
