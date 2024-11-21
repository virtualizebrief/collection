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
![screen-output](https://github.com/virtualizebrief/collection/blob/main/cvadtools/create-mcs-machines.png)
