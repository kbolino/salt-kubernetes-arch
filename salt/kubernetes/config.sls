br_netfilter:
  kmod.present

net.bridge.bridge-nf-call-iptables:
  sysctl.present:
    - value: 1
    - require:
      - kmod: br_netfilter

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

kubelet:
  service.enabled

