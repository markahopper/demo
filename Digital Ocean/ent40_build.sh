apt-get install apt-transport-https software-properties-common
apt-add-repository "deb https://erepo.saltstack.com/sse/4.0/public ubuntu main"
apt-key adv --keyserver pgp.mit.edu --recv-keys DE57BFBE
apt-get update
apt-get install salt-enterprise-master salt-enterprise-minion salt-enterprise-ssh salt-enterprise-syndic salt-enterprise-doc salt-enterprise-cloud salt-enterprise-api
start salt-master