/**
Codigo SQL para criar a função de processamento de adição de saldo no banco de dados.
 */

CREATE OR REPLACE FUNCTION adicionar_saldo_cliente(p_cliente_id BIGINT, p_valor NUMERIC(15,2))
RETURNS BOOLEAN AS $$
DECLARE
    v_saldo NUMERIC(15,2);
BEGIN
    -- Validação: valor positivo --
    IF p_valor IS NULL OR p_valor <= 0 THEN
        RETURN FALSE;
    END IF;

    -- Busca saldo atual --
    SELECT saldo INTO v_saldo FROM clientes WHERE id = p_cliente_id;
    IF v_saldo IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Atualiza saldo do cliente --
    UPDATE clientes SET saldo = saldo + p_valor WHERE id = p_cliente_id;

    -- Registra histórico da transação --
    INSERT INTO historico_transacoes (pedido_id, cliente_id, fornecedor_id, valor, data_transacao, tipo)
    VALUES (NULL, p_cliente_id, NULL, p_valor, NOW(), 'PIX');

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
