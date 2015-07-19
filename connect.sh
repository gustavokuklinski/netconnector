#/bin/bash

# Load interface configs
source config.sh

# Connection functions
# WEP connection
wep() {

  # Connect using iw + dhclient
  sudo iwconfig $wIntrf essid $1 key s:$2 && sudo dhclient $wIntrf
}

# WPA/WPA2 connection
wpa() {

  # Get the path + wireless network
  # Connect with wpa_supplicant + dclient
  sudo wpa_supplicant -B -i$wIntrf -c net/$1.conf -Dwext && sudo dhclient $wIntrf
}

# Ethernet connection
eth() {
  sudo ifconfig $eIntrf up && sudo dhclient $eIntrf
}

# Enable ETHERTNET and WIRELESS interfaces
enableIntrf() {
  sudo ifconfig $eIntrf up && echo "$eIntrf [ENABLED]" || echo "$eIntrf [FAIL]"
  sudo ifconfig $wIntrf up && echo "$wIntrf [ENABLED]" || echo "$wIntrf [FAIL]"
}

# Disable Interfaces
disableIntrf() {
  sudo ifconfig $eIntrf down && echo "$eIntrf [DISABLED]" || echo "$eIntrf [FAIL]"
  sudo ifconfig $wIntrf down && echo "$wIntrf [DISABLED]" || echo "$wIntrf [FAIL]"
}

listWireless() {
  sudo iwlist $wIntrf scan | sed -ne 's#^[[:space:]]*\(Quality=\|Encryption key:\|ESSID:\)#\1#p' -e 's#^[[:space:]]*\(Mode:.*\)$#\1\n#p'
}

# Disconect networks
disconnect() {
  sudo rm -Rf /var/lib/dhcp/dhclient*
  sudo iw dev $wIntrf disconnect
  disableIntrf 
}

# Display terminal application logo. 
# Just for little fun, some wires connected ;)
mesg() { 
  echo ""
  echo "  \   /  \   /  \   /  \   /  \   /  "
  echo "---///----///----///----///----///---"  
  echo "  /   \  /   \  /   \  /   \  /   \  " 
  echo ""
  echo "--------- Network Connector ---------"
  echo "-------- Press CTRL+C to EXIT -------"
  echo "-------------------------------------"
  echo "------ REQUIRE ROOT PRIVILEGIES -----"
  echo "Enable network interfaces..."
  enableIntrf
  echo ""
}

# And contact information :D
info() {
  echo ""
  echo "Developed by: Gustavo Kuklinski"
  echo "github.com/gustavokuklinski"
  echo "E-mail: tuxlinski@gmail.com"
  echo ""
}

clear
mesg
echo "Select your option:"
echo "-----------------------------------"
echo "Connect to a Wired Network"
echo "1 - Ethernet"
echo ""
echo "Select the wireless encryption type:"
echo "2 - List avaiable wireless"
echo "3 - WEP"
echo "4 - WPA/WPA2"
echo ""
echo "Test network"
echo "5 - Run test(Ping)"
echo ""
echo "Disconnect networks"
echo "6 - Disconnect"
echo "-----------------------------------"
echo "7 - Script information"
echo ""
echo -n "Type your option number: "
read wOp

case $wOp in
  1)
    clear
    mesg

    echo "Connect to Ethernet"
    echo "---------------------------"
    eth
  ;;
  2)
    mesg
    echo "Listing avaiable wireless networks"
    echo "---------------------------"
    listWireless   
  ;;
  3)
    clear 
    mesg

    echo "WEP Wireless Connector"
    echo "---------------------------"

    echo -n "Enter the wireless name: "
    read wpName
    echo -n "Entre the wireless key: "
    read wpKey

    echo "Activating Wireless interface"
    echo "Enable sudo to connect"
    wep $wpName $wpKey 
  ;;

  4)
    clear
    mesg
 
    echo "WPA/WPA2 Wireless Connector"
    echo "---------------------------"

    echo -n "Enter the wireless name: "
    read wName

    echo "Activating Wireless interface"
    echo "Enable sudo to connect"
    wpa $wName
  ;;

  5)
    clear
    mesg
    echo "Testing network on: google.com"
    ping www.google.com -c 4
  ;;
  6)
    clear
    mesg
    echo "Disconnecting..."
    disconnect
  ;;
  7)
    clear
    mesg
    info
  ;;
esac
