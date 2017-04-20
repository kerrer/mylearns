lantern（vpn）
=================
docker run -d -p 8787:8787 kent72/lantern

Butterfly
================
Butterfly is a xterm compatible terminal that runs in your browser.
Starting with login and password

docker run \
--env PASSWORD=mmmm \
-p 57575:57575 \
-d garland/butterfly --port=57575 --login
Starting with no password

docker run \
--env PORT=57575 \
-p 57575:57575 \
-d garland/butterfly --port=57575


tor
===
docker run -d --name tor -p 127.0.1.1:9150:9150 nagev/tor
docker run -d  -p 9050:9050 --name tor osminogin/tor-simple

openvpn
=======
Pick a name for the $OVPN_DATA data volume container, it will be created automatically.

OVPN_DATA="ovpn-data"
Initialize the $OVPN_DATA container that will hold the configuration files and certificates
  docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://vpn.max.com
  docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

Start OpenVPN server process
  docker run --name vpn  -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

Generate a client certificate without a passphrase
  docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

Retrieve the client configuration with embedded certificates
  docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
  docker run -v $OVPN_DATA:/etc/openvpn -p 1194:1194/udp --privileged -e DEBUG=1 kylemanna/openvpn

Create an environment variable with the name DEBUG and value of 1 to enable debug output (using "docker -e").
 docker run -v $OVPN_DATA:/etc/openvpn -p 1194:1194/udp --privileged -e DEBUG=1 kylemanna/openvpn

Test using a client that has openvpn installed correctly
   openvpn --config CLIENTNAME.ovpn
