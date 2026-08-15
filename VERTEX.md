git pull https://github.com/MHSanaei/3x-ui

docker build --platform linux/amd64 -t vertex:latest -f Vertex.Dockerfile .

docker image tag vertex:latest shura1oplot/vertex:latest
docker image push shura1oplot/vertex:latest

---

docker image pull shura1oplot/vertex:latest


docker stop vertex; docker rm vertex

docker run -it --rm --entrypoint bash
docker run -d --restart always

--name vertex

--dns 1.1.1.1 --dns 8.8.8.8 -p 0.0.0.0:80:80 -p 0.0.0.0:443:443 -p 127.0.0.1:8000:8000 -p 127.0.0.1:8123:8123 -p 0.0.0.0:8443:8443 -p 127.0.0.1:3128:3128 -p 127.0.0.1:1080:1080
--network host

-v ./cert:/root/cert -v ./conf:/etc/x-ui:rw shura1oplot/vertex:latest


acme.sh --issue --standalone --server letsencrypt -d example.com -d www.example.com


docker exec -it vertex
/app/main setting -username "..." -password "..." -port 8123 -webBasePath "/.../"
/app/main setting -resetTwoFactor true
