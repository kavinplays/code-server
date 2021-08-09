#!/bin/bash

START_DIR="${START_DIR:-/home/coder}"
PREFIX="deploy-code-server"

mkdir -p $START_DIR

project_init () {
    sudo mkdir $START_DIR/projects && sudo echo -e "Username:kavinplays\nPassword:${GITHUB}" > $START_DIR/projects/github_login
}
project_init
echo "[$PREFIX] Starting code-server..."

/usr/bin/entrypoint.sh --disable-update-check --bind-addr 0.0.0.0:8080 $START_DIR/projects
