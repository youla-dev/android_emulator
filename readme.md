# Android emulator

Данный репозиторий содержит dockerfile для создания образа с android эмулятором и скриптами запуска UI тестов

### Инструкция
Запуск контейнера
```sh
./startup_container.sh (true|false) 

true - позволяет запустить build образа и после запустить собранный образ
false - позволяет запустить собранный ранее образ
```

Запуск эмулятора внутри контейнера
```sh 
docker exec -it emulator ./scripts/startup.sh & disown
```

Запуск тестов
```sh
docker exec -it emulator ./scripts/start.sh
```