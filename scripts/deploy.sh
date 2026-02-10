#!/bin/bash
echo "Creating namespace ..."
kubectl create namespace redis-lab --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying redis ..."
kubectl apply -n redis-lab -f ../k8s/redis-deployment.yaml
kubectl apply -n redis-lab -f ../k8s/redis-service.yaml

echo "Deploying python-API ..."
kubectl apply -n redis-lab -f ../k8s/deployment.yaml
kubectl apply -n redis-lab -f ../k8s/service.yaml

echo "waiting for pods..."
kubectl wait --for=condition=ready pod -l app=redis -n redis-lab --timeout=120s
kubectl wait --for=condition=ready pod -l app=python-api -nredis-lab --timeout=120s

echo "Deployment complete!"
