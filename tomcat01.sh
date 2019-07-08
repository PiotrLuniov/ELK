#!/bin/bash
#install tomcat
yum -y install tomcat tomcat-webapps tomcat-admin-webapps

#deploy sample{1,2,3}.war
cd /usr/share/tomcat/webapps/
wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
for i in $(seq 1 3); do cp sample.war sample$i.war; done

chmod -R 755 /var/log/tomcat/

#start services
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

#install logstash
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat>/etc/yum.repos.d/logstash.repo<<EOM
[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOM
yum -y install logstash

#configure logstash
cat>/etc/logstash/conf.d/logstash.conf<<EOM
input {
  file {
    path => "/var/log/tomcat/catalina.2019-07-08.log"
    start_position => "beginning"
  }
}

output {
  elasticsearch {
    hosts => ["172.33.33.200:9200"]
  }
  stdout { codec => rubydebug }
}
EOM

#start services
systemctl start logstash.service
