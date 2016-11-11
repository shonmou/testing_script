#!/bin/bash
target='0x87654321';
count=0

func_init()
{
	$(adb root)
	sleep 1
	$(adb shell rmmod 8723ds.ko)
	sleep 1
	$(adb shell insmod /misc/modules/8723ds.ko)
	sleep 1
	$(adb shell netcfg wlan0 up)
	sleep 2
	$(adb shell rtwpriv wlan0 pm_set ips=0)
	func_write_0_test
	func_read_result result
	echo "driver initial done" $result
	sleep 1
}

func_write_0_test()
{
	echo "function_write_0_test"
	$(adb shell rtwpriv wlan0 write 4,0x1b8,0x0)
}

func_write_pattern_test()
{
	echo "function_write_test"
	$(adb shell rtwpriv wlan0 write 4,0x1b8,$target)
}

func_read_result()
{
	val1=$(adb shell rtwpriv wlan0 read 4,0x1b8 | awk -F":" '{print $2}')
	eval "$1=$val1"
}

# Start from here!!
func_init

while :
	do
		if [ `expr $count % 2` -eq 0 ]; then
			target='0x87654321';
		else
			target='0x12345678';
		fi

		func_write_pattern_test
		func_read_result ret_val
		echo "read back: "$ret_val

		if echo $val1 | grep -q $target; then
			echo "PASS!!!!!"
		else
			echo "FAIL#####"
			break
		fi

	count=$(($count+1))
	echo "test done: $count"
	sleep 2
done
