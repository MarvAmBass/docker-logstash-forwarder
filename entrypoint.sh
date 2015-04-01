#!/bin/bash

if [ ! -f /certs/logstash-forwarder.crt ]
then
  >&2 echo ">> no cert found... exiting"
  exit 1
fi

if [ ! -f /logstash-forwarder-conf/logstash-forwarder.conf ]
then
  >&2 echo ">> no configuration found... exiting"
  exit 1
fi

if [ -z ${LOGSTASH_SERVER+x} ]
then
  LOGSTASH_SERVER="logstash:5000"
fi

echo ">> using logstash server: $LOGSTASH_SERVER"
sed "s/LOGSTASH_SERVER/$LOGSTASH_SERVER/g" /logstash-forwarder-conf/logstash-forwarder.conf > /etc/logstash-forwarder.conf

echo ">> exec docker CMD"
echo "$@"
exec "$@"
