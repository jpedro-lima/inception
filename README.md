# Inception

**Inception** é um projeto que consiste em uma aplicação web Wordpress rodando em um ambiente Docker utilizando Docker Compose. O projeto é composto por três serviços principais: MariaDB, Nginx e WordPress, com o WordPress rodando em um container Debian configurado com PHP 7.

---

## Arquitetura do Projeto

- **MariaDB**: Banco de dados utilizado pelo WordPress para armazenar seus dados.
- **Nginx**: Servidor web responsável por servir o conteúdo da aplicação com SSL auto assinado.
- **WordPress**: CMS rodando em um container baseado na imagem do Debian, com suporte ao PHP 7.
- **Docker Compose**: Todas as imagens foram configurados do zero a partir de uma imagem debian, há dois volumes um para o banco de dados e o outro para a aplicação, ambos os volumes são locais e foram setados em `/home/joapedr2`

---

## Pré-requisitos

Certifique-se de ter as ferramentas a seguir instaladas em seu ambiente:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Make](https://www.gnu.org/software/make/)

---

## Como executar

#### 1. Clone o repositório

```bash
$ git clone https://github.com/jpedro-lima/inception.git
$ cd inception
$ make
```

#### 2. Acesse a aplicação
- Abra o navegador de sua preferência
- Acesse o link: `https://joapedr2.42.fr`  
NOTA: Permita a notificação de segurança, ele se refere ao Certificado SSL auto assinado

## Como limpar o projeto
```bash
$ make fclean
```

## Estrutura do projeto
```plaintext
.
├── Makefile                          # Automação de comandos para construção e limpeza do ambiente
├── README.md                         # Documentação do projeto
└── srcs                              # Diretório contendo todos os arquivos do projeto
    ├── docker-compose.yml            # Arquivo de configuração do Docker Compose
    └── requirements                  # Diretório com os serviços do projeto
        ├── mariadb                   # Serviço de banco de dados MariaDB
        │   ├── conf                  # Configurações específicas do MariaDB
        │   │   └── my.cnf            # Arquivo de configuração do MariaDB
        │   ├── Dockerfile            # Dockerfile para construção do container MariaDB
        │   └── tools                 # Scripts e ferramentas para o MariaDB
        │       └── mdb-script.sh     # Script para inicialização do MariaDB
        ├── nginx                     # Serviço do servidor web Nginx
        │   ├── conf                  # Configurações específicas do Nginx
        │   │   └── nginx.conf        # Arquivo de configuração do Nginx
        │   └── Dockerfile            # Dockerfile para construção do container Nginx
        └── wordpress                 # Serviço WordPress
            ├── conf                  # Configurações específicas do WordPress
            │   ├── wp-config.php     # Arquivo de configuração do WordPress
            │   └── www.conf          # Configuração do PHP-FPM
            ├── Dockerfile            # Dockerfile para construção do container WordPress
            └── tools                 # Scripts e ferramentas para o WordPress
                └── wp-script.sh      # Script para inicialização do WordPress

```