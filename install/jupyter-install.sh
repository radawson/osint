#!/bin/bash
# Install script for Jupyter Labs + OSINT template
# v1.1.0
# (c) 2021 Richard Dawson

# Get jupyter path variable from osint.conf
JUP_PATH=$(cat config | grep JUP_PATH | cut -c 10-) 

if [ ! -d "$JUP_PATH/tools" ]; then
	echo "Creating templates directory at ${JUP_PATH}/tools"
	sudo mkdir -p $JUP_PATH/tools
	sudo chmod 755 $JUP_PATH/tools
else
	echo "Template directory exists at ${JUP_PATH}/tools"
fi

# Install pip installer
sudo apt-get update
sudo apt-get -y install python3-pip

# Install Jupyter Labs
python3 -m pip install jupyterlab

# Install node.js
#curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# Just in case they aren't already installed
#sudo apt-get install gcc g++ make
sudo apt-get install -y nodejs

# Install and add templates
python3 -m pip install jupyterlab_templates
jupyter labextension install jupyterlab_templates
jupyter serverextension enable --py jupyterlab_templates

# Download and copy template to templates folder
wget https://raw.githubusercontent.com/rdbh/osint/main/Installation/jupyter_OSINT.ipynb
sudo cp jupyter_OSINT.ipynb $HOME/.local/lib/python3.9/site-packages/jupyterlab_templates/templates/jupyterlab_templates
rm jupyter_OSINT.ipynb

#Tool Install

#Install GoLang
echo Installing GoLang!
sudo apt-get install golang-go -qq -y

cd $JUP_PATH/tools

#Install Subfinder
sudo apt-get -y install subfinder

#Install assetfinder
sudo apt-get -y install assetfinder

#Install dnsprobe
echo Installing dnsprobe!
sudo apt-get -y install dnsx

#Install Infoga
echo Installing Infoga!
sudo git clone https://github.com/rdbh/Infoga.git $JUP_PATH/tools/Infoga -q
sudo python3 $JUP_PATH/tools/Infoga/setup.py install

#Install ShodanScraper
#Need to initialize Shodan API Key!
echo Installing ShodanScraper!
sudo git clone https://github.com/rdbh/shodan-scraper.git $JUP_PATH/tools/shodan-scraper -q
sudo chmod +x $JUP_PATH/tools/shodan-scraper/scraper.py 
pip3 install -r $JUP_PATH/tools/shodan-scraper/requirements.txt

#Install CloudEnum
echo Installing CloudEnum!
sudo git clone https://github.com/initstring/cloud_enum.git $JUP_PATH/tools/cloud_enum -q
pip3 install -r $JUP_PATH/tools/cloud_enum/requirements.txt -q

#Install GitDorker
echo Installing GitDorker
git clone https://github.com/obheda12/GitDorker $JUP_PATH/tools/GitDorker -q
pip3 install -r $JUP_PATH/tools/GitDorker/requirements.txt -q
rm $JUP_PATH/tools/GitDorker/*png

mkdir ~/.jupyter/ssl
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=COUNTRY/ST=STATE/L=CITY/O=ORGANIZATION/CN=CNAME" -keyout ~/.jupyter/ssl/mykey.key -out ~/.jupyter/ssl/mycert.pem
screen -dmS notebook jupyter-notebook --allow-root --notebook-dir ~/.jupyter
