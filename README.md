# spring-rce-poc

Minimal example of how to reproduce Spring RCE.

## Run using docker compose

1. Build the application using Docker compose
    ```shell
    docker-compose up --build
    ```
2. To test the app browse to [http://localhost:8080/handling-form-submission-complete/greeting](http://localhost:8080/handling-form-submission-complete/greeting)
3. Run the exploit
    ```shell
    ./exploits/run.sh
    ```
4. The exploit is going to create `rce.jsp` file in  `webapps/handling-form-submission-complete` on the web server.
5.  Use the exploit
Browse to [http://localhost:8080/handling-form-submission-complete/rce.jsp](http://localhost:8080/handling-form-submission-complete/rce.jsp)
