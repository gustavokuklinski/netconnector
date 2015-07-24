# NET CONNECTOR
It's a simply shell script to connect ethernet and wireless tools.

### Configuration
Edit the constants to fit your need.
If you don't know your networks intefaces, just type in terminal as sudo: `sudo ifconfig`. By default in UNIX Systems cable networks is `eth*`(where the `*` is the number)

### Connecting WEP
WEP is easy, and you need to store configs. Just know the name and password of the network

### Connecting to WPA/WPA2
Create a file with the name you want inside: `net` folder with the following paramethers:

```
network={
  ssid="Network Name"           # Can be found using: sudo iwlist INTERFACE scan
  password="Network Passphrase" # Network password
}
```
