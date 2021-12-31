# Media Server Setup

## Terminology
- `media-server` : The remote server you are about to configure
- `host-server` : The host machine you are working on
- `NAS`         : Network attached storage server


## Set up ssh key based login to the media-server

1. Generate a ssh keypair if you don't already have it in your host-server. (Check using `ls ~/.ssh`)
```shell script
ssh-keygen
```
2. Copy the public key to the media-server

```shell script 
ssh-copy-id username@media-server-ip-or-hostname
```

3. Test with logging in
```shell script
ssh username@media-server-ip-or-hostname
```

## Install Ansible in your host machine

## Install Ansible community plugins in your host machine

```shell script
ansible-galaxy collection install community.docker
``` 

## Configure ansible playbook

### Network share mount
If using a NFS share mount role, make sure on the NAS server side,
1. Create dedicated user and a group on the NAS server and note down `uid` and `gid`
2. Use user/group mapping when creating the data set in your storage pools
3. Use user/group mapping when creating the share. (e.g : `Mapall User` and `Mapall Group` in TrueNAS). 
4. Update `local_media_uid` and `local_media_gid` in `inventories/default/group_vars/all.yml` accordingly.

## Run Ansible Playbook
```shell script
ansible-playbook site.yml -i inventories/default/hosts.ini
```

## App specific configuration

### qbittorrent

1. Default username is `admin`, password is `adminadmin`, change it via the webui (`<your-ip>:8080`)
