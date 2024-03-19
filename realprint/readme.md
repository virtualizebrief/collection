|[Home](https://github.com/virtualizebrief)|[Collection](https://github.com/virtualizebrief/collection/blob/main/readme.md)|[Wiki](https://github.com/virtualizebrief/home/wiki)|[Wood cloud](https://marketplace.woodcloud.one/) :arrow_upper_right:|[VB blog](https://virtualizebrief.woodcloud.one/) :arrow_upper_right:|[MW LinkedIn](https://www.linkedin.com/in/michaelcharleswood/) :arrow_upper_right:
|---|---|---|---|---|---|

# Real Print
### *If its not real its passthrough*
Enterprise print solution taylored to Citrix Virtual App & Desktop deployments. Great for other setups and corporate wide deployment.

## [realprint-agent.ps1](realprint-agent.ps1)
Endpoint agent for querying real print database and connecting printers.

Performs the following
- Connect to real print database by endpoint name
- Get list of assigned printers and default
- Attempt to connect to each printer
- Set default, this is attempted a number of times to make sure he has the final word
- Write log file detailed results

Log file can be kept local to the machine and/or copied to a network location for archiving or quick historical access.

## [realprint-manager.ps1](realprint-manager.ps1)
Manager provides a frontend for assigning printers to endpoints.


