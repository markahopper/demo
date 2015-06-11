iis_setup:
  salt.state:
    - tgt: 'mh-windows01.ec2.internal'
    - sls: iis

state_event:
  salt.function:
    - tgt: 'hopz-master2'
    - name: cmd.run
    - arg:
      - salt mh-windows01.ec2.internal system.reboot && salt-run state.event 'salt/minion/minion05/start' count=1 quiet=True && salt mh-windows01.ec2.internal state.sls iis.newsite
    - require:
      - salt: iis_setup

firefox-install:
  salt.function:
    - tgt: 'mh-windows01.ec2.internal'
    - name: chocolatey.install
    - arg:
      - firefox
    - require:
      - salt: state_event
