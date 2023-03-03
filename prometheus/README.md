# Prometheus
 - https://serverspace.io/support/help/install-prometheus-ubuntu-20-04
 - https://prometheus.io/docs/guides/basic-auth/#creating-web-yml

# Node Exporter
 - [Basic knowlet](https://prometheus.io/docs/guides/node-exporter/ ) 
 - [Authen](https://www.stackhero.io/en/services/Prometheus/documentations/Using-Node-Exporter/Add-authentication-to-Prometheus-Node-Exporter)  

```
sudo useradd node_exporter -s /sbin/nologin

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz

sudo cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/sbin/
```

```shell
sudo vim /etc/systemd/system/node_exporter.service
```
```
[Unit]
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/sbin/node_exporter --web.listen-address=0.0.0.0:8003 --web.config.file=/etc/node-exporter/web-config.yml
[Install]
WantedBy=multi-user.target
```
add basic config
```shell
sudo mkdir -p /etc/node-exporter
sudo touch /etc/node-exporter/web-config.yml
sudo vim /etc/node-exporter/web-config.yml
```

[Gen pass with python](https://prometheus.io/docs/guides/basic-auth/)

In file /etc/node-exporter/web-config.yml  
```
basic_auth_users:
  exporter: ${passwordHashed}
```


check
```shell
/usr/sbin/node_exporter --help
```

enable
```
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
```

check
```shell
curl -u exporter:${passwordHashed} http://localhost:8003/metrics
```

Add to prometheus config default location at `/etc/prometheus/prometheus.yml`
```yml
scrape_configs:
  - job_name: node
  static_configs:
      - targets: ['localhost:8003']
  basic_auth:
      username: 'exporter'
      password: '${passwordHashed}'
```

[Gen pass with python](https://prometheus.io/docs/guides/basic-auth/)
```python
import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])
install("python-bcrypt")
install("bcrypt")
import getpass
import bcrypt

password = getpass.getpass("password: ")
hashed_password = bcrypt.hashpw(password, bcrypt.gensalt())
print(hashed_password)
```