#!/bin/bash
SNOW_FOX="/opt/snow-fox/bin/snow-fox"
REPO_PATH="/opt/snow-fox/etc/example-config"

${SNOW_FOX} --nodaemonise --git --repo_path ${REPO_PATH}
