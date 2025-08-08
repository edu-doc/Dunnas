/**
Codigo SQL para criar a tabela clientes no banco de dados.
 */

CREATE TABLE clientes (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    saldo NUMERIC(15, 2) NOT NULL DEFAULT 0.00,

    -- Lógica de negócio / Validação --
    CONSTRAINT chk_saldo_positivo CHECK (saldo >= 0)
);