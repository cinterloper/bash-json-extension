g@unit01:~/code/lash/lib/ext/luabash$ enable -f build/luabash.so luabash
g@unit01:~/code/lash/lib/ext/luabash$ cd ../../
g@unit01:~/code/lash/lib$ cd jstruct/
g@unit01:~/code/lash/lib/jstruct$ ls
jstruct.lua  jstruct.sh
g@unit01:~/code/lash/lib/jstruct$ source jstruct.sh 

#get some docker json from docker inspect, this is actually a 1-element arry, so we get an annoying _1 variable 
#(1-99 are taken as env names in bash)
g@unit01:~/code/lash/lib/jstruct$ JSON_STRING=$(docker inspect $(docker ps -q | head -n 1) ) decodeJson 
JSON_STRING_1

#pretty print it with jq
g@unit01:~/code/lash/lib/jstruct$ echo $JSON_STRING_1 | jq .
{
  "AppArmorProfile": "",
  "Args": [
    "-c",
    "/init.sh"
  ],
  "Config": {
    "AttachStderr": false,
    "AttachStdin": false,
    "AttachStdout": false,
    "Cmd": [
      "/bin/sh",
      "-c",
      "/init.sh"
    ],
    "Domainname": "",
    "Env": [
      "LAUNCHID=9e01b5c2-892b-47f2-8f90-59f6e4d2798a",
      "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
      "http_proxy=",
      "MT_PATH=/usr/local/lib",
      "CORNERSTONE_HOST=172.17.0.1",
      "KVDN_START_TIME=5",
      "MY_START_TIME=1",
      "FAILURE_HOOK=echo FAILURE",
      "STARTUP_HOOKS=/startup.sh",
      "CAPABILITIES=[\"VAULT_SERVER\"]",
      "STARTUP_HOOK=/opt/vault/vault server -config=/opt/vault/config.hcl"
    ],
    "ExposedPorts": {
      "8200/tcp": []
    },
    "Hostname": "0dd84528e9a6",
    "Image": "shadowsystem/vault:latest",
    "Labels": [],
    "OpenStdin": false,
    "StdinOnce": false,
    "Tty": false,
    "User": "",
    "WorkingDir": ""
  },
  "Created": "2016-07-10T05:22:11.675426434Z",
  "Driver": "aufs",
  "GraphDriver": {
    "Name": "aufs"
  },
  "HostConfig": {
    "BlkioWeight": 0,
    "CapAdd": [
      "IPC_LOCK"
    ],
    "CgroupParent": "",
    "ConsoleSize": [
      0,
      0
    ],
    "ContainerIDFile": "",
    "CpuPeriod": 0,
    "CpuQuota": 0,
    "CpuShares": 0,
    "CpusetCpus": "",
    "CpusetMems": "",
    "IpcMode": "",
    "Isolation": "",
    "KernelMemory": 0,
    "LogConfig": {
      "Config": [],
      "Type": "json-file"
    },
    "Memory": 0,
    "MemoryReservation": 0,
    "MemorySwap": 0,
    "MemorySwappiness": -1,
    "NetworkMode": "default",
    "OomKillDisable": false,
    "OomScoreAdj": 0,
    "PidMode": "",
    "PidsLimit": 0,
    "PortBindings": {
      "8200/tcp": [
        {
          "HostIp": "",
          "HostPort": "8200"
        }
      ]
    },
    "Privileged": false,
    "PublishAllPorts": false,
    "ReadonlyRootfs": false,
    "RestartPolicy": {
      "MaximumRetryCount": 0,
      "Name": ""
    },
    "ShmSize": 67108864,
    "UTSMode": "",
    "VolumeDriver": ""
  },
  "HostnamePath": "/var/lib/docker/containers/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21/hostname",
  "HostsPath": "/var/lib/docker/containers/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21/hosts",
  "Id": "0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21",
  "Image": "sha256:bd2f24c3d902764cba87c2216a824f9fb9dac8fd12f1e68040ae461ea984bd70",
  "LogPath": "/var/lib/docker/containers/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21-json.log",
  "MountLabel": "",
  "Mounts": [],
  "Name": "/vault",
  "NetworkSettings": {
    "Bridge": "",
    "EndpointID": "a3a766b9ae22c8f144dcfb62e01d453d5ff2205449b28ae912e50e9a3bf9ac8b",
    "Gateway": "172.17.0.1",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "HairpinMode": false,
    "IPAddress": "172.17.0.6",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "LinkLocalIPv6Address": "",
    "LinkLocalIPv6PrefixLen": 0,
    "MacAddress": "02:42:ac:11:00:06",
    "Networks": {
      "bridge": {
        "EndpointID": "a3a766b9ae22c8f144dcfb62e01d453d5ff2205449b28ae912e50e9a3bf9ac8b",
        "Gateway": "172.17.0.1",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "IPAddress": "172.17.0.6",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "MacAddress": "02:42:ac:11:00:06",
        "NetworkID": "deae66d787c7f9e3d51349c5a5e49c7a05c54f867499e85440e3a154a1d6f04a"
      }
    },
    "Ports": {
      "8200/tcp": [
        {
          "HostIp": "0.0.0.0",
          "HostPort": "8200"
        }
      ]
    },
    "SandboxID": "1907123b7f432921ccb5c7704d1057349f4d0c817e36003fe974f84fd64f78fb",
    "SandboxKey": "/var/run/docker/netns/1907123b7f43"
  },
  "Path": "/bin/sh",
  "ProcessLabel": "",
  "ResolvConfPath": "/var/lib/docker/containers/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21/resolv.conf",
  "RestartCount": 0,
  "State": {
    "Dead": false,
    "Error": "",
    "ExitCode": 0,
    "FinishedAt": "0001-01-01T00:00:00Z",
    "OOMKilled": false,
    "Paused": false,
    "Pid": 29082,
    "Restarting": false,
    "Running": true,
    "StartedAt": "2016-07-10T05:22:11.929716813Z",
    "Status": "running"
  }
}

#lets decode the real thing
g@unit01:~/code/lash/lib/jstruct$ decodeJson JSON_STRING_1
Path
ResolvConfPath
Driver
Id
Image
ProcessLabel
Mounts
HostConfig
Created
HostnamePath
NetworkSettings
State
Name
RestartCount
Config
AppArmorProfile
GraphDriver
Args
HostsPath
MountLabel
LogPath

#hey look now all the keys are enviornment vars, dont worry about complex queries and wierd escape issues!
g@unit01:~/code/lash/lib/jstruct$ echo $Path
/bin/sh
g@unit01:~/code/lash/lib/jstruct$ echo $ResolvConfPath
/var/lib/docker/containers/0dd84528e9a6b347c9a7932a5f97c13557e9fbec21bc464f91bf2deeac351a21/resolv.conf
g@unit01:~/code/lash/lib/jstruct$ echo $Mounts
[]
g@unit01:~/code/lash/lib/jstruct$ echo $Config
{"AttachStderr":false,"AttachStdin":false,"AttachStdout":false,"Cmd":["/bin/sh","-c","/init.sh"],"Domainname":"","Env":["LAUNCHID=9e01b5c2-892b-47f2-8f90-59f6e4d2798a","PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","http_proxy=","MT_PATH=/usr/local/lib","CORNERSTONE_HOST=172.17.0.1","KVDN_START_TIME=5","MY_START_TIME=1","FAILURE_HOOK=echo FAILURE","STARTUP_HOOKS=/startup.sh","CAPABILITIES=[\"VAULT_SERVER\"]","STARTUP_HOOK=/opt/vault/vault server -config=/opt/vault/config.hcl"],"ExposedPorts":{"8200/tcp":[]},"Hostname":"0dd84528e9a6","Image":"shadowsystem/vault:latest","Labels":[],"OpenStdin":false,"StdinOnce":false,"Tty":false,"User":"","WorkingDir":""}
g@unit01:~/code/lash/lib/jstruct$ decodeJson Config 
StdinOnce
WorkingDir
ExposedPorts
OpenStdin
User
Hostname
Tty
AttachStderr
AttachStdin
Image
Labels
AttachStdout
Cmd
Domainname
Env
g@unit01:~/code/lash/lib/jstruct$ echo $User

g@unit01:~/code/lash/lib/jstruct$ echo $WorkingDir

g@unit01:~/code/lash/lib/jstruct$ echo $Cmd
["/bin/sh","-c","/init.sh"]

g@unit01:~/code/lash/lib/jstruct$ decodeJson Config | encodeJson 
{"StdinOnce":false}
[]
{"ExposedPorts":{"8200/tcp":[]}}
{"OpenStdin":false}
[]
{"Hostname":0}
{"Tty":false}
{"AttachStderr":false}
{"AttachStdin":false}
{"Image":"shadowsystem/vault:latest"}
{"Labels":[]}
{"AttachStdout":false}
{"Cmd":["/bin/sh","-c","/init.sh"]}
[]
{"Env":["LAUNCHID=9e01b5c2-892b-47f2-8f90-59f6e4d2798a","PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","http_proxy=","MT_PATH=/usr/local/lib","CORNERSTONE_HOST=172.17.0.1","KVDN_START_TIME=5","MY_START_TIME=1","FAILURE_HOOK=echo FAILURE","STARTUP_HOOKS=/startup.sh","CAPABILITIES=[\"VAULT_SERVER\"]","STARTUP_HOOK=/opt/vault/vault server -config=/opt/vault/config.hcl"]}


g@unit01:~/code/lash/lib/jstruct$ echo $(decodeJson Config | xargs echo -n) | encodeJson 
{"AttachStderr":false,"AttachStdin":false,"AttachStdout":"false","Cmd":"[\"/bin/sh\",\"-c\",\"/init.sh\"]","Domainname":"","Env":"[\"LAUNCHID=9e01b5c2-892b-47f2-8f90-59f6e4d2798a\",\"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\",\"http_proxy=\",\"MT_PATH=/usr/local/lib\",\"CORNERSTONE_HOST=172.17.0.1\",\"KVDN_START_TIME=5\",\"MY_START_TIME=1\",\"FAILURE_HOOK=echo FAILURE\",\"STARTUP_HOOKS=/startup.sh\",\"CAPABILITIES=[\\\"VAULT_SERVER\\\"]\",\"STARTUP_HOOK=/opt/vault/vault server -config=/opt/vault/config.hcl\"]","ExposedPorts":{"8200/tcp":[]},"Hostname":0,"Image":"shadowsystem/vault:latest","Labels":"[]","OpenStdin":false,"StdinOnce":false,"Tty":false}
g@unit01:~/code/lash/lib/jstruct$ 



