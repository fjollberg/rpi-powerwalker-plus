# PowerMaster+ Docker container for a Raspberry Pi

Original idea from [Reddit](https://www.reddit.com/r/homelab/comments/13pnjnm/powerwalker_ups_powermaster_software_in_docker/).

## Failed spectacularly to run on Raspberry Pi

This project failed spectacularly to run on a Raspberry Pi.
The primary isse is that the bundled JRE does not support the arm64
architecture. I guess I should have seen that in advance.

In addition there are other binaries in the package. I've made
an attempt to provide anarnm64 jre, but the libppbedrvc.so
is also necessary, to talk to the device I presume.

So, end of the road.

It runs as-is on the target architecture x86-64, but have not
managed to get it to find the UPS device so far.

## PowerMaster+

PowerMaster is the controller software for [BlueWalker/PowerWalker](https://powerwalker.com/)
UPS devices.

The software is organised in a "Local" component, typically run on a computer with
a USB-connection with the UPS device, and a "Remote" component, run on all other
hosts which listens to UPS events "Local" broadcasts.

This container provides the "Local" service.

## Running

```docker run --name powermaster -p 3052:3052 -p 3052:3052/udp -p 53568:53568/udp -p 162:162/udp -p 53566:53566/udp -v /opt/pmasterp:/opt/pmasterp/data --privileged -v /dev:/dev  rpi-powerwalker-plus:latest```

While it is possible to redirect ports to other port numbers in docker, the
web interface will break if changed from 3025 due to links being hardcoded.

Note, need more port mappings.

## Connecting

```docker exec -it powermaster /bin/bash```

## TODO

* Test with actual USB device (once I get the new batteries for
  my device).
