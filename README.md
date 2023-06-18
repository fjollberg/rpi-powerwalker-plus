# PowerMaster+ Docker container

Original idea from [Reddit](https://www.reddit.com/r/homelab/comments/13pnjnm/powerwalker_ups_powermaster_software_in_docker/).

## Failed spectacularly to run on Raspberry Pi

This project failed spectacularly to run on a Raspberry Pi which
was my original intention to see if I could achieve.
The primary isse is that the bundled JRE does not support the arm64
architecture. I guess I should have seen that in advance.

In addition there are other binaries in the package. I've made
an attempt to provide anarnm64 jre, but the libppbedrvc.so
is also necessary, to talk to the device I presume.

So, end of the road.

It *does* run on the target architecture x86-64, and can attach
to the USB device if run with privileged flag set.

## PowerMaster+

PowerMaster is the controller software for [BlueWalker/PowerWalker](https://powerwalker.com/)
UPS devices.

The software is organised in a "Local" component, typically run on a computer with
a USB-connection with the UPS device, and a "Remote" component, run on all other
hosts which listens to UPS events "Local" broadcasts.

This container provides the "Local" service.

## Running

```docker run --name powermaster -p 3052:3052 -p 3052:3052/udp -p 53568:53568/udp -p 162:162/udp -p 53566:53566/udp -v /opt/pmasterp:/opt/pmasterp/data --privileged rpi-powerwalker-plus:latest```

While it is possible to redirect ports to other port numbers in docker, the
web interface will break if changed from 3025 due to links being hardcoded.

## "Development" and Testing

### Running the service manually.

Connecting to the container with another shell makes it possible to kill
the java process and start a new manually in order to catch output.

```./jre/bin/java -classpath lib/Startup.jar -Xmx256m -Xms128m -Djava.net.preferIPv4Stack=true -Djava.library.path=./bin -Djava.ext.dirs=./jre/lib/ext com.cyberpowersystems.ppbe.startup.Startup start```

### Connecting to the container

```docker exec -it powermaster /bin/bash```
