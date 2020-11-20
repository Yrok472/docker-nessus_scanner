#!/bin/bash

docker image rm yrok472/nessus_scanner
docker image rm nessus_scanner
docker build . -t nessus_scanner:latest
docker tag nessus_scanner yrok472/nessus_scanner:latest
docker push yrok472/nessus_scanner
