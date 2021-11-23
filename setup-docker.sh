#!/bin/bash

# build the flask container
docker build -t dratko30/food-web .

# create the network
docker network create food-net

# start the ES container
docker run -d --name es --net food-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.15.2

# start the flask app container
docker run -d --net food-net -p 5500:5000 --name foodtrucks-web dratko30/food-web
