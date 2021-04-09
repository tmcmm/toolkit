#!/bin/bash

# Pré-requisitos locais (localhost):
# - docker
# - curl

# Definição de variáveis
TOOLKIT_CONFIG=$HOME/.toolkit

# Create ToolKit configuration folder
mkdir -p $TOOLKIT_CONFIG
# Get toolkit template
#curl -k --header "${GITLAB_TOKEN}" https://gitlab.com/api/v4/projects/22815162/repository/files/toolkit.j2/raw?ref=master \
#-o $TOOLKIT_CONFIG/toolkit.j2

curl -k -H 'Accept: application/vnd.github.v3.raw' 'https://api.github.com/repos/tmcmm/toolkit/contents/toolkit.j2' \
-o $TOOLKIT_CONFIG/toolkit.j2

curl -k -H 'Accept: application/vnd.github.v3.raw' 'https://api.github.com/repos/tmcmm/toolkit/contents/toolkit.yaml' \
-o $TOOLKIT_CONFIG/toolkit.yaml

# Get toolkit configuration
#curl -k --header "${GITLAB_TOKEN}" https://gitlab.com/api/v4/projects/22815162/repository/files/toolkit.yaml/raw?ref=master \
#-o $TOOLKIT_CONFIG/toolkit.yaml

# Setup toolkit
cat $TOOLKIT_CONFIG/toolkit.yaml | docker run -i \
-u `id -u`:`id -g` -v $HOME:$HOME -v /tmp:/tmp -v `echo "/$(echo "$PWD" | cut -d "/" -f2)"`:`echo "/$(echo "$PWD" | cut -d "/" -f2)"` \
 -w $PWD \
-e HOME=$HOME  \
 tmcmm/jinja2 jinja2 --format=yaml  $TOOLKIT_CONFIG/toolkit.j2 -o $TOOLKIT_CONFIG/toolkit.env

# Persist toolkit into the environment
grep -qxF ". $TOOLKIT_CONFIG/toolkit.env" $HOME/.bashrc || echo ". $TOOLKIT_CONFIG/toolkit.env" >> $HOME/.bashrc

# Reload bashrc for parent shell
echo "Close your terminal to reload environment and end the setup."

# alias for list tools 
echo "Type list for display available tools list"
