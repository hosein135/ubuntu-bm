#!/bin/bash
# Colors:
RED='\033[0;31m';
NC='\033[0m'; # No Color
GREEN='\033[0;32m';
YELLOW='\033[1;33m';
delay_after_message=3;
#update and upgrade
printf "${YELLOW}Updating packages${NC}\n";
sleep $delay_after_message;
sudo apt update -y &&
sudo apt upgrade -y &&
#Installing important packages
printf "${YELLOW}Installing important packages${NC}\n";
sleep $delay_after_message;
sudo apt install -y \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils \
    zlib1g-dev

sleep 2;
#Install git
printf "${YELLOW}Installing git${NC}\n";
sleep $delay_after_message;
sudo apt install git sed -y
sleep 2;
#change git default branch name
printf "${YELLOW}change git default branch name to main${NC}\n";
sleep $delay_after_message;
git config --global init.defaultBranch main
sleep 2;
#Install Z Shell
printf "${YELLOW}Installing ZSH (Shell)${NC}\n";
sleep $delay_after_message;
sudo apt install zsh -y
sleep 2;
#Setting up Powerline
printf "${YELLOW}Installing and Setting up oh-my-zsh and Powerline and Powerline Fonts${NC}\n";
sleep $delay_after_message;
sudo apt-get install powerline -y
mkdir -p $HOME/.fonts
cp powerline-fonts/* $HOME/.fonts/
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
cat $HOME/.oh-my-zsh/templates/zshrc.zsh-template >> $HOME/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/' $HOME/.zshrc
echo 'bindkey -v' >> $HOME/.zshrc
sleep 2;
#Installing asdf
printf "${YELLOW}Installing asdf${NC}\n";
sleep $delay_after_message;
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
source ~/.bashrc
source ~/.zshrc
asdf plugin add nodejs
sed -i 's/for client in aria2c curl wget; do/for client in curl wget; do/' ~/.asdf/plugins/nodejs/.node-build/bin/node-build
sleep 2;
#Installing vscode
printf "${YELLOW}Installing vscode${NC}\n";
sleep $delay_after_message;
sudo apt-get install wget unzip zip gpg autoconf gettext -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update -y
sudo apt install code -y
sed -i 's/"terminal.integrated.fontFamily":.*/"terminal.integrated.fontFamily": "MesloLGS NF",/' ~/.config/Code/User/settings.json
sleep 2;
#change git default editor
printf "${YELLOW}change git default editor to vscode${NC}\n";
sleep $delay_after_message;
git config --global core.editor "code --wait"
sleep 2;
#install zed editor
printf "${YELLOW}install zed editor${NC}\n";
sleep $delay_after_message;
curl https://zed.dev/install.sh | sh
sleep 2;
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
sleep 2;
#Installing chrome
printf "${YELLOW}Installing chrome${NC}\n";
sleep $delay_after_message;
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -f install -y
sleep 2;
#change default browser
printf "${YELLOW}Set chrome as default browser${NC}\n";
sleep $delay_after_message;
CHROME=$(ls /usr/share/applications/ | grep "chrome");
xdg-settings set default-web-browser $CHROME
sudo sed -i 's|Exec=/usr/bin/google-chrome-stable %U|Exec=/usr/bin/google-chrome-stable --password-store=basic %U|' /usr/share/applications/google-chrome.desktop
sleep 2;
printf "${YELLOW}Reboot${NC}\n";
sleep $delay_after_message;
sudo reboot
