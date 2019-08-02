
docker rm -f elasticsearch

docker run -d \
	-v $(pwd)/es_data:/usr/share/elasticsearch/data \
	-p 9200:9200 -p 9300:9300 \
	-e "discovery.type=single-node" -e "bootstrap.memory_lock=true" -e "ES_JAVA_OPTS=-Xms1g -Xmx1g" \
	--name=elasticsearch \
	elasticsearch:7.2.0


sleep 10
curl -kv 127.0.0.1:9200