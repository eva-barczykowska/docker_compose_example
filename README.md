### Launching the complete set of services (containers)

 ## Learning objectives:
 How to launch a complete set of services(containers)?
 - define them in the docker-compose.yml file
 - `docker-compose up`
 - `docker-compose down`

 `docker-compose up`
 is the one command for launching the complete set of services (containers) defined in a docker-compose.yml

 ## Stuff learned:
 1. I had a port conflict, port 5000 was busy and I was learned that
 -it's best not to kill a process if you don't know what it does
 -to know if what process is running on a port, use `lsof -i :5000`

 2. commands to start containers or remove containers
 `docker-compose up`
 starts the containers and shows the logs in the terminal

 ❯ docker-compose up
[+] Running 2/0
 ✔ Network docker_compose_example_default  Created                                                                                                                   0.0s
 ✔ Container docker_compose_example-web-1  Created

 `docker-compose down`
 This stops and removes the containers, networks, and default volumes associated with the docker-compose.yml file

 ❯ docker-compose down
[+] Running 2/0
 ✔ Container docker_compose_example-web-1  Removed                                                                                                                   0.0s
 ✔ Network docker_compose_example_default  Removed

 While running the container I got this error:

 ❯ docker-compose up
[+] Running 2/0
 ✔ Network docker_compose_example_default  Created                                                                                                                   0.0s
 ✔ Container docker_compose_example-web-1  Created                                                                                                                   0.0s
Attaching to web-1
Gracefully stopping... (press Ctrl+C again to force)
[+] Stopping 1/0
 ✔ Container docker_compose_example-web-1  Stopped                                                                                                                   0.0s
Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:5000 -> 0.0.0.0:0: listen tcp 0.0.0.0:5000: bind: address already in use

I changed the ports but the application did not run and old ports were showing up:

❯ docker-compose up
[+] Running 1/0
 ✔ Container docker_compose_example-web-1  Recreated                                                                                                                 0.0s
Attaching to web-1
web-1  |  * Serving Flask app 'app'
web-1  |  * Debug mode: off
web-1  | WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
web-1  |  * Running on all addresses (0.0.0.0)
web-1  |  * Running on http://127.0.0.1:5000
web-1  |  * Running on http://172.19.0.2:5000

I learned that I need to rebuild the container(s) from the Dockerfile so I did this with
`docker-compose up --build`

I rebuilt but the problem persisted, I was not able to open the app on the local host in the port that I specified
http://127.0.0.1:5005

and also I could see that the output in the Terminal shows the old ports, port change was not visible
this is because some of the files get CACHED. find CACHED in the logs:

```bash
 => [web internal] load build definition from Dockerfile                                                                                                             0.0s
 => => transferring dockerfile: 4.00kB                                                                                                                               0.0s
 => [web internal] load metadata for docker.io/library/python:3.9-slim                                                                                               1.2s
 => [web auth] library/python:pull token for registry-1.docker.io                                                                                                    0.0s
 => [web internal] load .dockerignore                                                                                                                                0.0s
 => => transferring context: 2B                                                                                                                                      0.0s
 => [web 1/5] FROM docker.io/library/python:3.9-slim@sha256:a0ba1303f0593d819f74af19ec08c82a5d3be255beb85c148b9807f10463c86c                                         0.0s
 => => resolve docker.io/library/python:3.9-slim@sha256:a0ba1303f0593d819f74af19ec08c82a5d3be255beb85c148b9807f10463c86c                                             0.0s
 => [web internal] load build context                                                                                                                                0.1s
 => => transferring context: 2.41MB                                                                                                                                  0.1s
 => CACHED [web 2/5] WORKDIR /app                                                                                                                                    0.0s
 => CACHED [web 3/5] COPY requirements.txt .                                                                                                                         0.0s
 => CACHED [web 4/5] RUN pip install -r requirements.txt                                                                                                             0.0s
 => [web 5/5] COPY . .                                                                                                                                               0.1s
 => [web] exporting to image                                                                                                                                         0.1s
 => => exporting layers                                                                                                                                              0.1s
 => => writing image sha256:ec5c12cc7e6aaed8b1b53afa96d904cf02cafe81bfb7a3a605b12a66e14e1ebf                                                                         0.0s
 => => naming to docker.io/library/docker_compose_example-web                                                                                                        0.0s
 => [web] resolving provenance for metadata file
```

There's a number of ways to fix this:
`docker builder prune`
will remove build cache for all images, which can help clear up space, but use it with caution as it removes cache
for all images, not just the one you're working with

`docker-compose up --build --no-cache`
is a better option (but I used the previous option since I am currently working only with 2 containers)

So I rebuilt again and finally was able to see the app running on the correct port, 5005 in this example.
 Final correct output (with the correct port):
 Attaching to web-1
web-1  |  * Serving Flask app 'app'
web-1  |  * Debug mode: off
web-1  | WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
web-1  |  * Running on all addresses (0.0.0.0)
web-1  |  * Running on http://127.0.0.1:5005
web-1  |  * Running on http://172.19.0.2:5005
