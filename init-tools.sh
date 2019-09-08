#!/bin/bash

export http_proxy=http://10.140.123.158:3128
export https_proxy=http://10.140.123.158:3128

function init-ansible {

	local version=${1:-"v0.3.0"}
	local repo_url=https://github.com/sunbory/ansible-k8s/releases/download/v1.0/portable-ansible-${version}-py2.tar.bz2
		
	if ! curl -fsSL -o "portable-ansible.tar.bz2" "${repo_url}"; then
		fail "failed to download portable-ansible binary from ${repo_url}"
	fi
	
	tar jxvf portable-ansible.tar.bz2 > /dev/null && rm -rf portable-ansible.tar.bz2
	
	ln -s ansible ansible-playbook
  
}


function update-playbooks {
  
  local version=${1:-"v2.11.0"}
  local repo_url=https://github.com/kubernetes-sigs/kubespray/archive/${version}.zip
  
  if ! curl -fsSL -o "kubespray.tar.gz" "${repo_url}"; then
		fail "failed to download kubespray source from ${repo_url}"
	fi
  
  tar zxvf kubespray.tar.gz > /dev/null && kubespray.tar.gz
  
}

function main {
    init-ansible
    update-playbooks
}

main $@
