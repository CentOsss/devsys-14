FROM centos:7

RUN groupadd elasticsearch && \
         useradd -g elasticsearch elasticsearch

RUN yum install wget -y && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        mkdir /usr/share/elasticsearch/ /var/lib/elasticsearch/logs /var/lib/elasticsearch/data /var/lib/elasticsearch/snapshots && \
        tar -xf elasticsearch-8.0.1-linux-x86_64.tar.gz -C /usr/share/elasticsearch --strip-components 1 && \
        rm -f elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
        chown elasticsearch:elasticsearch /var/lib/elasticsearch/data /var/lib/elasticsearch/logs /var/lib/elasticsearch/snapshots

EXPOSE 9200/tcp 9300/tcp

USER elasticsearch

ENV PATH=/usr/share/elasticsearch/bin:$PATH

COPY . /usr/share/elasticsearch/config/

WORKDIR /usr/share/elasticsearch/

CMD ["elasticsearch"]


