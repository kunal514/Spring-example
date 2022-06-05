# Build stage
FROM openjdk:8-jdk-alpine as build
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app
chmod 777 *
RUN  /home/app/pom.xml clean install
# Package stage
FROM openjdk:8-jdk-alpine
COPY --from=build /home/app/target/*.jar app.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","app.jar"]

