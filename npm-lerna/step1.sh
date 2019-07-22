#!/usr/bin/env bash

DIR=$(dirname "$0")

kubectl apply -f "${DIR}/assets/gitea.pod.yaml"
kubectl apply -f "${DIR}/assets/verdaccio.pod.yaml"
kubectl apply -f "${DIR}/assets/gitea.svc.yaml"
kubectl apply -f "${DIR}/assets/verdaccio.svc.yaml"
