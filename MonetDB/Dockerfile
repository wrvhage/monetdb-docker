FROM monetdb/monetdb-r-docker
ADD $PWD /data

WORKDIR /data
EXPOSE 5000

RUN monetdbd create /data
RUN monetdbd start /data

RUN monetdb create mydb
RUN monetdb release mydb

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]