# Projeto ToolKit

O projeto toolkit permite centralizar tools de administração de sistemas baseadas em containers docker. 

## Como utilizar

Estas instruções permitem o setup do ambiente para o utilizador que irá correr o setup e não numa perspetiva de sistema.

### Pré-requisitos

- SO: Linux (testado em Centos 7 e RedHat EL 7)
- curl instalado no sistema
- docker instalado no sistema e a correr
- utilizador que irá executar o setup e respetivas tools tem de fazer parte do grupo "docker"

```
# Verificar SO
$ cat /etc/redhat-release 
Red Hat Enterprise Linux Server release 7.7 (Maipo)

# Verificar curl
$ curl -V
curl 7.29.0 (x86_64-redhat-linux-gnu) libcurl/7.29.0 NSS/3.36 zlib/1.2.7 libidn/1.28 libssh2/1.4.3
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IDN IPv6 Largefile NTLM NTLM_WB SSL libz unix-sockets

# Verificar docker
$ docker run --rm hello-world

```

### Instalação

A instalação é efetuada executando o script setup.sh 

```
bash <(curl --header 'PRIVATE-TOKEN: <your private token>' 'https://gitlab.com/api/v4/projects/**id_project**/repository/files/setup.sh/raw?ref=master')
```

O "private token" pode ser obtido no gitlab nas configurações da tua conta (User Settings > Access Tokens - permissão read_repository)

Para verificar a correta instalação podemos executar uma das aplicações do toolkit

```
$ kubectl version --client=true
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```

## Configuração

A configuração do ToolKit deve ser efetuada no repositório git [ToolKit](https://gitlab.com/tmcmm/toolkit.git):

* toolkit.yaml - O Yaml contem a configuração das tools e respetivos defaults
    * alias -> nome da tool e comando utilizado para executar
    * image -> nome da imagem a ser utilizada para execução da tool
    * run_interaction -> parâmetros core do docker. Exemplo: "-i"
    * run_user -> parâmetros docker referentes ao utilizador de execução
    * run_vols -> parâmetros docker referentes aos volumes
    * run_workdir -> parâmetro docker referente ao workdir
    * run_envs -> parâmetros docker referentes a variáveis de ambiente
    * run_ports -> parâmetros docker referentes a ports de comunicação
    * run_add_vols -> parâmetros docker referentes a volumes adicionais (aos default)
    * privileged -> Colocar a true para correr container em modo privilegiado

Existe uma secção de "Defaults" para definir os parâmetros por defeito para todas as tools

## Atualização das tools e configuração

Sempre o toolkit.yaml ou outro ficheiro do projeto for alterado podemos atualizar no sistema recorrendo ao mesmo script de instalação

```
bash <(curl --header 'PRIVATE-TOKEN: <your private token>' 'https://gitlab.com/api/v4/projects/**id_project**/repository/files/setup.sh/raw?ref=master')
``` 

### Relativo ao Ansible será necessário criar um ficheiro para as credenciais de acesso ao portal

cat $HOME/.azure/credentials
[default]
subscription_id=10dfa491-****-****-a4ee-9aeb49b8c00e
client_id=db93c95c-****-4cb7-****-773baa4cddef
secret=BBFJ2dMDsbuj8f***p.O_-*******-iKAeM
tenant=72f988bf-****-41af-****-2d7cd011db47


## Listar as tools existentes

Para sabermos as tools existentes- escrever list no terminal 

## Versionamento

Utilizamos [SemVer](http://semver.org/) para versionamento.
