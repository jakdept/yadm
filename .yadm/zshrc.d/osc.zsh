function osc() {
  # kill the image if it is running
  osc-kill

  # move to the osc folder
  mkdir -p ~/osc
  cd ~/osc
  
  # launch code
  code .
  
  # start the container
docker run -it --name=osc \
          -v "$(pwd):/root" \
          -w "/root" \
          jaltek/docker-opensuse-osc-client /bin/bash
}

function osc-kill() {
  [[ $(docker ps -a|grep osc|wc -l) -gt 0 ]] && {
    docker kill osc &>/dev/null || true
    docker rm osc
  }
}
