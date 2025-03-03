> [!Note]
> Code could be cleaner, yet gets the job done and might help understand whats going on more.

# Citrix MCS Machine Creator
- [create-mcs-machines.ps1](https://github.com/virtualizebrief/collection/blob/main/cvadtools/create-mcs-machines.ps1)

Works with both Cloud & On-Prem sites, simpatico. For good measure you do need Citrix Studio (for on-prem site) or Citrix PoshSDK (for cloud site).

# Prerequisites
- Run from Windows machine as AD User with permissions to add Computer Objects
- Powershell must have ADUC commands
- Machine Catalog
- Delivery Group

# What happens?
- Creates machine account(s) for active directory
- Creates machine(s) on hypervisor
- Add machine(s) to machine catalog
- Add machine(s) to delivery group
- powers on machine(s)

# Results
Screen shot of successful script run and creation of 10 VMs. Now 10 machines are registred in a delivery group and available for connection.

> [!Warning]
> Notice the failure of attempts on creating machines. This happens and is a known thing. As long as machine creation is successful by the 5th attempt your good. Have yet to see this fail 5 times.

|![screen-output](https://github.com/virtualizebrief/collection/blob/main/cvadtools/create-mcs-machines.png)|
|:---:|
|screen of results|
