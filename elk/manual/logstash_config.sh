# /etc/logstash/startup.options中 LS_SETTINGS_DIR=/etc/logstash/conf.d

sed -i 's/LS_SETTINGS_DIR=\/etc\/logstash$/LS_SETTINGS_DIR=\/etc\/logstash\/conf.d/g' /etc/logstash/startup.options