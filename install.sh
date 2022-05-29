# Linux OSINT setup
# v2.0.0
# Currently building for Ubuntu or Kali - others by request
# (C) 2022 Richard Dawson

## Variables
# Configuration Variables
BIN_PATH=${HOME}/Downloads/Programs
DOC_PATH=${HOME}/Documents/osint
JUP_PATH=/usr/share/jupyter

## Functions

check_root() {
  # Check to ensure script is not run as root
  if [[ "${UID}" -eq 0 ]]; then
    UNAME=$(id -un)
    printf "\nThis script should not be run as root.\n\n" >&2
    usage
  fi
}

echo_out() {
  # Get input from stdin OR $1
  local MESSAGE=${1:-$(</dev/stdin)}
  
  # Check to see if we need a \n
  if [[ "${2}" == 'n' ]]; then
    :
  else
    MESSAGE="${MESSAGE}\n"
  fi
  
  # Decide if we output to console and log or just log
  if [[ "${VERBOSE}" = 'true' ]]; then
    printf "${MESSAGE}" | tee /dev/fd/3
  else 
    printf "${MESSAGE}" >> ${LOG_FILE}
  fi
}

# Install functions for non-repository tools
install_carbon14 () {
cd $BIN_PATH
git clone https://github.com/rdbh/Carbon14.git
cd ~/Downloads/Programs/Carbon14
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/Carbon14
}

install_elasticsearch () {
cd $BIN_PATH
git clone https://github.com/AmIJesse/Elasticsearch-Crawler.git
mkdir -p $DOC_PATH/Elasticsearch
}

install_email2phone () {
cd $BIN_PATH
git clone https://github.com/rdbh/email2phonenumber.git
cd ~/Downloads/Programs/email2phonenumber
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/email2phonenumber
}

install_eyewitness () {
cd $BIN_PATH
git clone https://github.com/rdbh/EyeWitness.git
cd ~/Downloads/Programs/EyeWitness
cd Python/setup
sudo -H ./setup.sh
mkdir -p $DOC_PATH/EyeWitness
}

install_google_earth () {
cd $BIN_PATH
mkdir google-earth && cd google-earth
wget https://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth-stable*.deb
cd $BIN_PATH
rm -rf google-earth
}

install_osintgram () {
cd $BIN_PATH
git clone https://github.com/rdbh/Osintgram.git
cd ~/Downloads/Programs/Osintgram
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/osintgram
}

install_photon () {
cd $BIN_PATH
git pull https://github.com/rdbh/Photon.git
cd ~/Downloads/Programs/Photon
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/Photon
}

install_recon_ng () {
cd $BIN_PATH
git clone https://github.com/lanmaster53/recon-ng.git
cd ~/Downloads/Programs/recon-ng
python3 -m pip install -r REQUIREMENTS
mkdir -p $DOC_PATH/recon-ng
}

install_reddit_downloader () {
cd $BIN_PATH
git clone https://github.com/rdbh/bulk-downloader-for-reddit.git
cd ~/Downloads/Programs/bulk-downloader-for-reddit
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/reddit-downloader
}

install_sherlock () {
cd $BIN_PATH
git clone https://github.com/sherlock-project/sherlock.git
cd ~/Downloads/Programs/sherlock
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/sherlock
}

install_spiderfoot () {
  sudo apt-get -y install spiderfoot
  sudo mkdir -p /usr/share/spiderfoot/correlations
  touch $HOME/.spiderfoot/passwd
}

install_sublist3r (){
cd $BIN_PATH
git clone https://github.com/rdbh/Sublist3r.git
cd ~/Downloads/Programs/Sublist3r
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/Sublist3r
}

install_theharvester () {
cd $BIN_PATH
git clone https://github.com/rdbh/theHarvester.git
cd ~/Downloads/Programs/theHarvester
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/theHarvester
}

install_whatsmyname () {
cd $BIN_PATH
git clone https://github.com/WebBreacher/WhatsMyName.git
cd ~/Downloads/Programs/WhatsMyName
python3 -m pip install -r requirements.txt
mkdir -p $DOC_PATH/WhatsMyName
}

python_install () {
# Used to install python tools in the tools directory
cd $BIN_PATH
mkdir $1
cd ${1}
python3 -m pip install "${1}" -U
}

#-------------------
# MAIN
#-------------------

# Get OS distribution
if [[ "${1}" == "Kali" ]]; then 
  OS_NAME="Kali"
elif [[ "${1}" == "Ubuntu" ]]; then
  OS_NAME="Ubuntu"
else
  OS_NAME=$(lsb_release -a | grep '^Distributor' | cut -c 17-)
fi

echo "Installing for ${OS_NAME}"
read -n1 -p "Press Q to quit or [Enter] to continue" INSTALL_Q
if [[ "${INSTALL_Q}" == 'Q' ]] || [[ "${INSTALL_Q}" == 'q' ]];then
  echo "Quitting Script"
  exit 5
fi

# Create config file
touch ~/osint.config
echo DOC_PATH=$DOC_PATH > osint.config
echo BIN_PATH=$BIN_PATH >> osint.config
echo JUP_PATH=$JUP_PATH >> osint.config

# Create program paths
mkdir -p "${BIN_PATH}"

# Bring OS up to date
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt -y --fix-broken install
sudo snap refresh

# Install git
sudo apt-get -y install git

# Install Docker
sudo apt install -y docker.io
sudo apt install -y docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker $USER

# Add local installations to path
PATH=$HOME/.local/bin:$PATH
echo export PATH=$HOME/.local/bin:'$PATH' >> ~/.bashrc
echo export PATH=$HOME/.local/bin:'$PATH' >> ~/.zshenv
hash -r

# Python installation and package management 
sudo apt-get -y install python3-pip
sudo apt-get -y install pipenv

case $OS_NAME in
  Kali)
  # Kali Distro installations
    sudo apt-get -y install kali-tools-information-gathering

    # Tools in Kali repository  
    sudo apt-get -y install instaloader
    sudo apt-get -y install internetarchive
    sudo apt-get -y install photon
    sudo apt-get -y install sherlock
    install_spiderfoot
    sudo apt-get -y install youtube-dl
  
    #non-repository tools
    install_carbon14
	install_elasticsearch
	install_email2phone
	install_google_earth
	install_reddit_downloader
	    
	# Python tools
	python_install holehe
	python_install instalooter
	python_install socialscan
	python_install webscreenshot
	python-install youtube-tool
    ;;
  Ubuntu)
    #non-repository tools
    install_carbon14
	install_elasticsearch
	install_email2phone
	install_google_earth
	install_reddit_downloader
	
	# Python tools
	python_install holehe
	python_install instaloader
	python_install instalooter
	python_install internetarchive
	python_install socialscan
	python_install webscreenshot
	python-install youtube-tool
	;;
  *)
    echo "Unrecognized OS: ${OS_NAME}"
	;;
esac

# Clone the osint directory
cd $HOME/Documents
git clone https://github.com/rdbh/osint.git
cd osint/tools
sudo chmod 755 *.sh
	
# Create output directories
mkdir -p $DOC_PATH/gallery-dl
mkdir -p $DOC_PATH/instalooter
mkdir -p $DOC_PATH/metagoofil
mkdir -p $DOC_PATH/reddit
mkdir -p $DOC_PATH/waybackpy

# Python PyPi installations
python3 -m pip install nested-lookup -U
python3 -m pip install redditsfinder -U
python3 -m pip install streamlink -U
python3 -m pip install waybackpy -U

wget https://raw.githubusercontent.com/rdbh/osint/dev_rick/install/jupyter-install.sh
sudo jupyter-install.sh
rm jupyter-install.sh

# Install PeTeReport
cd $BIN_PATH
git clone https://github.com/1modm/petereport
cd petereport
sudo docker-compose up --build

sudo apt-get -y autoremove
sudo apt-get -y clean

echo
echo Installation Complete!
echo
echo "Jupyter notebook will start next"
read -p "Press [Enter] to continue or CTRL-C to abort" THROWAWAY

~/Documents/osint/tools/jupyter.sh
