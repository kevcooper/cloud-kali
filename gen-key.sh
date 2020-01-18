#!/bin/bash

if [[ ! -f kali_rsa ]] && [[ ! -f kali_rsa.pub ]]; then
  ssh-keygen -t rsa -b 2048 -f kali_rsa -C hack_the_planet
fi

if [[ $(command -v aws) ]]; then
  if [[ -n $(aws ec2 describe-key-pairs --key-names kali | grep "InvalidKeyPair.NotFound") ]]; then
    aws ec2 describe-key-pairs --key-names kali || aws ec2 import-key-pair --key-name kali --public-key-material "$(cat kali_rsa.pub)"
  fi
fi
