#!bin/bash

sed -i "s|autoindex off;|autoindex on;|" "default"
service nginx restart
