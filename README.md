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
