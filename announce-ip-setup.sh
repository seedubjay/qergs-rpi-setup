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
OnBootSec=0s

[Install]
WantedBy=timers.target
" > /etc/systemd/system/announce-ip.timer

systemctl daemon-reload

systemctl enable announce-ip.timer
systemctl restart announce-ip.timer