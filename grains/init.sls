{% if salt['file.file_exists']('/etc/mysql/my.cnf') %}
roles:
  grains.present:
    - value: database
{% else %}
roles:
  grains.present:
    - value: webserver
{% endif %}