minion_setup_1:
  salt.state:
    - tgt: 'websvr-03'
    - sls: nginx
  grains.present:
    - name: roles
    - value: webserver

