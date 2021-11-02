#!/bin/bash
docker login
docker build -t c1-app-sec-dotnet -f Dockerfile.${DOTNET_VERSION} .
docker tag c1-app-sec-dotnet ${DOCKER_USERNAME}/c1-app-sec-dotnet:latest
docker push ${DOCKER_USERNAME}/c1-app-sec-dotnet:latest

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
  name: c1-app-sec-dotnet
  labels:
    app: c1-app-sec-dotnet
spec:
  type: LoadBalancer
  ports:
  - port: 80
    name: c1-app-sec-dotnet
    targetPort: 80
  selector:
    app: c1-app-sec-dotnet
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: c1-app-sec-dotnet
  name: c1-app-sec-dotnet
spec:
  replicas: 1
  selector:
    matchLabels:
      app: c1-app-sec-dotnet
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  template:
    metadata:
      labels:
        app: c1-app-sec-dotnet
    spec:
      containers:
      - name: c1-app-sec-dotnet
        image: ${DOCKER_USERNAME}/c1-app-sec-dotnet:latest
        imagePullPolicy: Always
        env:
        - name: TREND_AP_KEY
          value: ${APPSEC_KEY}
        - name: TREND_AP_SECRET
          value: ${APPSEC_SECRET}
        ports:
        - containerPort: 80
EOF
