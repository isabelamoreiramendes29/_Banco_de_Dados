DROP DATABASE IF EXISTS agencia_db;
CREATE DATABASE IF NOT EXISTS agencia_db;
use agencia_db;

CREATE TABLE agente(
	id  UNIQUE, AUTO_INCREMENT,
    codinome VARCHAR(20),
    nome_real VARCHAR(30),
    especialidade VARCHAR(40),
    pais_alocacao VARCHAR(50),
    ano_recrutamento INT, NOT NULL,
    data_ultima_missao DATE,
	orcamento_missao DECIMAL(10,2),
	em_servico_ativo BOOLEAN  DEFAULT TRUE, 
);

ALTER TABLE agente ADD nivel_acesso INT;
ALTER TABLE agente ADD contato_emergencia VARCHAR(80);
ALTER TABLE agente MODIFY codinome VARCHAR(60);
ALTER TABLE agente MODIFY pais_alocacao VARCHAR(80);
ALTER TABLE agente DROP COLUMN nome_real;
