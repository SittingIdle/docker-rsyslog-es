FROM debian:8.4

RUN apt-get update \
  && apt-get install -y rsyslog rsyslog-elasticsearch \
  && rm -rf /var/lib/apt/lists/*
  
ADD rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]
