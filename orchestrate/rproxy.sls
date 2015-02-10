cmd.run:
  salt.function:
    - tgt: 'roles:rproxy'
    - tgt_type: grain
    - arg:
      - hostname -i
    - require:
      - salt: rproxy_setup

rproxy_setup:
  salt.state:
    - tgt: 'roles:rproxy'
    - tgt_type: grain
    - sls: nginx.rproxy
    - require:
      - salt: appserver_setup
  
appserver_setup:
  salt.state:
    - tgt: 'roles:appserver'
    - tgt_type: grain
    - sls: awesome-app.app

