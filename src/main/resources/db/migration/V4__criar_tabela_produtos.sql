/**
Codigo SQL para criar a tabela produtos no banco de dados.
 */

CREATE TABLE produtos (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10, 2) NOT NULL,
    preco_com_desconto NUMERIC(10, 2),
    fornecedor_id BIGINT NOT NULL,

    -- Criação da chave estrangeira --
    CONSTRAINT fk_produtos_fornecedor
                FOREIGN KEY (fornecedor_id)
                REFERENCES fornecedores(id),

    -- Lógica de negócio / Validação --
    CONSTRAINT chk_preco_valido CHECK (preco > 0),
    CONSTRAINT chk_desconto_valido CHECK (preco_com_desconto IS NULL OR (preco_com_desconto > 0 AND preco_com_desconto < preco))

);