/**
Codigo SQL para criar a coluna ativo em produtos no banco de dados.
 */

ALTER TABLE produtos ADD COLUMN ativo BOOLEAN NOT NULL DEFAULT TRUE;
