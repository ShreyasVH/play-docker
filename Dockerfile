FROM sbtscala/scala-sbt:eclipse-temurin-27_1.x AS build

WORKDIR /app/

COPY . .

ARG REPO_NAME=play-docker
ARG REPO_VERSION=1.0.0

RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

RUN sbt clean compile dist

RUN unzip target/universal/${REPO_NAME}-${REPO_VERSION}.zip && mv ${REPO_NAME}-${REPO_VERSION} dist

# ----------------------------------------------------------------

# Runtime stage
FROM eclipse-temurin:27-jdk-alpine

RUN apk add --no-cache bash

WORKDIR /app/

COPY --from=build /app/dist ./dist

EXPOSE 9000

ENTRYPOINT sh -c "./dist/bin/play-docker -Dhttp.port=9000"

