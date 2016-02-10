#!/bin/bash

if [ ! -d "/data/dbfarm/db" ]; then
 . /home/monetdb/init-db.sh
fi

#/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
mserver5 --set mapi_port=50000 --dbinit="include geom; include sql; sql.init(); sql.start();" --dbpath=/data/dbfarm/db --set sql_logdir=/data/dbfarm/db


