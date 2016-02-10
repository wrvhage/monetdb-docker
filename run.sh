#!/bin/bash

docker create -v /data --name datastore1 wrvhage/datastore /bin/true
docker run -d --volumes-from datastore1 --name monetdb1 wrvhage/monetdb
