#!/usr/bin/bash
timestamp=$(date '+%Y.%m.%d-%H:%M:%S')
runtime_timestamp="********************* [${timestamp}] *********************\n\n"

NOSETESTS_FILE="nosetests.txt"
NOSETESTS_TEMP_FILE=$(mktemp)

LINT_FILE="lint.txt"
LINT_TEMP_FILE=$(mktemp)

function runNosetests () {
    printf "${runtime_timestamp}" > "${NOSETESTS_TEMP_FILE}"
    nosetests -s >> "${NOSETESTS_TEMP_FILE}" 2>&1;
    if [ -e "${NOSETESTS_FILE}" ]; then
        cat "${NOSETESTS_FILE}" >> "${NOSETESTS_TEMP_FILE}"
    else
        touch "${NOSETESTS_FILE}"
        cat "${NOSETESTS_FILE}" >> "${NOSETESTS_TEMP_FILE}"
    fi
    mv "${NOSETESTS_TEMP_FILE}" "${NOSETESTS_FILE}"
}

function runMakeLint () {
    printf "${runtime_timestamp}" >> "${LINT_TEMP_FILE}"
    make lint -s >> "${LINT_TEMP_FILE}" 2>&1;
    printf "\n" >> "${LINT_TEMP_FILE}"
    if [ -e "${LINT_FILE}" ]; then
        cat "${LINT_FILE}" >> "${LINT_TEMP_FILE}"
    else
        touch "${LINT_FILE}"
        cat "${LINT_FILE}" >> "${LINT_TEMP_FILE}"
    fi
    mv "${LINT_TEMP_FILE}" "${LINT_FILE}"
}

runNosetests
runMakeLint
printf "\033[0;32m\033[1m\033[4m********************* [${timestamp}] - RUNTESTS FINISHED *********************\033[0m\n\n"