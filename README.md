# PowerMaster+ Docker container for a Raspberry Pi

Original idea from [Reddit](https://www.reddit.com/r/homelab/comments/13pnjnm/powerwalker_ups_powermaster_software_in_docker/).

## PowerMaster+

PowerMaster is the controller software for [BlueWalker/PowerWalker](https://powerwalker.com/)
UPS devices.

The software is organised in a "Local" component, typically run on a computer with
a USB-connection with the UPS device, and a "Remote" component, run on all other
hosts which listens to UPS events "Local" broadcasts.

This container provides the "Local" service.

## Running

```docker run --detach --name powermaster -p 3052:3052 -v /opt/pmasterp:/opt/pmasterp/data rpi-powerwalker-plus```

While it is possible to redirect ports to other port numbers in docker, the
web interface will break if changed from 3025 due to links being hardcoded.

Note, need more port mappings.

## Connecting

```docker exec -it powermaster /bin/bash```

## TODO

* Test with actual USB device (once I get the new batteries for
  my device).
