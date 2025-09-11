# Build stage 
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
#to improve caching 
COPY pom.xml .
# Cache dependencies
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage with jre not jdk
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 9966

ENTRYPOINT ["java", "-jar", "app.jar"]
