# /srv/reactor/startup_highstate.sls
reactor_highstate:
  cmd.state.highstate:
    - tgt: {{ data['name'] }}