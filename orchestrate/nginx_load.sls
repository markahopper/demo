minion_setup_1:
  salt.state:
    - tgt: 'websvr-03'
    - sls: nginx
  grains.present:
    - name: roles
    - value: webserver

minion_setup_1a:
  salt.function:
    - tgt: hopz-master1
    - name: cmd.run
    - arg:
      - salt websvr-03 mine.send network.ip_addrs
    - require:
      - salt: minion_setup_1

