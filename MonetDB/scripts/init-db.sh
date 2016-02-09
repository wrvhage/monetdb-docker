#!/bin/bash

function test_monetdb_connection() {
  runuser -l  monetdb -c "mclient -d db -s 'SELECT 1'" &> /dev/null
  local status=$?
  if [ $status -ne 0 ]; then
    return 0
  fi
  return 1
}

chown -R monetdb:monetdb /var/monetdb5
cd /home/monetdb

if [ ! -d "/data" ]; then
    runuser -l  monetdb -c 'monetdbd create /data'
else
    echo "Existing dbfarm found in '/data'"
fi
runuser -l  monetdb -c 'monetdbd start /data'
sleep 5
if [ ! -d "/data/db" ]; then
    runuser -l  monetdb -c 'monetdb create db && \
        monetdb set embedr=true db && \
        monetdb release db'
else
    echo "Existing database found in '/data/db'"
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
if [ "$i" = 0 ]; then
	echo >&2 'MonetDB startup failed'
	exit 1
fi

mkdir -p /data/log
chown -R monetdb:monetdb /data/log

echo "Initialization done"
