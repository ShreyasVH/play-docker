#FROM mozilla/sbt AS build
#WORKDIR /app/
#COPY . .
#RUN sbt clean compile dist
#ARG REPO_NAME=play-docker
#ARG REPO_VERSION=1.0.0
#RUN unzip target/universal/$REPO_NAME-$REPO_VERSION.zip
#RUN mv $REPO_NAME-$REPO_VERSION dist
#RUN ls target/universal
#
## ----------------------------------------------------------------
#
#FROM openjdk
#
#WORKDIR /app/
#ARG REPO_NAME=play-docker
#
#COPY --from=build /app/dist ./dist
#
##ENTRYPOINT ["sh", "-c", "dist/bin/play-docker"]
##ENTRYPOINT ["echo", "$REPO_NAME"]
#ENTRYPOINT ["dist/bin/play-docker", "-Dhttp.port=9000"]

# Build stage
FROM mozilla/sbt AS build

WORKDIR /app/

COPY . .

ARG REPO_NAME=play-docker
ARG REPO_VERSION=1.0.0

RUN sbt clean compile dist

RUN unzip target/universal/${REPO_NAME}-${REPO_VERSION}.zip && \
    mv ${REPO_NAME}-${REPO_VERSION} dist && \
    chmod +x dist/bin/${REPO_NAME} && \
    ls -lh dist/bin

# ----------------------------------------------------------------

# Runtime stage
FROM openjdk:17-slim

WORKDIR /app/

ARG REPO_NAME=play-docker

COPY --from=build /app/dist ./dist

EXPOSE 9000

# Use shell form to expand variables and allow execution
ENTRYPOINT sh -c "./dist/bin/play-docker -Dhttp.port=9000"

