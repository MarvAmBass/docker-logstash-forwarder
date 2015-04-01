# Docker ELK-Stack Container - Logstash-Forwarder
_maintained by MarvAmBass_

[FAQ - All you need to know about the marvambass Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

## What is it

This Dockerfile (available as ___marvambass/logstash-forwarder___) gives you a ready to use Logstash-Forwarder Container for your ELK stack or something else.

View in Docker Registry [marvambass/logstash-forwarder](https://registry.hub.docker.com/u/marvambass/marvambass/logstash-forwarder/)

View in GitHub [MarvAmBass/docker-logstash-forwarder](https://github.com/MarvAmBass/docker-logstash-forwarder)

## Environment variables and defaults

### Variables

* __LOGSTASH\_SERVER__
 * default: _logstash:5000_
 * you should set this to the common name and port of your logstash server

### Cert Filenames

* __/certs/logstash-forwarder.crt__
 * this must be the same cert file used by logstash!

## Running marvambass/logstash-forwarder Container

First of all you could start my [elasticsearch container](https://github.com/MarvAmBass/docker-elasticsearch) (Kibana needs a Elasticsearch instance to work) like this:

    docker run -d \
    --name elasticsearch \
    -v "$PWD/esdata":/usr/share/elasticsearch/data
    marvambass/elasticsearch

Secondly the Logstash Container:

    docker run -d \
    --name logstash \
    --link elasticsearch:elasticsearch \
    -v "$PWD/conf:/conf" \
    -v "$PWD/certs:/certs" \
    marvambass/logstash

_we create a new container and link it to our elasticsearch instance by the name __elasticsearch__, we also overwrite the _/conf_ directory with our own configuration directory and the _/certs_ directory to use our certs.


Now the Logstash-Forwarder Container which forwards the logs into Logstash:

    docker run -d \
    --name logstash-forwarder \
    --link logstash:logstash \
    --volumes-from logstash \
    -v "$PWD/logstash-forwarder-conf:/logstash-forwarder-conf" \
    -v /var/log:/var/log:ro marvambass/logstash-forwarder

_we create a new container and link it to our logstash server (you could also set LOGSTASH\_SERVER variable to point to a public server). after that we add our ssl certificate, the logstash forwarder config and the directory with the logfiles in it_

## Based on

This Dockerfile is based on my [marvambass/oracle-java8](https://registry.hub.docker.com/marvambass/oracle-java8) Image.
