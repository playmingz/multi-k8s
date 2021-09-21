docker build -t playmingz/multi-client:latest -t playmingz/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t playmingz/multi-server:latest -t playmingz/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t playmingz/multi-worker:latest -t playmingz/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push playmingz/multi-client:latest
docker push playmingz/multi-server:latest
docker push playmingz/multi-worker:latest
docker push playmingz/multi-client:$SHA
docker push playmingz/multi-server:$SHA
docker push playmingz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=playmingz/multi-server:$SHA
kubectl set image deployments/client-deployment client=playmingz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=playmingz/multi-worker:$SHA
