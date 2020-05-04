docker build -t hades12/docker-complex-test-client:latest -t hades12/docker-complex-test-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t hades12/docker-complex-test-server:latest -t hades12/docker-complex-test-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t hades12/docker-complex-test-worker:latest -t hades12/docker-complex-test-worker:$GIT_SHA -f ./worker/Dockerfile ./worker 

docker push hades12/docker-complex-test-client:latest
docker push hades12/docker-complex-test-server:latest
docker push hades12/docker-complex-test-worker:latest
docker push hades12/docker-complex-test-client:$GIT_SHA
docker push hades12/docker-complex-test-server:$GIT_SHA
docker push hades12/docker-complex-test-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hades12/docker-complex-test-client:$GIT_SHA
kubectl set image deployments/server-deployment server=hades12/docker-complex-test-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=hades12/docker-complex-test-worker:$GIT_SHA