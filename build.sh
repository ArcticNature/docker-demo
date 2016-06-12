#!/bin/bash
#  Build (and optionally push) docker images.
set -e


# Variables.
IMAGE="latest"
PUSH="no"
REPO="spogliani/snow-fox"


# Parse arguments.
while [ $# -ne 0 ]; do
  arg=$1
  shift

  case "${arg}" in
    --push)
      PUSH="yes"
      ;;

    --image)
      IMAGE=$1
      shift
      ;;

    --all-images)
      IMAGE=""
      ;;

    *)
      echo "Unrecognised argument '${arg}'!" >&2
      exit 1
  esac
done


# Build an image.
build_image() {
  image=$1
  tag="${REPO}:${image}"

  echo "*** Building ${image} ..."
  cd "${image}"
  sudo docker build --rm=true --tag="${tag}" .

  push_image "${image}"
}

push_image() {
  if [ "${PUSH}" != "yes" ]; then
    exit 0
  fi

  image=$1
  tag="${REPO}:${image}"
  echo "*** Pushing ${image} to ${tag} ..."
  sudo docker push "${tag}"
}


### MAIN
if [ -z "${IMAGE}" ]; then
  ls -1 | while read image; do
    if [ -f "${image}/Dockerfile" ]; then
      build_image "${image}"
    fi
  done

  exit 0
fi

build_image "${IMAGE}"
