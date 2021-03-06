#!/bin/bash

set -x

source ci/common.sh

# Build uperf image for ci
build_and_push uperf-wrapper/Dockerfile quay.io/cloud-bulldozer/uperf:snafu_ci

cd ripsaw

sed -i 's/uperf:latest/uperf:snafu_ci/g' roles/uperf-bench/templates/*

# Build new ripsaw image
update_operator_image snafu_ci

get_uuid test_uperf.sh
uuid=`cat uuid`

cd ..

index="ripsaw-uperf-results"

check_es $uuid $index
exit $?
