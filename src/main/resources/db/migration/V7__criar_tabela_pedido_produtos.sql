/**
Codigo SQL para criar a tabela pedido_produtos no banco de dados.
 */

 CREATE TABLE pedido_produtos (
    pedido_id BIGINT NOT NULL,
    produto_id BIGINT NOT NULL,
    PRIMARY KEY (pedido_id, produto_id),

    -- Criação da chave estrangeira --
    CONSTRAINT fk_pedido_produtos_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id),

    CONSTRAINT fk_pedido_produtos_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(id)

 );