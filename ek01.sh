#!/bin/bash

KIBANA_CONF="/etc/kibana/kibana.yml"
ELASTIC_CONF="/etc/elasticsearch/elasticsearch.yml"

#install elasticsearch
cat>/etc/yum.repos.d/elasticsearch.repo<<EOM
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOM

yum install -y elasticsearch

#install kibana
cat>/etc/yum.repos.d/kibana.repo<<EOM
[kibana-7.x]
name=Kibana repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOM

yum install -y kibana

#configure kibana
echo "server.host: 172.33.33.200" >>$KIBANA_CONF
echo 'elasticsearch.hosts: ["http://172.33.33.200:9200"]' >>$KIBANA_CONF

#configure elastic.search
echo "network.host: 172.33.33.200" >>$ELASTIC_CONF
echo "discovery.type: single-node" >>$ELASTIC_CONF


#start services
systemctl daemon-reload
systemctl start elasticsearch.service
systemctl start kibana.service
