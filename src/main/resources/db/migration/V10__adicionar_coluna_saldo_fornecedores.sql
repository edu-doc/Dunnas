/**
Codigo SQL para adicionar a coluna saldo na tabela fornecedores no banco de dados.
 */

ALTER TABLE fornecedores ADD COLUMN saldo NUMERIC(15,2) NOT NULL DEFAULT 0;
