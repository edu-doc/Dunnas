/**
Codigo SQL para criar a tabela pedidos no banco de dados.
 */

CREATE TABLE pedidos (
    id BIGSERIAL PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    fornecedor_id BIGINT NOT NULL,
    valor_total NUMERIC(15, 2) NOT NULL,
    desconto NUMERIC(15, 2),
    cupom VARCHAR(50),
    data_pedido TIMESTAMP NOT NULL DEFAULT NOW(),
    status VARCHAR(20) NOT NULL,
    
    -- Criação da chave estrangeira --
    CONSTRAINT fk_pedidos_cliente 
        FOREIGN KEY (cliente_id) 
        REFERENCES clientes(id),
    
    CONSTRAINT fk_pedidos_fornecedor
        FOREIGN KEY (fornecedor_id) 
        REFERENCES fornecedores(id)

);
