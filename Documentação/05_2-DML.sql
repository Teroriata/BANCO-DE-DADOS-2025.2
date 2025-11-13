-- Consulta 1: Listar todos os produtos com suas categorias
SELECT P.NOME AS Produto, C.NOME AS Categoria
FROM PRODUTO AS P
JOIN CATEGORIA AS C ON P.ID_CATEGORIA = C.ID_CATEGORIA;  -- Relaciona o produto à sua categoria

-- Consulta 2: Contar quantos produtos existem em cada categoria
SELECT C.NOME AS Categoria, COUNT(P.ID_PRODUTO) AS Quantidade
FROM CATEGORIA AS C
LEFT JOIN PRODUTO AS P ON C.ID_CATEGORIA = P.ID_CATEGORIA  -- Inclui categorias sem produtos
GROUP BY C.NOME;  -- Agrupa para contar

-- Consulta 3: Listar todos os pedidos com o nome do cliente
SELECT 
    PD.ID_PEDIDO, 
    U.NOME AS Cliente,       -- Nome vem da tabela USUARIO
    PD.STATUS, 
    PD.VALOR_TOTAL
FROM PEDIDO AS PD
JOIN CLIENTE AS CL ON PD.ID_CLIENTE = CL.ID_CLIENTE       -- Liga pedido ao cliente
JOIN USUARIO AS U ON CL.ID_USUARIO = U.ID_USUARIO;        -- Liga cliente ao usuário

-- Consulta 4: Listar os itens do pedido 1
SELECT IP.ID_PEDIDO, P.NOME AS Produto, IP.QUANTIDADE, IP.SUBTOTAL
FROM ITEM_PEDIDO AS IP
JOIN PRODUTO AS P ON IP.ID_PRODUTO = P.ID_PRODUTO  -- Traz o nome do produto
WHERE IP.ID_PEDIDO = 1;  -- Filtra pelo pedido escolhido

-- Consulta 5: Exibir todas as avaliações com o nome do cliente
SELECT 
    A.NOTA, 
    A.COMENTARIO, 
    U.NOME AS Cliente           -- Nome vem de USUARIO
FROM AVALIACAO_PEDIDO AS A
JOIN CLIENTE AS C ON A.ID_CLIENTE = C.ID_CLIENTE   -- Relaciona avaliação ao cliente
JOIN USUARIO AS U ON C.ID_USUARIO = U.ID_USUARIO;  -- Traz o nome do cliente

-- Consulta 6: Perguntas e respostas do produto 1
SELECT 
    PR.TEXTO AS Pergunta,
    R.TEXTO AS Resposta,
    U.NOME AS Cliente
FROM PERGUNTA AS PR
LEFT JOIN RESPOSTA AS R ON PR.ID_PERGUNTA = R.ID_PERGUNTA
JOIN CLIENTE AS C ON PR.ID_CLIENTE = C.ID_CLIENTE
JOIN USUARIO AS U ON C.ID_USUARIO = U.ID_USUARIO   -- Nome vem de USUARIO
WHERE PR.ID_PRODUTO = 1;

-- Consulta 8: Listar produtos favoritos de cada cliente
SELECT 
    U.NOME AS Cliente,
    P.NOME AS Produto
FROM FAVORITO AS F
JOIN CLIENTE AS C ON F.ID_CLIENTE = C.ID_CLIENTE
JOIN USUARIO AS U ON C.ID_USUARIO = U.ID_USUARIO   -- Nome vem de USUARIO
JOIN PRODUTO AS P ON F.ID_PRODUTO = P.ID_PRODUTO;

-- Consulta 9: Total gasto por cada cliente (apenas pedidos pagos)
SELECT 
    U.NOME AS Cliente,
    SUM(PD.VALOR_TOTAL) AS TotalGasto
FROM PEDIDO AS PD
JOIN CLIENTE AS C ON PD.ID_CLIENTE = C.ID_CLIENTE
JOIN USUARIO AS U ON C.ID_USUARIO = U.ID_USUARIO   -- Nome vem de USUARIO
WHERE PD.STATUS = 'PAGO'
GROUP BY U.NOME;

------------------------------------------------------------------------------

-- Atualizar o preço de um produto específico (ex: Produto 1 - Smartphone X10)
UPDATE PRODUTO
SET PRECO = 1599.90              -- Novo valor do produto
WHERE ID_PRODUTO = 1;            -- Escolhe qual produto será alterado

-- Aumentar em 10% o preço de todos os produtos da categoria 'Eletrônicos' (ID_CATEGORIA = 1)
UPDATE PRODUTO
SET PRECO = PRECO * 1.10         -- Reajusta o preço em +10%
WHERE ID_CATEGORIA = 1;          -- Filtra apenas a categoria desejada

-- Repor estoque do produto 'Mouse Gamer' (ID_PRODUTO = 5) para 150 unidades
UPDATE PRODUTO
SET ESTOQUE = 150                -- Novo valor de estoque
WHERE ID_PRODUTO = 5;            -- Produto escolhido

-- Atualizar a descrição do livro de Banco de Dados (ID_PRODUTO = 8)
UPDATE PRODUTO
SET DESCRICAO = 'Livro completo sobre modelagem, SQL e otimização de consultas'
WHERE ID_PRODUTO = 8;            -- Produto alvo da alteração

-- Desativar um produto sem removê-lo (controle por flag ATIVO)
UPDATE PRODUTO
SET ATIVO = 'N'                  -- Marca como inativo
WHERE ID_PRODUTO = 7;            -- Exemplo: controle sem fio

-- Inserir um novo produto na categoria 'Informática' (ID_CATEGORIA = 2)
INSERT INTO PRODUTO (
    ID_PRODUTO,
    ID_CATEGORIA,
    NOME,
    DESCRICAO,
    PRECO,
    ESTOQUE,
    ATIVO
) VALUES (
    13,                                              -- Novo ID_PRODUTO
    2,                                               -- Categoria: Informática
    'Headset Gamer Surround',                        -- Nome do produto
    'Headset com som surround 7.1 e microfone',      -- Descrição
    320.00,                                          -- Preço
    40,                                              -- Estoque inicial
    'S'                                              -- Ativo
);

-- excluir o produto 13 e todos os vínculos relacionados

-- 1) Remove favoritos vinculados ao produto
DELETE FROM FAVORITO
WHERE ID_PRODUTO = 13;

-- 2) Remove itens de carrinho com esse produto
DELETE FROM ITEM_CARRINHO
WHERE ID_PRODUTO = 13;

-- 3) Remove itens de pedido com esse produto (se permitido pela regra de negócio)
DELETE FROM ITEM_PEDIDO
WHERE ID_PRODUTO = 13;

-- 4) Remove ficha técnica do produto
DELETE FROM FICHA_TECNICA
WHERE ID_PRODUTO = 13;

-- 5) Remove imagens do produto
DELETE FROM IMAGEM
WHERE ID_PRODUTO = 13;

-- 6) Finalmente, remove o registro do produto
DELETE FROM PRODUTO
WHERE ID_PRODUTO = 13;

------------------------------------------------------------------------------

-- Incrementar a quantidade de um item no carrinho (ID_CARRINHO = 1, PRODUTO = 5)
UPDATE ITEM_CARRINHO
SET QUANTIDADE = QUANTIDADE + 1,
    PRECO_UNITARIO = 120.00     -- Se quiser manter o mesmo valor
WHERE ID_CARRINHO = 1 AND ID_PRODUTO = 5;

-- Remover até 1000 avaliações com nota menor que 3
DELETE FROM AVALIACAO_PEDIDO
WHERE NOTA < 3
LIMIT 1000;

-- Inserir o cliente 6 vinculado ao usuário 10
INSERT INTO CLIENTE (ID_CLIENTE, ID_USUARIO, CPF, TELEFONE, DATA_NASCIMENTO)
VALUES (6, 10, '77788899900', '11955554444', '1994-06-20');

-- Agora sim, adicionar o endereço para o cliente 6
INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, LOGRADOURO, NUMERO, BAIRRO, CIDADE, UF, CEP)
VALUES (6, 6, 'Rua Nova Esperança', '210', 'Centro', 'São Paulo', 'SP', '01020000');

-- Inserir uma nova forma de pagamento
INSERT INTO FORMA_PAGAMENTO (ID_FORMA_PAGAMENTO, DESCRICAO, ATIVO)
VALUES (6, 'Pagamento na Entrega', 'S');

-- Alterar o status de um pedido para 'ENTREGUE'
UPDATE PEDIDO
SET STATUS = 'ENTREGUE'
WHERE ID_PEDIDO = 3;

-- Alterar o email de um usuário específico
UPDATE USUARIO
SET EMAIL = 'novo.email@exemplo.com'
WHERE ID_USUARIO = 3;

------------------------------------------------------------------------------

-- Mostrar usuários com o nome do perfil associado
SELECT 
    U.ID_USUARIO,
    U.NOME AS Usuario,
    U.EMAIL,
    P.NOME AS Perfil
FROM USUARIO U
JOIN PERFIL P ON U.ID_PERFIL = P.ID_PERFIL;

-- Listar todos os produtos ativos
SELECT ID_PRODUTO, NOME, PRECO, ESTOQUE
FROM PRODUTO
WHERE ATIVO = 'S';

-- Mostrar o carrinho e seus itens (carrinho 1)
SELECT 
    IC.ID_PRODUTO,
    P.NOME,
    IC.QUANTIDADE,
    IC.PRECO_UNITARIO
FROM ITEM_CARRINHO IC
JOIN PRODUTO P ON IC.ID_PRODUTO = P.ID_PRODUTO
WHERE IC.ID_CARRINHO = 1;

-- Listar produtos mais caros primeiro
SELECT ID_PRODUTO, NOME, PRECO
FROM PRODUTO
ORDER BY PRECO DESC;

-- Remover linha null
DELETE FROM PRODUTO
WHERE ID_PRODUTO IS NULL;

-- Ver todos os produtos sem estoque
SELECT ID_PRODUTO, NOME, ESTOQUE
FROM PRODUTO
WHERE ESTOQUE = 0;


