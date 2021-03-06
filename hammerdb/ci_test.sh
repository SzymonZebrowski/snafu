#!/bin/bash

set -x

source ci/common.sh

# Build image for ci
build_and_push hammerdb/Dockerfile quay.io/cloud-bulldozer/hammerdb:snafu_ci

cd ripsaw

sed -i 's/hammerdb:latest/hammerdb:snafu_ci/g' roles/hammerdb/templates/*

# Build new ripsaw image
update_operator_image snafu_ci

get_uuid test_hammerdb.sh
uuid=`cat uuid`

cd ..

index="ripsaw-hammerdb-results"

check_es $uuid $index
exit $?
