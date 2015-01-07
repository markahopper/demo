asterisk:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: asterisk
/etc/asterisk/sip.conf:
  file:
    - managed
    - source: salt://asterisk/sip.conf
    - require:
      - pkg: asterisk
    - watch_in:
      - service: asterisk
