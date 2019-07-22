#!/usr/bin/env bash

DIR=$(dirname "$0")

kubectl apply -f "${DIR}/assets/infrastructure/gitea.pod.yaml"
kubectl apply -f "${DIR}/assets/infrastructure/verdaccio.pod.yaml"
kubectl apply -f "${DIR}/assets/infrastructure/gitea.svc.yaml"
kubectl apply -f "${DIR}/assets/infrastructure/verdaccio.svc.yaml"
