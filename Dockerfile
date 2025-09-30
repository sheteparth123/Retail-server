# Stage 1: Build with Maven + JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire project and build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Slimmer JDK 21 runtime
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

COPY --from=build /app/target/billingsoftware-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
