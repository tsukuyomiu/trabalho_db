<a id="readme-top"></a>

<br />
<div align="center">
  <samp>💻 Atividades Práticas de Banco de Dados 💻</samp>
  <h2 align="center">📊 Projetos de Modelagem e DDL (Parte I e II) 🗄️</h2>

  <p align="center">
    <strong>Aluno:</strong> Gabriel Nonato da Silva | <strong>Data:</strong> 02/06/2026 <br />
    Desenvolvido para a disciplina de Modelagem e Projeto de Banco de Dados (Prof. Romes).
  </p>
</div>

<details>
  <summary>🗺️ Índice de Navegação (Clique para abrir)</summary>
  <ol>
    <li>
      <a href="#-sobre-o-projeto">Sobre o Projeto</a>
      <ul>
        <li><a href="#-tecnologias-e-ferramentas">Tecnologias e Ferramentas</a></li>
      </ul>
    </li>
    <li><a href="#-conteúdo-da-entrega">Conteúdo da Entrega</a></li>
    <li>
      <a href="#-parte-i-exercícios-práticos-de-ddl">Parte I: Exercícios Práticos de DDL</a>
    </li>
    <li>
      <a href="#-parte-ii-clínica-médica-documentação">Parte II: Clínica Médica (Documentação)</a>
      <ul>
        <li><a href="#-descrição-de-índices-e-views">Descrição de Índices e Views</a></li>
        <li><a href="#-escolhas-de-tipos-de-dados">Escolhas de Tipos de Dados</a></li>
        <li><a href="#-restrições-e-regras-de-integridade-constraints">Restrições (Constraints)</a></li>
      </ul>
    </li>
    <li><a href="#-como-executar-o-projeto">Como Executar o Projeto</a></li>
  </ol>
</details>

---

## 📝 Sobre o Projeto

Este repositório contém a entrega oficial de duas etapas de atividades práticas da disciplina de *Modelagem e Projeto de Banco de Dados*. 

🎯 **Objetivo Geral:** Aplicar os conceitos práticos de DDL (*Data Definition Language*) para construir, alterar e estruturar bancos de dados relacionais.

O projeto está dividido em duas partes fundamentais:
* **Parte I:** Resolução de 10 questões práticas envolvendo comandos estruturais de SQL.
* **Parte II:** Modelagem completa e simulação do sistema de uma **Clínica Médica**, contendo 10 tabelas integradas com suas respectivas chaves e regras de negócios.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

### 🛠️ Tecnologias e Ferramentas

* ![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
* ![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-1E6B7A?style=for-the-badge&logo=mysql&logoColor=white)
* ![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 📦 Conteúdo da Entrega

Aqui no repositório você vai encontrar os arquivos separados pelas etapas da atividade:

**Arquivos da Parte I:**
* 📄 **`Trabalho_Banco1.pdf`**: Documento contendo as resoluções escritas dos 10 exercícios DDL.
* 📐 **`db_part1.mwb`**: Arquivo de modelo físico estruturado do sistema escolar desenvolvido na questão 10.

**Arquivos da Parte II:**
* 💾 **`clinica_medica.sql`**: Script SQL completo com os comandos de criação da Clínica Médica.
* 📐 **`clinica_medica.mwb`**: Arquivo do modelo físico da clínica.
* 🖼️ **`diagrama_eer.png`**: Captura de tela do Diagrama EER mostrando as 10 tabelas e suas conexões.

---

## 🏗️ Parte I: Exercícios Práticos de DDL

[cite_start]A primeira etapa consistiu em 10 desafios técnicos focados na sintaxe padrão SQL (PostgreSQL/MySQL). Os tópicos dominados e codificados foram:

1. **`CREATE TABLE` (Simples):** Criação da tabela `produto` com tipos primitivos.
2. **`CREATE TABLE` (PK Composta):** Tabela `matricula` utilizando identificadores múltiplos.
3. **`FOREIGN KEY`:** Criação de relacionamentos estruturais na tabela `livro`.
4. **`ALTER TABLE` (ADD):** Inserção da coluna `data_nascimento` na tabela de funcionários.
5. **`ALTER TABLE` (MODIFY / DROP):** Atualização de tipos de dados e deleção de colunas.
6. **`DROP TABLE`:** Exclusão segura de tabelas com verificação `IF EXISTS`.
7. **`CONSTRAINTS`:** Aplicação de `CHECK` (maior ou igual a zero) e `DEFAULT` na tabela de contas bancárias.
8. **`CREATE INDEX`:** Otimização de consultas por nome de produto e índices `UNIQUE`.
9. **`CREATE VIEW`:** Criação de visões pré-compiladas para checagem de estoque.
10. **Modelagem Completa:** Criação de um mini-sistema escolar amarrando as tabelas `curso`, `aluno` e `disciplina` com chaves estrangeiras, `CHECK`, índices e uma `VIEW`.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 🏥 Parte II: Clínica Médica (Documentação)

A segunda etapa exigiu a criação de um banco de dados robusto simulando uma clínica médica. Aqui estão justificadas as decisões técnicas que tomei na hora de estruturar e modelar esse banco:

### ⚡ Descrição de Índices e Views

* 🔍 **Índice 1 (`idx_paciente_nome`):** Criei esse índice na coluna `nome` da tabela `paciente`. Pensando no dia a dia prático de uma clínica, as recepcionistas vão buscar o cadastro das pessoas principalmente pelo nome, então isso vai deixar a pesquisa do sistema infinitamente mais rápida!
* 🔍 **Índice 2 (`idx_medico_nome`):** Aplicado na coluna `nome` da tabela `medico`, seguindo a mesma lógica do índice anterior para agilizar a busca rápida pelos nomes dos profissionais de saúde.
* 🔍 **Índice 3 (`idx_consulta_data`):** Criado na coluna `data_hora` da tabela `consulta`. Como uma clínica precisa filtrar o tempo todo quais são as consultas agendadas do dia, da semana ou do mês, esse índice ajuda o banco de dados a processar a agenda sem travamentos.
* 👁️ **View (`vw_consultas_agendadas`):** Essa visão realiza o relacionamento (`JOIN`) entre três tabelas distintas: `consulta`, `paciente` e `medico`. Ela serve para exibir de forma limpa o nome do paciente, o nome do médico e o horário marcado. 

### 🗂️ Escolhas de Tipos de Dados

* 🔢 **`INT`**: Usei o tipo inteiro para todas as chaves primárias (`PK`) e estrangeiras (`FK`). Integrado ao `AUTO_INCREMENT`, é perfeito para gerar IDs sequenciais automaticamente.
* 🔤 **`VARCHAR`**: Usei para campos de texto que variam de tamanho, como `nome`, `logradouro` e `email`. O banco economiza memória e só gasta o espaço do que realmente for digitado.
* 🔤 **`CHAR`**: Usei para campos com tamanho padrão fixo (`cpf`, `uf`, `cep`). Como o tamanho é previsível, o MySQL processa essas informações muito mais rápido.
* 💵 **`DECIMAL(10,2)`**: Essencial para campos financeiros (`valor`, `preco_unitario`), evitando problemas críticos de arredondamento de centavos.
* 📅 **`DATE` e `DATETIME`**: `DATE` para `data_nascimento` (onde só importa o dia). `DATETIME` para a `consulta` e o `prontuario`, porque registrar o horário exato do atendimento é fundamental.
* 📝 **`TEXT`**: Indispensável em `sintomas`, `diagnostico` e `observacoes`. Como os relatórios médicos são extensos, o `VARCHAR` corria o risco de cortar o texto pela metade. 

### 🛡️ Restrições e Regras de Integridade (Constraints)

* 🔑 **PRIMARY KEY & AUTO_INCREMENT**: Aplicado para garantir que cada registro seja único e indexável, impedindo duplicações.
* 🚫 **NOT NULL**: Usado em campos obrigatórios essenciais (ex: paciente sem CPF, ou consulta sem data definida).
* 🆔 **UNIQUE**: Aplicado no `cpf`, `email`, `crm` e `cnpj`, criando uma trava que impede a secretária de cadastrar a mesma pessoa ou clínica duas vezes.
* ⚖️ **CHECK**: Protege contra inserção de dados inválidos no motor do banco. Exemplo: `CHECK (sexo IN ('M','F','O'))` e a garantia de que valores financeiros ou dias nunca aceitem números negativos (`>= 0`).
* ⚙️ **DEFAULT**: Status de nova consulta entra como `'AGENDADA'` e o `data_registro` do prontuário utiliza `CURRENT_TIMESTAMP` por padrão.
* 🔗 **FOREIGN KEY & ON DELETE CASCADE**: Todas as chaves estrangeiras amarraram o banco e foram nomeadas no padrão exigido. Apliquei `ON DELETE CASCADE` na tabela de endereços, garantindo que se um paciente for excluído, seu endereço também seja, evitando "dados órfãos".

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 🚀 Como Executar o Projeto

Para testar e rodar este repositório no seu ambiente local:

1. Certifique-se de ter o **MySQL Server (versão 8.0+)** e o **MySQL Workbench** instalados.
2. Baixe os arquivos `.sql` e `.mwb` deste repositório.
3. Abra o script `.sql` dentro do editor de queries do seu Workbench e execute (ícone do ⚡). O script criará as estruturas de forma totalmente automatizada.
4. Para abrir o modelo visual, basta abrir os arquivos `.mwb` no Workbench.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>
