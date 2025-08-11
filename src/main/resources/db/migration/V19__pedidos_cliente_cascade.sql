/**
Codigo SQL para modificar a tabela pedido_cliente e adicionar cascate quando deletar no banco de dados.
 */

ALTER TABLE pedidos DROP CONSTRAINT IF EXISTS fk_pedidos_cliente;
ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_cliente
FOREIGN KEY (cliente_id)
REFERENCES clientes(id)
ON DELETE CASCADE;
