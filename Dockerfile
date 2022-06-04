# Build stage
FROM openjdk:8-jdk-alpine as build
WORKDIR /home/app
COPY    Spring-example/src /home/app/src
COPY Spring-example/pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean test package
# Package stage
FROM openjdk:8-jdk-alpine
COPY --from=build /home/app/target/*.jar app.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","app.jar"]

