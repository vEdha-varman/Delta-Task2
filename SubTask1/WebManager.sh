#!/bin/bash

sudo apt update
sudo apt install apache2
sudo ufw allow in "Apache Full"
sudo apt install net-tools


sudo mkdir -p /var/www/soldier.io
sudo chown -R $USER:$USER /var/www/soldier.io
sudo chmod -R 755 /var/www

for u in ArmyGeneral NavyMarshal AirForceChief
    do
    sudo mkdir /var/www/soldier.io/$u
	sudo touch /var/www/soldier.io/$u/index.html
    echo "<html><head>Indian Defence</head><body><p>Welcome $u</p></body></html>" | sudo tee /var/www/soldier.io/$u/index.html >/dev/null 2>&1
done


for g in Army Navy AirForce
    do
    sudo groupadd $g
    for n in {1..50}
        do
        sudo mkdir /var/www/soldier.io/$u
		sudo touch /var/www/soldier.io/$u/index.html
    	echo "<html><head>Indian Defence</head><body><p>Welcome $u</p></body></html>" | sudo tee /var/www/soldier.io/$u/index.html >/dev/null 2>&1
    done
done


sudo mkdir /var/www/soldier.io/ChiefCommander
sudo touch /var/www/soldier.io/ChiefCommander/index.html
echo "<?php echo \"Welcome Chief<br>\"; $file_lines = file('attendns.txt'); foreach($file_lines as $line){echo $line; echo \"<br>\"} ?>" | sudo tee /var/www/soldier.io/ChiefCommander/index.php >/dev/null 2>&1
sudo touch /var/www/soldier.io/ChiefCommander/attendns.txt
cat <~ChiefCommander/attendance_report.txt | sudo tee /var/www/soldier.io/ChiefCommander/attendns.txt


sudo mkdir /var/www/soldier.io/public
sudo touch /var/www/soldier.io/public/index.php
echo -e "<?php\necho \"<h4>Hi There! Your USER_AGENT:</h4>\";\necho \$_SERVER[\"HTTP_USER_AGENT\"]\n?>" | sudo tee /var/www/soldier.io/public/index.php >/dev/null 2>&1



sudo cp ./soldier.io.CONF /etc/apache2/sites-avilable/soldier.io.conf

sudo a2ensite soldier.io.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2



ip_adrs=$(ifconfig | grep -m 1 'inet ' | awk '{print $2}')
echo -e "\n$ip_adrs soldier.io" | sudo tee -a /etc/hosts >/dev/null 2>&1




sudo a2enmod rewrite
sudo systemctl restart apache2
sudo touch /var/www/soldier.io/.htaccess
echo "RewriteEngine on" | sudo tee /var/www/soldier.io/.htaccess >/dev/null 2>&1

echo -e "RewriteCond %{HTTP_USER_AGENT} ^ChiefCommander\$\nRewriteRule ^/?\$ ChiefCommander/index.php [L]\n\nRewriteCond %{HTTP_USER_AGENT} ^(Army|Navy|AirForce).*\nRewriteRule ^/?\$ %{HTTP_USER_AGENT}/index.html [L]\n\nRewriteRule ^/?\$ public/index.php [L]\n" | sudo tee -a /var/www/soldier.io/.htaccess >/dev/null 2>&1
