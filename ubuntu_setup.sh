#!/bin/sh
cBegin=$(printf "\033[1;36;40m")
cEnd=$(printf "\033[m")

set -x
apt-get update
apt-get upgrade -y
apt-get install -y ca-certificates curl gnupg lsb-release
apt-get update && apt-get install -y apt-transport-https

apt-get install -y zsh

if ! dpkg -l ibus-mozc 2>&1 > /dev/null
then
	apt-get install -y ibus-mozc
	echo;
	echo "${cBegin}To set Japanse input as default, please try the following command.${cEnd}"
	echo "${cBegin}    echo \"active_on_launch: True\" >> \$HOME/.config/mozc/ibus_config.textproto${cEnd}"
	echo "${cBegin}You need to reboot the system to enable mozc. After reboot, please rerun this script again.${cEnd}"
	exit 1
fi
echo

echo "# <<< Installing Google Chrome"
if ! dpkg -l google-chrome-stable 2>&1 > /dev/null
then
	wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
		| gpg --dearmor > /etc/apt/keyrings/googlechrom-keyring.gpg
	chmod a+r /etc/apt/keyrings/googlechrom-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/googlechrom-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
		| tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
	apt-get update && apt-get install -y google-chrome-stable || exit 1
	echo "# >>> Installed Google Chrome"
else
	echo "# >>> Google Chrome is already installed."
fi
echo;

echo "# <<< Installing VScode"
if ! dpkg -l code 2>&1 > /dev/null
then
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
		| gpg --dearmor > packages.microsoft.gpg
	install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	apt-get update && apt-get install -y code || exit 1
	echo "# >>> Installed VScode"
else
	echo "# >>> VScode is already installed."
fi
echo;


echo "# <<< Install docker"
if ! dpkg -l docker-ce 2>&1 > /dev/null
then
	mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
		| gpg --dearmor > /etc/apt/keyrings/docker.gpg
	chmod a+r /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
		| tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt-get update
	apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || exit 2
	echo;
	echo "${cBegin}To use docker command without \"sudo\". please try the following command.${cEnd}"
	echo "${cBegin}    echo groupadd docker && usermod -aG docker \$USER${cEnd}"
	echo "# >>> Install docker"
else
	echo "# >>> Docker is already installed"
fi
echo;


echo "# <<< Install nvidia container toolkit"
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
if ! dpkg -l nvidia-docker2 2>&1 > /dev/null
then
	if lspci | grep -i nvidia; then
		distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
			&& curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor > /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
			&& curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
			sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
			tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
		apt-get update;
		apt-get install -y nvidia-docker2;
		systemctl restart docker;
		echo "# >>> Install nvidia container toolkit"
	fi
	echo "# NVIDIA GPUs are not found."
else
	echo "# >>> Nvidia container toolkit is already installed"
fi
echo;
