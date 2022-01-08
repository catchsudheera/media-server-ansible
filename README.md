# Media Server Setup

## Terminology
- `media-server` : The remote server you are about to configure
- `host-server` : The host machine you are working on
- `NAS`         : Network attached storage server

## Follow these instruction to set up your environment.

#1. Set up ssh key based login to the media-server

a. Generate a ssh keypair if you don't already have it in your host-server. (Check using `ls ~/.ssh`)
```shell script
ssh-keygen
```
b. Copy the public key to the media-server

```shell script 
ssh-copy-id username@media-server-ip-or-hostname
```

c. Test with logging in
```shell script
ssh username@media-server-ip-or-hostname
```

#2. Install Ansible in your host machine

### Linux
```shell script
sudo apt update && sudo apt install ansible
```

#3. Install Ansible community plugins in your host machine

```shell script
ansible-galaxy collection install community.docker
``` 
#4. Port forward your internet facing router

- External port 443 should be forwarded to your `media-server` port 443.
- Access your router admin page to do it. 

Google it if you have no idea what this is.

#5. Configure ansible playbook

### Update hosts

update the `media-server-ansible/inventories/default/hosts.ini` file with your `media-server` ip address or hostname

### Configurie

Edit the file `media-server-ansible/inventories/default/group_vars/all.yml` and update variables if needed. Read following 
section and `App Specific configuration` to get a better understanding variables and their usage.

## App specific configuration

### NFS
If using a NFS share mount role, make sure on the NAS server side,
1. Create dedicated user and a group on the NAS server and note down `uid` and `gid`
2. Use user/group mapping when creating the data set in your storage pools
3. Use user/group mapping when creating the share. (e.g : `Mapall User` and `Mapall Group` in TrueNAS). 
4. Update `local_media_uid` and `local_media_gid` in `inventories/default/group_vars/all.yml` accordingly.

### VPN

- Disable VPN if not needed by seeting `gv_add_vpn_container` to false

### transmission

- Enable/Disable using `transmission_enable` variable in the role. Enabled by default

### qbittorrent

- Enable/Disable using `qbittorrent_enable` variable in the role. Disabled by default
- Default username is `admin`, password is `adminadmin`, change it via the webui (`<your-ip>:8080`)


#6. Start installation

Once the configuration is updated and then only use following command to start the installation

```shell script
cd ansible-playbook
./install.sh
```

Once the installation script completed successfully. Visit https://www.<hostname-you-enterted> to visit the dashboard.

## Container Stack operations
Once the installation is complete, you can use following commands from your host machine to start/stop all apps.

### Start all container stacks
```shell script
cd ansible-playbook
./start-all.sh
```
### Stop all container stacks 
```shell script
cd ansible-playbook
./stop-all.sh
```