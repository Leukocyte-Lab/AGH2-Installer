# AGH2 Installer

> ArgusHack Official Installer

This installer helps you install our security product, **ArgusHack** on your enviroment.

## Requirements
### Server _(where ArgusHack will be installed to)_

- CPU: **8 core** available (at least)
- RAM: **32GB** available (at least)
- Storage: **240GB SSD** available (at least)
- OS: ESXi (VMWare vSphere Hypervisor) `6.7+`
- Others:
  - Network connection with Internet accessibility

> :bulb: Use clearly installed ESXi `7.0U3b` for the best experiences.
> 
> Use the existed ESXi with other VMs running on it is also supported but not recommended. 

### Client _(where you run this installer)_

- OS: Linux / MacOS (other Unix-based distributions, WSL and Windows are not verified about the compatibility)
- Others:
  - Network connection with Internet accessibility
  - Network connection to the Server and the port group you plan to use for installation (default will be the same as Server it's own)
  - SSH client

## Preparing
### Server _(where ArgusHack will be installed to)_

1. Turn on SSH accessibility for your ESXi host
![](https://user-images.githubusercontent.com/14278162/159633634-2b30790f-7161-43fa-bdb4-4a0c2e05a23b.png)
> This options located at the "Host" page, you can access it on your ESXi web UI on the left-side Navigator.
> For more information, check out the article by [:link: VMWare offical support](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-DFA67697-232E-4F7D-860F-96C0819570A8.html).

### Client _(where you run this installer)_

1. Download and install **Packer** on your client
  - [:link: Install Packer](https://www.packer.io/downloads)
2. Clone AGH2-Installer repo, or download the archived

## Configuration

### Hypervisor

1. Copy the configuration files
  - `src/app/general/variables.vmware.pkrvars.hcl.example` -> `src/app/general/variables.vmware.pkrvars.hcl`
2. Modify the config follow your Hypervisor
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/general/variables.vmware.pkrvars.hcl.example#L3-L6

### AGH-DB

1. Copy the configuration files
  - `src/app/agh-db/variables.agh-db.pkrvars.hcl.example` -> `src/app/agh-db/variables.agh-db.pkrvars.hcl`
2. Networking - Modify the config follow your network enviroment (`AGH-DB`)
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L18-L21
3. Authorize information - Modify the config for setup `AGH-DB` authorize information
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L44-L46
> :bulb: Generate `password_encrypted` by `mkpasswd` with salt 4096 times
> 
> If you have `Docker` on your system, it can be an alternative methods by running `docker run --rm -ti alpine:latest mkpasswd -m sha512 -S 4096`
4. Env - Modify the config for setup AGH-DB enviroments
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-db/variables.agh-db.pkrvars.hcl.example#L71-L78

### AGH-K3S

1. Copy the configuration files
  - `src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example` -> `src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl`
2. Networking - Modify the config follow your network enviroment (`AGH-K3S-Master`)
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L18-L21
3. Authorize information - Modify the config for setup `AGH-K3S-Master` authorize information
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L44-L46
> :bulb: Generate `password_encrypted` by `mkpasswd` with salt 4096 times
> 
> If you have `Docker` on your system, it can be an alternative methods by running `docker run --rm -ti alpine:latest mkpasswd -m sha512 -S 4096`
4. Env - Modify the config for setup AGH-DB enviroments
https://github.com/Leukocyte-Lab/AGH2-Installer/blob/f5e5f35467fe117fdc849a5c768fabbf0ad3b3f7/src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl.example#L65-L76
