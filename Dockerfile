FROM openjdk:8-jre-alpine
WORKDIR /tmp
COPY target/demo-0.0.1-SNAPSHOT-jar-with-dependencies.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]