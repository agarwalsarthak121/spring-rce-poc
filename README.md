# spring-rce-poc

Minimal example of how to reproduce Spring RCE.

## Run using docker compose

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

Exploiting the Vulnerability :

1. Build the application using Docker compose
    ```shell
    docker-compose up --build
    ```
2. To test the app browse to [http://localhost:8080/spring-rce-demo/greeting](http://localhost:8080/spring-rce-demo/greeting)
3. Run the exploit
    ```shell
    ./exploits/run.sh
    ```
4. The exploit is going to create `rce.jsp` file in  `webapps/spring-rce-demo` on the web server.
5.  Use the exploit
Browse to [http://localhost:8080/spring-rce-demo/rce.jsp](http://localhost:8080/spring-rce-demo/rce.jsp)

Verifying the workaround

1. Clean Docker Cache and Existing Containers
    ```shell
    docker system prune -f
    ```
2. Do the workaround changes and Build the application using Docker compose
    ```shell
    docker-compose up --build
    ```
3. Run the exploit
    ```shell
    ./exploits/run.sh
    ```
4. Browse to [http://localhost:8080/spring-rce-demo/rce.jsp](http://localhost:8080/spring-rce-demo/rce.jsp). It will give 404 error.
