 5671  sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /client-bw -a 10.0.0.1 -r 1000000 -p 4444 -k 4096'
 5673  sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /client-bw -a 10.0.0.1 -r 1000000 -p 4444 -k 4096'
 6278  ./scripts/build image=native-example fs=ramfs -j4
 6279  ./scripts/build clean
 6280  ./scripts/build image=native-example fs=ramfs -j4
 6281  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /hello"
 6282  ./scripts/build image=native-example fs=ramfs -j4
 6283  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /hello"
 6287  ./scripts/build image=rust-microbench fs=ramfs -j24
 6288  ./scripts/build image=rust-tcp-io-perf fs=rofs
 6289  ./scripts/build image=rust-microbench fs=ramfs -j24
 6290  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /thread_yield"
 6291  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /thread_create"
 6292  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /thread_spawn"
 6293  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /allocate"
 6294  sudo ./scripts/run.py --vcpus 1 -p kvm -m 128M -e"--nopci --nomount /allocate_zero