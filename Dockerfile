# Stage 1: Build the fat jar with Gradle
FROM docker.io/gradle:jdk26-ubi AS builder

WORKDIR /app

# Copy only dependency-related files first
#COPY build.gradle settings.gradle ./
COPY build.gradle ./
COPY gradle/ gradle/

# Download dependencies (cached layer)
RUN gradle dependencies --no-daemon --quiet

# Copy source code and build
COPY src/ src/
RUN gradle shadowJar --no-daemon --quiet

# Stage 2: Minimal JRE runtime with no build artifacts
FROM docker.io/eclipse-temurin:26-jre-ubi10-minimal
#FROM docker.io/eclipse-temurin:26-jre-alpine

WORKDIR /app

# Copy the fat jar
COPY --from=builder /app/build/libs/app.jar /app/app.jar

# Create non-root user
RUN useradd appuser
USER appuser

EXPOSE 8080

# JVM container-aware flags
CMD ["java", \
     "-XX:+UseContainerSupport", \
     "-XX:MaxRAMPercentage=75.0", \
     "-XX:+UseG1GC", \
     "-XX:MaxGCPauseMillis=100", \
     "-Dmicronaut.environments=production", \
     "-jar", "/app/app.jar"]
