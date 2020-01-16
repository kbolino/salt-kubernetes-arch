/etc/docker/daemon.json:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://docker/daemon.json

docker service:
  service.enabled:
    - name: docker
