#!/usr/bin/env zsh
# Standarized $0 handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

awp() {
  local aws_profile
  if [[ "$#" -eq 0 ]]; then
    aws_profile=$(aws configure list-profiles | fzf)
  elif [[ "$#" -eq 1 ]]; then
    aws_profile=$(aws configure list-profiles | fzf -q ${1} --select-1 --exit-0)
  fi
  export AWS_PROFILE="${aws_profile}"
}