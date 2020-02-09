daemon-reload:
  module.run:
    - name: service.systemctl_reload
   
tmpfiles-create:
  cmd.run:
    - name: systemd-tmpfiles --create
