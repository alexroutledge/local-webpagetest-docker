#!/bin/bash
sudo docker pull webpagetest/server
sudo docker pull webpagetest/agent
cd server
sudo docker build -t local-wptserver .
# -t defines the name we are giving to this image
cd ../agent
# Make sure script.sh is executable:
chmod u+x script.sh
sudo docker build -t local-wptagent .
sudo docker run -d -p 4000:80 local-wptserver
sudo docker run -d -p 4001:80 \
    --network="host" \
    -e "SERVER_URL=http://localhost:4000/work/" \
    -e "LOCATION=Test" \
    local-wptagent