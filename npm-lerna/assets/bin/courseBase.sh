#!/usr/bin/env bash

DIR=$(dirname $0)

kubectl apply -f $DIR/../etc/gitea.pod.yaml
kubectl apply -f $DIR/../etc/verdaccio.pod.yaml
kubectl apply -f $DIR/../etc/gitea.svc.yaml
kubectl apply -f $DIR/../etc/verdaccio.svc.yaml
