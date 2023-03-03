#git add --chmod=+x .\deploy.sh

set -a
source ./env.env

echo "SERVICE_NAME=$SERVICE_NAME"

docker pull $DOCKER_IMAGE

mkdir -p ./data/datasources
mkdir -p ./data/lib_grafana

mkdir -p ./data/dashboard

touch ./data/dashboard/dashboard.json

chmod -R 777 ./data

echo "Deploy stack"
docker stack deploy -c ./stack.yml $SERVICE_NAME
