# forces nmcli to access a specific ssid
WIFI_SSID=my_cool_ssid
WIFI_PSK=pre-shared-key
sudo nmcli con delete remars
sudo nmcli c add type wifi con-name remars ifname wlan0 ssid ${WIFI_SSID}
sudo nmcli con modify remars wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify remars wifi-sec.psk ${WIFI_PSK}
sudo nmcli con up remars

# update the ip on the screen
python3 /home/ubuntu/minipupper_ros_bsp/mangdang/LCD/demo.py