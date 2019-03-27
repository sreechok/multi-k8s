docker build -t sreechok/multi-client:latest -t sreechok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sreechok/multi-server:latest -t sreechok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sreechok/multi-worker:latest -t sreechok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sreechok/multi-client:latest
docker push sreechok/multi-server:latest
docker push sreechok/multi-worker:latest

docker push sreechok/multi-client:$SHA
docker push sreechok/multi-server:$SHA
docker push sreechok/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sreechok/multi-server:$SHA
kubectl set image deployments/client-deployment client=sreechok/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sreechok/multi-worker:$SHA