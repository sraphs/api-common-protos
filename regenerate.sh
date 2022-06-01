#!/bin/bash

set -eux

dir=$(readlink -f $(dirname $0))
tmpdir=$(mktemp -d)

cd ${tmpdir}

# google api-common-protos
git clone --branch main https://github.com/googleapis/api-common-protos.git --depth 1
cp -r api-common-protos/google .
rm -rf api-common-protos

# kratos errors
mkdir -p errors
curl -sSL https://fastly.jsdelivr.net/gh/go-kratos/kratos@main/errors/errors.proto -o errors/errors.proto

# protoc-gen-openapiv2
mkdir -p protoc-gen-openapiv2/options
curl -sSL https://fastly.jsdelivr.net/gh/grpc-ecosystem/grpc-gateway@master/protoc-gen-openapiv2/options/annotations.proto -o protoc-gen-openapiv2/options/annotations.proto
curl -sSL https://fastly.jsdelivr.net/gh/grpc-ecosystem/grpc-gateway@master/protoc-gen-openapiv2/options/openapiv2.proto -o protoc-gen-openapiv2/options/openapiv2.proto

# validate
mkdir -p validate
curl -sSL https://fastly.jsdelivr.net/gh/envoyproxy/protoc-gen-validate@main/validate/validate.proto -o validate/validate.proto

# sraph
mkdir -p sraph/slog
curl -sSL https://fastly.jsdelivr.net/gh/sraphs/slog@main/log.proto -o sraph/slog/log.proto

# go/tags
mkdir -p go/tags
curl -sSL https://fastly.jsdelivr.net/gh/sraphs/protobuf-go@reat/add_go_tag/gotags/opts.proto -o go/tags/opts.proto

# copy and clean up
rsync -av --include='*.proto' --include='*/' --exclude='*' ${tmpdir}/* ${dir}
cd ${dir}
rm -rf ${tmpdir}

./genproto.sh