function docker-cleanup() {
  #docker ps -aq | xargs docker rm
  docker ps --filter status=exited -q | xargs docker rm -v
  docker ps --filter status=dead -q | xargs docker rm -v
  docker images --filter dangling=true -q | xargs docker rmi
}