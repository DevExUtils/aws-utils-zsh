# AWS Utilities for ZSH

ZSH AWP (Amazon Web Profile) is a small utility tool which uses the AWS CLI and FZF to quickly switch between your AWS CLI profiles and regions.

## About

This plugin contain two functions for your shell that allows you to quickly populate your $AWS_PROFILE and $AWS_REGION environment variables through an interactive FZF selection menu.

Currently the plugin supports the following two functions:
* awp
* awr

## Requirements

The plugin depends on the following tools, these must already be installed on your system and be available in your $PATH
* [FZF][fzf]
* [AWS CLI v2][AWSCLI]

### awp

This function interactively allows you to select a Profile from your AWS CLI profile config file and put that into the $AWS_PROFILE environment variable.
The function can be run two different ways.

List all profiles in your .aws/config file for interactive selection.
Selected profile exported to $env:AWS_PROFILE environment variable

```sh
awp
```

Pre-sort the profile list with the entered keyword.  
If multiple profiles matches the keyword, user is prompted to select profile from a list.  
If only a single match is found that profile is directly selected without further user prompts.  
Selected profile exported to $env:AWS_PROFILE environment variable.

```sh
awp myprofile
```

[fzf]: https://github.com/junegunn/fzf
[AWSCLI]: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
