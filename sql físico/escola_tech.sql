CREATE DATABASE escola_tech CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE escola_tech;

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL CHECK (carga_horaria > 0),
    preco DECIMAL(10,2) DEFAULT 0.00,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE SET NULL
);

ALTER TABLE alunos
ADD COLUMN data_matricula DATE,
ADD COLUMN telefone VARCHAR(20);

ALTER TABLE alunos
RENAME COLUMN telefone TO celular; 

TRUNCATE TABLE alunos;

/* DROP TABLE manda a tabela inteira pro espaço. Ele apaga os dados, a estrutura, as colunas, os índices e tudo. Você fica literalmente sem a tabela no banco. Deletou, sumiu.
TRUNCATE TABLE da um reset de fábrica na tabela, apaga todos os registros de uma vez só e é muito mais rápido que usar um DELETE sem WHERE, mas a casca da tabela, as colunas, os tipos de dados continua lá, intacta e prontinha pra receber dados novos, e ainda ele zera o contador do AUTO_INCREMENT.*/