#!/bin/bash

if [ -z "$LISTEN" ]; then
        echo "Please add your listen mode (socker / ip)"
   else
        sed 's|listen = /var/run/php5-fpm.sock|listen = '$LISTEN'|' -i /etc/php5/fpm/pool.d/www.conf
fi
/usr/sbin/php5-fpm
