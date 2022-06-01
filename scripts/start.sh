#!/bin/bash

BRed='\033[1;31m'      
BGreen='\033[1;32m'      
BYellow='\033[1;33m'     
BBlue='\033[1;34m'  
BWhite='\033[1;37m'  

start_emulator() {
    echo -ne "${BYellow}Ожидание эмулятора...${BYellow}\n"
    adb wait-for-device    
}

install_apks() {
    echo -ne "${BGreen}Установка apk из директории apks...${BGreen}\n"
    echo -ne "${BBlue}Установка /android/apks/app.apk ${BBlue}\n"
    adb install -r /android/data/apks/app.apk
    echo -ne "${BBlue}Установка /android/apks/test.apk ${BBlue}\n"
    adb install -r /android/data/apks/test.apk
}

run_tests() {
    echo -ne "${BGreen}Запуск тестов...${BGreen}\n"
    adb shell am instrument -w com.example.lightson/com.example.lightson.TestRunner
}

export_reports() {
    echo -ne "${BWhite}Тесты прошли${BWhite}\n"
    adb pull "sdcard/Android/data/youla-allure-results" /android/data/ 
}

start_emulator
install_apks
run_tests
export_reports