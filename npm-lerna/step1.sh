#!/usr/bin/env bash

kubectl apply -f assets/gitea.pod.yaml
kubectl apply -f assets/verdaccio.pod.yaml
kubectl apply -f assets/gitea.svc.yaml
kubectl apply -f assets/verdaccio.svc.yaml
