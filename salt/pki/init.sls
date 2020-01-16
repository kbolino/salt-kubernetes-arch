/etc/pki:
  file.directory:
    - user: root
    - group: root
    - mode: 0755

/etc/pki/gb.kbolino.com-2.crt:
  file.managed:
    - source: salt://pki/gb.kbolino.com-2.crt
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /etc/pki

trust anchor --store /etc/pki/gb.kbolino.com-2.crt:
  cmd.run:
    - onchanges:
      - file: /etc/pki/gb.kbolino.com-2.crt
