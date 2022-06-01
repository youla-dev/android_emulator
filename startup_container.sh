#!/bin/bash

build_container=$1

BGreen='\033[1;32m'

build_container() {
    echo -ne "${BGreen}Сборка образа android emulator...${BGreen}\n\n"
    if [[ $build_container == "true" ]]; then 
        docker build --pull --rm -f "Dockerfile" -t emulator:latest "."
    fi
}
    
run_container() {
    echo -ne "${BGreen}Запуск контейнера android emulator...${BGreen}\n\n"
    path=$(pwd)
    docker run --device=/dev/kvm --volume $path/data/:/android/data --name emulator -d -t emulator:latest 
}

build_container
run_container