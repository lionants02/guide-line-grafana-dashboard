#git add --chmod=+x .\deploy.sh
mkdir -p ./data
chmod 777 ./data

echo "Deploy stack"
docker stack deploy -c ./stack.yml prometheus
