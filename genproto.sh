#!/bin/bash

set -eux
cd $(dirname $0)

PROTO_FILES=$(find "google/protobuf" -name "*.proto")

for file in $PROTO_FILES; do
    sed -i 's,google.golang.org/protobuf,github.com/sraphs/third_party,g' $file
    protoc \
        --proto_path . \
        --go_out=. \
        ${PROTO_FILES}
done

mkdir -p types/known
cp -r github.com/sraphs/third_party/types/known types
rm -rf github.com

cd -
