count=0
while :
do
#adb shell insmod /system/lib/modules/8189es.ko
adb shell insmod /misc/modules/8723ds.ko
#sleep 2
#adb shell netcfg
adb shell netcfg wlan0 up
sleep 1
adb shell rmmod 8723ds.ko
count=$(($count+1))
echo "test done: $count"
done
