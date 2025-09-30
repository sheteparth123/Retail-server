# Stage 1: Build the app using Maven
FROM maven:3.6.3-openjdk-8 AS build
WORKDIR /app

# Copy pom.xml and download dependencies (helps caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the entire project and build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Use a smaller JDK runtime image
FROM openjdk:8-jdk-slim
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/BillingsoftwareApplication.jar app.jar

# Expose port 8080 (Spring Boot default)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]