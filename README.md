# Overview

Example to run Terraform to create a Ubuntu 22.04 VM in vSphere using a Packer template.

```sh
op run --env-file=.1p.env -- docker run \
--env-file=.env \
--env TF_VAR_vcenter_username \
--env TF_VAR_vcenter_password \
--env TF_VAR_vcenter_server \
--env TF_VAR_guest_user_name \
--env TF_VAR_guest_user_hashed_password \
--env TF_VAR_guest_user_gecos \
--env TF_VAR_guest_user_ssh_key \
-v `pwd`:/workspace \
-w /workspace \
hashicorp/terraform:latest \
apply --auto-approve
```

[`cloud-init` - Datasources - VMware](https://canonical-cloud-init.readthedocs-hosted.com/en/latest/reference/datasources/vmware.html)  
[How to make guest OS customization with cloud-init engine work on Ubuntu 20.04.x and later (80934)](https://kb.vmware.com/s/article/80934)  
[How to switch vSphere Guest OS Customization engine for Linux virtual machine (59557)](https://kb.vmware.com/s/article/59557)  
[Ubuntu, Cloud-Init, vSphere and vRealize Automation - A short tale of misery](https://www.funkycloudmedina.com/2022/05/ubuntu-cloud-init-vsphere-and-vrealize-automation-a-short-tale-of-misery/)  
[Running cloud-init twice via Packer & Terraform on VMware Ubuntu 22.04 guest](https://stackoverflow.com/a/72768538/10149240)
