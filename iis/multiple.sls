iis_setup:
  salt.state:
    - tgt: 'minion05'
    - sls: iis

state_event:
  salt.function:
    - tgt: 'sse401'
    - name: cmd.run
    - arg:
      - salt minion05 system.reboot && salt-run state.event 'salt/minion/minion05/start' count=1 quiet=True && salt minion05 state.sls iis.newsite
    - require:
      - salt: iis_setup

firefox-install:
  salt.function:
    - tgt: 'minion05'
    - name: chocolatey.install
    - arg:
      - firefox
    - require:
      - salt: state_event
