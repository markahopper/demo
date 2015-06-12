haproxy:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/default/haproxy
    - source: salt://haproxy/default_haproxy
    - require:
      - pkg: haproxy
  service:
    - running
    - watch:
      - file: /etc/default/haproxy
