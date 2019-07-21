#!/usr/bin/env bash

kubectl apply -f infrastructure/gitea.pod.yaml
kubectl apply -f infrastructure/verdaccio.pod.yaml
kubectl apply -f infrastructure/gitea.svc.yaml
kubectl apply -f infrastructure/verdaccio.svc.yaml
