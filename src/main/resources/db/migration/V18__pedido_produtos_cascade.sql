/**
Codigo SQL para modificar a tabela pedido_produtos e adicionar cascate quando deletar no banco de dados.
 */

ALTER TABLE pedido_produtos DROP CONSTRAINT IF EXISTS fk_pedido_produtos_produto;
ALTER TABLE pedido_produtos
ADD CONSTRAINT fk_pedido_produtos_produto
FOREIGN KEY (produto_id)
REFERENCES produtos(id)
ON DELETE CASCADE;
