# Stage 1: Build the application using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
# Download dependencies first to cache them
RUN mvn dependency:go-offline

COPY src ./src
# Build the WAR file (ignoring tests for faster deployment)
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copy the built WAR from the builder stage
COPY --from=builder /app/target/*.war app.war

# Expose the default Spring Boot port
EXPOSE 8080

# Run the WAR file
ENTRYPOINT ["java", "-jar", "app.war"]
