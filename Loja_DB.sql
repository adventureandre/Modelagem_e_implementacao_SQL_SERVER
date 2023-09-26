-- DROP SCHEMA dbo;
--Olhe se ja tem criado o Schema
CREATE SCHEMA dbo;


-- Drop table

-- DROP TABLE Loja.dbo.pessoas;

CREATE TABLE pessoas (
	id_pessoa int IDENTITY(0,1) NOT NULL,
	nome varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	endereco varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	cidade varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	telefone varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	email varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT pessoas_PK PRIMARY KEY (id_pessoa)
);




-- DROP TABLE Loja.dbo.produto;

CREATE TABLE produto (
	id_produto int IDENTITY(0,1) NOT NULL,
	nome varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	quantidade int NOT NULL,
	precoVenda decimal(10,2) NOT NULL,
	CONSTRAINT produto_PK PRIMARY KEY (id_produto)
);




-- DROP TABLE Loja.dbo.usuario;

CREATE TABLE usuario (
	id_usuario int IDENTITY(0,1) NOT NULL,
	[login] varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	senha varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT usuario_PK PRIMARY KEY (id_usuario)
);




-- DROP TABLE Loja.dbo.pessoa_fisica;

CREATE TABLE pessoa_fisica (
	id_pessoa int NOT NULL,
	cpf varchar(14) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT pessoa_fisica_FK FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);




-- DROP TABLE Loja.dbo.pessoa_juridica;

CREATE TABLE pessoa_juridica (
	id_pessoa int NOT NULL,
	cnpj varchar(18) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT pessoa_juridica_FK FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE
);




-- DROP TABLE Loja.dbo.movimento;

CREATE TABLE movimento (
	id_movimento int IDENTITY(0,1) NOT NULL,
	id_usuario int NOT NULL,
	id_pessoa int NOT NULL,
	id_produto int NOT NULL,
	quantidade int NOT NULL,
	tipo varchar(1) COLLATE Latin1_General_CI_AS NOT NULL,
	valorUnitario decimal(10,2) NOT NULL,
	CONSTRAINT movimento_PK PRIMARY KEY (id_movimento),
	CONSTRAINT movimento_FK FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT movimento_FK_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT movimento_FK_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);
