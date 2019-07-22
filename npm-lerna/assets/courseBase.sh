#!/usr/bin/env bash

kubectl apply -f /root/.env/gitea.pod.yaml
kubectl apply -f /root/.env/verdaccio.pod.yaml
kubectl apply -f /root/.env/gitea.svc.yaml
kubectl apply -f /root/.env/verdaccio.svc.yaml
