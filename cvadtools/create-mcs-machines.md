> [!Note]
> I admit code could be cleaner, yet gets the job done and might help understand whats going on more.

# Citrix MCS Machine Creator
Works with both Cloud & On-Prem sites, simpatico. For good measure you do need Citrix Studio (for on-prem site) or Citrix PoshSDK (for cloud site)

# Prerequisites
- Run from Windows machine as AD User with permissions to add Computer Objects
- Machine Catalog
- Delivery Group
- Powershell must have ADUC commands

# What happens?
- Creates machine account(s) (active directory)
- Creates machine(s) (real VMs on hypervisor)
- Add machine(s) to machine catalog
- Add machine(s) to delivery group
- powers on machine(s)

# Results
Screen shot of successful script run and creation of 10 VMs. Now 10 machines are registred in a delivery group and available for connection.

> [!Warning]
> Notice the failure of attempts on creating machines. This happens and is a known thing. As long as machine creation is successful by the 5th attempt your good. Have yet to see this fail 5 times.

![screen-output](https://github.com/virtualizebrief/collection/blob/main/cvadtools/create-mcs-machines.png)
