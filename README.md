# docker-rsyslog-es
rsyslog + omelasticsearch

## Simple tryout (needs clean-up)

Create a network so Docker containers can easily find each other (without Docker Links)
```
docker network create adriaan
```

Start elasticsearch
```
docker run -d --name es --net adriaan -p 9200:9200 -p 9300:9300 elasticsearch
```

Start rsyslog
```
docker run -d --name rs --net adriaan -p 514:514 adejonge/rsyslog-es
```

Start logspout
```
docker run --name="logspout" -d \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    --net adriaan \
    gliderlabs/logspout \
    tcp://rs:514
```

Do something to generate logs
```
docker run -d debian ping 8.8.8.8
```

Option 1: Quick check of results (from Docker host)
```
curl http://localhost:9200/test-index/_search/
```

Option 2: Run Kibana and see results
```
docker run --name kibana --net adriaan -e ELASTICSEARCH_URL=http://es:9200  -p 5601:5601 -d kibana
```
and open it from the browser pointing to `http://your-docker-host:5601/`
