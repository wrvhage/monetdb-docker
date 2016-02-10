#!/bin/bash

function test_monetdb_connection() {
  runuser -l  monetdb -c "mclient -d db -s 'SELECT 1'" &> /dev/null
  local status=$?
  if [ $status -ne 0 ]; then
    return 0
  fi
  return 1
}

chown -R monetdb:monetdb /data
cd /home/monetdb

if [ ! -d "/data/dbfarm" ]; then
    runuser -l  monetdb -c 'monetdbd create /data/dbfarm'
else
    echo "Existing dbfarm found in '/data/dbfarm'"
fi
runuser -l  monetdb -c 'monetdbd start /data/dbfarm'
sleep 5
if [ ! -d "/data/dbfarm/db" ]; then
    runuser -l  monetdb -c 'monetdb create db && \
        monetdb set embedr=true db && \
        monetdb release db'
else
    echo "Existing database found in '/data/dbfarm/db'"
fi
runuser -l  monetdb -c 'monetdb start db'

for i in {30..0}; do
  echo 'Testing MonetDB connection ' $i
	if test_monetdb_connection ; then
		echo 'Waiting for MonetDB to start...'
  	sleep 1
  else
    echo 'MonetDB is running'
    break
	fi
done

runuser -l  monetdb -c 'monetdb stop db'

runuser -l  monetdb -c 'monetdbd stop'

if [ "$i" = 0 ]; then
	echo >&2 'MonetDB startup failed'
	exit 1
fi

if [ ! -d "/data/log" ]; then
	mkdir -p /data/log
	chown -R monetdb:monetdb /data/log
fi

echo "Initialization done"
