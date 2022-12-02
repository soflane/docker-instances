sudo touch elasticsearch/config/elasticsearch.yml
sudo touch kibana/config/kibana.yml
sudo sysctl -w vm.max_map_count=262144
sudo cp elasticsearch.yml  elasticsearch/config/elasticsearch.yml && sudo chmod 777 elasticsearch/config/elasticsearch.yml && docker-compose up -d && docker logs -f elastic
# sudo chmod -R 777 elasticsearch/ kibana/ logstash/ redis/ && docker-compose up -d && docker logs -f logstash