flash microSD card

in `sudo raspi-config`, set hostname to rpiXX

add `/etc/wpa_supplicant/wpa_supplicant.conf`

'''
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
'''

with token from [UIS](https://tokens.csx.cam.ac.uk/)

