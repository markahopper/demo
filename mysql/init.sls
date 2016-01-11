
######################################################
# Name: mysql.sls
#
# Description: install MySQL
#
# verified OS: Ubuntu 14.04, CentOS 6.5
#
# usage:
# salt <target> state.sls mysql
#
#####################################################
# installs mysql and ensures it's started
mysql-server:
  pkg.installed:
    {% if grains['os_family'] == 'RedHat' %}
    - pkgs:
      - mysql-server
      - MySQL-python
    {% elif grains['os_family'] == 'Debian' %}
    - pkgs:
      - mysql-server
      - mysql-client
      - python-mysql.connector
      - python-mysqldb
    {% endif %}
  service.running:
    - require:
      - pkg: mysql-server 
    - names:
    {% if grains['os_family'] == 'RedHat' %}
      - mysqld
    {% elif grains['os_family'] == 'Debian' %}
      - mysql
    {% endif %}