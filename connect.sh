#/bin/bash

# Load interface configs
source config.sh

# Connection functions
# WEP connection
wep() {

  # Enable Wireless interface
  # Connect using iwconfig + dhclient
  sudo iwconfig $wIntrf essid $1 key $2 && sudo dhclient $wIntrf
}

# WPA/WPA2 connection
wpa() {

  # Enable wireless interface
  # Get the path + wireless network
  # Connect with wpa_supplicand + dclient
  sudo wpa_supplicant -B -iwlan0 -c net/$1.conf -Dwext && sudo dhclient $wIntrf
}

# Ethernet connection
eth() {
  sudo ifconfig $eIntrf up && sudo dhclient $eIntrf
}

enableIntrf() {
  sudo ifconfig $eIntrf up && echo "$eIntrf [ENABLED]" || echo "$eIntrf [FAIL]"
  sudo ifconfig $wIntrf up && echo "$wIntrf [ENABLED]" || echo "$wIntrf [FAIL]"
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
echo "Select the wireless encryption key:"
echo "2 - WEP"
echo "3 - WPA/WPA2"
echo ""
echo "Test network"
echo "4 - Run test(Ping)"
echo "-----------------------------------"
echo "5 - Script information"
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
    clear 
    mesg

    echo "WPA/WPA2 Wireless Connector"
    echo "---------------------------"

    echo -n "Enter the wireless name: "
    read wpName
    echo -n "Entre the wireless key: "
    read wpKey

    echo "Activating Wireless interface"
    echo "Enable sudo to connect"
    wep $wpName $wpKey 
  ;;

  3)
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

  4)
    clear
    mesg
    echo "Testing network on: google.com"
    ping www.google.com -c 4
  ;;
  5)
    clear
    mesg
    info
  ;;
esac

