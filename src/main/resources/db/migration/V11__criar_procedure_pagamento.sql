/**
Codigo SQL para criar a função de processamento de pagamento no banco de dados.
 */

CREATE OR REPLACE FUNCTION processar_pagamento(p_pedido_id BIGINT)
RETURNS BOOLEAN AS $$
DECLARE
    v_cliente_id BIGINT;
    v_fornecedor_id BIGINT;
    v_valor NUMERIC(15,2);
    v_status VARCHAR;
    v_saldo_cliente NUMERIC(15,2);
BEGIN
    SELECT cliente_id, fornecedor_id, valor_total, status INTO v_cliente_id, v_fornecedor_id, v_valor, v_status
    FROM pedidos WHERE id = p_pedido_id;

    IF v_status IS NULL OR v_status = 'PAGO' THEN
        RETURN FALSE;
    END IF;

    SELECT saldo INTO v_saldo_cliente FROM clientes WHERE id = v_cliente_id;
    IF v_saldo_cliente IS NULL OR v_saldo_cliente < v_valor THEN
        RETURN FALSE;
    END IF;

    UPDATE clientes SET saldo = saldo - v_valor WHERE id = v_cliente_id;
    UPDATE fornecedores SET saldo = saldo + v_valor WHERE id = v_fornecedor_id;
    UPDATE pedidos SET status = 'PAGO' WHERE id = p_pedido_id;

    -- Atualiza histórico: muda tipo de PENDENTE para PAGO
    UPDATE historico_transacoes SET tipo = 'PAGO', data_transacao = NOW()
    WHERE pedido_id = p_pedido_id AND tipo = 'PENDENTE';

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
