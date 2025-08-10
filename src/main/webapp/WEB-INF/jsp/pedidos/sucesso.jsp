<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Pedido Realizado</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: linear-gradient(120deg, #e0e7ff 0%, #f5f5f5 100%); }
        .container {
            max-width: 420px;
            margin: 60px auto;
            background: #fff;
            padding: 38px 32px 32px 32px;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.10);
            text-align: center;
        }
        .icon-success {
            font-size: 54px;
            color: #28a745;
            margin-bottom: 18px;
        }
        h2 {
            color: #28a745;
            margin-bottom: 18px;
            font-size: 2rem;
            font-weight: 700;
        }
        .info {
            margin-bottom: 28px;
            color: #333;
            font-size: 1.08rem;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 18px 0;
            box-shadow: 0 1px 4px rgba(40,167,69,0.07);
        }
        .info span {
            display: block;
            margin-bottom: 7px;
        }
        .btn-historico {
            background: linear-gradient(90deg, #007bff 60%, #0056b3 100%);
            color: #fff;
            padding: 12px 32px;
            border: none;
            border-radius: 7px;
            text-decoration: none;
            font-size: 1.08rem;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: background 0.2s, box-shadow 0.2s;
            cursor: pointer;
            display: inline-block;
        }
        .btn-historico:hover {
            background: linear-gradient(90deg, #0056b3 60%, #007bff 100%);
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon-success">&#10004;</div>
        <h2>Pedido realizado com sucesso!</h2>
        <div class="info">
            <span><strong>Número do pedido:</strong> ${pedido.id}</span>
            <span><strong>Valor total:</strong> R$ ${pedido.valorTotal}</span>
            <span><strong>Desconto aplicado:</strong> R$ ${pedido.desconto}</span>
            <c:choose>
                <c:when test="${pedido.cupom != null && !pedido.cupom.isEmpty() && pedido.desconto == 0}">
                    <span style="color:#dc3545;"><strong>Cupom informado:</strong> ${pedido.cupom} (inválido ou expirado)</span>
                </c:when>
                <c:when test="${pedido.cupom != null && !pedido.cupom.isEmpty() && pedido.desconto > 0}">
                    <span style="color:#28a745;"><strong>Cupom aplicado:</strong> ${pedido.cupom}</span>
                </c:when>
            </c:choose>
        </div>
    <a href="/pedidos/historico" class="btn-historico">Ver histórico de pedidos</a>
    </div>
</body>
</html>
