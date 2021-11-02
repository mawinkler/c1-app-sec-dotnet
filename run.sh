#!/bin/bash
sudo rm logs/appsec.log
#DOCKER_BUILDKIT=1 
docker build -t c1-app-sec-dotnet -f Dockerfile.${DOTNET_VERSION} .

docker run -p 80:80 --rm \
  --name c1-app-sec-dotnet \
  -e TREND_AP_KEY=${APPSEC_KEY} \
  -e TREND_AP_SECRET=${APPSEC_SECRET} \
  -v $(pwd)/logs:/var/log/appsec:rw \
   c1-app-sec-dotnet
