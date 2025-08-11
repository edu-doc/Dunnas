/**
Codigo SQL para dar drop no not null da coluna pedido_id e fornecedor_id no banco de dados.
 */

ALTER TABLE historico_transacoes ALTER COLUMN pedido_id DROP NOT NULL;

ALTER TABLE historico_transacoes ALTER COLUMN fornecedor_id DROP NOT NULL;