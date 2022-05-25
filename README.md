# Third Party Protos

This repository is a home for the protocol buffer types which are made available for use as dependencies elsewhere.

## Schemas

- (google apis)[https://github.com/googleapis/api-common-protos]
  
- (errors)[https://github.com/go-kratos/kratos]
  
- (validate)[https://github.com/envoyproxy/protoc-gen-validate]

## Usage

Clone the repository:

```base
git clone https://github.com/sraphs/api-common-protos.git schema/api-common-protos
```

Initialize the submodule:

```bash
git submodule update --init --recursive
```