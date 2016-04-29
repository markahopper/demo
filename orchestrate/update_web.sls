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
      
update_site:
  salt.state:
    - tgt: 'web01'
    - sls: web.pretty
    - require:
      - salt: update_haproxy_1
      
add_server:
  salt.function:
    - tgt: 'web01'
    - name: mine.update
    - require:
      - salt: update_site

update_haproxy_2:
  salt.state:
    - tgt: 'haproxy'
    - sls: haproxy.config
    - require:
      - salt: add_server