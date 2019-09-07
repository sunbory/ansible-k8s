#!/bin/bash

# export http_proxy=http://10.140.123.158:3128
# export https_proxy=http://10.140.123.158:3128

TOP_DIR=$(cd $(dirname "$0") && pwd)

function main {

        version=${1:-"v0.3.0"}
        local repo_url=https://github.com/ownport/portable-ansible/archive/${version}.tar.gz

        if ! curl -fsSL -o "portable-ansible.tar.gz" "${repo_url}"; then
                fail "failed to download portable-ansible source from ${repo_url}"
        fi

        tar zxvf portable-ansible.tar.gz > /dev/null

        cp requirements portable-ansible-0.3.0/conf 
        
        cd portable-ansible-0.3.0　
        
        make tarballs
        
        mkdir ../dist && mv builds/*.tar.bz2 ../dist
}

main $@
