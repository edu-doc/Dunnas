/**
Codigo SQL para criar a função de registrar a criação de produto no banco de dados.
 */

CREATE OR REPLACE FUNCTION registrar_criacao_produto(p_produto_id BIGINT)
RETURNS BOOLEAN AS $$
DECLARE
    v_fornecedor_id BIGINT;
    v_valor NUMERIC(15,2);
BEGIN
    -- Busca dados do produto --
    SELECT fornecedor_id, preco INTO v_fornecedor_id, v_valor
    FROM produtos WHERE id = p_produto_id;

    -- Validação: produto existe --
    IF v_fornecedor_id IS NULL THEN
        RETURN FALSE;
    END IF;

    -- Registra histórico da transação --
    INSERT INTO historico_transacoes (pedido_id, cliente_id, fornecedor_id, valor, data_transacao, tipo)
    VALUES (NULL, NULL, v_fornecedor_id, v_valor, NOW(), 'CRIACAO_PRODUTO');

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;