-- RunTracker - plataforma de circuitos de corridas de rua
-- Modelo com 7 tabelas: 5 entidades do enunciado + 2 associativas

CREATE DATABASE runtracker_db;
USE runtracker_db;


-- 1. PROVAS (CORRIDAS)
CREATE TABLE prova (
    idProva INT AUTO_INCREMENT PRIMARY KEY,
    nomeCorrida VARCHAR(100) NOT NULL,
    modalidade ENUM('Caminhada','5K','10K','MeiaMaratona','Maratona') NOT NULL,
    taxaInscricao DECIMAL(10,2) NOT NULL CHECK (taxaInscricao >= 0),
    distanciaTotal INT NOT NULL CHECK (distanciaTotal > 0)  -- em metros
);


-- 2. ARENAS DE PROVA (LOCAIS)
CREATE TABLE arena (
    idArena INT AUTO_INCREMENT PRIMARY KEY,
    nomeLocal VARCHAR(100) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    uf CHAR(2) NOT NULL,
    responsavelInfra VARCHAR(100) NOT NULL,
    cronometragemEletronica BOOLEAN NULL  -- opcional: aceita NULL
);


-- ASSOCIATIVA N:N - uma prova usa varias arenas, uma arena sedia varias provas
CREATE TABLE prova_arena (
    idProva INT NOT NULL,
    idArena INT NOT NULL,
    PRIMARY KEY (idProva, idArena),
    FOREIGN KEY (idProva) REFERENCES prova(idProva),
    FOREIGN KEY (idArena) REFERENCES arena(idArena)
);


-- 3. ATLETAS (CORREDORES)
CREATE TABLE atleta (
    cpf CHAR(11) PRIMARY KEY,
    nomeCompleto VARCHAR(100) NOT NULL,
    equipe VARCHAR(60),
    email VARCHAR(100) NOT NULL,
    categoriaDesempenho TINYINT NOT NULL CHECK (categoriaDesempenho BETWEEN 1 AND 10)
);


-- 6. RELATORIOS MEDICOS / ANAMNESE
-- Relacionamento 1:1 opcional com atleta.
-- O cpfAtleta e PK e FK ao mesmo tempo: sendo PK ele nao repete,
-- entao um atleta nunca consegue ter duas fichas.
CREATE TABLE ficha_medica (
    cpfAtleta CHAR(11) PRIMARY KEY,
    nivelAptidaoFisica TINYINT NOT NULL CHECK (nivelAptidaoFisica BETWEEN 1 AND 5),
    observacoesRestricoes TEXT,
    FOREIGN KEY (cpfAtleta) REFERENCES atleta(cpf)
);


-- 5. LOGISTICA DE KITS (FORNECEDOR DO KIT)
CREATE TABLE fornecedor_kit (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    dataLimiteRetirada DATE NOT NULL,
    custoLogisticoEnvio DECIMAL(10,2) NOT NULL CHECK (custoLogisticoEnvio >= 0)
);


-- 4. INSCRICOES (TRANSACAO)
-- Associativa entre atleta e prova, com atributos proprios.
-- PK composta (cpf + idProva), como o enunciado exige.
CREATE TABLE inscricao (
    cpfAtleta CHAR(11) NOT NULL,
    idProva INT NOT NULL,
    idFornecedor INT NOT NULL,
    valorTotalPago DECIMAL(10,2) NOT NULL CHECK (valorTotalPago >= 0),
    formaPagamento ENUM('Pix','Cartao','Boleto') NOT NULL,
    numeroPeito INT NOT NULL,
    PRIMARY KEY (cpfAtleta, idProva),
    UNIQUE (idProva, numeroPeito),  -- peito unico dentro de cada prova
    FOREIGN KEY (cpfAtleta) REFERENCES atleta(cpf),
    FOREIGN KEY (idProva) REFERENCES prova(idProva),
    FOREIGN KEY (idFornecedor) REFERENCES fornecedor_kit(idFornecedor)
);


-- ---------------------------------------------------------------
-- DADOS DE TESTE
-- ---------------------------------------------------------------

INSERT INTO prova (nomeCorrida, modalidade, taxaInscricao, distanciaTotal) VALUES
('Maratona Noturna', 'Maratona', 250.00, 42195),
('5K Solidario', '5K', 60.00, 5000),
('Circuito das Aguas 10K', '10K', 95.50, 10000),
('Caminhada da Primavera', 'Caminhada', 30.00, 3000);

INSERT INTO arena (nomeLocal, cidade, uf, responsavelInfra, cronometragemEletronica) VALUES
('Parque das Aguas', 'Santa Rita do Sapucai', 'MG', 'Carlos Andrade', TRUE),
('Orla Central', 'Santos', 'SP', 'Marina Lopes', TRUE),
('Praca da Liberdade', 'Belo Horizonte', 'MG', 'Rafael Souza', FALSE),
('Arena Vale Verde', 'Pouso Alegre', 'MG', 'Juliana Prado', NULL);

INSERT INTO prova_arena (idProva, idArena) VALUES
(1, 1), (1, 2),
(2, 1),
(3, 3), (3, 4),
(4, 1);

INSERT INTO atleta (cpf, nomeCompleto, equipe, email, categoriaDesempenho) VALUES
('11122233344', 'Isabela Moreira Mendes', 'Assessoria Run Inatel', 'isabela@email.com', 7),
('55566677788', 'Pedro Henrique Alves', 'Equipe Trilha Livre', 'pedro@email.com', 9),
('99988877766', 'Camila Ferreira', NULL, 'camila@email.com', 4),
('12345678900', 'Lucas Barbosa', 'Assessoria Run Inatel', 'lucas@email.com', 10);

-- Nem todo atleta tem ficha: o enunciado diz que ele "pode" preencher.
-- Camila e Lucas ficaram de fora de proposito.
INSERT INTO ficha_medica (cpfAtleta, nivelAptidaoFisica, observacoesRestricoes) VALUES
('11122233344', 4, 'Sem restricoes. Historico de lesao no joelho direito em 2024.'),
('55566677788', 5, NULL);

INSERT INTO fornecedor_kit (dataLimiteRetirada, custoLogisticoEnvio) VALUES
('2026-11-20', 18.75);

INSERT INTO inscricao (cpfAtleta, idProva, idFornecedor, valorTotalPago, formaPagamento, numeroPeito) VALUES
('11122233344', 1, 1, 268.75, 'Pix', 101),
('55566677788', 1, 1, 268.75, 'Cartao', 102),
('99988877766', 2, 1, 78.75, 'Boleto', 201),
('11122233344', 2, 1, 78.75, 'Pix', 202),
('12345678900', 3, 1, 114.25, 'Cartao', 301);


-- ---------------------------------------------------------------
-- CONSULTAS DE VERIFICACAO
-- ---------------------------------------------------------------

-- Todas as provas com suas arenas (percorre a associativa N:N)
SELECT p.nomeCorrida, p.modalidade, a.nomeLocal, a.cidade, a.uf
FROM prova p
JOIN prova_arena pa ON p.idProva = pa.idProva
JOIN arena a ON pa.idArena = a.idArena
ORDER BY p.nomeCorrida;

-- Inscritos de cada prova com numero de peito e forma de pagamento
SELECT p.nomeCorrida, at.nomeCompleto, i.numeroPeito, i.formaPagamento, i.valorTotalPago
FROM inscricao i
JOIN atleta at ON i.cpfAtleta = at.cpf
JOIN prova p ON i.idProva = p.idProva
ORDER BY p.nomeCorrida, i.numeroPeito;

-- Quanto cada prova arrecadou
SELECT p.nomeCorrida, COUNT(*) AS total_inscritos, SUM(i.valorTotalPago) AS arrecadado
FROM inscricao i
JOIN prova p ON i.idProva = p.idProva
GROUP BY p.idProva, p.nomeCorrida;

-- Arenas sem cronometragem eletronica confirmada (FALSE ou nao informado)
SELECT nomeLocal, cidade, uf, cronometragemEletronica
FROM arena
WHERE cronometragemEletronica = FALSE OR cronometragemEletronica IS NULL;

-- Todos os atletas e a ficha medica quando existir.
-- LEFT JOIN porque a ficha e opcional: com JOIN comum, quem nao
-- preencheu sumiria do resultado.
SELECT at.nomeCompleto, at.categoriaDesempenho,
       fm.nivelAptidaoFisica, fm.observacoesRestricoes
FROM atleta at
LEFT JOIN ficha_medica fm ON at.cpf = fm.cpfAtleta;

-- Atletas que ainda nao preencheram a ficha medica
SELECT at.nomeCompleto, at.email
FROM atleta at
LEFT JOIN ficha_medica fm ON at.cpf = fm.cpfAtleta
WHERE fm.cpfAtleta IS NULL;

-- Atletas de elite (categoria 8 a 10)
SELECT nomeCompleto, equipe, categoriaDesempenho
FROM atleta
WHERE categoriaDesempenho BETWEEN 8 AND 10
ORDER BY categoriaDesempenho DESC;
