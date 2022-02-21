# oct/03/2018 11:05:49 by RouterOS 6.35.2
# software id = KP4Y-QTZ6
#
/ip route
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend check-gateway=ping disabled=no \
    distance=1 dst-address=0.0.0.0/0 gateway=89.223.64.1 !route-tag \
    !routing-mark scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=10 \
    dst-address=0.0.0.0/0 gateway=83.242.228.57 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=8.8.4.4/32 gateway=89.223.64.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway comment="else nowhere" \
    disabled=no distance=200 dst-address=8.8.4.4/32 !route-tag !routing-mark \
    type=blackhole
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=10.1.150.0/24 gateway=172.23.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=77.88.8.8/32 gateway=83.242.228.57 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.16.0.0/16 gateway=172.18.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=yes distance=1 \
    dst-address=172.16.0.0/16 gateway=172.17.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.17.0.0/16 gateway=*63 !route-tag !routing-mark scope=30 \
    target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.17.0.0/16 gateway=ether7 pref-src=172.17.0.2 !route-tag \
    !routing-mark scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.17.77.0/24 gateway=172.17.0.5 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.17.88.0/24 gateway=172.17.0.3 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=172.20.0.0/16 gateway=172.18.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.3.0/24 gateway=10.2.1.3 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.11.128/30 gateway=172.23.0.1 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.11.132/30 gateway=172.23.0.1 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.16.0/24 gateway=172.18.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.53.0/24 gateway=10.1.53.2 pref-src=10.1.53.1 \
    !route-tag !routing-mark scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.57.0/24 gateway=10.1.57.2 pref-src=10.1.57.1 \
    !route-tag !routing-mark scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.62.0/24 gateway=10.2.1.62 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.63.0/24 gateway=10.2.1.63 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.65.0/24 gateway=10.2.1.65 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.66.0/24 gateway=10.2.1.66 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.199.0/24 gateway=10.2.1.199 !route-tag !routing-mark \
    scope=30 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.202.0/24 gateway=10.1.202.2 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.204.0/24 gateway=172.17.0.5 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.205.0/24 gateway=172.17.0.3 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.206.0/24 gateway=10.2.1.206 !route-tag !routing-mark \
    scope=10 target-scope=10
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=192.168.254.0/24 gateway=172.18.0.1 !route-tag !routing-mark \
    scope=30 target-scope=10
