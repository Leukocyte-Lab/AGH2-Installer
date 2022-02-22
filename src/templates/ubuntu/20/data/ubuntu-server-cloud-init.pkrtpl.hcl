#cloud-config
autoinstall:
  version: 1
  apt:
    geoip: true
    preserve_sources_list: true
    primary:
      - arches: [amd64, i386]
        uri: http://tw.archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports    
  early-commands:
    # Ensures that Packer does not connect too soon.
    - sudo systemctl stop ssh
  locale: ${language}
  keyboard:
    layout: ${keyboard}
  storage:
    layout:
      name: lvm
  identity:
    hostname: ${hostname}
    username: ${username}
    password: ${password_encrypted}
  ssh:
    install-server: true
    allow-pw: true
    authorized-keys:
      - ${ssh_key}
  packages:
    - openssh-server
    - open-vm-tools
    - software-properties-common
    - cloud-init
    - ca-certificates
    - curl
    - wget
  user-data:
    disable_root: false
    package_update: true
    package_upgrade: true
    package_reboot_if_required: true
  late-commands:
    - echo '${username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${username}
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/${username}
    - sed -i 's/^#*\(send dhcp-client-identifier\).*$/\1 = hardware;/' /target/etc/dhcp/dhclient.conf
  timezone: ${timezone}