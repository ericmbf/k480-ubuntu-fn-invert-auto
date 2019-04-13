# k480_conf
Configuration utility for setting up function keys on ubuntu for Logitech k480 keyboard.

Inspiration came from this place:

http://www.trial-n-error.de/posts/2012/12/31/logitech-k810-keyboard-configurator/

Mario made this tool for k810, I simply re-traced his steps for k480.
My current configuration is Ubuntu 14.10 with k480 connected through some old d-link bluetooth adapter (on a desktop machine). 

Steps:

1) check which hidraw device is your logitech keyboard:


$cat /sys/class/hidraw/hidraw*/device/uevent


Identify which one it is, e.g. hidraw2 (It might be any other, be sure which one it is before you proceed).

2) Then run following files to make function keys behave as function keys by default. (after downloading/cloning files from here):

$./build.sh
```
$sudo ./k480_conf -d /dev/hidraw2 -f on
```

You can also revert this behaviour by running:

```
$sudo ./k480_conf -d /dev/hidraw2 -f off
```

which will make media keys default and function keys accessible by (fn + function key).

To keep this setting after a restart you need to tell Ubuntu to run the script for you.


Here is one of possible rules to be put in /etc/udev/rules.d/99-k480.rules:

KERNEL=="hidraw2", SUBSYSTEM=="hidraw", ACTION=="add", RUN+="/opt/bin/k480_conf -d /dev/hidraw2 -f on"

Use this command to check syspath from device, change the "*" for the number of your device.

udevadm info -a -n /dev/hidraw*

The return is something like this:

```
  looking at device '/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:21/0005:046D:B33D.0010/hidraw/hidraw2':
    KERNEL=="hidraw2"
    SUBSYSTEM=="hidraw"
    DRIVER==""

```

So, with the syspath, test if the rules is working

```
udevadm test --action="add" /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:21/0005:046D:B33D.000E/hidraw/hidraw2
```

The return should be like this

```
run: '/opt/bin/k480_conf -d /dev/hidraw2 -f on'
Unload module index
Unloaded link configuration context.
```

Run this command to reload rules and add your new dev rule:
```
udevadm control --reload
```


