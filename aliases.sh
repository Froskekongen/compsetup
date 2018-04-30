alias docker_rm_cont="docker rm $(docker ps -a -q)"
alias docker_rm_imgs="docker rmi $(docker images | grep ``^<none>`` | awk ``{print $3}``)"
