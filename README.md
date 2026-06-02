<a id="readme-top"></a>

<br />
<div align="center">
  <samp>🏥 Sistema de Gestão Hospitalar 🏥</samp>
  <h2 align="center">🩺 Clínica Médica - Banco de Dados 📊</h2>

  <p align="center">
    <strong>Atividade Prática de DDL (Parte II)</strong><br />
    Desenvolvido para a disciplina de Modelagem e Projeto de Banco de Dados.
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
      <a href="#-documentação-e-justificativas">Documentação e Justificativas</a>
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

Este repositório contém a entrega oficial da **Atividade Prática - Parte II** da disciplina de *Modelagem e Projeto de Banco de Dados*, coordenada pelo **Professor Romes**. 

🎯 **Objetivo:** Aplicar os conceitos práticos de DDL (*Data Definition Language*) para construir um esquema completo, consistente e profissional de banco de dados.

O cenário simula o sistema real de uma **Clínica Médica**, contendo **10 tabelas relacionais** perfeitamente integradas com suas respectivas chaves primárias, chaves estrangeiras, restrições de integridade e índices de otimização.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

### 🛠️ Tecnologias e Ferramentas

* ![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
* ![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-1E6B7A?style=for-the-badge&logo=mysql&logoColor=white)
* ![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 📦 Conteúdo da Entrega

Aqui na pasta você vai encontrar os arquivos obrigatórios solicitados na atividade:

* 💾 **`clinica_medica.sql`**: Script SQL completo com os comandos de criação do banco, tabelas, restrições, índices e view.
* 📐 **`clinica_medica.mwb`**: Arquivo de modelo físico estruturado para abertura direta no MySQL Workbench.
* 🖼️ **`diagrama_eer.png`**: Captura de tela do Diagrama EER mostrando as 10 tabelas e suas conexões.
* 📄 **Este arquivo README**: Nossa documentação com o relatório detalhado de justificativas.

### 🖼️ Visualização do Diagrama EER
<div align="center">
  <img src="diagrama_eer.png" alt="Diagrama EER Clínica Médica" width="95%" style="border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.25);">
</div>

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 🔍 Documentação e Justificativas

Aqui estão explicadas todas as decisões técnicas que tomei na hora de estruturar e modelar o banco de dados:

### ⚡ Descrição Index/View

* 🔍 **Índice 1 (`idx_paciente_nome`):** Criei esse índice na coluna `nome` da tabela `paciente`. Pensando no dia a dia prático de uma clínica, as recepcionistas vão buscar o cadastro das pessoas principalmente pelo nome, então isso vai deixar a pesquisa do sistema infinitamente mais rápida!
* 🔍 **Índice 2 (`idx_medico_nome`):** Aplicado na coluna `nome` da tabela `medico`, seguindo a mesma lógica do índice anterior para agilizar a busca rápida pelos nomes dos profissionais de saúde.
* 🔍 **Índice 3 (`idx_consulta_data`):** Criado na coluna `data_hora` da tabela `consulta`. Como uma clínica precisa filtrar o tempo todo quais são as consultas agendadas do dia, da semana ou do mês, esse índice ajuda o banco de dados a processar a agenda sem travamentos.
* 👁️ **View (`vw_consultas_agendadas`):** Essa visão realiza o relacionamento (`JOIN`) entre três tabelas distintas: `consulta`, `paciente` e `medico`. Ela serve para exibir de forma limpa o nome do paciente, o nome do médico e o horário marcado. Assim, a recepção consegue consultar a agenda de forma direta sem precisar digitar um bloco gigante de código SQL toda vez.

### 🗂️ Escolhas de Tipos de Dados

* 🔢 **`INT`**: Usei o tipo inteiro para todas as chaves primárias (`PK`) e estrangeiras (`FK`). Como a instrução do projeto mandou usar `AUTO_INCREMENT`, o `INT` é o tipo perfeito para gerar esses números de ID sequenciais automaticamente.
* 🔤 **`VARCHAR`**: Usei para campos de texto que variam de tamanho entre os cadastros, como `nome`, `logradouro`, `email` e `bairro`. Desse jeito, o banco economiza memória e só gasta o espaço do que realmente for digitado.
* 🔤 **`CHAR`**: Usei para campos que têm um tamanho padrão fixo que nunca muda, como o `cpf` (11 caracteres), a `uf` (2 caracteres) e o `cep` (8 caracteres). Como o tamanho é previsível, o MySQL processa essas informações muito mais rápido.
* 💵 **`DECIMAL(10,2)`**: Usei no `valor` da consulta e no `preco_unitario` do medicamento. Como mexe com dinheiro, o formato decimal com duas casas é o único seguro para evitar problemas ou bugs de arredondamento de centavos.
* 📅 **`DATE` e `DATETIME`**: Usei `DATE` para `data_nascimento` e `data_adesao` (onde só importa o dia). Já para a `consulta` e o `prontuario`, usei `DATETIME` porque registrar o horário exato do atendimento ou da criação do registro é fundamental.
* 📝 **`TEXT`**: Usei em `sintomas`, `diagnostico` e `observacoes` na tabela de prontuário. Como os médicos podem escrever relatórios e históricos bem longos, o `VARCHAR` corria o risco de cortar o texto pela metade. O `TEXT` resolve isso perfeitamente.

### 🛡️ Restrições e Regras de Integridade (Constraints)

* 🔑 **PRIMARY KEY & AUTO_INCREMENT**: Aplicado em todas as tabelas para garantir que cada registro seja único e indexável, impedindo qualquer duplicidade de dados no sistema.
* 🚫 **NOT NULL**: Usei em campos essenciais do negócio. Afinal, não faz sentido o sistema aceitar cadastrar um paciente sem nome e sem CPF, ou marcar uma consulta sem uma data definida.
* 🆔 **UNIQUE**: Apliquei no `cpf`, `email`, `crm` e `cnpj`. Isso cria uma trava de segurança impedindo que o usuário cadastre a mesma pessoa, médico ou clínica duas vezes por engano.
* ⚖️ **CHECK**: Excelente para validações lógicas direto no motor do banco de dados. No campo `sexo`, a regra `CHECK (sexo IN ('M','F','O'))` impede a inserção de dados inválidos. Também usei `CHECK` para garantir que valores financeiros ou dias de tratamento nunca aceitem números negativos (`>= 0`).
* ⚙️ **DEFAULT**: Usei para automatizar o fluxo. O status de uma nova consulta entra sempre como `'AGENDADA'` por padrão. No prontuário, o campo `data_registro` puxa o horário atual do servidor automaticamente usando a função `CURRENT_TIMESTAMP`.
* 🔗 **FOREIGN KEY & ON DELETE CASCADE**: As chaves estrangeiras foram todas nomeadas seguindo o padrão exigido (`fk_tabela_origem_tabela_destino`). Um detalhe bem legal que pesquisei se dava para fazer (e funcionou!) foi aplicar o `ON DELETE CASCADE` na tabela de endereços. Isso garante que se um paciente for excluído do sistema, o endereço dele seja apagado junto automaticamente, limpando o banco e evitando que fiquem dados perdidos ou "órfãos".

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

## 🚀 Como Executar o Projeto

Para testar e rodar este esquema de banco de dados no seu ambiente local:

1. Certifique-se de ter o **MySQL Server (versão 8.0+)** e o **MySQL Workbench** instalados e rodando.
2. Baixe o arquivo `clinica_medica.sql` disponível neste repositório.
3. Abra o script dentro do editor de queries do seu Workbench.
4. Execute o script completo (clicando no ícone do raiozinho ⚡). O script criará o banco `clinica_medica`, estruturará as 10 tabelas, aplicará os índices e a view de forma totalmente automatizada.
5. Para abrir o modelo visual estruturado, basta abrir o arquivo `clinica_medica.mwb` no Workbench ou usar a função *Database > Reverse Engineer* apontando para o seu servidor local.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>
