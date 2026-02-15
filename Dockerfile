FROM sbtscala/scala-sbt:eclipse-temurin-25.0.1_8_1.12.2_3.8.1 AS build

WORKDIR /app/

COPY . .

ARG REPO_NAME=play-docker
ARG REPO_VERSION=1.0.0

RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

RUN sbt clean compile dist

RUN unzip target/universal/${REPO_NAME}-${REPO_VERSION}.zip && mv ${REPO_NAME}-${REPO_VERSION} dist

# ----------------------------------------------------------------

# Runtime stage
FROM eclipse-temurin:25.0.1_8-jdk-jammy

WORKDIR /app/

COPY --from=build /app/dist ./dist

EXPOSE 9000

ENTRYPOINT sh -c "./dist/bin/play-docker -Dhttp.port=9000"

