|[Home](https://github.com/virtualizebrief)|[Collection](https://github.com/virtualizebrief/collection/blob/main/readme.md)|[Wiki](https://github.com/virtualizebrief/home/wiki)|[Wood cloud](https://marketplace.woodcloud.one/) :arrow_upper_right:|[VB blog](https://virtualizebrief.woodcloud.one/) :arrow_upper_right:|[MW LinkedIn](https://www.linkedin.com/in/michaelcharleswood/) :arrow_upper_right:
|---|---|---|---|---|---|

# Igel
|[Igel company info](https://igel.com) :arrow_upper_right:|
---|

What is Igel? Thin client management platform.

### About profiles
An Igel profile is a predefined configuration that can be assigned to managed devices across the globe. Profiles can be used to:
- Set the same configuration for multiple devices
- Define different usage scenarios for devices or groups of devices
- Reduce administrative outlay
- Reduce configuration options on the device

## [os11-theme-icecream.xml](os11-theme-icecream.xml) <br>
Igel desktop theme. Light in colors using off white and blue with a hint of light red for good measure. Pairs with a background imaged named `background.png`.

## [os11-imprivata-check-if-bootstrap.xml :arrow_upper_right:](os11-imprivata-check-if-bootstrap.xml) <br>
|[VB blog on topic](https://virtualizebrief.woodcloud.one/self-healing-for-igel-11-09-imprivata-pie-7-12/)|
| :--- |

> [!IMPORTANT]
> Pairs with the file [imprivata_clean.sh](imprivata_clean.sh)

### Mixing OS and PIE version
There is an issue with upgraded to Igel OS 11.09.x and running Imprivata ProveID Embedded 7.11 (I'll call it PIE for short). You must add PIE 7.12 for 11.09.x to your Imprivata appliance while keeping PIE 7.11 for 11.08.x.

| Igel OS | Imprivata PIE |
| :--- | :--- |
| 11.08.x or lower | 7.11 or lower |
| 11.09.x or higher | 7.12 or higher |

### Profile seeks to accomplish
- rest for five minutes
- check if file exist: /.imprivata_data/runtime/offline/Agent/FirstDomain.txt
  - if file exist do nothing, write log file.
  - if file does not exist, wipe ImprivataBootstrap, install ImprivataBootstrap, reboot

:bulb: Attaching this profile to a folder that runs PIE will make sure PIE is installed and working on every device recardless if they are using Igel OS 11.08.x or Igel OS 11.09.x. This is as long as your Imprivata application also provides both PIE 7.11 and 7.12.

  
