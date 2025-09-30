# Stage 1 - Build the .jar
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2 - Run the .jar
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/billingsoftware-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/app.jar"]