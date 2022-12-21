docker build -t andrwcao/multi-client:latest -t andrwcao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrwcao/multi-server:latest -t andrwcao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrwcao/multi-worker:latest -t andrwcao/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andrwcao/multi-client:latest
docker push andrwcao/multi-server:latest
docker push andrwcao/multi-worker:latest

docker push andrwcao/multi-client:$SHA
docker push andrwcao/multi-server:$SHA
docker push andrwcao/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=andrwcao/multi-client:$SHA
kubectl set image deployments/server-deployment server=andrwcao/multi-server:$SHA
kubectl set image deployments/worker-deployment server=andrwcao/multi-worker:$SHA