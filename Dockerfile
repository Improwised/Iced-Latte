FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /usr/app
COPY . /usr/app
RUN mvn versions:set-property -Dproperty=project.version -DnewVersion=0.0.1 && \
    mvn package -Pdev -DskipTests
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /usr/app
COPY --from=build /usr/app/target/*.jar /usr/app/app.jar
CMD ["java", "-jar", "/usr/app/app.jar"]
