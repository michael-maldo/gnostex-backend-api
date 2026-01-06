# =========================
# Build stage
# =========================
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom and download deps first (cache-friendly)
COPY pom.xml .
#RUN mvn dependency:go-offline

# Copy source and build
COPY src ./src
#RUN mvn clean package -DskipTests
#RUN mvn -B -DskipTests package
#RUN mvn -B -DskipTests -Dmaven.artifact.threads=1 package
RUN mvn -B -DskipTests -Dmaven.artifact.threads=1 clean package




# =========================
# Runtime stage
# =========================
FROM eclipse-temurin:21-jre
WORKDIR /app

# add curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy jar from build stage
COPY --from=build /app/target/gnostex-backend-api-0.0.1-SNAPSHOT.jar app.jar

# Copy source and target for exploration
# Comment out in production
#COPY --from=build /app/src ./src
#COPY --from=build /app/target ./target
#COPY --from=build /app/pom.xml ./pom.xml


# App port
EXPOSE 8080

# Optional JVM tuning (safe defaults)
ENV JAVA_OPTS=""

# health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Run Spring Boot
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar"]
