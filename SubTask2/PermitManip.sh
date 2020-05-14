#!/bin/bash
# Assign Permissions

chmod 700 ~ChiefCommander


for u in ArmyGeneral NavyMarshal AirForceChief
    do
    chmod 700 /home/${u}
    setfacl -m u:ChiefCommander:rwx -R /home/${u}
done


for u in Army{1..50}
    do
    chmod 700 /home/$u
    setfacl -m u:ChiefCommander:rwx -R /home/$u
    setfacl -m u:ArmyGeneral:rwx -R /home/$u
done
for u in Navy{1..50}
    do
    chmod 700 /home/$u
    setfacl -m u:ChiefCommander:rwx -R /home/$u
    setfacl -m u:NavyMarshal:rwx -R /home/$u
done
for u in AirForce{1..50}
    do
    chmod 700 /home/$u
    setfacl -m u:ChiefCommander:rwx -R /home/$u
    setfacl -m u:AirForceChief:rwx -R /home/$u
done

