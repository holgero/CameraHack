https://github.com/guino/Merkury720
https://github.com/guino/BazzDoorbell/issues/2

http://admin:056565099@192.168.178.29/devices/deviceinfo

http://192.168.178.29/devices/deviceinfo
devname	"Smart Home Camera"
model	"Mini 8X"
serialno	"058376543"
softwareversion	"2.9.1"
hardwareversion	"M8X_H1_V10_F23"
firmwareversion	"ppstrong-c5-tuya2_pearl-2.9.1.20190920"
authkey	"cA5tjw8UQ07o6tEGHR6DKhkRFLMBcIi6"
deviceid	"pp0140d2b6eac44cc0a4"
identity	"MR1908280101003019"
pid	"aaa"
WiFi MAC	"74:ee:2a:ae:51:89"


http://admin:056565099@192.168.178.29/proc/cmdline
mem=37M console=ttyAMA0,115200n8 mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd

Nach dem hack
mem=37M console=ttyAMA0,115200n8 mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd - ip=${T//_/$'\\x20'}:::::;T=\"sleep_5;mkdir_-p_/mnt/mmc01;mount_-t_vfat_/dev/mmcblk0p1_/mnt/mmc01;/mnt/mmc01/initrun.sh&\";eval mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd


Benutze user:telnet für
 telnet 192.168.178.29

Genauso user:telnet für
 http://user:telnet@192.168.178.29:8080/


psapp:
 segement_3.1: 0x10000
 main: 000cb120
 pps_tuya_app_enable_echoshow: 000ca47c

  patch location: 000e6140 bne
                  000e5e28 beq



snap.cgi mjpeg.cgi:
  DAT_0048c574

play.cgi:
  DAT_0048cf88


Rom Patcher JS:
CRC32: 85b4e0d4
MD5: 2f85aa8640fe17ac4134f3de55514a7b
SHA-1: 7e2fa58fd0ec9c5603c485ef95af65813a542f41

mit https://github.com/DeltaTangoLima/orion_sc008ha
modified env, added 
cp_/mnt/mmc01/S90PPStrong-290_/etc/init.d/S90PPStrong;
before /mnt/mmc01/initrun.sh

rtsp://192.168.178.29:8554/

