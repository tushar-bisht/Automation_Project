#!/bin/bash
#################################Task 2 ###################################################
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo service apache2 start
sudo  systemctl enable apache2
cd /tmp
timestamp=$(date '+%d%m%Y-%H%M%S')
s3=upgrad-tusharbisht
name=tusharbisht
tar -cvf $name-httpd-logs-$timestamp.tar /var/log/apache2/*.log
sudo apt install awscli -y
aws s3 cp /tmp/$name-httpd-logs-$timestamp.tar s3://$s3/$name-httpd-logs-$timestamp.tar

################################Task 3 #####################################################
cd /var/www/html/
if [ -f /var/www/html/inventory.html ]; then
echo "File exist"
else
touch inventory.html
echo -e "Log Type\t\t Date Created\t\t\t Type\t\t Size" >>/var/www/html/inventory.html
echo -e "\n" >>/var/www/html/inventory.html
fi
cd /tmp
size=$(ls -lah /tmp | grep tusharbisht | grep $timestamp | awk '{print $5}')
echo -e "httpd-logs\t\t $timestamp\t\t tar\t\t ${size}">>/var/www/html/inventory.html

if [ -f /etc/cron.d/automation ]; then
echo "File exist"
else
touch /etc/cron.d/automation
echo "@daily root /root/Automation_Project/automation.sh" >/etc/cron.d/automation
fi
