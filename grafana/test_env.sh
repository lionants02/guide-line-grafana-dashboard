set -a
source ./env.env
chmode +x deploy.sh
chmode +x test_env.sh
echo "S_DATA=$S_DATA"
echo "SERVICE_NAME=$SERVICE_NAME"