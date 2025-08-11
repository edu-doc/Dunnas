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
    SELECT cliente_id, fornecedor_id, valor_total, status INTO v_cliente_id, v_fornecedor_id, v_valor, v_status
    FROM pedidos WHERE id = p_pedido_id;

    IF v_status IS NULL OR v_status <> 'PENDENTE' THEN
        RETURN FALSE;
    END IF;

    UPDATE pedidos SET status = 'CANCELADO' WHERE id = p_pedido_id;

    -- Atualiza histórico: muda tipo de PENDENTE para CANCELADO
    UPDATE historico_transacoes SET tipo = 'CANCELADO', data_transacao = NOW()
    WHERE pedido_id = p_pedido_id AND tipo = 'PENDENTE';

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
