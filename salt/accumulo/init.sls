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
    - home: /opt
    - createhome: false
    - require:
      - group: accumulo
