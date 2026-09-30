-- ===============================================================
-- Grande Premio de Interlagos - Triagem Tecnica do Paddock
-- Isabela Moreira Mendes
-- ===============================================================

DROP DATABASE IF EXISTS paddock_db;
CREATE DATABASE paddock_db;
USE paddock_db;
SET SQL_SAFE_UPDATES = 0;


-- ---------------------------------------------------------------
-- PARTE 1 - CRIACAO DAS TABELAS E RELACIONAMENTOS
-- A tabela equipes vem primeiro: engenheiros tem uma FK que
-- aponta pra ela, e nao da pra referenciar tabela inexistente.
-- ---------------------------------------------------------------

CREATE TABLE equipes(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(60) NOT NULL,
    pais_origem VARCHAR(40)
);

CREATE TABLE engenheiros(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
	anos_experiencia INT CHECK (anos_experiencia >= 0),
    especialidade VARCHAR(50),
    disponivel_paddock BOOLEAN,
     credencial_ativa BOOLEAN,
    nota_avaliacao INT CHECK (nota_avaliacao BETWEEN 0 AND 100),
    status_convocacao ENUM('DISPONIVEL','EM_ESPERA','PROMOVIDO','INDISPONIVEL'),
    equipe_id INT,
    FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);


-- ---------------------------------------------------------------
-- PARTE 2 - POVOAMENTO COM INTEGRIDADE REFERENCIAL
-- As equipes entram primeiro: a FK exige que o equipe_id ja exista.
-- ---------------------------------------------------------------

INSERT INTO equipes (nome_equipe, pais_origem) VALUES
('Ferrari Academy', 'Italia'),
('Mercedes Junior', 'Alemanha'),
('Red Bull Powertrains', 'Austria'),
('Alpine Academy', 'Franca');

INSERT INTO engenheiros (nome, anos_experiencia, especialidade, disponivel_paddock,
     credencial_ativa, nota_avaliacao, status_convocacao, equipe_id)
VALUES
('Carlos Eduardo', 12, 'Telemetria Senior', TRUE, FALSE, 95, 'INDISPONIVEL', 1),
('Marcus Vance', 8, 'Analista de Dados', TRUE, TRUE, 88, 'DISPONIVEL', 2),
('Sergio Perez', 3, 'Telemetria Pleno', TRUE, TRUE, 78, 'DISPONIVEL', 3),
('Lucas Di Grassi', 10, 'Sistemas Embarcados', FALSE, TRUE, 92, 'EM_ESPERA', 4),
('Beatriz Figueiredo', 6, 'Engenharia de Telemetria', TRUE, TRUE,  94, 'DISPONIVEL', 4),
('Pietro Fittipaldi', 4, 'Aerodinamica', TRUE, TRUE, 85, 'DISPONIVEL', 3);


-- ---------------------------------------------------------------
-- PARTE 3 - MANIPULACAO DE DADOS (UPDATE e DELETE)
-- ---------------------------------------------------------------

-- 1. Pietro Fittipaldi (id 6) refez o teste: nota vai para 91
UPDATE engenheiros SET nota_avaliacao = 91 WHERE id = 6;

-- 2. Carlos Eduardo (id 1) regularizou a licenca
UPDATE engenheiros SET credencial_ativa = TRUE WHERE id = 1;

-- 3. Remove quem nao esta no Paddock (sai o Lucas Di Grassi)
DELETE FROM engenheiros WHERE disponivel_paddock = FALSE;


-- ---------------------------------------------------------------
-- PARTE 4 - CONSULTAS FILTRADAS POR CHAVE ESTRANGEIRA (SELECT)
-- ---------------------------------------------------------------

-- 1. Todos os engenheiros: nome, especialidade, nota e equipe
SELECT nome, especialidade, nota_avaliacao, equipe_id
FROM engenheiros;

-- 2. Somente os da equipe 4 (Alpine Academy)
SELECT * FROM engenheiros WHERE equipe_id = 4;

-- 3. Os das equipes 2 ou 3, usando IN
SELECT * FROM engenheiros WHERE equipe_id IN (2, 3);

-- 4. Pelo menos 5 anos de experiencia E das equipes 1 ou 4
SELECT * FROM engenheiros
WHERE anos_experiencia >= 5 AND equipe_id IN (1, 4);

-- 5. Quantos engenheiros a equipe 3 tem
SELECT COUNT(*) AS total_engenheiros
FROM engenheiros
WHERE equipe_id = 3;

-- 6. Media da nota por equipe
SELECT equipe_id, AVG(nota_avaliacao) AS media_nota
FROM engenheiros
GROUP BY equipe_id;


-- ---------------------------------------------------------------
-- PARTE 5 - PROMOVENDO O SUBSTITUTO
-- Os parenteses no bloco do LIKE sao obrigatorios: AND tem
-- precedencia sobre OR, entao sem eles o filtro quebra.
-- Resultado esperado: Beatriz Figueiredo (nota 94).
-- ---------------------------------------------------------------

SELECT nome, especialidade, anos_experiencia, nota_avaliacao, equipe_id
FROM engenheiros
WHERE disponivel_paddock = TRUE
  AND credencial_ativa = TRUE
  AND anos_experiencia >= 5
  AND (especialidade LIKE '%Telemetria%'
       OR especialidade LIKE '%Dados%'
       OR especialidade LIKE '%Sistemas%' )
  AND status_convocacao = 'DISPONIVEL'
  AND equipe_id IN (2, 3, 4)
ORDER BY nota_avaliacao DESC
LIMIT 1;
