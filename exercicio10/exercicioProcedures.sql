-- Exercícios Procedures e Functions - Cantina
-- Escreva cada resolução no espaço abaixo da questão correspondente.
-- Lembre-se: use DELIMITER $$ para criar procedures/functions e volte com DELIMITER ; ao final.

DROP DATABASE IF EXISTS cantina;
CREATE DATABASE cantina;
USE cantina;

-- Considere a seguinte tabela:

CREATE TABLE Produto (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nome VARCHAR(45) NOT NULL,
	categoria VARCHAR(45) NOT NULL,
	preco DECIMAL(8,2) NOT NULL,
	estoque INT NOT NULL
);

-- Inserir produtos
INSERT INTO Produto (nome, categoria, preco, estoque) VALUES
('Coxinha', 'Salgado', 6.50, 30),
('Pastel', 'Salgado', 8.00, 8),
('Suco Natural', 'Bebida', 7.00, 20),
('Refrigerante', 'Bebida', 5.50, 5),
('Pão de Queijo', 'Salgado', 4.00, 40),
('Brownie', 'Doce', 9.00, 12);

-- ================= PARTE 1: PROCEDURES =================

-- Questão 1:
-- Crie uma procedure chamada AplicarDesconto que receba o id de um produto e um
-- percentual de desconto e reduza o preço desse produto de acordo com o percentual.
-- Ao final, a procedure deve exibir a mensagem 'Desconto aplicado!' como Resultado.
-- Depois, chame a procedure para dar 10% de desconto na Coxinha (id 1) e confira o preço.
-- (Dica: o nome do parâmetro não pode ser igual ao nome da coluna, senão WHERE id = id
-- é sempre verdadeiro e altera todas as linhas.)

DELIMITER $$
CREATE PROCEDURE AplicarDesconto(IN p_id INT, IN p_percentual DECIMAL(5,2))
BEGIN
    UPDATE Produto
    SET preco = preco - (preco * p_percentual / 100)
    WHERE id = p_id;

    SELECT 'Desconto aplicado!' AS Resultado;
END $$
DELIMITER ;

CALL AplicarDesconto(1, 10);
SELECT * FROM Produto WHERE id = 1;

-- Questão 2:
-- Crie uma procedure chamada ReporEstoque que receba o id de um produto e uma
-- quantidade e some essa quantidade ao estoque do produto.
-- Depois, reponha 20 unidades do Refrigerante (id 4) e confira o estoque.


DELIMITER $$
CREATE PROCEDURE ReporEstoque(IN p_id INT, IN p_quantidade INT)
BEGIN
    UPDATE Produto
    SET estoque = estoque + p_quantidade
    WHERE id = p_id;
END $$
DELIMITER ;

CALL ReporEstoque(4, 20);
SELECT * FROM Produto WHERE id = 4;
-- ================= PARTE 2: FUNCTIONS =================

-- Questão 3:
-- Crie uma function chamada ValorEmEstoque que receba o preço e a quantidade de
-- um produto e retorne o valor total (preço x quantidade).
-- Depois, use-a em um SELECT para mostrar o nome de cada produto e seu valor em estoque.
DELIMITER $$
CREATE FUNCTION ValorEmEstoque(p_preco DECIMAL(8,2), p_quantidade INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_preco * p_quantidade;
END $$
DELIMITER ;

SELECT nome, ValorEmEstoque(preco, estoque) AS valor_em_estoque
FROM Produto;


-- Questão 4 (Desafio):
-- Crie uma function chamada SituacaoEstoque que receba uma quantidade e retorne
-- 'Baixo' se ela for menor que 10 e 'Ok' caso contrário.
-- Depois, use-a em um SELECT para mostrar o nome, o estoque e a situação de cada produto.
DELIMITER $$
CREATE FUNCTION SituacaoEstoque(p_quantidade INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF p_quantidade < 10 THEN
        RETURN 'Baixo';
    ELSE
        RETURN 'Ok';
    END IF;
END $$
DELIMITER ;

SELECT nome, estoque, SituacaoEstoque(estoque) AS situacao
FROM Produto;

-- ================= LIMPEZA =================

-- Questão 6:
-- Apague todas as procedures e functions criadas neste exercício.

DROP PROCEDURE IF EXISTS AplicarDesconto;
DROP PROCEDURE IF EXISTS ReporEstoque;
DROP FUNCTION IF EXISTS ValorEmEstoque;
DROP FUNCTION IF EXISTS SituacaoEstoque;
