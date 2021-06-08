# Introduction to Namespace and Cgroups 

<img src="cgns.png">

## Switching context. 

```
❯ docker  context  ls
NAME                TYPE                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                 ORCHESTRATOR
awsDE               moby                                                          ssh://cisco@54.156.100.112                                        
default *           moby                Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://127.0.0.1:57644 (default)   swarm
❯ docker  context  use  awsDE
awsDE
❯ docker  context  ls
NAME                TYPE                DESCRIPTION                               DOCKER ENDPOINT               KUBERNETES ENDPOINT                 ORCHESTRATOR
awsDE *             moby                                                          ssh://cisco@54.156.100.112                                        
default             moby                Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   https://127.0.0.1:57644 (default)   swarm

```

## Namespace the backbone of container creation process 

<img src="ns.png">

## Cgroups in container 

<img src="cg.png">

```
❯ docker  run  -itd --name  ashuc2  --memory 100M   busybox  ping fb.com
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
b71f96345d44: Pull complete 
Digest: sha256:930490f97e5b921535c153e0e7110d251134cc4b72bbb8133c6a5065cc68580d
Status: Downloaded newer image for busybox:latest
90e815db6f6493ed87438d48181bec76ca1efab0552d458f0734e7d14cfc9e4e
❯ docker  ps
CONTAINER ID   IMAGE            COMMAND                CREATED          STATUS          PORTS                  NAMES
90e815db6f64   busybox          "ping fb.com"          5 seconds ago    Up 3 seconds                           ashuc2
3c93475e5f39   alpine           "ping 127.0.0.1"       3 minutes ago    Up 3 minutes                           ashuc123
d04209cc5c93   varunhttp:v002   "httpd -DFOREGROUND"   56 minutes ago   Up 56 minutes   0.0.0.0:8501->80/tcp   varunwebC2


```

### checking resources

```
docker stats 

CONTAINER ID   NAME         CPU %     MEM USAGE / LIMIT    MEM %     NET I/O           BLOCK I/O     PIDS
90e815db6f64   ashuc2       0.01%     640KiB / 100MiB      0.62%     12.5kB / 11.6kB   0B / 0B       1
3c93475e5f39   ashuc123     0.01%     1.523MiB / 7.69GiB   0.02%     978B / 0B         1.24MB / 0B   1
d04209cc5c93   varunwebC2   0.11%     19.87MiB / 7.69GiB   0.25%     1.63kB / 0B       15MB / 0B     213
^C%                 

```

## Restart policy 

<img src="restart.png">

## checking restart policy 

```
 docker  inspect  varunwebC2   --format='{{.HostConfig.RestartPolicy.Name}}'    

```

### name of restart policies 

<img src="rsname.png">

## setting restart policy to a container 

```
❯ docker  run -itd --name helloc1  --restart  always  busybox ping localhost
82e7eae217034ec3c9f4c9011f74e56a0687c5f6080fb6044a486f6e73e709e1
❯ docker  inspect  helloc1   --format='{{.HostConfig.RestartPolicy.Name}}'
always

```

## Java code based Dockerifle 

```
❯ ls
hello.java      java.dockerfile
❯ docker  build  -t  ashujava:ciscov1  .
unable to prepare context: unable to evaluate symlinks in Dockerfile path: lstat /Users/fire/Desktop/ciscoapps/java/Dockerfile: no such file or directory
❯ docker  build  -t  ashujava:ciscov1   -f java.dockerfile   .
Sending build context to Docker daemon  3.584kB
Step 1/7 : FROM openjdk
latest: Pulling from library/openjdk
5a581c13a8b9: Extracting  22.58MB/42.18MB
26cd02acd9c2: Download complete 
66727af51578: Download complete 


```


## Dockerfile with JDK install and use 

```
❯ ls
hello.java            installjdk.dockerfile java.dockerfile
❯ docker build -t  new:jdk8 -f  installjdk.dockerfile  .
Sending build context to Docker daemon  4.608kB
Step 1/8 : FROM oraclelinux:8.3
 ---> 816d99f0bbe8
Step 2/8 : MAINTAINER ashutoshh
 ---> Running in 6cd264e021a2
Removing intermediate container 6cd264e021a2
 ---> bf55fec68e85
Step 3/8 : RUN dnf install java-1.8.0-openjdk.x86_64 -y
 ---> Running in ebf6fb6b8640
Oracle Linux 8 BaseOS Latest (x86_64)           152 MB/s |  35 MB     00:00    
Oracle Linux 8 Application Stream (x86_64)      138 MB/s |  28 MB     00:00    
Last metadata expiration check: 0:00:06 ago on Tue Jun  8 07:10:55 2021.
Dependencies resolved.
================================================================================================
 Package                       Arch    Version                          Repository          Size
================================================================================================
Installing:
 java-1.8.0-openjdk            x86_64  1:1.8.0.292.b10-1.el8_4          ol8_appstream      335 k
Installing dependencies:
 aajohan-comfortaa-fonts       noarch  3.001-2.el8                      ol8_baseos_latest  148 k
 
 
 ```
 
 ### Creating container of java normal code
 
 ```
 docker  run -itd --name ashujc1 --restart  always --memory=300M --cpu-shares=20 6e6f2fb28805 
10069  docker  stats
10070  docker  logs  -f  ashujc1

```
# Docker networking 

## Network topology 

<img src="nettop.png">

### creating container with docker bridge ip 

```
❯ docker  run  -tid --name ashuc1  alpine  ping localhost
9d73d2c2803d2799a2ee41d19b96b623663f6a2ca26a17c68b563fce6c0f7a01
❯ docker  ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
9d73d2c2803d   alpine    "ping localhost"   5 seconds ago   Up 3 seconds             ashuc1
❯ docker  exec  -it  ashuc1  sh
/ # ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02  
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:836 (836.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:46 errors:0 dropped:0 overruns:0 frame:0
          TX packets:46 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:3864 (3.7 KiB)  TX bytes:3864 (3.7 KiB)


```

### best way to check IP address of a container 

```
❯ docker  inspect  netcon1   --format='{{.NetworkSettings.IPAddress}}'
172.17.0.3
❯ docker  inspect  ashuc1   --format='{{.NetworkSettings.IPAddress}}'
172.17.0.2
❯ docker  inspect  manishax1  --format='{{.NetworkSettings.IPAddress}}'
172.17.0.4

```

## NAT concept is already there if ANy container wants to connect outside host 

<img src="nat.png">

## POrt forwarding rule 

<img src="portf.png">

## docker0 Bridge is never preffered 

<img src="no2docker0.png">

## TIme to use custom bridge 

<img src="cb.png">




