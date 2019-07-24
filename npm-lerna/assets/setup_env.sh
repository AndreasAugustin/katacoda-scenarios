#!/usr/bin/env bash

minikube start

DIR=$(dirname "$0")

kubectl apply -f "${DIR}/gitea.pod.yaml"
kubectl apply -f "${DIR}/verdaccio.pod.yaml"
kubectl apply -f "${DIR}/gitea.svc.yaml"
kubectl apply -f "${DIR}/verdaccio.svc.yaml"
