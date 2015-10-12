minion_setup_1:
  salt.state:
    - tgt: 'websvr-03'
    - sls: nginx

minion_setup_1a:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - salt websvr-03 grains.setval roles webserver
    - require:
      - salt: minion_setup_1

minion_setup_1b:
  salt.function:
    - tgt: hopz-master1
    - name: cmd.run
    - arg:
      - salt websvr-03 mine.send network.ip_addrs
    - require:
      - salt: minion_setup_1a

