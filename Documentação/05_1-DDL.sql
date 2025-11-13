-- Certifique-se de estar no banco certo:
-- USE seu_banco;
create database mind;
------------------------------------------------------------
-- 1) PERFIL
------------------------------------------------------------
CREATE TABLE PERFIL (
    ID_PERFIL   INT           NOT NULL PRIMARY KEY,
    NOME        VARCHAR(50)   NOT NULL,
    DESCRICAO   VARCHAR(255)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 2) USUARIO
------------------------------------------------------------
CREATE TABLE USUARIO (
    ID_USUARIO     INT            NOT NULL PRIMARY KEY,
    ID_PERFIL      INT            NOT NULL,
    NOME           VARCHAR(100)   NOT NULL,
    EMAIL          VARCHAR(100)   NOT NULL UNIQUE,
    SENHA          VARCHAR(255)   NOT NULL,
    DATA_CADASTRO  DATETIME       DEFAULT CURRENT_TIMESTAMP,
    ATIVO          CHAR(1)        NOT NULL DEFAULT 'S',

    CONSTRAINT FK_USUARIO_PERFIL
        FOREIGN KEY (ID_PERFIL)
        REFERENCES PERFIL (ID_PERFIL)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 3) PERMISSAO
------------------------------------------------------------
CREATE TABLE PERMISSAO (
    ID_PERMISSAO  INT           NOT NULL PRIMARY KEY,
    ID_PERFIL     INT           NOT NULL,
    NOME          VARCHAR(50)   NOT NULL,
    DESCRICAO     VARCHAR(255),

    CONSTRAINT FK_PERMISSAO_PERFIL
        FOREIGN KEY (ID_PERFIL)
        REFERENCES PERFIL (ID_PERFIL)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 4) CLIENTE
------------------------------------------------------------
CREATE TABLE CLIENTE (
    ID_CLIENTE      INT          NOT NULL PRIMARY KEY,
    ID_USUARIO      INT          NOT NULL,
    CPF             CHAR(11)     UNIQUE,
    TELEFONE        VARCHAR(20),
    DATA_NASCIMENTO DATE,

    CONSTRAINT FK_CLIENTE_USUARIO
        FOREIGN KEY (ID_USUARIO)
        REFERENCES USUARIO (ID_USUARIO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 5) FUNCIONARIO
------------------------------------------------------------
CREATE TABLE FUNCIONARIO (
    ID_FUNCIONARIO  INT           NOT NULL PRIMARY KEY,
    ID_USUARIO      INT           NOT NULL,
    CARGO           VARCHAR(50),
    SALARIO         DECIMAL(10,2),
    DATA_ADMISSAO   DATE,

    CONSTRAINT FK_FUNCIONARIO_USUARIO
        FOREIGN KEY (ID_USUARIO)
        REFERENCES USUARIO (ID_USUARIO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 6) ENDERECO
------------------------------------------------------------
CREATE TABLE ENDERECO (
    ID_ENDERECO   INT            NOT NULL PRIMARY KEY,
    ID_CLIENTE    INT            NOT NULL,
    LOGRADOURO    VARCHAR(150)   NOT NULL,
    NUMERO        VARCHAR(10)    NOT NULL,
    COMPLEMENTO   VARCHAR(50),
    BAIRRO        VARCHAR(80)    NOT NULL,
    CIDADE        VARCHAR(80)    NOT NULL,
    UF            CHAR(2)        NOT NULL,
    CEP           CHAR(8)        NOT NULL,

    CONSTRAINT FK_ENDERECO_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 7) FORMA_PAGAMENTO
------------------------------------------------------------
CREATE TABLE FORMA_PAGAMENTO (
    ID_FORMA_PAGAMENTO INT          NOT NULL PRIMARY KEY,
    DESCRICAO          VARCHAR(50)  NOT NULL,
    ATIVO              CHAR(1)      NOT NULL DEFAULT 'S'
) ENGINE=InnoDB;

------------------------------------------------------------
-- 8) CATEGORIA
------------------------------------------------------------
CREATE TABLE CATEGORIA (
    ID_CATEGORIA  INT            NOT NULL PRIMARY KEY,
    NOME          VARCHAR(100)   NOT NULL,
    DESCRICAO     VARCHAR(255)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 9) PRODUTO
------------------------------------------------------------
CREATE TABLE PRODUTO (
    ID_PRODUTO    INT            NOT NULL PRIMARY KEY,
    ID_CATEGORIA  INT            NOT NULL,
    NOME          VARCHAR(100)   NOT NULL,
    DESCRICAO     VARCHAR(500),
    PRECO         DECIMAL(10,2)  NOT NULL,
    ESTOQUE       INT            DEFAULT 0,
    ATIVO         CHAR(1)        NOT NULL DEFAULT 'S',

    CONSTRAINT FK_PRODUTO_CATEGORIA
        FOREIGN KEY (ID_CATEGORIA)
        REFERENCES CATEGORIA (ID_CATEGORIA)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 10) IMAGEM
------------------------------------------------------------
CREATE TABLE IMAGEM (
    ID_IMAGEM    INT            NOT NULL PRIMARY KEY,
    ID_PRODUTO   INT            NOT NULL,
    CAMINHO      VARCHAR(255)   NOT NULL,
    PRINCIPAL    CHAR(1)        NOT NULL DEFAULT 'N',

    CONSTRAINT FK_IMAGEM_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 11) FICHA_TECNICA
------------------------------------------------------------
CREATE TABLE FICHA_TECNICA (
    ID_FICHA_TECNICA INT            NOT NULL PRIMARY KEY,
    ID_PRODUTO       INT            NOT NULL,
    ATRIBUTO         VARCHAR(100)   NOT NULL,
    VALOR            VARCHAR(255)   NOT NULL,

    CONSTRAINT FK_FICHA_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 12) CARRINHO
------------------------------------------------------------
CREATE TABLE CARRINHO (
    ID_CARRINHO    INT           NOT NULL PRIMARY KEY,
    ID_CLIENTE     INT           NOT NULL,
    DATA_CRIACAO   DATETIME      DEFAULT CURRENT_TIMESTAMP,
    STATUS         VARCHAR(20)   NOT NULL DEFAULT 'ABERTO',

    CONSTRAINT FK_CARRINHO_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 13) ITEM_CARRINHO
------------------------------------------------------------
CREATE TABLE ITEM_CARRINHO (
    ID_CARRINHO    INT           NOT NULL,
    ID_PRODUTO     INT           NOT NULL,
    QUANTIDADE     INT           NOT NULL,
    PRECO_UNITARIO DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_ITEM_CARRINHO
        PRIMARY KEY (ID_CARRINHO, ID_PRODUTO),

    CONSTRAINT FK_ITEM_CARR_CARRINHO
        FOREIGN KEY (ID_CARRINHO)
        REFERENCES CARRINHO (ID_CARRINHO),

    CONSTRAINT FK_ITEM_CARR_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 14) PEDIDO
------------------------------------------------------------
CREATE TABLE PEDIDO (
    ID_PEDIDO          INT           NOT NULL PRIMARY KEY,
    ID_CLIENTE         INT           NOT NULL,
    ID_ENDERECO        INT           NOT NULL,
    ID_FORMA_PAGAMENTO INT           NOT NULL,
    DATA_PEDIDO        DATE          NOT NULL,
    STATUS             VARCHAR(20)   NOT NULL,
    VALOR_TOTAL        DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_PEDIDO_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE),

    CONSTRAINT FK_PEDIDO_ENDERECO
        FOREIGN KEY (ID_ENDERECO)
        REFERENCES ENDERECO (ID_ENDERECO),

    CONSTRAINT FK_PEDIDO_FORMA_PAGTO
        FOREIGN KEY (ID_FORMA_PAGAMENTO)
        REFERENCES FORMA_PAGAMENTO (ID_FORMA_PAGAMENTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 15) ITEM_PEDIDO
------------------------------------------------------------
CREATE TABLE ITEM_PEDIDO (
    ID_PEDIDO      INT           NOT NULL,
    ID_PRODUTO     INT           NOT NULL,
    QUANTIDADE     INT           NOT NULL,
    PRECO_UNITARIO DECIMAL(10,2) NOT NULL,
    SUBTOTAL       DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_ITEM_PEDIDO
        PRIMARY KEY (ID_PEDIDO, ID_PRODUTO),

    CONSTRAINT FK_ITEM_PED_PEDIDO
        FOREIGN KEY (ID_PEDIDO)
        REFERENCES PEDIDO (ID_PEDIDO),

    CONSTRAINT FK_ITEM_PED_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 16) AVALIACAO_PEDIDO
------------------------------------------------------------
CREATE TABLE AVALIACAO_PEDIDO (
    ID_AVALIACAO   INT          NOT NULL PRIMARY KEY,
    ID_PEDIDO      INT          NOT NULL,
    ID_CLIENTE     INT          NOT NULL,
    NOTA           TINYINT      NOT NULL,
    COMENTARIO     VARCHAR(500),
    DATA_AVALIACAO DATE         NOT NULL,

    CONSTRAINT FK_AVAL_PEDIDO
        FOREIGN KEY (ID_PEDIDO)
        REFERENCES PEDIDO (ID_PEDIDO),

    CONSTRAINT FK_AVAL_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 17) PERGUNTA
------------------------------------------------------------
CREATE TABLE PERGUNTA (
    ID_PERGUNTA    INT            NOT NULL PRIMARY KEY,
    ID_CLIENTE     INT            NOT NULL,
    ID_PRODUTO     INT            NOT NULL,
    TEXTO          VARCHAR(500)   NOT NULL,
    DATA_PERGUNTA  DATETIME       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_PERGUNTA_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE),

    CONSTRAINT FK_PERGUNTA_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;

------------------------------------------------------------
-- 18) RESPOSTA
------------------------------------------------------------
CREATE TABLE RESPOSTA (
    ID_RESPOSTA     INT            NOT NULL PRIMARY KEY,
    ID_PERGUNTA     INT            NOT NULL,
    ID_FUNCIONARIO  INT            NOT NULL,
    TEXTO           VARCHAR(500)   NOT NULL,
    DATA_RESPOSTA   DATETIME       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_RESPOSTA_PERGUNTA
        FOREIGN KEY (ID_PERGUNTA)
        REFERENCES PERGUNTA (ID_PERGUNTA),

    CONSTRAINT FK_RESPOSTA_FUNC
        FOREIGN KEY (ID_FUNCIONARIO)
        REFERENCES FUNCIONARIO (ID_FUNCIONARIO)
) ENGINE=InnoDB;


-- 19) FAVORITO
------------------------------------------------------------
CREATE TABLE FAVORITO (
    ID_CLIENTE    INT        NOT NULL,
    ID_PRODUTO    INT        NOT NULL,
    DATA_FAVORITO DATETIME   DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_FAVORITO
        PRIMARY KEY (ID_CLIENTE, ID_PRODUTO),

    CONSTRAINT FK_FAVORITO_CLIENTE
        FOREIGN KEY (ID_CLIENTE)
        REFERENCES CLIENTE (ID_CLIENTE),

    CONSTRAINT FK_FAVORITO_PRODUTO
        FOREIGN KEY (ID_PRODUTO)
        REFERENCES PRODUTO (ID_PRODUTO)
) ENGINE=InnoDB;
