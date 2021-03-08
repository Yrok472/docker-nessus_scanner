#!/bin/bash

# "cd" into "nessus_scanner" before script running

# Preconditions:
# docker login https://harbor.smartvz.site # enter creds from https://harbor.smartvz.site

docker image rm infra/nessus_scanner
docker image rm nessus_scanner
docker build . -t nessus_scanner:latest
docker tag nessus_scanner harbor.smartvz.site/infra/nessus_scanner:latest
docker push harbor.smartvz.site/infra/nessus_scanner:latest
