# =========================
# 1) Build da aplicação
# =========================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -DskipTests package


# =========================
# 2) Runtime
# =========================
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=build /app/target/quarkus-app /app/

# Porta padrão do Quarkus
EXPOSE 8080

CMD ["java", "-jar", "/app/quarkus-run.jar"]
