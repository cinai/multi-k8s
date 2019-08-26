docker build -t cinai/multi-client:latest -t cinai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cinai/multi-server:latest -t cinai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cinai/multi-worker:latest -t cinai/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cinai/multi-client:latest
docker push cinai/multi-server:latest
docker push cinai/multi-worker:latest

docker push cinai/multi-client:$SHA
docker push cinai/multi-server:$SHA
docker push cinai/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cinai/multi-server:$SHA
kubectl set image deployments/client-deployment client=cinai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cinai/multi-worker:$SHA