## confd and Docker - Separating config and code for containers

This repo contains an example of how to use confd with Docker environment variables in order to set run-time configuration for containers.  A full blog post is available [here](http://www.mricho.com/confd-and-docker-separating-config-and-code-for-containers)

This example uses nginx.  The following occurs when launching a new container.  

* the container bootstrap script `/start.sh` executes.  It validates required environment variables and sets defaults where required.  
* confd executes and creates 2 configuration files in `/etc/nginx/conf.d` based on templates and environment variables.  
* nginx gets launched.  

The 2 configuration files created are for a simple reverse proxy and for a simple load balancer.  They are only intended as an example of what's possible with confd and environment variables.

## Getting started

Create the required docker image.  

	docker build nginx-confd .

Run the container with the required environment variables.  In this instance, `$proxy_domain`, `$backend_host`, `$load_balancer_domain` and `$app_servers`.


	docker run -it -p 80:80 -e proxy_domain="awesome.app.local" \
	-e backend_host="app01.domain.local" \
	-e load_balancer_domain="myapp.local" \
	-e app_servers="myapp01.local:myapp02.local:myapp03.local:myapp04.local" \
	nginx-confd
