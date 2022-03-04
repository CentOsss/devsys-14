https://www.elastic.co/blog/how-to-make-a-dockerfile-for-elasticsearch#ref2
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html#install-rpm


## Configure the logging driver  global setting:
```
/etc/docker/daemon.json

{
  "log-driver": "local",
  "log-opts": {
    "max-size": "10"
  }
}
# check that type of logger uses:
docker info --format '{{.LoggingDriver}}'
docker inspect -f '{{.HostConfig.LogConfig.Type}}' <CONTAINER>
```


## max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```
cat /proc/sys/vm/max_map_count
sh -c 'echo "vm.max_map_count = 262144" >> /etc/sysctl.conf'
sysctl -p

```

## запуск контейнера
```
docker run -d --log-driver local --log-opt max-size=50m --log-opt max-file=10 --name elastic \
-p 9200:9200 -v ELASTIC_LOG:/var/lib/log nordit/elasticsearch:latest

```


## set password 
```
docker exec -it $(docker ps ) sh -c '/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic'
4QujjqMz0fMOLe2OGBXe
```


## create index
```
curl -u elastic -k -v -X PUT https://localhost:9200/ind-2?pretty -H 'Content-Type: application/json' -d '{"settings": {"number_of_shards": 2, "number_of_replicas": 1 } }'
```

## list index
```
curl -k -u elastic -X GET 'https://localhost:9200/_cat/indices?v'
```

## status index
```
curl -u elastic -k -X GET 'https://localhost:9200/_cluster/health/ind-1?pretty'
```


0qkR9zAZJchuqtmIJAuY
0qkR9zAZJchuqtmIJAuY