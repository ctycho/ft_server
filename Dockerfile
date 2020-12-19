# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ctycho <ctycho@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/14 15:50:21 by ctycho            #+#    #+#              #
#    Updated: 2020/12/18 19:41:37 by ctycho           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get -y update

RUN apt-get -y install nginx wget vim

RUN apt-get -y install mariadb-server php-mbstring php-zip php-gd php-mysql php7.3-fpm

COPY ./srcs/default /etc/nginx/sites-available/default
COPY ./srcs/turn-on.sh /etc/nginx/sites-available/
COPY ./srcs/turn-off.sh /etc/nginx/sites-available/
COPY ./srcs/script-start.sh /etc/ssl/

WORKDIR ./var/www/html/
RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz
RUN tar xvf latest-ru_RU.tar.gz
RUN rm -rf latest-ru_RU.tar.gz
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
RUN tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz
RUN rm -rf phpMyAdmin-4.9.7-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.7-all-languages phpmyadmin
COPY ./srcs/wp-config.php ./wordpress/wp-config.php
COPY ./srcs/config.inc.php ./phpmyadmin/config.inc.php

EXPOSE 80 443

WORKDIR ../../../etc/ssl/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout key.key \
	-out key.crt \
	-subj "/C=RU/ST=Tatarstan/L=Kazan/O=school21/CN=ctycho"

CMD bash script-start.sh

