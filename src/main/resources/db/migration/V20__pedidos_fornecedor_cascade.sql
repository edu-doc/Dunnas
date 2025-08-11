/**
Codigo SQL para modificar a tabela pedido_fornecedor e adicionar cascate quando deletar no banco de dados.
 */

ALTER TABLE pedidos DROP CONSTRAINT IF EXISTS fk_pedidos_fornecedor;
ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_fornecedor
FOREIGN KEY (fornecedor_id)
REFERENCES fornecedores(id)
ON DELETE CASCADE;
