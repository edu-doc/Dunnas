/**
Codigo SQL para criar a tabela clientes no banco de dados.
 */

CREATE TABLE clientes (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    saldo NUMERIC(15, 2) NOT NULL DEFAULT 0.00,

    -- Criação da chave estrangeira --
    CONSTRAINT fk_clientes_usuarios
        FOREIGN KEY (id)
        REFERENCES usuarios (id),

    -- Lógica de negócio / Validação --
    CONSTRAINT chk_saldo_positivo CHECK (saldo >= 0)
);