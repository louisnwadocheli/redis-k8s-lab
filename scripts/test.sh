#!/bin/bash
kubectl port-forward svc/python-api 8000:80 -n redis-lab &
PID=$!

sleep 5

echo "writing value ..."
curl -X POST "http://localhost:8000/cache?key=stage5&value=success"

echo ""
echo "Reading value ..."
curl "http://localhost:8000/cache?key=stage5"

kill $PID

