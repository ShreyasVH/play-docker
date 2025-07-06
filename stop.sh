docker exec ${COMPOSE_PROJECT_NAME}-docker rm -f /app/dist/RUNNING_PID

docker compose -p ${COMPOSE_PROJECT_NAME} -f docker-compose.yml stop > /dev/null 2>&1