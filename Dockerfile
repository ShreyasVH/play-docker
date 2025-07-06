FROM mozilla/sbt AS build

WORKDIR /app/

COPY . .

ARG REPO_NAME=play-docker
ARG REPO_VERSION=1.0.0

RUN sbt clean compile dist

RUN unzip target/universal/${REPO_NAME}-${REPO_VERSION}.zip && mv ${REPO_NAME}-${REPO_VERSION} dist

# ----------------------------------------------------------------

# Runtime stage
FROM openjdk:11-slim

WORKDIR /app/

COPY --from=build /app/dist ./dist

EXPOSE 9000

ENTRYPOINT sh -c "./dist/bin/play-docker -Dhttp.port=9000"

