# Projetos_SQL
Projetos SQL

# Desafio de Projeto: Refinamento de Esquema Conceitual para E-commerce

Este repositório contém o desafio de modelagem de banco de dados relacional para um ecossistema de E-commerce, refinado utilizando o MySQL Workbench.

## 📌 Objetivos do Refinamento

O modelo original foi estendido para suportar as seguintes regras de negócio do mundo real:

1. **Modelagem de Clientes (PF/PJ):** Os clientes foram divididos através de uma estratégia de especialização. A tabela mãe `Cliente` armazena dados comuns, enquanto as tabelas filhas `Pessoa_Fisica` (CPF) e `Pessoa_Juridica` (CNPJ) herdam o ID do cliente de forma exclusiva (um cliente não pode ser PF e PJ simultaneamente).
2. **Gestão de Pagamentos:** Foi implementada a tabela `Forma_Pagamento`, permitindo que um cliente cadastre múltiplos meios de pagamento (Cartões, Pix, Boleto) e que o histórico de transações fique devidamente associado aos pedidos.
3. **Módulo de Entregas:** Adicionada a entidade `Entrega` vinculada aos pedidos, contendo atributos essenciais para a logística, como código de rastreamento internacional/nacional e status dinâmico do envio.

## 🛠️ Tecnologias Utilizadas
- MySQL Workbench (Ferramenta de Modelagem ER)
- Linguagem SQL
