#!/bin/bash


main() {
    image_name="$1"
    image_builddir="$PWD/images/${image_name}"

    if [ ! -d "images/${image_name}" ]; then
        printf 'could not find image "%s"\n"' "${image_name}"
        return 1
    fi


    image_id="$(sudo docker build "${image_builddir}" | tail -1)"
    image_tag="$(sudo docker image inspect "${image_id}" | jq -r '[.[].Config.Env[] | select(test("(NAME|VERSION)")) | split("=")| .[1]] | { name: .[0], version: .[1] }  | "\(.name):\(.version)"')"

    sudo docker tag "${image_id}" "localhost/${image_tag}"

    printf 'created: %s\n' "${image_tag}"
}

main "$@"
