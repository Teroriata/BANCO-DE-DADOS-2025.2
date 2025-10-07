# 🧠 Projeto Mind  
**Documento de Requisitos de Dados (DRD)**  

---

## 1. Identificação  
- **Projeto:** Mind  
- **Tipo de documento:** Documento de Requisitos de Dados (DRD)  
- **Instituição responsável:** Instituto de Informática – UFG  
- **Autores:** Gabriel Oliveira Ponde, Mateus Silva de Sousa  
- **Data:** 16/09/2025  
- **Versão atual:** 0.1  

---

## 1.1. Controle de Versão  

| Versão | Data       | Autor                | Descrição da Alteração     |
|:-------|:------------|:---------------------|:----------------------------|
| 0.1    | 16/09/2025  | Mateus Silva de Sousa | Versão inicial do documento |

---

## 1.2. Introdução  
O presente documento tem como objetivo descrever os **requisitos de dados** para o **Sistema Mind**, cuja proposta é oferecer suporte a um ambiente de comércio eletrônico.  

O sistema deverá contemplar o registro e a organização de informações relativas aos **produtos disponíveis para venda**, ao **cadastro de usuários**, bem como às **interações dos clientes** com os itens, incluindo **comentários, avaliações, perguntas e respostas**.  

As regras de negócio são apresentadas em linguagem natural, sem segmentação explícita em elementos técnicos de modelagem. A interpretação e derivação dos componentes do **Modelo Entidade-Relacionamento (MER)** ficam a critério do analista que utilizar este documento como insumo para a etapa de modelagem.

---

## 1.3. Escopo  
O sistema permitirá o registro histórico e organizado dos **produtos disponíveis para venda**, contendo informações como **descrição, valor, quantidade em estoque** e demais atributos relevantes.  

Será possível **cadastrar e gerenciar usuários**, armazenando seus **dados pessoais, endereços, histórico de compras** e **formas de pagamento padrão**.  

O sistema também possibilitará o uso de um **carrinho de compras**, onde os usuários poderão **adicionar ou remover produtos** antes da finalização do pedido.  

Cada compra será registrada, vinculando:
- o **cliente**,  
- os **itens adquiridos**,  
- as **formas de pagamento utilizadas**,  
- e o **status da transação** (pendente, pago, enviado, entregue, cancelado).  

Além disso, o sistema oferecerá recursos de **interação social**, permitindo:
- comentários nos produtos,  
- avaliações (ex.: nota de 1 a 5 estrelas),  
- e perguntas e respostas relacionadas a cada item.  

Também haverá a funcionalidade de **favoritar produtos**, permitindo que os usuários marquem itens de interesse para consulta futura.  

Para apoiar a **administração do e-commerce**, será possível cadastrar **funcionários**, que terão acesso a funções específicas, como:
- cadastrar, editar e excluir produtos,  
- responder comentários e perguntas de clientes.  

Os funcionários serão autenticados por **login e senha**, e terão **permissões conforme seu perfil de acesso**.  

O sistema fornecerá suporte tanto às **operações de venda**, quanto à **geração de dados estratégicos** e **de relacionamento com o cliente**, fortalecendo a gestão do e-commerce.

---

## 1.4. Regras de Negócio  

### Produtos
- Cada produto deve conter **descrição, valor e quantidade em estoque** (dados obrigatórios).  
- Não é possível disponibilizar um produto sem essas informações mínimas.  
- O produto pode possuir **atributos adicionais**, como categoria, imagens e especificações técnicas.  
- O **estoque** deve ser controlado automaticamente:
  - decrementado a cada venda,  
  - atualizado em cancelamentos ou devoluções.  
- Não é permitido vender quantidade superior ao estoque disponível.  

### Usuários
- Devem ser cadastrados individualmente, com **identificação única** (CPF ou e-mail).  
- O cadastro inclui:
  - nome, data de nascimento, CPF, endereço(s), formas de pagamento padrão.  
- É permitido possuir **múltiplos endereços** e **múltiplas formas de pagamento**.  

### Carrinho de Compras e Pedidos
- Cada carrinho é **associado a um usuário**.  
- O usuário pode **adicionar ou remover produtos** até a finalização da compra.  
- Após a confirmação, o carrinho se transforma em um **pedido**, contendo:
  - produtos adquiridos,  
  - valores correspondentes,  
  - forma de pagamento,  
  - endereço de entrega.  
- Cada pedido deve possuir um **status controlado pelo sistema**:  
  `pendente → pago → enviado → entregue → cancelado`.  
- O **histórico de compras** de cada usuário deve ser armazenado.  

### Interações Sociais
- O sistema permite **comentários, avaliações, perguntas e respostas**.  
- Cada interação deve estar associada a um **produto existente** e a um **usuário cadastrado**.  
- Avaliações devem conter uma **nota obrigatória (1–5 estrelas)** e, opcionalmente, um **texto descritivo**.  

### Favoritos
- Usuários podem **favoritar produtos** de interesse.  
- Um produto pode ser favoritado por **vários usuários**.  
- A exclusão de um produto do catálogo deve **remover automaticamente** sua presença nas listas de favoritos.  

### Funcionários
- Devem ser cadastrados com **login e senha exclusivos**.  
- Podem **cadastrar, editar e excluir produtos**, além de **responder interações de clientes**.  
- Devem possuir **perfis de acesso** que definem suas permissões.  

### Integridade e Relacionamentos
- Nenhum pedido pode existir sem estar **associado a um usuário válido**.  
- Nenhum comentário, avaliação, favorito ou pergunta pode existir sem **referência a um produto existente**.  
- Nenhuma ação administrativa pode ocorrer sem **vínculo a um funcionário**.  

---

## 1.5. Considerações Finais  
As regras de negócio aqui descritas permitem a elaboração de um **modelo conceitual consistente** para a gestão de um ambiente de comércio eletrônico.  

Apesar de não haver detalhamento técnico explícito sobre entidades, relacionamentos ou atributos, esses elementos estão **implicitamente presentes na narrativa** e podem ser derivados pelo analista responsável pela modelagem.  

O documento mantém a **clareza necessária para stakeholders não técnicos**, ao mesmo tempo em que fornece a base essencial para a construção do **Modelo Entidade-Relacionamento (MER)** e sua posterior tradução para o **modelo lógico de dados**.  

O sistema **Mind**, ao contemplar **produtos, usuários, funcionários, pedidos, interações sociais e favoritos**, garante não apenas o suporte às **operações de venda e gestão**, mas também a **geração de informações estratégicas** para análise e tomada de decisão.

---
