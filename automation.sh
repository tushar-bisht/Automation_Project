#!/bin/bash
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
