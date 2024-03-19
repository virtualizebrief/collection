|[Home](https://github.com/virtualizebrief)|[Collection](https://github.com/virtualizebrief/collection/blob/main/readme.md)|[Wiki](https://github.com/virtualizebrief/home/wiki)|[Wood cloud](https://marketplace.woodcloud.one/) :arrow_upper_right:|[VB blog](https://virtualizebrief.woodcloud.one/) :arrow_upper_right:|[MW LinkedIn](https://www.linkedin.com/in/michaelcharleswood/) :arrow_upper_right:
|---|---|---|---|---|---|

# Real Print
### *If its not real its passthrough*
Enterprise print solution taylored to Citrix Virtual App & Desktop deployments. Great for other setups and corporate wide deployment.

## [realprint-agent.ps1](realprint-agent.ps1)
Endpoint agent for querying real print database and connecting printers.

Performs the following:
- Connect to real print database by endpoint name
- Get list of assigned printers and default
- Attempt to connect to each printer
- Set default. this is attempted a number of times to make sure he has the final word
- Write log file containing detailed results

Log file can be kept local to the machine and/or copied to a network location for archiving or quick historical access.

### Example log file
```
20240319T115446 =========================================
20240319T115446   Real Print
20240319T115446   Release: 2024.03.19
20240319T115446 =========================================
20240319T115446   ...Running User Processes
20240319T115446   ...User found: michaelwood
20240319T115446   ...Endpoint: Office
20240319T115446   ...Citrix Desktop: MyDesk
20240319T115446
20240319T115446   Printer processing...
20240319T115446   -------------------------------
20240319T115446   deleting: none
20240319T115447   adding  : \\printserver1.mydomain.com\printer1
20240319T115447   adding  : \\printserver1.mydomain.com\printer3
20240319T115447   default : \\printserver1.mydomain.com\printer3
20240319T115447   default : attempt 1 of 5 (20 second pause between)
20240319T115507   default : attempt 2 of 5 (20 second pause between)
20240319T115527   default : attempt 3 of 5 (20 second pause between)
20240319T115547   default : attempt 4 of 5 (20 second pause between)
20240319T115607   default : attempt 5 of 5 (20 second pause between)
20240319T115607   -------------------------------
20240319T115607   Seconds to complete work: 41
```

## [realprint-manager.ps1](realprint-manager.ps1)
Manager provides a frontend for assigning printers to endpoints. Screen capture says it all.

![image](https://github.com/virtualizebrief/collection/assets/153381859/d9d288c0-3146-4a6e-b259-91d14e0e4190)

## [convertto-textasciiart.ps1](convertto-textasciiart.ps1)
> :memo: **Note:** This feature is option and can be disabled or not used.

Creates the cool banner logo for real print manager.
