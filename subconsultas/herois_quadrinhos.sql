--  BANCO DE DADOS: HERÓIS DOS QUADRINHOS  🦸‍♂️🦹‍♀️
-- =====================================================================
--  Script para MySQL Workbench / MariaDB
--  (Prof. Romes)
-- ---------------------------------------------------------------------
--  Relacionamentos disponíveis para praticar:
--    1:N   -> editora -> personagem | cidade -> personagem
--    N:N   -> personagem <-> poder  | personagem <-> equipe
--    Auto  -> batalha (herói x vilão, ambos na tabela personagem)
-- =====================================================================
 
-- Recria o banco do zero para você poder rodar quantas vezes quiser
DROP DATABASE IF EXISTS herois_quadrinhos;
CREATE DATABASE herois_quadrinhos
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE herois_quadrinhos;
 
-- =====================================================================
--  1. TABELAS
-- =====================================================================
 
-- Editoras (Marvel, DC, etc.)
CREATE TABLE editora (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(60)  NOT NULL,
    pais            VARCHAR(40)  NOT NULL,
    ano_fundacao    INT          NOT NULL
);
 
-- Cidades que os personagens protegem (ou aterrorizam)
CREATE TABLE cidade (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(60)  NOT NULL,
    pais            VARCHAR(40)  NOT NULL,
    populacao       BIGINT       NOT NULL,
    ficticia        BOOLEAN      NOT NULL DEFAULT TRUE
);
 
-- Personagens (heróis, vilões e anti-heróis na mesma tabela)
CREATE TABLE personagem (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome_heroi      VARCHAR(60)  NOT NULL,
    nome_real       VARCHAR(80),
    alinhamento     ENUM('HEROI','VILAO','ANTI_HEROI') NOT NULL,
    nivel_forca     INT          NOT NULL,          -- escala de 1 a 100
    primeira_aparicao INT,                           -- ano
    patrimonio      DECIMAL(15,2) DEFAULT 0.00,      -- em dólares
    editora_id      INT,
    cidade_id       INT,
    CONSTRAINT fk_personagem_editora
        FOREIGN KEY (editora_id) REFERENCES editora(id),
    CONSTRAINT fk_personagem_cidade
        FOREIGN KEY (cidade_id)  REFERENCES cidade(id)
);
 
-- Poderes / habilidades
CREATE TABLE poder (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(60)  NOT NULL,
    categoria       VARCHAR(40)  NOT NULL,           -- Físico, Mental, Energia...
    nivel_perigo    INT          NOT NULL            -- escala de 1 a 10
);
 
-- Equipes / grupos
CREATE TABLE equipe (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(60)  NOT NULL,
    ano_formacao    INT,
    editora_id      INT,
    CONSTRAINT fk_equipe_editora
        FOREIGN KEY (editora_id) REFERENCES editora(id)
);
 
-- N:N -> quais poderes cada personagem tem
CREATE TABLE personagem_poder (
    personagem_id   INT NOT NULL,
    poder_id        INT NOT NULL,
    PRIMARY KEY (personagem_id, poder_id),
    CONSTRAINT fk_pp_personagem
        FOREIGN KEY (personagem_id) REFERENCES personagem(id) ON DELETE CASCADE,
    CONSTRAINT fk_pp_poder
        FOREIGN KEY (poder_id)      REFERENCES poder(id)      ON DELETE CASCADE
);
 
-- N:N -> quais equipes cada personagem integra
CREATE TABLE personagem_equipe (
    personagem_id   INT NOT NULL,
    equipe_id       INT NOT NULL,
    ano_entrada     INT,
    PRIMARY KEY (personagem_id, equipe_id),
    CONSTRAINT fk_pe_personagem
        FOREIGN KEY (personagem_id) REFERENCES personagem(id) ON DELETE CASCADE,
    CONSTRAINT fk_pe_equipe
        FOREIGN KEY (equipe_id)     REFERENCES equipe(id)     ON DELETE CASCADE
);
 
-- Batalhas (auto-relacionamento: herói x vilão)
CREATE TABLE batalha (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    heroi_id        INT NOT NULL,
    vilao_id        INT NOT NULL,
    cidade_id       INT,
    ano             INT,
    vencedor_id     INT,                             -- NULL = empate
    descricao       VARCHAR(150),
    CONSTRAINT fk_batalha_heroi
        FOREIGN KEY (heroi_id)   REFERENCES personagem(id),
    CONSTRAINT fk_batalha_vilao
        FOREIGN KEY (vilao_id)   REFERENCES personagem(id),
    CONSTRAINT fk_batalha_cidade
        FOREIGN KEY (cidade_id)  REFERENCES cidade(id),
    CONSTRAINT fk_batalha_vencedor
        FOREIGN KEY (vencedor_id) REFERENCES personagem(id)
);
 
-- =====================================================================
--  2. POVOAMENTO DOS DADOS
-- =====================================================================
 
-- ---------- EDITORAS ----------
INSERT INTO editora (nome, pais, ano_fundacao) VALUES
('Marvel Comics',   'EUA', 1939),
('DC Comics',       'EUA', 1934),
('Image Comics',    'EUA', 1992),
('Dark Horse',      'EUA', 1986),
('Mauricio de Sousa','Brasil', 1959);
 
-- ---------- CIDADES ----------
INSERT INTO cidade (nome, pais, populacao, ficticia) VALUES
('Nova York',       'EUA',    8400000, FALSE),  -- 1
('Gotham City',     'EUA',    9300000, TRUE),   -- 2
('Metropolis',      'EUA',    8200000, TRUE),   -- 3
('Wakanda',         'África', 6000000, TRUE),   -- 4
('Central City',    'EUA',    1200000, TRUE),   -- 5
('Asgard',          'Reino de Asgard', 9000000, TRUE), -- 6
('Limbo City',      'Inferno', 500000, TRUE),   -- 7
('São Paulo',       'Brasil', 12300000, FALSE), -- 8
('Star City',       'EUA',    1500000, TRUE);   -- 9
 
-- ---------- PERSONAGENS ----------
-- id (auto) | nome_heroi | nome_real | alinhamento | forca | aparicao | patrimonio | editora | cidade
INSERT INTO personagem
(nome_heroi, nome_real, alinhamento, nivel_forca, primeira_aparicao, patrimonio, editora_id, cidade_id) VALUES
-- HERÓIS Marvel
('Homem de Ferro',  'Tony Stark',        'HEROI',      82, 1963, 100000000000, 1, 1), -- 1
('Capitão América', 'Steve Rogers',      'HEROI',      70, 1941,        5000, 1, 1), -- 2
('Thor',            'Thor Odinson',      'HEROI',      98, 1962,  9000000000, 1, 6), -- 3
('Homem-Aranha',    'Peter Parker',      'HEROI',      65, 1962,        2000, 1, 1), -- 4
('Hulk',            'Bruce Banner',      'HEROI',      99, 1962,      150000, 1, 1), -- 5
('Pantera Negra',   'TChalla',           'HEROI',      80, 1966, 90000000000, 1, 4), -- 6
('Viúva Negra',     'Natasha Romanoff',  'HEROI',      55, 1964,      500000, 1, 1), -- 7
('Wolverine',       'Logan',             'ANTI_HEROI', 78, 1974,      300000, 1, 1), -- 8
('Doutor Estranho', 'Stephen Strange',   'HEROI',      88, 1963,    20000000, 1, 1), -- 9
-- HERÓIS DC
('Superman',        'Clark Kent',        'HEROI',      97, 1938,       40000, 2, 3), -- 10
('Batman',          'Bruce Wayne',       'HEROI',      72, 1939, 80000000000, 2, 2), -- 11
('Mulher-Maravilha','Diana Prince',      'HEROI',      90, 1941,      100000, 2, 3), -- 12
('Flash',           'Barry Allen',       'HEROI',      85, 1956,       70000, 2, 5), -- 13
('Aquaman',         'Arthur Curry',      'HEROI',      83, 1941,    50000000, 2, 1), -- 14
('Lanterna Verde',  'Hal Jordan',        'HEROI',      86, 1959,       60000, 2, 9), -- 15
('Arqueiro Verde',  'Oliver Queen',      'HEROI',      58, 1941,  7000000000, 2, 9), -- 16
-- ANTI-HERÓIS / outros
('Deadpool',        'Wade Wilson',       'ANTI_HEROI', 60, 1991,       80000, 1, 1), -- 17
('Demolidor',       'Matt Murdock',      'HEROI',      62, 1964,      120000, 1, 1), -- 18
('Spawn',           'Al Simmons',        'ANTI_HEROI', 91, 1992,           0, 3, 7), -- 19
-- VILÕES Marvel
('Thanos',          'Thanos',            'VILAO',     100, 1973,           0, 1, 1), -- 20
('Loki',            'Loki Laufeyson',    'VILAO',      75, 1962,  1000000000, 1, 6), -- 21
('Duende Verde',    'Norman Osborn',     'VILAO',      64, 1964,  5000000000, 1, 1), -- 22
('Caveira Vermelha','Johann Schmidt',    'VILAO',      54, 1941,     2000000, 1, 1), -- 23
('Ultron',          'Ultron',            'VILAO',      89, 1968,           0, 1, 1), -- 24
-- VILÕES DC
('Coringa',         'Desconhecido',      'VILAO',      52, 1940,      900000, 2, 2), -- 25
('Lex Luthor',      'Lex Luthor',        'VILAO',      60, 1940, 75000000000, 2, 3), -- 26
('Darkseid',        'Uxas',              'VILAO',      99, 1970,           0, 2, 3), -- 27
('Reverso',         'Eobard Thawne',     'VILAO',      84, 1963,           0, 2, 5), -- 28
('Pinguim',         'Oswald Cobblepot',  'VILAO',      30, 1941,   300000000, 2, 2); -- 29
 
-- ---------- PODERES ----------
INSERT INTO poder (nome, categoria, nivel_perigo) VALUES
('Super Força',          'Físico',  9),  -- 1
('Voo',                  'Físico',  6),  -- 2
('Velocidade Sobre-humana','Físico',8),  -- 3
('Fator de Cura',        'Físico',  7),  -- 4
('Invulnerabilidade',    'Defesa',  9),  -- 5
('Manipulação Mágica',   'Mágico',  10), -- 6
('Inteligência Genial',  'Mental',  5),  -- 7
('Visão de Calor',       'Energia', 8),  -- 8
('Controle da Água',     'Elemental',7), -- 9
('Manipulação do Tempo', 'Energia', 10), -- 10
('Garras de Adamantium', 'Físico',  6),  -- 11
('Sentido Aranha',       'Mental',  4),  -- 12
('Telepatia',            'Mental',  8),  -- 13
('Tecnologia Avançada',  'Equipamento',7),-- 14
('Habilidade de Combate','Físico',  5),  -- 15
('Anel de Energia',      'Equipamento',9);-- 16
 
-- ---------- EQUIPES ----------
INSERT INTO equipe (nome, ano_formacao, editora_id) VALUES
('Vingadores',          1963, 1), -- 1
('Liga da Justiça',     1960, 2), -- 2
('X-Men',               1963, 1), -- 3
('Quarteto Fantástico', 1961, 1), -- 4
('Esquadrão Suicida',   1959, 2); -- 5
 
-- ---------- N:N PERSONAGEM x PODER ----------
INSERT INTO personagem_poder (personagem_id, poder_id) VALUES
(1,14),(1,7),(1,2),                       -- Homem de Ferro
(2,15),(2,1),                             -- Capitão América
(3,1),(3,2),(3,6),(3,5),                  -- Thor
(4,12),(4,1),(4,15),                      -- Homem-Aranha
(5,1),(5,5),(5,4),                        -- Hulk
(6,15),(6,14),(6,1),                      -- Pantera Negra
(7,15),                                   -- Viúva Negra
(8,11),(8,4),(8,15),                      -- Wolverine
(9,6),(9,2),(9,7),                        -- Doutor Estranho
(10,1),(10,2),(10,5),(10,8),              -- Superman
(11,7),(11,14),(11,15),                   -- Batman
(12,1),(12,2),(12,15),                    -- Mulher-Maravilha
(13,3),                                   -- Flash
(14,9),(14,1),                            -- Aquaman
(15,16),(15,2),                           -- Lanterna Verde
(16,15),(16,14),                          -- Arqueiro Verde
(17,4),(17,15),                           -- Deadpool
(18,12),(18,15),                          -- Demolidor
(19,6),(19,1),(19,5),                     -- Spawn
(20,1),(20,5),(20,6),                     -- Thanos
(21,6),(21,13),                           -- Loki
(22,1),(22,14),                           -- Duende Verde
(24,7),(24,2),(24,5),                     -- Ultron
(26,7),(26,14),                           -- Lex Luthor
(27,1),(27,8),(27,5),                     -- Darkseid
(28,3),(28,10);                           -- Reverso
 
-- ---------- N:N PERSONAGEM x EQUIPE ----------
INSERT INTO personagem_equipe  (personagem_id, equipe_id, ano_entrada) VALUES
(1,1,1963),(2,1,1964),(3,1,1963),(5,1,1963),(7,1,1973),(6,1,2016),(9,1,2010), -- Vingadores
(10,2,1960),(11,2,1960),(12,2,1960),(13,2,1960),(14,2,1960),(15,2,1960),(16,2,1969), -- Liga
(8,3,1975),                                                                   -- X-Men
(25,5,1959),(17,5,2016),(29,5,2010);                                          -- Esquadrão Suicida
 
-- ---------- BATALHAS (herói x vilão) ----------
INSERT INTO batalha (heroi_id, vilao_id, cidade_id, ano, vencedor_id, descricao) VALUES
(1, 20, 1, 2018, 20, 'Thanos vence com o estalo em Nova York'),
(3, 21, 6, 2011,  3, 'Thor derrota Loki em Asgard'),
(10,26, 3, 2016, 10, 'Superman impede plano de Lex em Metropolis'),
(11,25, 2, 2008, 11, 'Batman captura o Coringa em Gotham'),
(4, 22, 1, 2002,  4, 'Homem-Aranha vence o Duende Verde'),
(12,27, 3, 2020, NULL,'Mulher-Maravilha empata com Darkseid'),
(13,28, 5, 2014, 28, 'Reverso supera o Flash em Central City'),
(2, 23, 1, 1945,  2, 'Capitão derrota Caveira Vermelha na guerra'),
(1, 24, 1, 2015,  1, 'Homem de Ferro destrói Ultron'),
(5, 20, 1, 2018, 20, 'Hulk é derrotado por Thanos'),
(6, 27, 4, 2021,  6, 'Pantera Negra protege Wakanda de Darkseid'),
(11,29, 2, 2012, 11, 'Batman prende o Pinguim em Gotham'),
(15,27, 9, 2019, NULL,'Lanterna Verde resiste a Darkseid'),
(19,21, 7, 2017, 19, 'Spawn humilha Loki em Limbo City');

