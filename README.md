# Project ToolKit

Toolkit centralizes the administration and debugging tools inside docker containers.

## How to
These instructions allow to setup an environment withouth the need to install these setup tools.

### Pre-requirements

- SO: Linux .
- Having curl installed.
- Having docker installed and running.
- The user that executes the setup and respective tooling needs to be part of the docker group.

```
# Check SO
$ cat /etc/redhat-release 
Red Hat Enterprise Linux Server release 7.7 (Maipo)

# Check curl
$ curl -V
curl 7.29.0 (x86_64-redhat-linux-gnu) libcurl/7.29.0 NSS/3.36 zlib/1.2.7 libidn/1.28 libssh2/1.4.3
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IDN IPv6 Largefile NTLM NTLM_WB SSL libz unix-sockets

# Check docker
$ docker run --rm hello-world

```

### Installation

The installation is done executing remotely the script.sh

```
bash <(curl -H 'Authorization: token <your private token>' -H 'Accept: application/vnd.github.v3.raw' 'https://api.github.com/repos/tmcmm/toolkit/contents/setup.sh')
```

The github personal access token can be created as described in this link [Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token "Github Access Token")


To confirm that you have the right installation you can execute one of the toolkit applications:
```
$ kubectl version --client=true
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```

## Configuration

Toolkit configuration must be done in the hithub repo.

* toolkit.yaml - yaml file as configuration tools and default commands
    * alias -> tooling name and the command to execute it
    * image -> container name that is executing the tooling
    * run_interaction -> core docker parameters like '-i'
    * run_user -> parameter that references container run user
    * run_vols -> parameter to expose container volumes
    * run_workdir -> parameter referencing container workdir
    * run_envs -> parameters to expose environment variables
    * run_ports -> parameter to expose container ports
    * run_add_vols -> parameter to run additional container volumes
    * privileged -> True to run container in priviledged mode

There is the defaults section to define the default parameters on every tool
## Tooling update

Every time there is an update to this repository you need to run the script setup.sh remotely to update.

```
bash <(curl -H 'Authorization: token <your private token>' -H 'Accept: application/vnd.github.v3.raw' 'https://api.github.com/repos/tmcmm/toolkit/contents/setup.sh')
``` 

### To run ansible with azure modules it is necessary to create a file inside your home dir with the credentials for accessing portal
```
cat $HOME/.azure/credentials
[default]
subscription_id=10dfa491-****-****-a4ee-9aeb49b8c00e
client_id=db93c95c-****-4cb7-****-773baa4cddef
secret=BBFJ2dMDsbuj8f***p.O_-*******-iKAeM
tenant=72f988bf-****-41af-****-2d7cd011db47
```

## List the existing tools

To know which tools exist type list in the terminal

## Versioning

[SemVer](http://semver.org/) for versioning.
