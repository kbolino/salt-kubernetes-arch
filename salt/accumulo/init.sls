include:
  - systemd

accumulo:
  pkg.installed:
    - version: '1.9.3-1'
  group.present:
    - gid: 503
    - system: true
  user.present:
    - uid: 503
    - system: true
    - gid_from_name: true
    - home: /home/accumulo
    - createhome: false
    - require:
      - group: accumulo

/home/accumulo:
  file.directory:
    - user: accumulo
    - group: accumulo
    - require:
      - user: accumulo

/home/accumulo/.profile:
  file.managed:
    - source: salt://accumulo/profile
    - user: accumulo
    - group: accumulo
    - require:
      - file: /home/accumulo

/home/accumulo/.ssh:
  file.directory:
    - user: accumulo
    - group: accumulo
    - mode: '0700'
    - require:
      - file: /home/accumulo

{% for file_name in ['id_rsa', 'known_hosts', 'authorized_keys'] %}
/home/accumulo/.ssh/{{ file_name }}:
  file.managed:
    - source: salt://accumulo/ssh/{{ file_name }}
    - user: accumulo
    - group: accumulo
    - mode: '0600'
    - require:
      - file: /home/accumulo/.ssh
{% endfor %}

/opt/accumulo:
  file.symlink:
    - target: /opt/accumulo-1.9.3
    - require:
      - pkg: accumulo

/opt/accumulo/conf:
  file.recurse:
    - source: salt://accumulo/conf
    - require:
      - file: /opt/accumulo

/var/log/accumulo:
  file.directory:
    - user: accumulo
    - group: accumulo
    - require:
      - user: accumulo

/etc/tmpfiles.d/accumulo-pid-dir.conf:
  file.managed:
    - source: salt://accumulo/accumulo-pid-dir.conf
    - require:
      - user: accumulo
    - onchanges_in:
      - tmpfiles-create
