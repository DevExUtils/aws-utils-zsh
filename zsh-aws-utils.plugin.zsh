#!/usr/bin/env zsh
# Standarized $0 handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ -z "$AWS_UTILS_FZF_DEFAULT_OPTS" ]]
then
	AWS_UTILS_FZF_DEFAULT_OPTS="
    --ansi
    --border
    --height='60%'
    --layout=reverse
  "
fi

# 
set-awsprofile() {
  local aws_profile
  local opts=$AWS_UTILS_FZF_DEFAULT_OPTS
  if [[ "$#" -eq 0 ]]; then
    aws_profile=$(aws configure list-profiles |  FZF_DEFAULT_OPTS="$opts" fzf )
  elif [[ "$#" -eq 1 ]]; then
    aws_profile=$(aws configure list-profiles |  FZF_DEFAULT_OPTS="$opts" fzf -q ${1} --select-1 --exit-0)
  fi
  export AWS_PROFILE="${aws_profile}"
}

set-awsregion() {
  local aws_region
  local opts=$AWS_UTILS_FZF_DEFAULT_OPTS
  if [[ "$#" -eq 0 ]]; then
    aws_region=$(aws ec2 describe-regions \
                  --all-regions \
                  --query "Regions[].{Name:RegionName}" \
                  --output text | FZF_DEFAULT_OPTS="$opts" fzf)
  elif [[ "$#" -eq 1 ]]; then
    aws_region=$(aws ec2 describe-regions \
                  --all-regions \
                  --query "Regions[].{Name:RegionName}" \
                  --output text | FZF_DEFAULT_OPTS="$opts" fzf -q ${1} --select-1 --exit-0)
  fi
  export AWS_REGION="${aws_region}"
}

remove-awsvariables() {
  case ${1} in
      -a | --all)
          unset AWS_PROFILE
          unset AWS_ACCESS_KEY_ID
          unset AWS_SECRET_ACCESS_KEY
          unset AWS_SESSION_TOKEN
          unset AWS_REGION
          unset AWS_ROLE_ARN
          unset AWS_ROLE_SESSION_NAME
          ;;
      -k | --keys)
          unset AWS_ACCESS_KEY_ID
          unset AWS_SECRET_ACCESS_KEY
          unset AWS_SESSION_TOKEN
          ;;
      -p | --profile)
          unset AWS_PROFILE
          ;;
      -re | --region)
          unset AWS_REGION
          ;;
      -ro | --role)
          unset AWS_ROLE_ARN
          unset AWS_ROLE_SESSION_NAME
          ;;
      *)
          echo "Select which environment variables to unset:"
          echo "-k / --keys : AWS_ACCESS_KEY_ID - AWS_SECRET_ACCESS_KEY - AWS_SESSION_TOKEN"
          echo "-p / --profile : AWS_PROFILE"
          echo "-re / --region : AWS_REGION"
          echo "-ro / --role : AWS_ROLE_ARN - AWS_ROLE_SESSION_NAME"
          echo "-a / --all : Clears all above keys"
          ;;
  esac
}


list-awsvariables() {
  env | grep AWS_
}

if [[ -z "$AWS_UTILS_NO_ALIASES" ]]; then
    alias awp="set-awsprofile"
    alias awr="set-awsregion"
    alias awc="remove-awsvariables"
    alias awl="list-awsvariables"
fi