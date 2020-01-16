/etc/pacman.conf:
  file.managed:
    - source: salt://pacman/pacman.conf
    - user: root
    - group: root
    - mode: 0644
