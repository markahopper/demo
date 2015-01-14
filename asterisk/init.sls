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

/etc/asterisk/extensions.conf:
  file:
    - managed
    - source: salt://asterisk/extensions.conf
    - require:
      - pkg: asterisk
    - watch_in:
      - service: asterisk

/etc/asterisk/voicemail.conf:
  file:
    - managed
    - source: salt://asterisk/voicemail.conf
    - require:
      - pkg: asterisk
    - watch_in:
      - service: asterisk

ddclient:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: asterisk

/etc/ddclient.conf:
  file:
    - managed
    - source: salt://asterisk/ddclient.conf
    - require:
      - pkg: ddclient
    - watch_in:
      - service: ddclient
