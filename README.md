flash microSD card with standard Lite image

in `sudo raspi-config`, set hostname to rpiXX and enable ssh

generate token from [UIS](https://tokens.csx.cam.ac.uk/)

add `/etc/wpa_supplicant/wpa_supplicant.conf`

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=0
country=GB

network={
	ssid="eduroam"
	key_mgmt=WPA-EAP
	eap=PEAP
	pairwise=CCMP TKIP
	phase2="auth=MSCHAPV2"
	
	anonymous_identity="@cam.ac.uk"
	ca_cert="/etc/ssl/certs/QuoVadis_Root_CA_2_G3.pem"

	identity="XXX+rpiXX@cam.ac.uk"
	password="XXXXXXXXXX"
}
```

in the file `/lib/dhcpd/dhcpd-hooks/10-wpa_supplicant`, change the line

```
wpa_supplicant_driver="${wpa_supplicant_driver:-nl80211,wext}"
```

to

```
wpa_supplicant_driver="${wpa_supplicant_driver:-wext,nl80211}"
```

reboot, and note IP on restart

scp `setup.sh` to machine and run it with `sudo` privileges