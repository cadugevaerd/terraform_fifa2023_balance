
# Terraform FIFA 2023 Balance

Este repositório contém o código Terraform para a criação de uma infraestrutura na AWS, utilizando o Amazon ECS (Elastic Container Service) com balanceamento de carga distribuído em três zonas de disponibilidade diferentes.

## Estrutura do Projeto

- **infra/**: Contém todos os módulos e recursos de infraestrutura necessários para configurar o ambiente.
- **env/producao/**: Diretório onde a chamada do Terraform deve ser realizada para provisionar o ambiente de produção.

## Pré-requisitos

- Terraform >= 1.0
- AWS CLI configurado
- Credenciais da AWS com permissões adequadas

## Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/cadugevaerd/terraform_fifa2023_balance.git
   cd terraform_fifa2023_balance/env/producao
   ```

2. Inicialize o Terraform:
   ```bash
   terraform init
   ```

3. Planeje a infraestrutura:
   ```bash
   terraform plan
   ```

4. Aplique as mudanças:
   ```bash
   terraform apply
   ```

## Contribuição

Contribuições são bem-vindas! Por favor, abra um _issue_ ou envie um _pull request_ com melhorias ou correções.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.