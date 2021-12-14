# Media Server Setup

## Terminology
- `media-server` : The remote server you are about to configure
- `host-server` : The host machine you are working on


## Set up ssh keybased login to the media-server

1. Generate a ssh keypair if you don't already have it in your host-server. (Check using `ls ~/.ssh`)
```bash
ssh-keygen
```
2. Copy the public key to the media-server

```bash 
ssh-copy-id username@media-server-ip-or-hostname
```

3. Test with logging in
```bash
ssh username@media-server-ip-or-hostname
```

## Install Ansible in your host machine

## Configure ansible playbook

## Run Ansible Playbook
