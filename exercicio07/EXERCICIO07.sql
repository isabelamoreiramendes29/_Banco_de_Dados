DROP DATABASE IF EXISTS Ecommerce;
CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

CREATE TABLE IF NOT EXISTS produto(
id INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(400) NOT NULL,
 preco DECIMAL(10,2) NOT NULL,
 estoque INT NOT NULL,
 descricao TEXT
 );
 
 DROP USER IF EXISTS 'dev_junior'@'%', 'vendedor_1';
 DROP ROLE IF EXISTS 'role_venda';

 CREATE USER  'dev_junior'@'%';
 GRANT SELECT on Ecommerce.* TO 'dev_junior';
 GRANT INSERT on Ecommerce.produto TO 'dev_junior';
 REVOKE INSERT ON Ecommerce.produto FROM 'dev_junior';

 CREATE ROLE 'role_venda';
 GRANT SELECT (nome,preco) ON Ecommerce.produto TO 'role_venda';
 CREATE USER 'vendedor_1';
 GRANT 'role_venda' TO 'vendedor_1';
 