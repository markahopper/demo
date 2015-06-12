include:
  - .init

/etc/haproxy/haproxy.cfg:
  file:
    - managed
    - source: salt://haproxy/haproxy.cfg
    - template: jinja
    - require:
      - file: /etc/default/haproxy
      - pkg: haproxy
    - watch_in:
      - service: haproxy
