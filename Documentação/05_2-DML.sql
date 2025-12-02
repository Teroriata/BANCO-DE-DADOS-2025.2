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

------------------------------------------------------------------------------

-- Produtos ativos com categoria e estoque
SELECT 
    p.ID_PRODUTO,
    p.NOME        AS NOME_PRODUTO,
    c.NOME        AS CATEGORIA,
    p.PRECO,
    p.ESTOQUE
FROM PRODUTO AS p
JOIN CATEGORIA AS c
  ON c.ID_CATEGORIA = p.ID_CATEGORIA
WHERE p.ATIVO = 'S'
ORDER BY c.NOME, p.NOME;

-- Produtos sem estoque ou inativos
SELECT 
    p.ID_PRODUTO,
    p.NOME,
    p.PRECO,
    p.ESTOQUE,
    p.ATIVO
FROM PRODUTO AS p
WHERE p.ESTOQUE = 0
   OR p.ATIVO = 'N'
ORDER BY p.ATIVO, p.ESTOQUE;


-- Clientes com dados de usuário (nome e e-mail)
SELECT 
    cl.ID_CLIENTE,
    u.NOME  AS NOME_USUARIO,
    u.EMAIL,
    cl.CPF,
    cl.TELEFONE
FROM CLIENTE AS cl
JOIN USUARIO AS u
  ON u.ID_USUARIO = cl.ID_USUARIO
ORDER BY u.NOME;

-- Pedidos de um cliente específico (por e-mail)
SELECT
    p.ID_PEDIDO,
    p.DATA_PEDIDO,
    p.STATUS,
    p.VALOR_TOTAL
FROM PEDIDO AS p
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = p.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
WHERE u.EMAIL = 'cliente@exemplo.com'
ORDER BY p.DATA_PEDIDO DESC;

------------------------------------------------------------------------------
-- Funções de texto, data e numéricas
--Listar usuários com e-mail em minúsculas e data formatada
SELECT
    u.ID_USUARIO,
    UPPER(u.NOME)                    AS NOME_MAIUSCULO,
    LOWER(u.EMAIL)                   AS EMAIL_MINUSCULO,
    DATE_FORMAT(u.DATA_CADASTRO, '%d/%m/%Y %H:%i') AS DATA_CADASTRO_FORMATADA
FROM USUARIO AS u;

-- Pegar domínio de e-mail dos usuários (ex: gmail.com)
SELECT
    u.ID_USUARIO,
    u.EMAIL,
    SUBSTRING_INDEX(u.EMAIL, '@', -1) AS DOMINIO_EMAIL
FROM USUARIO AS u;

-- Calculando idade aproximada dos clientes
SELECT
    c.ID_CLIENTE,
    u.NOME AS NOME_CLIENTE,
    c.DATA_NASCIMENTO,
    TIMESTAMPDIFF(YEAR, c.DATA_NASCIMENTO, CURDATE()) AS IDADE
FROM CLIENTE AS c
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
WHERE c.DATA_NASCIMENTO IS NOT NULL;

------------------------------------------------------------------------------
-- JOINs
-- Detalhes de pedido com itens e produto
SELECT
    p.ID_PEDIDO,
    p.DATA_PEDIDO,
    p.STATUS,
    pr.NOME        AS PRODUTO,
    ip.QUANTIDADE,
    ip.PRECO_UNITARIO,
    ip.SUBTOTAL
FROM PEDIDO AS p
JOIN ITEM_PEDIDO AS ip
  ON ip.ID_PEDIDO = p.ID_PEDIDO
JOIN PRODUTO AS pr
  ON pr.ID_PRODUTO = ip.ID_PRODUTO
ORDER BY p.ID_PEDIDO, pr.NOME;

-- Pedidos com cliente, endereço e forma de pagamento
SELECT
    p.ID_PEDIDO,
    u.NOME                  AS CLIENTE,
    p.DATA_PEDIDO,
    p.STATUS,
    p.VALOR_TOTAL,
    e.LOGRADOURO,
    e.NUMERO,
    e.CIDADE,
    e.UF,
    f.DESCRICAO             AS FORMA_PAGAMENTO
FROM PEDIDO AS p
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = p.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
JOIN ENDERECO AS e
  ON e.ID_ENDERECO = p.ID_ENDERECO
JOIN FORMA_PAGAMENTO AS f
  ON f.ID_FORMA_PAGAMENTO = p.ID_FORMA_PAGAMENTO
ORDER BY p.DATA_PEDIDO DESC;

-- Perguntas de clientes e respectivas respostas com funcionário
SELECT
    pe.ID_PERGUNTA,
    ucli.NOME          AS CLIENTE,
    pr.NOME            AS PRODUTO,
    pe.TEXTO           AS PERGUNTA,
    pe.DATA_PERGUNTA,
    r.TEXTO            AS RESPOSTA,
    ur.NOME            AS FUNCIONARIO,
    r.DATA_RESPOSTA
FROM PERGUNTA AS pe
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = pe.ID_CLIENTE
JOIN USUARIO AS ucli
  ON ucli.ID_USUARIO = c.ID_USUARIO
JOIN PRODUTO AS pr
  ON pr.ID_PRODUTO = pe.ID_PRODUTO
LEFT JOIN RESPOSTA AS r
  ON r.ID_PERGUNTA = pe.ID_PERGUNTA
LEFT JOIN FUNCIONARIO AS f
  ON f.ID_FUNCIONARIO = r.ID_FUNCIONARIO
LEFT JOIN USUARIO AS ur
  ON ur.ID_USUARIO = f.ID_USUARIO
ORDER BY pe.DATA_PERGUNTA DESC;

------------------------------------------------------------------------------
-- Agregações, GROUP BY e HAVING
-- Total de vendas por dia (últimos 30 dias)
SELECT
    p.DATA_PEDIDO,
    SUM(p.VALOR_TOTAL) AS TOTAL_DIA,
    COUNT(*)            AS QTDE_PEDIDOS
FROM PEDIDO AS p
WHERE p.DATA_PEDIDO >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY p.DATA_PEDIDO
ORDER BY p.DATA_PEDIDO;

-- Top 5 produtos mais vendidos (por quantidade)
SELECT
    pr.ID_PRODUTO,
    pr.NOME,
    SUM(ip.QUANTIDADE) AS QTDE_TOTAL
FROM ITEM_PEDIDO AS ip
JOIN PRODUTO AS pr
  ON pr.ID_PRODUTO = ip.ID_PRODUTO
GROUP BY pr.ID_PRODUTO, pr.NOME
ORDER BY QTDE_TOTAL DESC
LIMIT 5;

-- Clientes com mais de 5 pedidos
SELECT
    c.ID_CLIENTE,
    u.NOME AS NOME_CLIENTE,
    COUNT(*) AS QTDE_PEDIDOS
FROM PEDIDO AS p
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = p.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
GROUP BY c.ID_CLIENTE, u.NOME
HAVING COUNT(*) > 5
ORDER BY QTDE_PEDIDOS DESC;

-- Ticket médio por cliente (média de valor_total)
SELECT
    c.ID_CLIENTE,
    u.NOME AS NOME_CLIENTE,
    COUNT(p.ID_PEDIDO)      AS QTDE_PEDIDOS,
    SUM(p.VALOR_TOTAL)      AS SOMA_COMPRAS,
    AVG(p.VALOR_TOTAL)      AS TICKET_MEDIO
FROM PEDIDO AS p
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = p.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
GROUP BY c.ID_CLIENTE, u.NOME
ORDER BY TICKET_MEDIO DESC;

------------------------------------------------------------------------------
-- Subqueries (EXISTS, NOT EXISTS, IN)
-- Clientes sem nenhum pedido (cadastros “ociosos”)
SELECT
    c.ID_CLIENTE,
    u.NOME,
    u.EMAIL
FROM CLIENTE AS c
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
WHERE NOT EXISTS (
    SELECT 1
    FROM PEDIDO AS p
    WHERE p.ID_CLIENTE = c.ID_CLIENTE
);

-- Produtos favoritados, mas nunca comprados pelo mesmo cliente
SELECT
    f.ID_CLIENTE,
    u.NOME AS NOME_CLIENTE,
    pr.ID_PRODUTO,
    pr.NOME AS NOME_PRODUTO
FROM FAVORITO AS f
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = f.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO
JOIN PRODUTO AS pr
  ON pr.ID_PRODUTO = f.ID_PRODUTO
WHERE NOT EXISTS (
    SELECT 1
    FROM PEDIDO AS p
    JOIN ITEM_PEDIDO AS ip
      ON ip.ID_PEDIDO = p.ID_PEDIDO
    WHERE p.ID_CLIENTE = f.ID_CLIENTE
      AND ip.ID_PRODUTO = f.ID_PRODUTO
);

-- Produtos que nunca foram vendidos
SELECT
    p.ID_PRODUTO,
    p.NOME,
    p.PRECO,
    p.ESTOQUE
FROM PRODUTO AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM ITEM_PEDIDO AS ip
    WHERE ip.ID_PRODUTO = p.ID_PRODUTO
);

-- Produtos com valor acima da média de todos os produtos
SELECT
    p.ID_PRODUTO,
    p.NOME,
    p.PRECO
FROM PRODUTO AS p
WHERE p.PRECO > (
    SELECT AVG(PRECO) FROM PRODUTO
)
ORDER BY p.PRECO DESC;

------------------------------------------------------------------------------
--UNION e conjuntos
-- Clientes que já avaliaram algum pedido OU já fizeram perguntas (sem repetir)
-- Clientes que avaliaram pedidos
SELECT
    c.ID_CLIENTE,
    u.NOME,
    u.EMAIL,
    'AVALIACAO' AS TIPO_INTERACAO
FROM AVALIACAO_PEDIDO AS ap
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = ap.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO

UNION

-- Clientes que fizeram perguntas
SELECT
    c.ID_CLIENTE,
    u.NOME,
    u.EMAIL,
    'PERGUNTA' AS TIPO_INTERACAO
FROM PERGUNTA AS pe
JOIN CLIENTE AS c
  ON c.ID_CLIENTE = pe.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = c.ID_USUARIO;

-- Valor total de cada carrinho em aberto
SELECT
    c.ID_CARRINHO,
    cli.ID_CLIENTE,
    u.NOME AS NOME_CLIENTE,
    c.DATA_CRIACAO,
    c.STATUS,
    SUM(ic.QUANTIDADE * ic.PRECO_UNITARIO) AS VALOR_TOTAL_CARRINHO
FROM CARRINHO AS c
JOIN CLIENTE AS cli
  ON cli.ID_CLIENTE = c.ID_CLIENTE
JOIN USUARIO AS u
  ON u.ID_USUARIO = cli.ID_USUARIO
LEFT JOIN ITEM_CARRINHO AS ic
  ON ic.ID_CARRINHO = c.ID_CARRINHO
WHERE c.STATUS = 'ABERTO'
GROUP BY c.ID_CARRINHO, cli.ID_CLIENTE, u.NOME, c.DATA_CRIACAO, c.STATUS
ORDER BY c.DATA_CRIACAO;

-- Avaliação de pedidos por produto (média de nota)
SELECT
    pr.ID_PRODUTO,
    pr.NOME AS NOME_PRODUTO,
    AVG(ap.NOTA) AS MEDIA_NOTA,
    COUNT(DISTINCT ap.ID_AVALIACAO) AS QTDE_AVALIACOES
FROM AVALIACAO_PEDIDO AS ap
JOIN PEDIDO AS p
  ON p.ID_PEDIDO = ap.ID_PEDIDO
JOIN ITEM_PEDIDO AS ip
  ON ip.ID_PEDIDO = p.ID_PEDIDO
JOIN PRODUTO AS pr
  ON pr.ID_PRODUTO = ip.ID_PRODUTO
GROUP BY pr.ID_PRODUTO, pr.NOME
ORDER BY MEDIA_NOTA DESC;
