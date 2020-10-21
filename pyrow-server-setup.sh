apt-get install libusb-dev libudev-dev usbutils libatlas-base-dev python3-pip
pip3 install pyusb libusb numpy flask flask-cors

echo 'SUBSYSTEM=="usb",
ATTR{idVendor}=="17a4",
ATTR{idProduct}=="0001",
MODE="666"
' > /etc/udev/rules.d/99-pm3.rules

echo 'SUBSYSTEM=="usb",
ATTR{idVendor}=="17a4",
ATTR{idProduct}=="0002",
MODE="666"
' > /etc/udev/rules.d/99-pm4.rules

echo 'SUBSYSTEM=="usb",
ATTR{idVendor}=="17a4",
ATTR{idProduct}=="0003",
MODE="666"
' > /etc/udev/rules.d/99-pm5.rules

wget https://github.com/seedubjay/qergs-rpi-server/archive/main.zip -O main.zip
unzip main.zip
rm main.zip
mv qergs-rpi-server-main /home/pi/qergs-rpi-server

echo '[Unit]
Description=QErgs Server
Requires=networking.service
After=networking.service
[Service]
Restart=on-failure
RestartSec=5s
ExecStart=python3 /home/pi/qergs-rpi-server/server.py
[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/qergs-server.service

systemctl daemon-reload

systemctl enable qergs-server.service
systemctl restart qergs-server.service