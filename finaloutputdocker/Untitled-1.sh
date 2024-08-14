#####
setenv ipaddr 192.168.0.100
setenv serverip 192.168.0.1
setenv bootargs "console=ttySTM0,115200 root=/dev/nfs ip=192.168.0.1 nfsroot=192.168.0.9:/nfs,nfsvers=3,tcp rw init=/bin/sh" 
setenv bootcmd 'tftp 0xc2000000 zImage; tftp 0xc4000000 stm32mp157a-dk1.dtb; bootz 0xc2000000 - 0xc4000000'

##configuration d 'un serveur nfs  notes u need to
docker build -t tt .
docker run -d --name yyy --network my_macvlan_net --ip 192.168.0.9  --privileged -v /home/ahmed/embedded-linux-labs/tinysystem/nfsroot/:/nfs  -p 2088:2049 tt
modprobe {nfs,nfsd,rpcsec_gss_krb5}


sudo apt install nfs-common nfs-kernel-server


docker network create -d macvlan \
  --subnet=192.168.0.0/24 \
  --gateway=192.168.0.1 \
  -o parent=enp4s0 \
  my_macvlan_net

  network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp4s0:
      dhcp4: no
      addresses:
        - 192.168.0.1/24

 sudo nano /etc/netplan/01-netcfg.yaml
       


sudo netplan apply
srv/tftp zimage / tftp 0xc2000000 zImage
tftp 0xc4000000 stm32mp157a-dk1.dtb