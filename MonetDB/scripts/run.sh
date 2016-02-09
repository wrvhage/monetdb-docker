#!/bin/bash

if [ ! -d "/data/dbfarm/db" ]; then
 . /home/monetdb/init-db.sh
fi

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf


