CREATE DATABASE Papiro_Desaparecido;
use Papiro_Desaparecido;

CREATE TABLE membros_expedicao(
	id  INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    anos_experiencia INT CHECK(anos_experiencia>=0),
    funcao VARCHAR(50),
    universidade VARCHAR(60),
    estava_na_tenda_principal BOOLEAN,
    horario_visto TIME,
	testemunha_confirmada BOOLEAN,
	pistas_encontradas INT CHECK(pistas_encontradas>=0),
    grau_desconfianca ENUM('BAIXO','MEDIO','ALTO','CRITICO')
);

INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Arthur Pendelton', 22,'Arqueologo Chefe', 'Oxford', TRUE, '22:45', TRUE, 0, 'BAIXO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Elena Rostova', 12, 'Restauradora','Sorbonne',TRUE,'22:45',FALSE,2,'ALTO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Tariq Al-Mansoor', 8, 'Guia Local','Cairo University',False,'21:30',TRUE,'0','BAIXO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Lucas Silva', 3, 'Assistente de Campo','USP',TRUE,'22:50',FALSE,1,'MEDIO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Beatriz Mendes', 5, 'Epigrafista','Coimbra',FALSE,'20:15',TRUE,0,'BAIXO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Hans Gruber', 18, 'Historiador','Heidelberg',TRUE,'22:40',FALSE,3,'CRITICO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Amira Hassan', 10, 'Fotografa Documentarista','Cairo University',FALSE,'23:10',TRUE,0,'BAIXO');
INSERT INTO membros_expedicao (nome, anos_experiencia,funcao,universidade,estava_na_tenda_principal, horario_visto, testemunha_confirmada, pistas_encontradas, grau_desconfianca) VALUES('Mateo Benitez', 2, 'Estagiario de Conservacao','Madrid',TRUE,'22:35',TRUE,0,'MEDIO');


UPDATE membros_expedicao SET grau_desconfianca = 'ALTO' WHERE id = 4;
UPDATE membros_expedicao SET universidade = 'Cambridge' WHERE nome = 'Elena Rostova';
UPDATE membros_expedicao SET grau_desconfianca = 'CRITICO' WHERE id = 6;


DELETE FROM membros_expedicao WHERE id = 7;
DELETE FROM membros_expedicao WHERE grau_desconfianca = 'Baixo';

SELECT * FROM membros_expedicao;
SELECT nome, funcao FROM membros_expedicao;
SELECT * FROM membros_expedicao ORDER BY anos_experiencia DESC;

SELECT * FROM membros_expedicao WHERE estava_na_tenda_principal = TRUE;
SELECT * FROM membros_expedicao WHERE grau_desconfianca = 'ALTO' OR grau_desconfianca = 'CRITICO';
SELECT * FROM MEMBROS_EXPEDICAO WHERE anos_experiencia BETWEEN 5 AND 20;

SELECT * FROM membros_expedicao WHERE nome Like 'A%';
SELECT * FROM membros_expedicao WHERE nome LIKE '%o';
SELECT * FROM membros_expedicao WHERE funcao LIKE '%Arqueologo%' OR funcao LIKE '%Assistente%';

SELECT * FROM membros_expedicao WHERE universidade IN ('Oxford', 'Cambridge', 'USP');
SELECT * FROM membros_expedicao WHERE grau_desconfianca IN ('MEDIO', 'ALTO', 'CRITICO');

SELECT COUNT(*) AS total_membros FROM membros_expedicao;
SELECT SUM(pistas_encontradas) AS total_pistas FROM membros_expedicao;

SELECT universidade, COUNT(*) AS quantidade FROM membros_expedicao GROUP BY universidade;
SELECT grau_desconfianca, COUNT(*) AS quantidade FROM membros_expedicao GROUP BY grau_desconfianca;

SELECT * FROM membros_expedicao WHERE estava_na_tenda_principal = TRUE
  AND testemunha_confirmada = FALSE
  AND grau_desconfianca = 'CRITICO'
  AND pistas_encontradas >= 1
  AND (nome LIKE 'E%' OR nome LIKE 'H%');