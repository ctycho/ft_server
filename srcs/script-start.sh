#!/bin/bash

service nginx start
service php7.3-fpm start
service mysql start
echo "create database mydb;" | mysql
echo "CREATE USER 'ctycho'@'localhost' IDENTIFIED BY '';" | mysql
echo "GRANT ALL ON mydb.* TO 'ctycho'@'localhost' IDENTIFIED BY '' WITH GRANT OPTION;" | mysql
echo "flush privileges;" | mysql

bash
