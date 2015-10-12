minion_setup_1:
  salt.state:
    - tgt: 'websvr-03'
    - sls: nginx
  grains.present:
    - name: roles
    - value: webserver
  salt.function:
    - tgt: hopz-master1
    - name: cmd.run
    - arg:
      - salt websvr-03 mine.set network.ip_addrs

