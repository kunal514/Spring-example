# Build the application first using Maven
FROM java:alpine
WORKDIR /app
COPY . .
RUN mvn install

# Inject the JAR file into a new container to keep the file small
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/spring-example-0.0.1-SNAPSHOT-jar-with-dependencies.jar /app/app.jar
EXPOSE 8090
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
