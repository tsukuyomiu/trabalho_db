CREATE DATABASE IF NOT EXISTS clinica_medica
DEFAULT CHARACTER SET utf8mb4 
DEFAULT COLLATE utf8mb4_general_ci;

USE clinica_medica;

CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M','F','O')),
    telefone VARCHAR(15),
    email VARCHAR(80) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    logradouro VARCHAR(120) NOT NULL,
    numero VARCHAR(10),
    bairro VARCHAR(60) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    CONSTRAINT fk_endereco_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE,
    descricao VARCHAR(200)
) ENGINE=InnoDB;

CREATE TABLE medico (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(15) NOT NULL UNIQUE,
    id_especialidade INT NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(80) UNIQUE,
    CONSTRAINT fk_medico_especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidade(id_especialidade)
) ENGINE=InnoDB;

CREATE TABLE convenio (
    id_convenio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE,
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    ativo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE paciente_convenio (
    id_paciente INT,
    id_convenio INT,
    numero_carteirinha VARCHAR(30) NOT NULL,
    data_adesao DATE NOT NULL,
    PRIMARY KEY (id_paciente, id_convenio),
    CONSTRAINT fk_paciente_convenio_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_paciente_convenio_convenio FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio)
) ENGINE=InnoDB;

CREATE TABLE consulta (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'AGENDADA',
    valor DECIMAL(10,2) CHECK (valor >= 0),
    CONSTRAINT fk_consulta_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_consulta_medico FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
) ENGINE=InnoDB;

CREATE TABLE prontuario (
    id_prontuario INT AUTO_INCREMENT PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    sintomas TEXT,
    diagnostico TEXT,
    observacoes TEXT,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_prontuario_consulta FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
) ENGINE=InnoDB;

CREATE TABLE medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    fabricante VARCHAR(80),
    preco_unitario DECIMAL(10,2) CHECK (preco_unitario >= 0)
) ENGINE=InnoDB;

CREATE TABLE prescricao (
    id_prescricao INT AUTO_INCREMENT PRIMARY KEY,
    id_prontuario INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(50) NOT NULL,
    duracao_dias INT CHECK (duracao_dias > 0),
    observacoes VARCHAR(200),
    CONSTRAINT fk_prescricao_prontuario FOREIGN KEY (id_prontuario) REFERENCES prontuario(id_prontuario),
    CONSTRAINT fk_prescricao_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
) ENGINE=InnoDB;

CREATE INDEX idx_paciente_nome ON paciente (nome);
CREATE INDEX idx_medico_nome ON medico (nome);
CREATE INDEX idx_consulta_data ON consulta (data_hora);

CREATE VIEW vw_consultas_agendadas AS
SELECT p.nome AS paciente, m.nome AS medico, c.data_hora
FROM consulta c
JOIN paciente p ON c.id_paciente = p.id_paciente
JOIN medico m ON c.id_medico = m.id_medico;