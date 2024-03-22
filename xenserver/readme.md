



### get-xenserver-vm-info.ps1
> [!IMPORTANT]
> Powershell modules required
> - Citrix SDK (Citrix site management, ie Citrix Studio installation or Cloud Posh SDK)
> - XenServer Powershell SDK

This code is written assuming your executing it local to a Citrix delivery controller or cloud connector.
- Get list of all XenServers connected to Citrix site
- Get list of all VMs connect to each XenServer
- Get list of specs for each VM. Default is `name_label,vcpus_max,memory_static_max`
- Create csv for each XenServer
- Create csv for all XenServer and VMs. Single pain of glass

![image](https://github.com/virtualizebrief/collection/assets/153381859/3ce18dab-cc44-466e-bb4a-c4b7c21feec9)
