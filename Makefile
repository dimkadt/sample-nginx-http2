NGINX_BIN := /usr/local/nginx/sbin/nginx

build:
	go build -i -v -o sample

fmt:
	go fmt

run: build
	sudo ./sample \
		-http2 \
		-port=443 \
		-key=./certs/key_example.com.pem \
		-cert=./certs/cert_example.com.pem

run-http1: build
	./sample -http2=false -port=8080


run-nginx:
	$(NGINX_BIN) -p $(shell pwd)/ -c nginx.cfg

open-chrome:
	SSLKEYLOGFILE=~/tlskey.log \
        /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &

.PHONY: build fmt run open-chrome
