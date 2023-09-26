-- inserindo pessoas fisica
INSERT INTO pessoas (nome, endereco, cidade, telefone, email)
VALUES ('André', 'Rua prof julita', 'Leopoldo de Bulhoes', '62996106990', 'adventureandre@hotmail.com');

INSERT INTO pessoa_fisica (id_pessoa, cpf)
VALUES (SCOPE_IDENTITY(), '15687456947');






-- inserindo pessoa juridica
INSERT INTO pessoas (nome, endereco, cidade, telefone, email)
VALUES ('ALFA', 'Rua prof julita', 'Leopoldo de Bulhoes', '33371570', 'admin@funilariaepintura.com.br');

INSERT INTO pessoa_juridica  (id_pessoa, cnpj)
VALUES (SCOPE_IDENTITY(), '4545540001-78');


-- inserindo pessoa juridica
INSERT INTO pessoas (nome, endereco, cidade, telefone, email)
VALUES ('JJC', 'Rua pedro loduvico', 'Anapolis', '33370000', 'admin@JJC.com.br');

INSERT INTO pessoa_juridica  (id_pessoa, cnpj)
VALUES (SCOPE_IDENTITY(), '77885550001-78');




--inserindo Produto
INSERT INTO produto
(nome, quantidade, precoVenda)
VALUES('Banana', 100, 5.00);

--inserindo Produto
INSERT INTO produto
(nome, quantidade, precoVenda)
VALUES('laranja', 500, 4.50);

--inserindo Produto
INSERT INTO produto
(nome, quantidade, precoVenda)
VALUES('uva', 20, 50.00);

--inserindo Produto
INSERT INTO produto
(nome, quantidade, precoVenda)
VALUES('ameixa', 40, 18.25);





--inserindo usuario
INSERT INTO usuario
([login], senha)
VALUES('op1', 'op1');

--inserindo usuario
INSERT INTO usuario
([login], senha)
VALUES('op2', 'op2');






-- Inserir uma entrada (E)
INSERT INTO movimento (id_usuario, id_pessoa, id_produto, quantidade, tipo, valorUnitario)
VALUES (0, 4, 0, 15, 'E', 10.00);

-- Inserir uma saída (S)
INSERT INTO movimento (id_usuario, id_pessoa, id_produto, quantidade, tipo, valorUnitario)
VALUES (0, 2, 2, 2, 'S', 15.00);

-- Inserir uma entrada (E)
INSERT INTO movimento (id_usuario, id_pessoa, id_produto, quantidade, tipo, valorUnitario)
VALUES (1, 1, 3, 9, 'E', 20.00);

-- Inserir uma saída (S)
INSERT INTO movimento (id_usuario, id_pessoa, id_produto, quantidade, tipo, valorUnitario)
VALUES (1, 3, 1, 2, 'S', 10.00);





--Consultas
--Dados completo de pessoas fisicas
SELECT p.*, pf.cpf
FROM pessoas p
INNER JOIN pessoa_fisica pf ON p.id_pessoa = pf.id_pessoa;


--Dados completo de Uma pessoa especifica
SELECT p.*, pf.cpf
FROM pessoas p
INNER JOIN pessoa_fisica pf ON p.id_pessoa = pf.id_pessoa
WHERE p.id_pessoa = 1;






--Consultas
--Dados completo de pessoas juridica
SELECT p.*, pj.cnpj 
FROM pessoas p
INNER JOIN pessoa_juridica pj ON p.id_pessoa = pj.id_pessoa ;








--Consultas
--Dados da movimentação e junta eles criando um total 
-- Consulta para entradas (tipo 'E')
SELECT 
    m.id_movimento,
    pr.nome AS nome_produto,
    p.nome AS nome_fornecedor,
    m.quantidade,
    m.valorUnitario,
    (m.quantidade * m.valorUnitario) AS valor_total
FROM movimento m
INNER JOIN produto pr ON m.id_produto = pr.id_produto
INNER JOIN pessoa_juridica pj ON m.id_pessoa = pj.id_pessoa
INNER JOIN pessoas p ON pj.id_pessoa = p.id_pessoa
WHERE m.tipo = 'E';


-- Consulta para saídas (tipo 'S')
SELECT 
    m.id_movimento,
    pr.nome AS nome_produto,
    p.nome AS nome_fornecedor,
    m.quantidade,
    m.valorUnitario,
    (m.quantidade * m.valorUnitario) AS valor_total
FROM movimento m
INNER JOIN produto pr ON m.id_produto = pr.id_produto
INNER JOIN pessoa_fisica pf ON m.id_pessoa = pf.id_pessoa
INNER JOIN pessoas p ON pf.id_pessoa = p.id_pessoa
WHERE m.tipo = 'S';







-- Valor total das entradas agrupadas por produto
SELECT 
    m.id_produto,
    pr.nome AS nome_produto,
    SUM(m.quantidade * m.valorUnitario) AS valor_total_entradas
FROM movimento m
INNER JOIN produto pr ON m.id_produto = pr.id_produto
WHERE m.tipo = 'E'
GROUP BY m.id_produto, pr.nome;




-- Valor total das saídas agrupadas por produto
SELECT 
    m.id_produto,
    pr.nome AS nome_produto,
    SUM(m.quantidade * m.valorUnitario) AS valor_total_saidas
FROM movimento m
INNER JOIN produto pr ON m.id_produto = pr.id_produto
WHERE m.tipo = 'S'
GROUP BY m.id_produto, pr.nome;




-- Operadores que não efetuaram movimentações de entrada (compra)
SELECT u.id_usuario, u.login
FROM usuario u
LEFT JOIN movimento m ON u.id_usuario = m.id_usuario AND m.tipo = 'E'
WHERE m.id_movimento IS NULL;



-- Valor total de entrada, agrupado por operador
SELECT 
    u.id_usuario,
    u.login AS nome_operador,
    SUM(m.quantidade * m.valorUnitario) AS valor_total_entrada
FROM usuario u
LEFT JOIN movimento m ON u.id_usuario = m.id_usuario AND m.tipo = 'E'
GROUP BY u.id_usuario, u.login;



-- Valor total de saída, agrupado por operador
SELECT 
    u.id_usuario,
    u.login AS nome_operador,
    SUM(m.quantidade * m.valorUnitario) AS valor_total_saida
FROM usuario u
LEFT JOIN movimento m ON u.id_usuario = m.id_usuario AND m.tipo = 'S'
GROUP BY u.id_usuario, u.login;


-- Valor médio de venda por produto (média ponderada)
SELECT 
    p.id_produto,
    p.nome AS nome_produto,
    SUM(m.quantidade * m.valorUnitario) / SUM(m.quantidade) AS valor_medio_venda
FROM produto p
INNER JOIN movimento m ON p.id_produto = m.id_produto
WHERE m.tipo = 'S'
GROUP BY p.id_produto, p.nome;



