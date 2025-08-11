/**
Codigo SQL para criar a função de processamento de cancelamento de pedido no banco de dados.
 */

CREATE OR REPLACE FUNCTION processar_cancelamento(p_pedido_id BIGINT)
RETURNS BOOLEAN AS $$
DECLARE
    v_cliente_id BIGINT;
    v_fornecedor_id BIGINT;
    v_valor NUMERIC(15,2);
    v_status VARCHAR;
BEGIN
    -- Busca dados do pedido --
    SELECT cliente_id, fornecedor_id, valor_total, status INTO v_cliente_id, v_fornecedor_id, v_valor, v_status
    FROM pedidos WHERE id = p_pedido_id;

    -- Validação: pedido existe e está pendente --
    IF v_status IS NULL OR v_status <> 'PENDENTE' THEN
        RETURN FALSE;
    END IF;

    -- Atualiza status do pedido --
    UPDATE pedidos SET status = 'CANCELADO' WHERE id = p_pedido_id;

    -- Registra histórico da transação --
    INSERT INTO historico_transacoes (pedido_id, cliente_id, fornecedor_id, valor, data_transacao, tipo)
    VALUES (p_pedido_id, v_cliente_id, v_fornecedor_id, v_valor, NOW(), 'CANCELAMENTO');

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
