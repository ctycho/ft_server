#!bin/bash

sed -i "s|autoindex on;|autoindex off;|" "default"
service nginx restart
