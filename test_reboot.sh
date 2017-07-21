#!/bin/bash
target='1';
count=0

while :
do
sleep 1
echo "reboot DUT"
adb shell reboot
sleep 1
echo "rebooting..."
sleep 60
result=$(adb shell getprop dev.bootcomplete)
echo "result: "$result

if echo $result | grep -q $target; then
    count=$(($count+1))
    echo "test done: $count"
else
    echo "test fail!"
    break
fi
done
