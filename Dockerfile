# =========================
# 1) Build da aplicação
# =========================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copia TODO o projeto (pom.xml, src, etc)
COPY . .

# Compila a aplicação (sem rodar testes)
RUN mvn -DskipTests package


# =========================
# 2) Runtime (imagem final)
# =========================
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copia o fast-jar gerado pelo Quarkus
COPY --from=build /app/target/quarkus-app /app/

# Expõe a porta padrão do Quarkus
EXPOSE 8080

# Comando de inicialização
CMD ["java", "-jar", "/app/quarkus-run.jar"]
