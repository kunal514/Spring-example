FROM adoptopenjdk/openjdk11:alpine-jre

ARG APP_NAME="Spring-example"
ARG APP_VERSION="0.0.1"
ARG JAR_FILE="/target/spring-example-0.0.1-SNAPSHOT-jar-with-dependencies.jar"

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "app.jar"]
