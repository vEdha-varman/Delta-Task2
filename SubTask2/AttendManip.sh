#!/bin/bash


user=$(whoami)
loc_file=$(locate AttendManip.sh)
nl=$(cat /etc/crontab | grep -c 'AttendManip.sh')
if [[ $nl -eq 0 ]]
then
	echo "0  6  * * * $user "\"\\\"$loc_file\\\"\" | tee -a /etc/crontab >/dev/null 2>&1
fi


Date=$(date -I -d "-1 day")

touch /home/ArmyGeneral/attendance_record.txt
echo "$Date:" | tee -a /home/ArmyGeneral/attendance_record.txt >/dev/null 2>&1
grep -i "$Date.* Army" attendance.log | awk '{if ( $3 == "YES" ) print "\t"$2}' | tee -a /home/ArmyGeneral/attendance_record.txt >/dev/null 2>&1

touch /home/NavyMarshal/attendance_record.txt
echo "$Date:" | tee -a /home/NavyMarshal/attendance_record.txt >/dev/null 2>&1
grep -i "$Date.* Navy" attendance.log | awk '{if ( $3 == "YES" ) print "\t"$2}' | tee -a /home/NavyMarshal/attendance_record.txt >/dev/null 2>&1

touch /home/AirForceChief/attendance_record.txt
echo "$Date:" | tee -a /home/AirForceChief/attendance_record.txt >/dev/null 2>&1
grep -i "$Date.* AirForce" attendance.log | awk '{if ( $3 == "YES" ) print "\t"$2}' | tee -a /home/AirForceChief/attendance_record.txt >/dev/null 2>&1
