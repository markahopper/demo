minion_setup:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt-run cloud.profile prof=u64_512 instances=docker01,docker02,haproxy
