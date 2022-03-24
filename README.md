# AGH2 Installer

> ArgusHack Official Installer

This installer helps you install our security product, **ArgusHack** on your environment, including 2 VMs, one for the DB (`AGH-DB`) and one for the Service (`AGH-K3S-Master`).

## Requirements

### Server

> Where **ArgusHack** be installed to

- CPU: **8 core** available (at least)
- RAM: **32GB** available (at least)
- Storage: **240GB SSD** available (at least)
- OS: ESXi (VMWare vSphere Hypervisor) `6.7+`
- Others:
  - Network connection with Internet accessibility

> :bulb: **Tips**
>
> Use clearly installed ESXi `7.0U3b` for the best experiences.
>
> Use the existed ESXi with other VMs running on it is also supported but not recommended.

### Client

> Where you run this installer

- OS: Linux / macOS (other Unix-based distributions, WSL, and Windows are not verified about the compatibility)
- Others:
  - Network connection with Internet accessibility
  - Network connection to the Server and the port group you plan to use for installation (default be the same as Server it's own)
  - SSH client

## Preparing

### Server

> Where ArgusHack be installed to

1. Turn on SSH accessibility for your ESXi host
![](https://user-images.githubusercontent.com/14278162/159633634-2b30790f-7161-43fa-bdb4-4a0c2e05a23b.png)
    > This option is located at the "Host" page; you can access it on your ESXi web UI on the left-side Navigator.
    > For more information, check out the article by [:link: VMWare official support](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-DFA67697-232E-4F7D-860F-96C0819570A8.html).

### Client

> Where you run this installer

1. Download and install **Packer** on your client
    - [:link: Install Packer](https://www.packer.io/downloads)
2. Clone AGH2-Installer repo, or download the archived

## Configuration

### Hypervisor

1. Copy the configuration files
    - `src/app/general/variables.vmware.pkrvars.hcl.example` -> `src/app/general/variables.vmware.pkrvars.hcl`
2. Modify the config follow your Hypervisor
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/general/variables.vmware.pkrvars.hcl.example#L3-L6>

### AGH-DB

1. Make a copy of the configuration files
    - `src/app/agh-db/variables.agh-db.pkrvars.hcl.example` -> `src/app/agh-db/variables.agh-db.pkrvars.hcl`
2. Networking - Modify the config follow your network environment (`AGH-DB`)
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L18-L21>
3. Authorize information - Modify the config for setup `AGH-DB` authorize information
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L44-L46>
    > :bulb: **Tips**
    >
    > Generate `password_encrypted` by `mkpasswd` with salt 4096 times
    >
    > If you have `Docker` on your system, it can be an alternative method by running
    >
    > `docker run --rm -ti alpine:latest mkpasswd -m sha512 -S 4096`
4. Env - Modify the config for setup AGH-DB environment variables
<https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L71-L78>

### AGH-K3S-Master

1. Make a copy of the configuration files
    - `src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example` -> `src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl`
2. Networking - Modify the config follow your network environment (`AGH-K3S-Master`)
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L18-L21>
3. Authorize information - Modify the config for setup `AGH-K3S-Master` authorize information
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L44-L46>
    > :bulb: **Tips**
    >
    > Generate `password_encrypted` by `mkpasswd` with salt 4096 times
    >
    > If you have `Docker` on your system, it can be an alternative method by running
    >
    > `docker run --rm -ti alpine:latest mkpasswd -m sha512 -S 4096`
4. Env - Modify the config for setup `AGH-K3S-Master` environment variables
    <https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L65-L76>

## Installation

Run the following script in your shell to install _ArgusHack_

```sh
make install
```

## Troubleshooting

### General

If a stage runs out with error like following results, you can press `r` then `Return` to let installer _**auto-retry**_ that step, or `c` to _**clean up**_, exit and try again.

If you still can't solve the problem, use `a` to abort the installation, and please contact us to take support. **ONLY** use `a` if you are sure that the problem is not caused by your configuration.

```log
==> vmware-iso.ubuntu-server: Step "StepCreateDisks" failed
==> vmware-iso.ubuntu-server: [c] Clean up and exit, [a] abort without cleanup, or [r] retry step (build may fail even if retry succeeds)?
```

### Stuck on `null.vmware-preprocess: Waiting for SSH to become available...`

Make sure you have `SSH` enabled on your Hypervisor, and all the variables configured in `src/app/general/variables.vmware.pkrvars.hcl` are correct.

You can also try directly access the Hypervisor with `ssh root@<Hypervisor IP>` to figure out the problem.
