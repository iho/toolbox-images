#!/bin/bash
set -x

main() {
    image_name="$(./util/build.sh "${1}" | awk '{print $2}')"

    docker tag "localhost/${image_name}" "${TOOLBOX_REPO}/${image_name}"
    docker push "${image_name}" "${TOOLBOX_REPO}/${image_name}"
}

main "$@"
