FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/billingsoftware-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/app.jar"]