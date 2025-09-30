# Stage 1: Build the app using Maven + JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies (helps caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire project and build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Use a smaller JDK 17 runtime image
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/billingsoftware-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080 (Spring Boot default)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
