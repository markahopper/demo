mediawiki:
  pkg.installed:
    - name: mediawiki119
  file.managed:
    - name: /etc/httpd/conf.d/mediawiki.conf
    - source: salt://mediawiki.conf
    - mode: 644
    - user: root
    - group: root
    - require:
      - pkg: mediawiki

mediawiki-config:
  file.managed:
    - source: salt://LocalSettings.php
    - name: /var/www/mediawiki119/LocalSettings.php
    - require:
      - file: mediawiki

apache:
  pkg.installed:
    - name: httpd
  service.running:
    - name: httpd
    - enable: True
    - require:
      - pkg: apache
      - service: mysql
      - service: iptables

mysql:
  pkg.installed:
    - name: mysql-server
  service.running:
    - name: mysqld
    - enable: True
    - require:
      - pkg: mysql

mysql-python:
  pkg.installed:
    - name: MySQL-python

iptables:
  service.dead:
    - enable: False

mediawiki-schema:
  file.managed:
    - name: /root/mediawiki.sql
    - source: salt://mediawiki.sql

mediawiki-db:
  mysql_database.present:
    - name: my_wiki

mediawiki-tables:
  cmd.run:
    - name: mysql -u root my_wiki < /root/mediawiki.sql
    - unless: 'test -e /var/lib/mysql/my_wiki/page.frm'
    - require:
      - file: mediawiki-schema
      - mysql_database: mediawiki-db
