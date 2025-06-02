# Notes

These are just some notes and example commands, experimental, use at your own risk!

# Client 
  
```
  ssh-copy-id -i ~/.ss/mykey hostname
  ssh -i ~/.ssh/mykey hostname
  vi config
  
  pamac install openssh-askpass
  pamac install x11-ssh-askpass
  virt-manager -c 'qemu+ssh://paulda@hostname/system?keyfile=mykey'
```

# Server

```
  sudo apt install qemu-system-x86 libvirt-daemon-system virtinst virt-manager virt-viewer ovmf swtpm qemu-utils guestfs-tools libosinfo-bin tuned
  sudo systemctl enable libvirtd.service
  sudo virt-host-validate qemu
  sudo systemctl enable --now tuned
  tuned-adm active
  tuned-adm list
  tuned-adm active
  sudo apt install network-manager
  sudo nmcli device status
  sudo nmcli connection add type bridge con-name bridge0 ifname bridge0
  sudo nmcli connection add type ethernet slave-type bridge     con-name 'Bridge connection 1' ifname eno1 master bridge0
  sudo nmcli connection modify bridge0 ipv4.addresses '172.16.1.37/24'
  sudo nmcli connection modify bridge0 ipv4.gateway '172.16.1.1'
  sudo nmcli connection modify bridge0 ipv4.dns '172.16.1.11,172.16.1.12'
  sudo nmcli connection modify bridge0 ipv4.dns-search 'int.mydomain.io'
  sudo nmcli connection modify bridge0 ipv4.method manual
  sudo nmcli connection up bridge0
  sudo vi /etc/netplan/00-installer-config.yaml 
  sudo netplan apply
  sudo nmcli connection up bridge0
  sudo nmcli connection modify bridge0 connection.autoconnect-slaves 1
  sudo nmcli connection up bridge0
  sudo nmcli device status
  vim nwbridge.xml
  sudo virsh net-define nwbridge.xml
  sudo virsh net-start nwbridge
  sudo virsh net-autostart nwbridge
  sudo virsh net-list --all
  virsh uri
  sudo usermod -aG libvirt $USER
  virsh uri
  sudo setfacl -R -b /var/lib/libvirt/images
  sudo setfacl -R -m u:$USER:rwX /var/lib/libvirt/images
  sudo setfacl -m d:u:$USER:rwx /var/lib/libvirt/images
  getfacl /var/lib/libvirt/images
  cd /var/lib/libvirt/images/
  ls
  touch sdf
  rm sdf 
  cd ~
  wget https://cdimage.kali.org/kali-2024.2/kali-linux-2024.2-qemu-amd64.7z
  sudo apt install p7zip-full
  7za x kali-linux-2024.2-qemu-amd64.7z 
  cp kali-linux-2024.2-qemu-amd64.qcow2 /var/lib/libvirt/images/
  cd /var/lib/libvirt/images/
  ls
  mv kali-linux-2024.2-qemu-amd64.qcow2 kail.qcow2
  sudo apt install virt-customize
  sudo apt install  libguestfs-tools
  sudo virt-customize -a /var/lib/libvirt/images/kali.qcow2 --root-password password:LinuxIsAwesome --uninstall cloud-init
```
  

# Creating and adding new storage:

## On host: 

```
 $ qemu-img create -f qcow2 -o preallocation=full ec-opt2.qcow2 50G
 $ virsh attach-disk hulk /var/lib/libvirt/images/ec-opt2.qcow2 vdb --cache none --persistent
```

## On Guest:

```
  $ sudo fdisk /dev/vdb
  $ sudo mkfs.ext4 /dev/vdb1
```
```
$ lsblk
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
vda     253:0    0 103.5G  0 disk 
├─vda1  253:1    0 102.5G  0 part /
├─vda14 253:14   0     4M  0 part 
├─vda15 253:15   0   106M  0 part /boot/efi
└─vda16 259:0    0   913M  0 part /boot
vdb     253:16   0    50G  0 disk 
└─vdb1  253:17   0    50G  0 part 
```

```
$ cat /etc/fstab 

LABEL=cloudimg-rootfs	/	 ext4	discard,commit=30,errors=remount-ro	0 1
LABEL=BOOT	/boot	ext4	defaults	0 2
LABEL=UEFI	/boot/efi	vfat	umask=0077	0 1
/dev/vdb1	/opt	ext4	defaults	0  2
host_home  /home/paulda/host-home  virtiofs  defaults  0  0
```

# Resources:

- https://www.reddit.com/r/ManjaroLinux/comments/bprycv/manjaro_and_virtmanager_remote_connect/
- https://www.kali.org/docs/virtualization/install-qemu-guest-vm/
- https://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
- https://gcore.com/learning/how-to-extract-7z-files-linux/
- https://askubuntu.com/questions/1190504/why-is-nmcli-not-configuring-device
- https://9to5linux.com/you-can-now-upgrade-ubuntu-22-04-lts-to-ubuntu-24-04-lts-heres-how - I upgraded the host machine to the latest Ubuntu (22->24)
- https://fabianlee.org/2019/02/16/kvm-virt-manager-to-connect-to-a-remote-console-using-qemussh/
- https://sysguides.com/kvm-guest-os-from-the-command-line
- https://sysguides.com/create-virtual-machines-in-kvm-virt-manager
- https://sysguides.com/install-kvm-on-linux - This is where to start
