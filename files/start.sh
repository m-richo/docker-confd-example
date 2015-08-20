#!/bin/bash
set -e  

# if $proxy_domain is not set, then default to $HOSTNAME
export proxy_domain=${proxy_domain:-$HOSTNAME}

# ensure the following environment variables are set. 
# exit script and container if not set.
test $backend_host
test $load_balancer_domain
test $app_servers

/usr/local/bin/confd -onetime -backend env

echo "Starting Nginx"
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf
