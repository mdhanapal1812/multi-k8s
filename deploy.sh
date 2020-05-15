docker build -t mdhanapal/multi-client:latest -t mdhanapal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mdhanapal/multi-server:latest -t mdhanapal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mdhanapal/multi-worker:latest -t mdhanapal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mdhanapal/multi-client:latest
docker push mdhanapal/multi-server:latest
docker push mdhanapal/multi-worker:latest

docker push mdhanapal/multi-client:$SHA
docker push mdhanapal/multi-server:$SHA
docker push mdhanapal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mdhanapal/multi-server:$SHA
kubectl set image deployment/client-deployment client=mdhanapal/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=mdhanapal/multi-worker:$SHA