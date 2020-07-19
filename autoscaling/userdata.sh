#!/bin/bash
sudo -i
yum update -y --security
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install httpd php stress unzip wget
systemctl enable httpd
systemctl start httpd
cd /var/www/html
wget http://rhev.usuarioroot.com/terraform-aws/ec2-stress.zip
unzip ec2-stress.zip

echo 'UserData has been successfully executed. ' >> /home/ec2-user/result
find -wholename /root/.*history -wholename /home/*/.*history -exec rm -f {} \;
find / -name 'authorized_keys' -exec rm -f {} \;
rm -rf /var/lib/cloud/data/scripts/*

systemctl restart httpd