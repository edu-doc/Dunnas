/**
Codigo SQL para criar a tabela cupons no banco de dados.
 */

CREATE TABLE cupons (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    desconto NUMERIC(10,2) NOT NULL,
    data_validade DATE NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);
