# 2 - Requisitos do Sistema

## 2.1. Requisitos Funcionais
- O sistema deve permitir o cadastro de produtos, registrando a descrição, o valor, a quantidade em estoque e atributos adicionais, como categoria, imagens e especificações técnicas.

- O sistema deve permitir o cadastro de usuários, incluindo nome, data de nascimento, CPF, e-mail e informações de endereço e pagamento. Um usuário pode ter múltiplos endereços de entrega e formas de pagamento cadastradas. O CPF e o e-mail devem ser únicos para cada usuário.

- O sistema deve gerenciar um carrinho de compras para cada usuário, permitindo adicionar, remover e ajustar a quantidade de produtos antes de finalizar a compra.

- O sistema deve registrar cada pedido, associando-o a um usuário, aos produtos comprados e às formas de pagamento e endereço de entrega utilizados. O pedido deve ter seu status controlado (pendente, pago, enviado, entregue, cancelado).

- O sistema deve permitir aos usuários comentar e avaliar os produtos. Uma avaliação deve conter uma nota, e um comentário pode incluir um texto descritivo. Tanto comentários quanto avaliações devem ser vinculados a um produto e a um usuário.

- O sistema deve possibilitar a criação de um espaço de perguntas e respostas para cada produto, onde usuários podem fazer perguntas e funcionários podem respondê-las.

- O sistema deve permitir que os usuários favoritem produtos, adicionando-os a uma lista pessoal para consulta futura.

- O sistema deve permitir o cadastro de funcionários, que terão acesso a funções administrativas, como gerenciamento de produtos e respostas a perguntas e comentários. Cada funcionário deve ter um login e senha únicos e estar associado a um perfil de acesso que define suas permissões.

### 2.1.1. Relatórios de Negócio
- **Relatório de Vendas por Produto e Categoria:** O sistema deve gerar um relatório que mostre o total de vendas (em quantidade de itens e valor total) para cada produto e para cada categoria, em um período específico.

- **Relatório de Avaliações e Comentários:** O sistema deve gerar um relatório que mostre a média de avaliação de cada produto, bem como o número total de comentários e o conteúdo deles, permitindo identificar os produtos mais bem avaliados.

- **Relatório de Compras por Usuário:** O sistema deve permitir a consulta do histórico de compras de um usuário, mostrando todos os pedidos feitos, a data, o valor total, os produtos adquiridos e o status de cada transação.

- **Relatório de Produtos Favoritados:** O sistema deve listar os 10 produtos mais favoritados pelos usuários, bem como o número de vezes que cada um foi adicionado à lista de favoritos.

- **Relatório de Desempenho de Funcionários:** O sistema deve gerar um relatório que mostre o número de perguntas e comentários respondidos por cada funcionário em um determinado período, permitindo avaliar a produtividade da equipe.

## 2.2. Requisitos de Integridade

### 2.2.1. Integridade da Entidade
- Cada entidade no banco de dados deve ter uma chave primária para garantir que cada registro seja único.

- Produtos são identificados por um código único.

- Usuários são identificados pelo CPF.

- Pedidos são identificados por um código de pedido único.

- Comentários e Avaliações são identificados por uma chave composta que inclui o produto e o usuário que os criou.

- Um endereço é identificado por uma chave composta que inclui o usuário e o tipo de endereço (ex: residencial, comercial).

### 2.2.2. Integridade Referencial
-**Chaves Estrangeiras:** As chaves estrangeiras devem ser usadas para ligar tabelas relacionadas. Por exemplo, a tabela de Pedidos deve referenciar o CPF de um usuário e os códigos dos produtos comprados. A tabela de Comentários e Avaliações deve referenciar o produto e o usuário.

- **Ações de Deleção e Atualização:**
  - **ON DELETE RESTRICT:** Não deve ser possível excluir um usuário se ele tiver pedidos, comentários ou avaliações associados.

  - **ON UPDATE CASCADE:** A atualização do CPF de um usuário deve ser refletida automaticamente em todas as tabelas onde esse atributo é referenciado como chave estrangeira. A exclusão de um produto do catálogo deve refletir automaticamente na exclusão dele das listas de favoritos de todos os usuários.

### 2.2.3. Integridade de Domínio
- **Atributos de Texto (String):** Nomes, descrições de produtos e endereços devem ter um tamanho máximo definido. O e-mail deve seguir um formato válido.

- **Atributos Numéricos:** O valor dos produtos e o estoque devem ser armazenados como valores numéricos.

- **Datas:** Datas de nascimento, de pedidos e de comentários devem ser armazenadas em formato de data apropriado.

- **Restrições de Nulo:** Campos essenciais como nome de usuário, descrição de produto, valor e quantidade em estoque não podem ser nulos.

- **Valores de Enumeração/Domínio:** O status do pedido deve ser restrito a uma lista pré-definida de valores: 'pendente', 'pago', 'enviado', 'entregue', 'cancelado'. A nota de avaliação deve ser um número inteiro de 1 a 5.

### 2.2.4. Integridade Definida pelo Usuário
- Um produto não pode ser vendido em quantidade superior ao estoque disponível.

- Um pedido deve sempre estar associado a um usuário válido e a pelo menos um produto.

- Um comentário, avaliação ou pergunta deve estar sempre vinculado a um produto existente e a um usuário cadastrado.

- A cada venda, o estoque do produto correspondente deve ser automaticamente decrementado. Em caso de cancelamento, o estoque deve ser reajustado.

