#!/bin/bash


user=$(whoami)
loc_file=$(locate PosManip.sh)
nl=$(cat /etc/crontab | grep -c 'PosManip.sh')
if [[ $nl -eq 0 ]]
then
	echo "0  0  * * * $user "\"\\\"$loc_file\\\"\" | tee -a /etc/crontab >/dev/null 2>&1
fi


Date=$(date +"%F")
for g in Army Navy AirForce
    do
    for u in {1..50}
        do
        n=$(ls /home/$g$u | grep -c 'position_allotted.txt')
        touch /home/$g$u/position_allotted.txt
		if [[ $n -eq 0 ]]
		then
        	echo "Date       Post" | tee -a /home/$g$u/position_allotted.txt >/dev/null 2>&1
        fi
        pos=$(grep -i "$Date.* $g$u " position.log | awk '{print $3,$4}')
        echo "$Date $pos" | tee -a /home/$g$u/position_allotted.txt >/dev/null 2>&1
    done
done

