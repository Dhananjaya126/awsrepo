#!/bin/bash

# Stop web server
httpd_running=`pgrep httpd`
if [[ -n  $httpd_running ]]; then
    sudo service httpd stop
fi

# Remove existing html pages
rm -r /var/www/html/*