# Tuya Camera Root and Customization

This repository is a fork from https://github.com/guino/Merkury720 , because
most of the files I use come from there. But I used also instructions from
* https://github.com/guino/Merkury1080P
* https://github.com/guino/Merkury720
* https://github.com/guino/BazzDoorbell/issues/2
* https://github.com/DeltaTangoLima/orion_sc008ha
* https://github.com/guino/BazzDoorbell/issues/13
* https://github.com/guino/BazzDoorbell/wiki/%5BHow-to%5D-Integrate-with-Home-Assistant,-HomeBridge,-Domoticz,-etc
* https://github.com/guino/BazzDoorbell/issues/4#issuecomment-1208466146
* https://github.com/guino/ppsapp-rtsp

My camera had port 80 open from the beginning and I could use that
to get the device info from it:
`curl http://admin:056565099@192.168.178.29/devices/deviceinfo`
gives
```json
{"devname":"Smart Home Camera","model":"Mini 8X","serialno":"058376543","softwareversion":"2.9.1","hardwareversion":"M8X_H1_V10_F23","firmwareversion":"ppstrong-c5-tuya2_pearl-2.9.1.20190920","authkey":"cA5tjw8UQ07o6tEGHR6DKhkRFLMBcIi6","deviceid":"pp0140d2b6eac44cc0a4","identity":"MR1908280101003019","pid":"aaa","WiFi MAC":"74:ee:2a:ae:51:89"}
```

So the method to use is the one from https://github.com/guino/BazzDoorbell/issues/13 

1. Get the original kernel command line `curl http://admin:056565099@192.168.178.29/proc/cmdline`
```
mem=37M console=ttyAMA0,115200n8 mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd
```

2. Prepare `env` file: SD-Card/env (has a zero byte at the end)
```
bootargs=mem=37M console=ttyAMA0,115200n8 mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd - ip=\\${T//_/\\$\\'"\\\\x20"\\'}:::::";T=\\"sleep_5;mkdir_-p_/mnt/mmc01;mount_-t_vfat_/dev/mmcblk0p1_/mnt/mmc01;/mnt/mmc01/initrun.sh&\\";eval"
```

3. Prepare FAT32 formatted SD card with the files `env`, `ppsMmcTool.txt` and `initrun.sh` in the root

4. Power camera off, insert SD card, press reset button (its behinde a small hole on the back side, poke into the hole with one of these thingies that come with smartphones or tablets to open the SD card tray), power on the camera and keep pressing the button for 5 more seconds.

5. Check if it worked: `curl http://admin:056565099@192.168.178.29/proc/cmdline`
```
mem=37M console=ttyAMA0,115200n8 mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd - ip=${T//_/$'\\x20'}:::::;T=\"sleep_5;mkdir_-p_/mnt/mmc01;mount_-t_vfat_/dev/mmcblk0p1_/mnt/mmc01;/mnt/mmc01/initrun.sh&\";eval mtdparts=hi_sfc:384k(bld)ro,64k(env),64k(enc)ro,64k(sysflg),3584k(sys),6656k(app),1536k(cfg),1m(recove),2880k(user),128k(oeminfo) ppsAppParts=5 ppsWatchInitEnd
```
   and `curl http://admin:056565099@192.168.178.29/proc/self/root/mnt/mmc01/hack` outputs `done`.

6. Add the mmc files and busybox to the SD card, set the user and password to 'user' and 'telnet' for both telnet and http access (DES encrypted in the file `passwd` and as plaintext in `httpd.conf`. Uncomment the lines for recording and event recording in `custom.sh`.

7. Power off the camera, insert the SD card, power on. So far all worked fine, now had telnet and http access to the camera.

