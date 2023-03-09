#git add --chmod=+x .\deploy.sh

echo "Deploy stack"
docker stack deploy -c ./stack.yml cadvisor
