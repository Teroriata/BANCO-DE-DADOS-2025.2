------------------------------------------------------------
-- INSERÇÕES DE DADOS (DML) - PROJETO E-COMMERCE
-- ATENÇÃO: se você já inseriu dados antes, verifique conflitos de IDs.
------------------------------------------------------------

------------------------------------------------------------
-- 1) PERFIL
------------------------------------------------------------
INSERT INTO PERFIL (ID_PERFIL, NOME, DESCRICAO) VALUES (1, 'Administrador', 'Acesso total ao sistema');
INSERT INTO PERFIL (ID_PERFIL, NOME, DESCRICAO) VALUES (2, 'Cliente', 'Pode visualizar produtos e realizar pedidos');
INSERT INTO PERFIL (ID_PERFIL, NOME, DESCRICAO) VALUES (3, 'Funcionário', 'Responsável pelo atendimento e gestão de pedidos');
INSERT INTO PERFIL (ID_PERFIL, NOME, DESCRICAO) VALUES (4, 'Gestor', 'Acompanha relatórios e desempenho da loja');

------------------------------------------------------------
-- 2) USUARIO
------------------------------------------------------------
INSERT INTO USUARIO (ID_USUARIO, ID_PERFIL, NOME, EMAIL, SENHA, DATA_CADASTRO, ATIVO) VALUES
(1, 1, 'Admin Master', 'admin@sistema.com', '1234', NOW(), 'S'),
(2, 2, 'João Silva', 'joao.silva@gmail.com', '1234', NOW(), 'S'),
(3, 2, 'Maria Oliveira', 'maria.oliveira@gmail.com', '1234', NOW(), 'S'),
(4, 3, 'Carlos Mendes', 'carlos.mendes@loja.com', '1234', NOW(), 'S'),
(5, 2, 'Ana Paula', 'ana.paula@gmail.com', '1234', NOW(), 'S'),
(6, 3, 'Pedro Santos', 'pedro.santos@loja.com', '1234', NOW(), 'S'),
(7, 2, 'Luiza Fernandes', 'luiza.fernandes@gmail.com', '1234', NOW(), 'S'),
(8, 2, 'Marcos Lima', 'marcos.lima@gmail.com', '1234', NOW(), 'S'),
(9, 3, 'Fernanda Costa', 'fernanda.costa@loja.com', '1234', NOW(), 'S'),
(10, 2, 'Rafael Souza', 'rafael.souza@gmail.com', '1234', NOW(), 'S');

------------------------------------------------------------
-- 3) PERMISSAO
------------------------------------------------------------
INSERT INTO PERMISSAO (ID_PERMISSAO, ID_PERFIL, NOME, DESCRICAO) VALUES
(1, 1, 'GERENCIAR_USUARIOS', 'Pode criar, editar e excluir usuários'),
(2, 1, 'GERENCIAR_PRODUTOS', 'Pode gerenciar o catálogo de produtos'),
(3, 1, 'GERENCIAR_PEDIDOS', 'Pode gerenciar todos os pedidos'),
(4, 3, 'VISUALIZAR_PEDIDOS', 'Pode visualizar pedidos dos clientes'),
(5, 3, 'RESPONDER_PERGUNTAS', 'Pode responder dúvidas sobre produtos'),
(6, 4, 'VISUALIZAR_RELATORIOS', 'Pode visualizar relatórios gerenciais');

------------------------------------------------------------
-- 4) CLIENTE
------------------------------------------------------------
INSERT INTO CLIENTE (ID_CLIENTE, ID_USUARIO, CPF, TELEFONE, DATA_NASCIMENTO) VALUES
(1, 2, '12345678901', '11988887777', '1990-05-10'),
(2, 3, '98765432100', '21977776666', '1988-08-22'),
(3, 5, '55555555555', '11999990000', '1995-02-17'),
(4, 7, '22233344455', '31988884444', '1992-11-30'),
(5, 8, '11122233344', '41977778888', '1985-03-05');

------------------------------------------------------------
-- 5) FUNCIONARIO
------------------------------------------------------------
INSERT INTO FUNCIONARIO (ID_FUNCIONARIO, ID_USUARIO, CARGO, SALARIO, DATA_ADMISSAO) VALUES
(1, 4, 'Atendente', 2500.00, '2022-01-10'),
(2, 6, 'Analista de Vendas', 3200.00, '2021-09-01'),
(3, 9, 'Suporte Técnico', 3000.00, '2023-03-15');

------------------------------------------------------------
-- 6) ENDERECO
------------------------------------------------------------
INSERT INTO ENDERECO (
    ID_ENDERECO, 
    ID_CLIENTE, 
    LOGRADOURO, 
    NUMERO, 
    COMPLEMENTO,
    BAIRRO, 
    CIDADE, 
    UF, 
    CEP
) VALUES
(1, 1, 'Rua das Flores', '123', NULL, 'Centro', 'São Paulo', 'SP', '01001000'),
(2, 2, 'Avenida Paulista', '1500', 'Apto 12', 'Bela Vista', 'São Paulo', 'SP', '01310000'),
(3, 3, 'Rua Rio Branco', '88', NULL, 'Centro', 'Rio de Janeiro', 'RJ', '20040007'),
(4, 4, 'Rua das Laranjeiras', '45', 'Casa', 'Laranjeiras', 'Rio de Janeiro', 'RJ', '22240003'),
(5, 5, 'Rua XV de Novembro', '500', 'Bloco B', 'Centro', 'Curitiba', 'PR', '80020010');

------------------------------------------------------------
-- 7) FORMA_PAGAMENTO
------------------------------------------------------------
INSERT INTO FORMA_PAGAMENTO (ID_FORMA_PAGAMENTO, DESCRICAO, ATIVO) VALUES
(1, 'Cartão de Crédito', 'S'),
(2, 'PIX', 'S'),
(3, 'Boleto Bancário', 'S'),
(4, 'Cartão de Débito', 'S'),
(5, 'Carteira Digital', 'S');

------------------------------------------------------------
-- 8) CATEGORIA
------------------------------------------------------------
INSERT INTO CATEGORIA (ID_CATEGORIA, NOME, DESCRICAO) VALUES
(1, 'Eletrônicos', 'Celulares, TVs, áudio e vídeo'),
(2, 'Informática', 'Computadores, periféricos e acessórios'),
(3, 'Casa e Cozinha', 'Eletrodomésticos e utilidades domésticas'),
(4, 'Games', 'Consoles, jogos e acessórios'),
(5, 'Livros', 'Livros físicos e digitais');

------------------------------------------------------------
-- 9) PRODUTO
------------------------------------------------------------
INSERT INTO PRODUTO (
    ID_PRODUTO, 
    ID_CATEGORIA, 
    NOME, 
    DESCRICAO, 
    PRECO, 
    ESTOQUE, 
    ATIVO
) VALUES
(1, 1, 'Smartphone X10', '64GB, câmera dupla, tela 6.1"', 1500.00, 50, 'S'),
(2, 2, 'Teclado Mecânico RGB', 'Teclado mecânico com iluminação RGB, switch blue', 350.00, 80, 'S'),
(3, 3, 'Liquidificador Turbo', 'Liquidificador 900W, 5 velocidades', 200.00, 40, 'S'),
(4, 1, 'Smart TV 50" 4K', 'Smart TV 50 polegadas, 4K UHD', 2500.00, 30, 'S'),
(5, 2, 'Mouse Gamer 7200dpi', 'Mouse gamer ergonômico, 7 botões', 120.00, 100, 'S'),
(6, 4, 'Console GameBox', 'Console de última geração, 1TB', 4500.00, 20, 'S'),
(7, 4, 'Controle sem fio', 'Controle sem fio para Console GameBox', 300.00, 60, 'S'),
(8, 5, 'Livro - Banco de Dados', 'Livro sobre modelagem e SQL', 120.00, 25, 'S'),
(9, 5, 'Livro - Programação em Java', 'Conceitos básicos e avançados', 140.00, 30, 'S'),
(10, 3, 'Cafeteira Elétrica', 'Cafeteira 220V, 30 cafezinhos', 180.00, 35, 'S'),
(11, 1, 'Fone Bluetooth', 'Fone de ouvido sem fio, com case', 250.00, 70, 'S'),
(12, 2, 'Monitor 24" Full HD', 'Monitor LED 24 polegadas, 75Hz', 900.00, 40, 'S');

------------------------------------------------------------
-- 10) IMAGEM
------------------------------------------------------------
INSERT INTO IMAGEM (ID_IMAGEM, ID_PRODUTO, CAMINHO, PRINCIPAL) VALUES
(1, 1, '/img/produtos/smartphone_x10_1.png', 'S'),
(2, 2, '/img/produtos/teclado_rgb_1.png', 'S'),
(3, 3, '/img/produtos/liquidificador_1.png', 'S'),
(4, 4, '/img/produtos/tv_50_4k_1.png', 'S'),
(5, 5, '/img/produtos/mouse_gamer_1.png', 'S'),
(6, 6, '/img/produtos/console_gamebox_1.png', 'S'),
(7, 7, '/img/produtos/controle_gamebox_1.png', 'S'),
(8, 8, '/img/produtos/livro_banco_dados_1.png', 'S'),
(9, 9, '/img/produtos/livro_java_1.png', 'S'),
(10, 10, '/img/produtos/cafeteira_1.png', 'S'),
(11, 11, '/img/produtos/fone_bt_1.png', 'S'),
(12, 12, '/img/produtos/monitor_24_1.png', 'S');

------------------------------------------------------------
-- 11) FICHA_TECNICA
------------------------------------------------------------
INSERT INTO FICHA_TECNICA (ID_FICHA_TECNICA, ID_PRODUTO, ATRIBUTO, VALOR) VALUES
(1, 1, 'Memória Interna', '64GB'),
(2, 1, 'Tamanho da Tela', '6.1 polegadas'),
(3, 4, 'Resolução', '4K UHD'),
(4, 4, 'Tamanho da Tela', '50 polegadas'),
(5, 2, 'Tipo de Switch', 'Blue'),
(6, 3, 'Potência', '900W'),
(7, 6, 'Armazenamento', '1TB'),
(8, 12, 'Taxa de Atualização', '75Hz');

------------------------------------------------------------
-- 12) CARRINHO
------------------------------------------------------------
INSERT INTO CARRINHO (ID_CARRINHO, ID_CLIENTE, DATA_CRIACAO, STATUS) VALUES
(1, 1, NOW() - INTERVAL 5 DAY, 'ABERTO'),
(2, 2, NOW() - INTERVAL 3 DAY, 'EM_ANDAMENTO'),
(3, 3, NOW() - INTERVAL 10 DAY, 'FINALIZADO'),
(4, 4, NOW() - INTERVAL 1 DAY, 'ABERTO'),
(5, 5, NOW() - INTERVAL 7 DAY, 'CANCELADO');

------------------------------------------------------------
-- 13) ITEM_CARRINHO
------------------------------------------------------------
INSERT INTO ITEM_CARRINHO (ID_CARRINHO, ID_PRODUTO, QUANTIDADE, PRECO_UNITARIO) VALUES
(1, 1, 1, 1500.00),
(1, 5, 2, 120.00),
(2, 4, 1, 2500.00),
(2, 2, 1, 350.00),
(3, 8, 1, 120.00),
(3, 9, 1, 140.00),
(4, 11, 1, 250.00),
(5, 3, 1, 200.00);

------------------------------------------------------------
-- 14) PEDIDO
------------------------------------------------------------
INSERT INTO PEDIDO (
    ID_PEDIDO,
    ID_CLIENTE,
    ID_ENDERECO,
    ID_FORMA_PAGAMENTO,
    DATA_PEDIDO,
    STATUS,
    VALOR_TOTAL
) VALUES
(1, 1, 1, 1, CURDATE() - INTERVAL 4 DAY, 'PAGO', 1740.00),
(2, 2, 2, 2, CURDATE() - INTERVAL 2 DAY, 'PROCESSANDO', 2850.00),
(3, 3, 3, 3, CURDATE() - INTERVAL 9 DAY, 'ENTREGUE', 260.00),
(4, 4, 4, 1, CURDATE() - INTERVAL 6 DAY, 'CANCELADO', 4500.00),
(5, 5, 5, 4, CURDATE() - INTERVAL 3 DAY, 'PAGO', 1080.00),
(6, 1, 1, 5, CURDATE() - INTERVAL 1 DAY, 'PAGO', 430.00);

------------------------------------------------------------
-- 15) ITEM_PEDIDO
------------------------------------------------------------
INSERT INTO ITEM_PEDIDO (
    ID_PEDIDO,
    ID_PRODUTO,
    QUANTIDADE,
    PRECO_UNITARIO,
    SUBTOTAL
) VALUES
(1, 1, 1, 1500.00, 1500.00),
(1, 5, 2, 120.00, 240.00),
(2, 4, 1, 2500.00, 2500.00),
(2, 2, 1, 350.00, 350.00),
(3, 8, 1, 120.00, 120.00),
(4, 6, 1, 4500.00, 4500.00),
(5, 12, 1, 900.00, 900.00),
(6, 10, 1, 180.00, 180.00),
(6, 11, 1, 250.00, 250.00);

------------------------------------------------------------
-- 16) AVALIACAO_PEDIDO
------------------------------------------------------------
INSERT INTO AVALIACAO_PEDIDO (
    ID_AVALIACAO,
    ID_PEDIDO,
    ID_CLIENTE,
    NOTA,
    COMENTARIO,
    DATA_AVALIACAO
) VALUES
(1, 1, 1, 5, 'Produto excelente e entrega rápida.', CURDATE() - INTERVAL 2 DAY),
(2, 3, 3, 4, 'Livro muito bom, conteúdo bem explicado.', CURDATE() - INTERVAL 5 DAY),
(3, 5, 5, 5, 'Monitor com ótima imagem.', CURDATE() - INTERVAL 1 DAY),
(4, 2, 2, 3, 'Demorou um pouco para enviar, mas produto é bom.', CURDATE() - INTERVAL 1 DAY);

------------------------------------------------------------
-- 17) PERGUNTA
------------------------------------------------------------
INSERT INTO PERGUNTA (
    ID_PERGUNTA,
    ID_CLIENTE,
    ID_PRODUTO,
    TEXTO,
    DATA_PERGUNTA
) VALUES
(1, 1, 1, 'Esse smartphone tem NFC?', CURDATE() - INTERVAL 3 DAY),
(2, 2, 4, 'A TV tem entrada HDMI 2.1?', CURDATE() - INTERVAL 2 DAY),
(3, 3, 6, 'O console acompanha algum jogo?', CURDATE() - INTERVAL 1 DAY),
(4, 4, 12, 'Esse monitor é compatível com suporte VESA?', CURDATE() - INTERVAL 1 DAY);

------------------------------------------------------------
-- 18) RESPOSTA
------------------------------------------------------------
INSERT INTO RESPOSTA (
    ID_RESPOSTA,
    ID_PERGUNTA,
    ID_FUNCIONARIO,
    TEXTO,
    DATA_RESPOSTA
) VALUES
(1, 1, 1, 'Sim, o modelo X10 possui NFC.', CURDATE() - INTERVAL 2 DAY),
(2, 2, 2, 'Sim, a TV possui 2 entradas HDMI 2.1.', CURDATE() - INTERVAL 1 DAY),
(3, 3, 2, 'O console não acompanha jogos físicos, apenas demonstrações digitais.', CURDATE()),
(4, 4, 3, 'Sim, o monitor é compatível com suporte VESA 75x75mm.', CURDATE());

------------------------------------------------------------
-- 19) FAVORITO
------------------------------------------------------------
INSERT INTO FAVORITO (
    ID_CLIENTE,
    ID_PRODUTO,
    DATA_FAVORITO
) VALUES
(1, 4, CURDATE() - INTERVAL 5 DAY),
(1, 6, CURDATE() - INTERVAL 4 DAY),
(2, 1, CURDATE() - INTERVAL 3 DAY),
(3, 8, CURDATE() - INTERVAL 2 DAY),
(4, 12, CURDATE() - INTERVAL 1 DAY),
(5, 11, CURDATE());