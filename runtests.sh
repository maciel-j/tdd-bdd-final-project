#!/usr/bin/bash
timestamp=$(date '+%Y.%m.%d-%H:%M:%S')
runtime_timestamp="********************* [${timestamp}] *********************\n\n"

function runNosetests () {
    printf "${runtime_timestamp}" >> nosetests.txt
    nosetests -s >> nosetests.txt 2>&1;
}

function runMakeLint () {
    printf "${runtime_timestamp}" >> lint.txt
    make lint -s >> lint.txt 2>&1;
    printf "\n" >> lint.txt
}

runNosetests
runMakeLint
printf "\033[0;32m\033[1m\033[4m********************* [${timestamp}] - RUNTESTS FINISHED *********************\033[0m\n\n"