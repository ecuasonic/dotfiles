current_fan1=$(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm1_enable)
current_fan2=$(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm2_enable)
if [ $current_fan1 == $current_fan2 ]; then

	if [ $current_fan1 == 0 ]; then
		next_fan=2
	else
		next_fan=0
	fi
	sudo sh -c "echo ${next_fan} > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm1_enable"
	sudo sh -c "echo ${next_fan} > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm2_enable"

else

	if [ $current_fan1 == 0 ]; then
		sudo sh -c "echo 2 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm1_enable"
	fi
	if [ $current_fan2 == 0 ]; then
		sudo sh -c "echo 2 > /sys/devices/platform/asus-nb-wmi/hwmon/hwmon7/pwm2_enable"
	fi

fi


