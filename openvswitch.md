
node1: 172.29.88.207 172.17.1.0/24
node2: 172.29.88.208 172.17.2.0/24 

sudo apt-get install openvswitch-switch bridge-utils

1. 首先在node1和node2上分别建立OVS Bridge
 ovs-vsctl add-br obr0
 
2. 建立gre，并将新建的gre0添加到obr0
node1: ovs-vsctl add-port obr0 gre0 -- set Interface gre0 type=gre options:remote_ip=172.29.88.208
node2: ovs-vsctl add-port obr0 gre0 -- set Interface gre0 type=gre options:remote_ip=172.29.88.207

3. minion1和minion2之间的隧道已经建立。然后我们在minion1和minion2上创建Linux网桥kbr0替代Docker默认的docker0（我们假设minion1和minion2都已安装Docker），设置minion1的kbr0的地址为172.17.1.1/24， minion2的kbr0的地址为172.17.2.1/24，并添加obr0为kbr0的接口，以下命令在minion1和minion2上执行：
# brctl addbr kbr0              //创建linux bridge代替docker0
# brctl addif kbr0 obr0         //添加obr0为kbr0的接口

# ip link set dev docker0 down  //设置docker0为down状态
# ip link del dev docker0       //删除docker0，可选

ovs-vsctl show
brctl show

5. 为了使新建的kbr0在每次系统重启后任然有效，我们在minion1的/etc/network/interfaces文件中追加内容如下：（在CentOS上会有些不一样）

# vi /etc/network/interfaces
auto kbr0
iface kbr0 inet static
        address 172.17.1.1
        netmask 255.255.255.0
        gateway 172.17.1.0
        dns-nameservers 172.31.1.1
同样在minion2上追加类似内容，只需修改address为172.17.2.1和gateway为172.17.2.0即可，然后执行ip link set dev kbr0 up，你能在minion1和minion2上发现kbr0都设置了相应的IP地址。为了验证我们创建的隧道是否能通信，我们在minion1和minion2上相互ping对方kbr0的IP地址，从下面的结果发现是不通的，经查找这是因为在minion1和minion2上缺少访问172.17.1.1和172.17.2.1的路由，因此我们需要添加路由保证彼此之间能通信

minion1上执行:
# ip route add 172.17.2.0/24 via 172.29.88.208 dev eth0

minion2上执行:
# ip route add 172.17.1.0/24 via 172.29.88.207 dev eth0
