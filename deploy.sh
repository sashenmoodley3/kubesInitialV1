docker build -t slashy/multi-client:latest -t slashy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t slashy/multi-server:latest -t slashy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t slashy/multi-worker:latest -t slashy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push slashy/multi-client:latest
docker push slashy/multi-server:latest
docker push slashy/multi-worker:latest

docker push slashy/multi-client:$SHA
docker push slashy/multi-server:$SHA
docker push slashy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=slashy/multi-server:$SHA
kubectl set image deployments/client-deployment client=slashy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=slashy/multi-worker:$SHA