haproxy:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/default/haproxy
    - source: salt://haproxy-docker/haproxy/default_haproxy
    - require:
      - pkg: haproxy
  service:
    - running
    - watch:
      - file: /etc/default/haproxy
