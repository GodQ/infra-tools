set -x 

docker rm -f kibana

local_ip=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v 172.1|grep -v 192.168|grep -v inet6|\
	awk '{print $2}'|tr -d "addr:")

docker run -d \
	-p 5601:5601 \
	-e "ES_JAVA_OPTS=-Xms1g -Xmx1g" -e "ELASTICSEARCH_HOSTS=http://${local_ip}:9200"\
	-e "XPACK_SECURITY_ENABLED=false" \
	-e "XPACK_MONITORING_UI_CONTAINER_ELASTICSEARCH_ENABLED=false" \
	--name=kibana \
	kibana:7.2.0

docker logs -f kibana

# sleep 10

# curl -kv 127.0.0.1:5601