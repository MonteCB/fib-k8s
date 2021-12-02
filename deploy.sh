docker build -t montecb/fib-client:latest -t montecb/fib-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t montecb/fib-server:latest -t montecb/fib-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t montecb/fib-worker:latest -t montecb/fib-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push montecb/fib-client:latest
docker push montecb/fib-server:latest
docker push montecb/fib-worker:latest

docker push montecb/fib-client:$SHA
docker push montecb/fib-server:$SHA
docker push montecb/fib-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=montecb/fib-server:$SHA
kubectl set image deployments/client-deployment client=montecb/fib-client:$SHA
kubectl set image deployments/worker-deployment worker=montecb/fib-worker:$SHA