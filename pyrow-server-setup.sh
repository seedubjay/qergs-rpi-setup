apt-get install libusb-dev libudev-dev usbutils python3-pip
pip3 install pyusb libusb numpy

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

wget https://github.com/seedubjay/qergs-rpi-server/archive/main.zip
unzip main.zip -d qergs-rpi-server

echo '[Unit]
Description=QErgs Server
Requires=networking.service
After=networking.service
[Service]
Restart=on-failure
RestartSec=5s
ExecStart=python3 /home/pi/qergs-rpi-server/server.py
' > /etc/systemd/system/qergs-server.service

systemctl daemon-reload

systemctl enable qergs-server.service
systemctl restart qergs-server.service