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
      
demo_pause:
  salt.function:
    - tgt: 'hopz-master1'
    - name: cmd.run
    - arg:
      - sleep 10
    - require:
      - update_haproxy_1
      
update_site:
  salt.state:
    - tgt: 'web01'
    - sls: web.pretty
    - require:
      - demo_pause
      
add_server:
  salt.function:
    - tgt: 'web01'
    - name: mine.update
    - require:
      - update_site

update_haproxy_2:
  salt.state:
    - tgt: 'haproxy'
    - sls: haproxy.config
    - require:
      - salt: add_server