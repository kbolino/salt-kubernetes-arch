zookeeper:
  pkg.installed:
    - version: '3.4.5-1'
  group.present:
    - gid: 501
    - system: true
  user.present:
    - uid: 501
    - system: true
    - gid_from_name: true
    - home: /opt
    - createhome: false
    - require:
      - group: zookeeper

/opt/zookeeper:
  file.symlink:
    - target: /opt/zookeeper-3.4.5
    - require:
      - pkg: zookeeper

/opt/zookeeper/conf/zoo.cfg:
  file.managed:
    - source: salt://zookeeper/zoo.cfg
    - require:
      - file: /opt/zookeeper

/etc/systemd/system/zookeeper.service:
  file.managed:
    - source: salt://zookeeper/zookeeper.service
    - require:
      - file: /opt/zookeeper
    - onchanges_in:
      - module: systemd-reload

systemd-reload:
  module.run:
    - name: service.systemctl_reload
