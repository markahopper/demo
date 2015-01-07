asterisk:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: asterisk
