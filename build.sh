#!/bin/bash

# export http_proxy=http://10.140.123.158:3128
# export https_proxy=http://10.140.123.158:3128

function main {

	local repo_url=https://github.com/ownport/portable-ansible/archive/v0.3.0.tar.gz
		
	if ! curl -fsSL -o "portable-ansible-0.3.0.tar.gz" "${repo_url}"; then
		fail "failed to download portable-ansible source from ${repo_url}"
	fi
	
	tar zxvf portable-ansible-0.3.0.tar.gz > /dev/null && rm -rf portable-ansible.tar.bz2
	
	ln -s ansible ansible-playbook
}

main $@
