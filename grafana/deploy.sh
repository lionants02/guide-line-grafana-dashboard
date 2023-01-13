set -a
source env.env

echo "S_DATA=$S_DATA"
echo "SERVICE_NAME=$SERVICE_NAME"

docker pull $DOCKER_IMAGE

echo "Create folder $S_DATA/datasources"
mkdir -p $S_DATA/datasources
echo "Create folder $S_DATA/lib_grafana"
mkdir -p $S_DATA/lib_grafana

mkdir -p $S_DATA/dashboard

touch $S_DATA/dashboard/dashboard.json


#cp grafana.ini $S_DATA/grafana.ini

ln -s $(pwd)/grafana.ini $S_DATA/grafana.ini

echo "Change mod foler $S_DATA/grafana"
chmod -R 777 $S_DATA

echo "Deploy stack"
docker stack deploy -c ./stack.yml $SERVICE_NAME
