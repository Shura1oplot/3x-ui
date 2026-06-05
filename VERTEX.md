docker image tag vertex:latest shura1oplot/vertex:latest
docker image push shura1oplot/vertex:latest

docker image pull shura1oplot/vertex:latest

docker stop vertex; docker rm vertex

docker run -it --rm --entrypoint bash
docker run -d --restart always
--name vertex --dns 1.1.1.1 --dns 8.8.8.8 -p 0.0.0.0:8123:8123 -p 0.0.0.0:8443:8443 -p 127.0.0.1:3128:3128 -p 127.0.0.1:1080:1080 -p 0.0.0.0:80:80 -p 0.0.0.0:443:443 -p 0.0.0.0:54861:54861 -v ./cert:/root/cert -v ./conf:/etc/x-ui:rw shura1oplot/vertex:latest

/app/main setting -username "..." -password "..." -port 8123 -webBasePath "/.../"
/app/main setting -resetTwoFactor true
