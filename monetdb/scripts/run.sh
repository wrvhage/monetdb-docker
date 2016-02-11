#!/bin/bash

if [ ! -d "/data/dbfarm/db" ]; then
  echo "Setting up MonetDB Database Farm"
  . /home/monetdb/init-db.sh
  echo "Setting up password"
  . /home/monetdb/set-monetdb-password.sh monetdb
fi

/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
#mserver5 --daemon=no --set mapi_port=50000 --set mapi_open=true --dbinit="include geom; include sql; sql.init(); sql.start();" --dbpath=/data/dbfarm/db --set sql_logdir=/data/dbfarm/db



