On the raspberry pi

	1. Execute this command and keep monitoring until the upgrade is complete
	 	journalctl -f -u container-stack*

On your Laptop/PC

	1. Download the patch release : https://github.com/catchsudheera/media-server-ansible/archive/refs/tags/1.0.2.zip
	2. Make sure content of following files are correct. (Use previously used files) : 
			ansible-playbook/inventories/default/group_vars/all.yml
			ansible-playbook/inventories/default/hosts.ini
	3. `cd` in to `media-server-ansible/ansible-playbook` directory
	4. Run `./upgrade.sh 1.0.1`

That's all


After this change, all docker-compose files will be managed by systemd and you can use following commands to manage

	sudo systemctl status <stack-name>.service
	sudo systemctl start <stack-name>.service
	sudo systemctl stop <stack-name>.service
	sudo systemctl restart <stack-name>.service

	Where <stack-name> is one of container stack name you can find by executing this -> `ls -alt /home/media-user/ | grep container |  awk '{print $NF}' | sed -r 's/\.//g'`

