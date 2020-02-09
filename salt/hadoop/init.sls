include:
  - systemd

hadoop:
  pkg.installed:
    - version: '2.4.0-1'
  group.present:
    - gid: 502
    - system: true
  user.present:
    - uid: 502
    - system: true
    - gid_from_name: true
    - home: /home/hadoop
    - createhome: false
    - require:
      - group: hadoop

/home/hadoop:
  file.directory:
    - user: hadoop
    - group: hadoop
    - require:
      - user: hadoop

/home/hadoop/.profile:
  file.managed:
    - source: salt://hadoop/profile
    - user: hadoop
    - group: hadoop
    - require:
      - file: /home/hadoop

/home/hadoop/.ssh:
  file.directory:
    - user: hadoop
    - group: hadoop
    - mode: '0700'
    - require:
      - file: /home/hadoop

{% for file_name in ['id_rsa', 'known_hosts', 'authorized_keys'] %}
/home/hadoop/.ssh/{{ file_name }}:
  file.managed:
    - source: salt://hadoop/ssh/{{ file_name }}
    - user: hadoop
    - group: hadoop
    - mode: '0600'
    - require:
      - file: /home/hadoop/.ssh
{% endfor %}

/opt/hadoop:
  file.symlink:
    - target: /opt/hadoop-2.4.0
    - require:
      - pkg: hadoop

{% for file_name in ['core-site.xml', 'hadoop-env.sh', 'hdfs-site.xml', 'slaves'] %}
/opt/hadoop/etc/hadoop/{{ file_name }}:
  file.managed:
    - source: salt://hadoop/{{ file_name }}
    - require:
      - file: /opt/hadoop
{% endfor %}

/var/log/hadoop:
  file.directory:
    - user: hadoop
    - group: hadoop
    - require:
      - user: hadoop

/etc/tmpfiles.d/hadoop-pid-dir.conf:
  file.managed:
    - source: salt://hadoop/hadoop-pid-dir.conf
    - require:
      - user: hadoop
    - onchanges_in:
      - tmpfiles-create
