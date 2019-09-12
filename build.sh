#!/bin/bash

# export http_proxy=http://10.140.123.158:3128
# export https_proxy=http://10.140.123.158:3128

TOP_DIR=$(cd $(dirname "$0") && pwd)

function main {

    local version=${1:-"0.3.0"}
    local repo_url=https://github.com/ownport/portable-ansible/archive/v${version}.tar.gz

    if ! curl -fsSL -o "portable-ansible.tar.gz" "${repo_url}"; then
        fail "failed to download portable-ansible source from ${repo_url}"
    fi

    tar zxvf portable-ansible.tar.gz > /dev/null \
        && rm -rf portable-ansible.tar.gz \
        && cp requirements portable-ansible-${version}/conf


    cd ${TOP_DIR}/portable-ansible-${version} \
        && sed -i 's/--no-deps//g' Makefile \
        && make tarballs
    
    mkdir -p ${TOP_DIR}/dist && mv builds/*.tar.bz2 ${TOP_DIR}/dist
}

main $@
