#!/bin/bash
set -e

RUN_DB=`docker ps | grep mysql`

# Run db if its necessary
if [ -z "${RUN_DB}" ]; then
	docker run --name db \
	    -e MYSQL_ROOT_PASSWORD=testroot \
	    -e MYSQL_USER=jackpotian \
	    -e MYSQL_PASSWORD=test \
	    -e MYSQL_DATABASE=experiment_db \
	    -p 3307:3306 \
	    -d mysql:8.0
fi

RUN_S3=`docker ps | grep minio`

if [ -z "${RUN_S3}" ]; then
	docker run -d --name s3 -p 9000:9000 -p 9001:9001 quay.io/minio/minio server /data --console-address ":9001" 
fi

cd experiments-params
go build 
go run . &

cd ..
cd arm-selector
go build
go run . &