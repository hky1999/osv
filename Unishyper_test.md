## Rust-microbench
```
./scripts/build image=rust-microbench
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart thread_yield'
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart thread_spawn'
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart allocate'
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart allocate_zero'
```

## Rust net-demos http-server
```
./scripts/build image=rust-pie-net-demos fs=rofs
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 http-server'
ab -n 100 http://10.0.0.4:4444/
```

## rust-tcp-io-perf
### build
```
./scripts/build image=rust-tcp-io-perf fs=rofs
```
### bandwidth test
#### osv server, Linux client
```
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /server-bw -r 100000 -p 4444 -k 4096'

./client-bw -a 10.0.0.4 -p 4444 -r 100000 -k 4096
```
#### osv client, Linux server
```
./server-bw -p 4444 -r 100000 -k 4096

sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /client-bw -r 100000 -a 192.168.106.222 -p 4444 -k 4096'
```
### latency test
#### osv server, Linux client
```
sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /server-latency -r 100000 -p 4444 -k 1'

./client-latency -a 10.0.0.4 -p 4444 -r 100000 -k 1
```
#### osv client, Linux server
```
./server-latency -p 4444 -r 100000 -k 1

sudo ./scripts/run.py -V --tap=tap0 --networking -c 1 -e '--bootchart --ip=eth0,10.0.0.4,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /client-latency -r 100000 -a 192.168.106.222 -p 4444 -k 1'
```