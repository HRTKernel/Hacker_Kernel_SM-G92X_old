#!/system/bin/sh
# thanks to mythos234 for the script

/sbin/busybox mount -t rootfs -o remount,rw rootfs

sync

/system/xbin/daemonsu --auto-daemon &

# Make internal storage directory.
if [ ! -d /data/.hackerkernel ]; then
	mkdir /data/.hackerkernel
fi;

# Synapse
busybox mount -t rootfs -o remount,rw rootfs
busybox chmod -R 755 /res/synapse
busybox ln -fs /res/synapse/uci /sbin/uci
/sbin/uci
busybox mount -t rootfs -o remount,ro rootfs

# kernel custom test

if [ -e /data/hackertest.log ]; then
rm /data/hackertest.log
fi

#Set default values on boot
echo "temporary none" > /sys/class/scsi_disk/0:0:0:1/cache_type
echo "temporary none" > /sys/class/scsi_disk/0:0:0:2/cache_type
echo "Set default values on boot successful." >> /data/hackertest.log

#Symlink busybox parts
#cd /sbin
#for i in $(./busybox --list)
#do
#	./busybox ln -s busybox $i
#done
#echo "Busybox symlinks created successful." >> /data/hackertest.log
#cd /

echo  Kernel script is working !!! >> /data/hackertest.log
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /data/hackertest.log
echo  Done ! >> /data/hackertest.log

# Init.d
busybox run-parts /system/etc/init.d
/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,rw /data

#Synapse profile
if [ ! -f /data/.hackerkernel/bck_prof ]; then
	cp -f /res/synapse/files/bck_prof /data/.hackerkernel/bck_prof
fi


# frandom permissions
# chmod 444 /dev/erandom
# chmod 444 /dev/frandom

# turn frandom on by default.
#if [ ! -f /data/.hackerkernel/setting_frandom ]; then
#	echo 1 > /data/.hackerkernel/setting_frandom
#fi;

#setting_frandom=`cat /data/.hackerkernelsetting_frandom`

#if [[ $setting_frandom == 1 ]]; then
#	insmod /system/lib/modules/frandom.ko
#	chmod 644 /dev/frandom
#	chmod 644 /dev/erandom
#	mv /dev/random /dev/random.ori
#	mv /dev/urandom /dev/urandom.ori
#	ln /dev/frandom /dev/random
#	chmod 644 /dev/random
#	ln /dev/erandom /dev/urandom
#	chmod 644 /dev/urandom
#fi;

chmod 777 /data/.hackerkernel/bck_prof





