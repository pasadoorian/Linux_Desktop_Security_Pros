# Paul's Linux Cheat Sheet

## Ubuntu - Static IP:

```
sudo vi /etc/netplan/01-netcfg.yaml
```

## network:

```
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
      addresses:
        - 172.16.1.10/24
      routes:
        - to: default
          via: 172.16.1.1
      nameservers:
        addresses: [172.16.1.11,172.16.1.12]
        search: [int.psw.io]
```

```
sudo chmod 600 /etc/netplan/01-netcfg.yaml
```

```
sudo netplan apply
```

## Force UPv4 when updating:


```
sudo apt-get -o Acquire::ForceIPv4=true update
```

## Tailscale:

```
sudo systemctl enable --now tailscaled
```

```
sudo tailscale up
```

```
tailscale status
```

## Manjaro Packages:


```
$ sudo pacman -S base-devel
```

```
$ pamac install rebuild-detector \
pacutils \
spotify \
ytmdesktop \
slack-desktop \
vscodium-bin \
vscodium-marketplace \
zoom \
qflipper \
pulse-sms \
mailspring-bin \
microsoft-edge-stable-bin \
fwupd \
gimp \
kdenlive \
audacity \
arduino-ide-bin \
bambustudio-bin \
vmware-workstation
tio \
signal-desktop \
google-chrome \
firefox \
rpi-imager \
topgrade
```

## Manjaro Customization:

- https://forum.manjaro.org/t/howto-disable-turn-off-hibernate-completely/8033

- https://superuser.com/questions/1597162/how-to-unlock-linux-user-after-too-many-failed-login-attempts

- https://forum.manjaro.org/t/set-zsh-as-default/103501

- https://forum.manjaro.org/t/how-can-i-change-the-gnome-mouse-style/106249

- https://wiki.manjaro.org/index.php/Pacman-mirrors - ONly US mirrors

- https://www.fosslinux.com/46741/things-to-do-after-installing-manjaro.htm

- https://community.frame.work/t/arch-linux-on-the-framework-laptop-16/44854

## Docker:

## Remove all containers, images, volumes and networks:

```
docker stop $(docker ps -aq)  
sleep 2
docker rm $(docker ps -aq)   
sleep 2
docker rmi $(docker images -q) --force
sleep 2
docker volume prune -f       
sleep 2
docker network prune -f      
sleep 2
docker system prune -a -f
```

## ESP32 Development:

## First time (for Manjaro, and probably Arch):

```
## Install esptool
$ pamac install esptool
```

```
## Create uucp group
$ sudo usermod -a -G uucp
```

```
## Enable group membership without logout or reboot:
$ newgrp uucp
```

## Flash from command line (experimental):

```
$ esptool.py --chip esp32-s3 --port /dev/ttyUSB0 --baud 115200 write_flash -z 0x1000 firmware.bin
```

```
$ esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 115200 write_flash -z 0x1000 firmware.bin
```

