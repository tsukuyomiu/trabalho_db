<a id="readme-top"></a>

<br />
<div align="center">
  <h3 align="center">Clínica Médica - Banco de Dados</h3>

  <p align="center">
    Atividade Prática de DDL (Parte II) desenvolvida para a disciplina de Modelagem de Banco de Dados.
    <br />
  </p>
</div>

<details>
  <summary>Índice</summary>
  <ol>
    <li>
      <a href="#sobre-o-projeto">Sobre o Projeto</a>
      <ul>
        <li><a href="#tecnologias-utilizadas">Tecnologias Utilizadas</a></li>
      </ul>
    </li>
    <li><a href="#conteúdo-da-entrega">Conteúdo da Entrega</a></li>
    <li>
      <a href="#documentação-e-justificativas">Documentação e Justificativas</a>
      <ul>
        <li><a href="#1-índices-e-views">Índices e Views</a></li>
        <li><a href="#2-tipos-de-dados">Tipos de Dados</a></li>
        <li><a href="#3-restrições-constraints">Restrições</a></li>
      </ul>
    </li>
    <li><a href="#como-executar">Como Executar</a></li>
  </ol>
</details>

## Sobre o Projeto

[cite_start]Este repositório contém a entrega da Atividade Prática - Parte II [cite: 3] [cite_start]da disciplina de Modelagem e Projeto de Banco de Dados [cite: 1][cite_start], ministrada pelo Professor Romes[cite: 2]. 

[cite_start]O objetivo do projeto é aplicar os conceitos de DDL (Data Definition Language) na construção de um esquema completo de banco de dados[cite: 9]. [cite_start]O cenário simula o sistema de informação de uma clínica médica, contendo 10 tabelas relacionais com suas devidas chaves, restrições e relacionamentos[cite: 10].

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

### Tecnologias Utilizadas

* ![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
* ![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-1E6B7A?style=for-the-badge&logo=mysql&logoColor=white)

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

## Conteúdo da Entrega

[cite_start]Os seguintes arquivos estão disponíveis neste repositório para avaliação[cite: 93, 94, 95, 96]:

1. **`clinica_medica.sql`**: Script SQL completo contendo os comandos de `CREATE DATABASE`, `CREATE TABLE`, `CREATE INDEX` e `CREATE VIEW`.
2. **`clinica_medica.mwb`**: Arquivo de modelo gerado por engenharia reversa no MySQL Workbench.
3. **`diagrama_eer.png`**: Captura de tela do Diagrama EER mostrando as 10 tabelas e seus relacionamentos.
4. **Este documento (README)**: Contendo a identificação e a justificativa das escolhas técnicas de modelagem.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

## Documentação e Justificativas

Abaixo estão detalhadas as decisões de modelagem aplicadas neste projeto, conforme os critérios de avaliação:

### 1. Índices e Views

* **Índice 1 (`idx_paciente_nome`):** Criado na coluna `nome` da tabela `paciente`. O motivo é que, no dia a dia da clínica, buscas pelo nome do paciente são as mais frequentes.
* **Índice 2 (`idx_medico_nome`):** Criado na coluna `nome` da tabela `medico`. Facilita buscas rápidas pela equipe de médicos da clínica.
* **Índice 3 (`idx_consulta_data`):** Criado na coluna `data_hora` da tabela `consulta`. Otimiza a filtragem de agendas diárias, semanais e mensais.
* **View (`vw_consultas_agendadas`):** Criada utilizando `JOIN` entre as tabelas `consulta`, `paciente` e `medico`. Apresenta de forma simplificada o nome do paciente, nome do médico e horário da consulta, facilitando a visualização da agenda pela recepção sem a necessidade de queries complexas.

### 2. Tipos de Dados

* **INT:** Utilizado para as chaves primárias e estrangeiras em conjunto com o `AUTO_INCREMENT` para geração de identificadores sequenciais[cite: 53].
* **VARCHAR vs. CHAR:** * O `VARCHAR` foi usado para campos de tamanho variável (nome, endereço, bairro, etc.), otimizando o armazenamento. 
  * [cite_start]O `CHAR` foi aplicado em colunas de tamanho fixo para maior velocidade de processamento, como CPF (11) [cite: 63][cite_start], UF (2) e CEP (8)[cite: 65].
* **DECIMAL(10,2):** Utilizado para dados financeiros (valor da consulta e preço do medicamento)[cite: 77, 81], evitando falhas de arredondamento.
* [cite_start]**DATE e DATETIME:** `DATE` para registros apenas de dia (data de nascimento e adesão) [cite: 63, 75] [cite_start]e `DATETIME` para registros precisos como agendamentos e geração de prontuários[cite: 77, 79].
* **TEXT:** Aplicado em campos extensos do prontuário (sintomas, diagnósticos e observações)[cite: 79], garantindo que as anotações médicas não sejam cortadas.

### 3. Restrições (Constraints)

* [cite_start]**PRIMARY KEY:** Utilizada para garantir a unicidade de cada registro nas tabelas[cite: 53].
* [cite_start]**NOT NULL:** Aplicada em campos obrigatórios essenciais para a regra de negócio (ex: nome, CPF, data da consulta)[cite: 62, 63, 77].
* **UNIQUE:** Garante que dados que não devem se repetir no sistema, como CPF, CRM, CNPJ e e-mails, sejam únicos no banco[cite: 63, 67, 69, 72].
* **CHECK:** Validação de regras lógicas a nível de banco. [cite_start]Exemplos: `CHECK (sexo IN ('M','F','O'))` na tabela paciente [cite: 63] [cite_start]e verificações de valores financeiros onde o valor não pode ser negativo (`valor >= 0`)[cite: 77].
* **DEFAULT:** Otimização de cadastros. Exemplo: status de consultas entram como `'AGENDADA'` por padrão [cite: 77] e a data do prontuário usa `CURRENT_TIMESTAMP`[cite: 79].
* **FOREIGN KEY:** Garantem a integridade referencial. [cite_start]Na tabela endereço, foi utilizado `ON DELETE CASCADE` [cite: 65] para remover endereços de pacientes deletados do sistema, evitando dados órfãos.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

## Como Executar

[cite_start]Para testar este esquema de banco de dados localmente[cite: 12]:

1. [cite_start]Tenha o **MySQL Server (versão 8.0+)** e o **MySQL Workbench** instalados[cite: 12].
2. Baixe o arquivo `clinica_medica.sql` deste repositório.
3. [cite_start]Abra o script no Query Tab do Workbench[cite: 13].
4. Execute o script. Ele irá automaticamente criar o banco de dados (caso não exista), criar as tabelas e inserir as chaves e índices.
5. [cite_start]Para visualizar o modelo físico, você pode importar o arquivo `clinica_medica.mwb` ou utilizar o recurso *Database > Reverse Engineer* [cite: 108, 109] [cite_start]no seu banco local[cite: 110].

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>
