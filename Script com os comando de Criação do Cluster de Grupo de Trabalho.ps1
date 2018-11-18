## Comandos de Criação do Cluster de Grupo de Trabalho ##


# Console de gerenciamento do servidor.

sconfig.cmd


# Cria um usuário local com nome USERCLUSTER.

net user /add USERCLUSTER $@abc123


# Adiciona o usuário USERCLUSTER ao grupo Administradores locais.

net localgroup administrators USERCLUSTER /add # Windows Server em Inglês

net localgroup administradores USERCLUSTER /add # Windows Server m Português.


# Cria a chave de registro.

new-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name LocalAccountTokenFilterPolicy -Value 1


# Adicionar o sufixo de DNS primário "cluster.local".

Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "NV Domain" -Value "cluster.local"


# Verificar se o sufixo de DNS primário foi adicionado.

Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" | Select-Object "NV Domain"


# Abri o arquivo hosts atráves do Notepad.exe, esse comando deve ser executado dentra da basta c:\Windows\System32\drivers\etc

notepad.exe hosts


# Faça as seguinte alteração no arquivo hosts colocando as seguintes informações.


# IP, Hostname, DNS primário.

192.168.1.102 NO1.cluster.local
192.168.1.101 NO2.cluster.local


#  Resetar o servidor.

Restart-Computer


# Instalar o Recurso de Failover Clustering e também as ferramentas de gerenciamento.

Install-WindowsFeature Failover-Clustering –IncludeManagementTools



# Criação do Cluster de Grupo de Trabalho, sem storage com ip estático.

new-cluster -name WorkgroupCluster  -node NO1, NO2 -nostorage -staticaddress 192.168.1.222 -AdministrativeAccessPoint DNS -verbose


# Verifica o nome do cluster.

get-cluster


# Verifica os nós do cluster.

get-clusternode


# Obtém o recurso do cluster.

get-clusterresource


## Conhecimento só é válido quando compartilhado! ## www.gabrielluiz.com