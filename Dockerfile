# Build
FROM maven:3.8.3-jdk-8 as build-env

VOLUME /tmp
WORKDIR /

COPY ./pom.xml .

RUN mvn dependency:go-offline -B

COPY ./src ./src

RUN mvn package
RUN ls
RUN mv ./target/*.jar /*.jar

# Package
FROM public.ecr.aws/amazoncorretto/amazoncorretto:8-al2-jdk

ADD https://github.com/aws-observability/aws-otel-java-instrumentation/releases/download/v1.2.0/aws-opentelemetry-agent.jar /app/aws-opentelemetry-agent.jar
ENV JAVA_TOOL_OPTIONS "-javaagent:/app/aws-opentelemetry-agent.jar"

WORKDIR /app

COPY --from=build-env /*.jar service.jar


ENTRYPOINT exec java -jar service.jar
