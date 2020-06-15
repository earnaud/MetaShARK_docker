#!/bin/sh

git pull
docker build -t metashark .
docker stop MS; docker run -d --rm -p 3838:3838 --name MS metashark
