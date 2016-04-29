remove_server:
  salt.function:
    - tgt: 'web01'
    - name: mine.flush

update_haproxy_1:
  salt.state:
    - tgt: 'haproxy'
    - sls: haproxy.config
    - require:
      - salt: remove_server