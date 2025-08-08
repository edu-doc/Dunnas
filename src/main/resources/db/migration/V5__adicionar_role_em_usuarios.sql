/**
Codigo SQL para adicionar a coluna roles em clientes no banco de dados.
 */

ALTER TABLE usuarios ADD COLUMN role VARCHAR(10) NOT NULL;