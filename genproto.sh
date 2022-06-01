#!/bin/bash

set -eux
cd $(dirname $0)

SCHEMA=.
OUT_PATH=.

[ -d ${OUT_PATH} ] || mkdir ${OUT_PATH}

PROTO_FILES=$(find ${SCHEMA} -name "*.proto")
protoc \
    --proto_path ./${SCHEMA} \
    --go_out=paths=source_relative:${OUT_PATH} \
    ${PROTO_FILES}

cd -
