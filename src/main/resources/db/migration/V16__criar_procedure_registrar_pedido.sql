/**
Codigo SQL para criar a função de registrar a criação de pedidos no banco de dados.
 */

CREATE OR REPLACE FUNCTION registrar_criacao_pedido(p_pedido_id BIGINT)
RETURNS BOOLEAN AS $$
DECLARE
    v_cliente_id BIGINT;
    v_fornecedor_id BIGINT;
    v_valor NUMERIC(15,2);
BEGIN
    -- Busca dados do pedido --
    SELECT cliente_id, fornecedor_id, valor_total INTO v_cliente_id, v_fornecedor_id, v_valor
    FROM pedidos WHERE id = p_pedido_id;

    -- Validação: pedido existe --
    IF v_cliente_id IS NULL OR v_fornecedor_id IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Registra histórico da transação --
    INSERT INTO historico_transacoes (pedido_id, cliente_id, fornecedor_id, valor, data_transacao, tipo)
    VALUES (p_pedido_id, v_cliente_id, v_fornecedor_id, v_valor, NOW(), 'CRIACAO_PEDIDO');

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;