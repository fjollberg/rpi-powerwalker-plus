# PowerMaster+ Docker container for a Raspberry Pi

Original idea from [Reddit](https://www.reddit.com/r/homelab/comments/13pnjnm/powerwalker_ups_powermaster_software_in_docker/).

## Failed spectacularly to run on Raspberry Pi

This project failed spectacularly in the current setup to run on a
Raspberry Pi. The issue is that the bundled JRE does not support the
architecture. I guess I should have seen that in advance.

In addition, there are other binaries in the bin folder of Powermaster
which does not match the architecture. I'm uncertain what role they
play. I'm mainly interrested in viewing the status of the UPS device
and not in the USP event propagation bits.

It runs as-is on the target architecture x86-64.

I'm considering doing a retake on this, extracting the webapp and using
a JRE as provided by the environment. But this feels like violating
the Powerwalker rights to the software a bit.

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
