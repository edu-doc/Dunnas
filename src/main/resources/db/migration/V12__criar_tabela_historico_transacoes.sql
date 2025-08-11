/**
Codigo SQL para criar a tabela historico de transações no banco de dados.
 */

CREATE TABLE historico_transacoes (
    id SERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL,
    cliente_id BIGINT NOT NULL,
    fornecedor_id BIGINT NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    data_transacao TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Adiciona índices --
CREATE INDEX idx_historico_transacoes_pedido_id ON historico_transacoes(pedido_id);
CREATE INDEX idx_historico_transacoes_cliente_id ON historico_transacoes(cliente_id);
CREATE INDEX idx_historico_transacoes_fornecedor_id ON historico_transacoes(fornecedor_id);
