# 4.2. Normalização

Durante o desenvolvimento do banco de dados, todas as entidades foram estruturadas de acordo com as principais formas normais (1FN, 2FN e 3FN), garantindo maior consistência, ausência de redundâncias e evitando anomalias de inserção, atualização e remoção.

## 1ª Forma Normal (1FN)

Para atender à 1FN, todas as tabelas foram projetadas com:

- Atributos atômicos, armazenando valores indivisíveis;
- Ausência de grupos repetitivos;
- Linhas identificáveis por chave primária.

### Aplicações no projeto

- Na tabela `CLIENTE`, atributos como `nome`, `cpf`, `telefone` e `email` são totalmente atômicos.
- Os endereços dos clientes foram separados em `ENDERECO_CLIENTE`, garantindo que os campos `logradouro`, `numero`, `bairro`, `cidade` e `cep` sejam armazenados de forma detalhada e padronizada.
- Em vez de agrupar vários produtos dentro da tabela `PEDIDO`, foi criada a entidade `ITEM_PEDIDO`, permitindo registrar cada produto do marketplace comprado em um pedido de maneira individual.
- Na tabela `RESTAURANTE` (fornecedor no marketplace), atributos como `nome_fantasia`, `cnpj`, `especialidade` e `telefone` são atômicos, evitando agrupamento de dados.
- A tabela `PRODUTO` referencia apenas uma `CATEGORIA`, evitando listas ou campos compostos.

Essas decisões garantem a ausência de valores multivalorados e mantêm a granularidade adequada dos dados.

## 2ª Forma Normal (2FN)

Para atender à 2FN, garantimos que nenhum atributo não-chave depende apenas de parte de uma chave composta, especialmente em tabelas com chave primária composta.

A aplicação mais evidente ocorre em `ITEM_PEDIDO`, cuja chave primária é composta por:

- `id_pedido`
- `id_produto`

Nessa tabela:

- Atributos como `quantidade` e `valor_unitario` dependem da combinação completa da chave composta.
- Informações próprias do produto (por exemplo, `foto`, `descricao`, `preco_base`) permanecem somente em `PRODUTO`.
- Informações gerais do pedido (`data`, `status`, `valor_total`) pertencem exclusivamente à tabela `PEDIDO`.

### Outras decisões alinhadas à 2FN

- Dados próprios do restaurante/vendedor (`cnpj`, `nome_fantasia`, `especialidade`) não são repetidos em `PEDIDO` ou `ITEM_PEDIDO`, evitando redundâncias no marketplace.
- As informações da forma de pagamento são armazenadas apenas na tabela `FORMA_PAGAMENTO`, enquanto `PEDIDO` guarda somente `id_forma_pagamento`.

Assim, elimina-se dependência parcial e evita-se duplicação de informações entre as entidades participantes do marketplace.

## 3ª Forma Normal (3FN)

A 3FN foi atendida garantindo que nenhum atributo não-chave dependa de outro atributo não-chave, eliminando dependências transitivas.

### Principais aplicações no projeto

#### Cliente e Endereço

- A tabela `CLIENTE` guarda apenas informações pessoais.
- A tabela `ENDERECO_CLIENTE` mantém todos os dados relacionados ao endereço do cliente.

Dessa forma, atributos como `cidade` ou `cep` não ficam associados indevidamente ao cliente, mas sim ao endereço, eliminando dependência transitiva.

#### Pedido e Forma de Pagamento

- A tabela `PEDIDO` armazena somente a chave estrangeira `id_forma_pagamento`.
- A descrição e o tipo da forma de pagamento permanecem centralizados em `FORMA_PAGAMENTO`, evitando repetição desses dados a cada pedido realizado no marketplace.

#### Pedido e Avaliação

- Avaliações foram corretamente isoladas em `AVALIACAO_PEDIDO`, com atributos `nota` e `comentario`.
- Esses atributos não dependem diretamente do pedido, e sim de um processo à parte (a avaliação), garantindo independência lógica entre as tabelas.

#### Produto e Categoria

- Cada `PRODUTO` referencia apenas uma `CATEGORIA`, sem armazenar informações descritivas repetidas.
- A descrição da categoria e sua organização permanecem na entidade `CATEGORIA`, centralizando a informação.

#### Entrega (quando aplicável ao marketplace)

Mesmo em um marketplace, onde a logística pode ser própria ou terceirizada:

- A tabela `ENTREGA` armazena apenas as referências necessárias (como `id_pedido`, `id_cliente` e `id_restaurante`).
- Informações como CPF do cliente ou CNPJ do restaurante não são duplicadas, pois permanecem em suas respectivas entidades.

Isso mantém a integridade e evita redundâncias entre os participantes do marketplace.

## Conclusão da Normalização

As tabelas do projeto foram corretamente estruturadas nas três formas normais, garantindo:

- Estruturas sem campos multivalorados;
- Eliminação de dependências parciais e transitivas;
- Redundância mínima e consistência máxima;
- Flexibilidade para expansão, inclusão de novos vendedores/restaurantes e ampliação da base de produtos.

Essa normalização assegura que o sistema de marketplace opere de forma eficiente, íntegro e escalável para receber múltiplos vendedores e uma grande variedade de produtos.
