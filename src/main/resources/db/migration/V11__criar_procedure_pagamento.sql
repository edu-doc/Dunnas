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
    -- Busca dados do pedido --
    SELECT cliente_id, fornecedor_id, valor_total, status INTO v_cliente_id, v_fornecedor_id, v_valor, v_status
    FROM pedidos WHERE id = p_pedido_id;

    -- Validação: pedido existe e não está pago --
    IF v_status IS NULL OR v_status = 'PAGO' THEN
        RETURN FALSE;
    END IF;

    -- Busca saldo do cliente --
    SELECT saldo INTO v_saldo_cliente FROM clientes WHERE id = v_cliente_id;
    IF v_saldo_cliente IS NULL OR v_saldo_cliente < v_valor THEN
        RETURN FALSE;
    END IF;

    -- Debita saldo do cliente --
    UPDATE clientes SET saldo = saldo - v_valor WHERE id = v_cliente_id;

    -- Credita saldo do fornecedor --
    UPDATE fornecedores SET saldo = saldo + v_valor WHERE id = v_fornecedor_id;

    -- Atualiza status do pedido --
    UPDATE pedidos SET status = 'PAGO' WHERE id = p_pedido_id;

    -- Registra histórico da transação --
    INSERT INTO historico_transacoes (pedido_id, cliente_id, fornecedor_id, valor, data_transacao, tipo)
    VALUES (p_pedido_id, v_cliente_id, v_fornecedor_id, v_valor, NOW(), 'PAGAMENTO');

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
