<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Pedido Realizado</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 480px;
            margin: 70px auto;
            background: #fff;
            padding: 48px 38px 38px 38px;
            border-radius: 22px;
            box-shadow: 0 8px 36px rgba(0,0,0,0.18);
            text-align: center;
        }
        .branding {
            font-size: 1.25rem;
            color: #d90429;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 18px;
            text-align: center;
        }
        .icon-success {
            font-size: 70px;
            color: #28a745;
            margin-bottom: 22px;
        }
        h2 {
            color: #d90429;
            margin-bottom: 22px;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .info {
            margin-bottom: 32px;
            color: #232526;
            font-size: 1.12rem;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 22px 0;
            box-shadow: 0 2px 8px rgba(40,167,69,0.10);
        }
        .info span {
            display: block;
            margin-bottom: 9px;
        }
        .btn-historico {
            background: linear-gradient(90deg, #d90429 60%, #232526 100%);
            color: #fff;
            padding: 14px 0;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            font-size: 1.15rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(220,4,41,0.10);
            transition: background 0.2s, box-shadow 0.2s;
            cursor: pointer;
            display: inline-block;
            width: 100%;
        }
        .btn-historico:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Pedido Realizado</div>
        <div class="icon-success">&#10004;</div>
        <h2>Pedido realizado com sucesso!</h2>
        <div class="info">
            <span><strong>Número do pedido:</strong> ${pedido.id}</span>
            <span><strong>Valor total:</strong> R$ ${pedido.valorTotal}</span>
            <span><strong>Desconto aplicado:</strong> R$ ${pedido.desconto}</span>
            <c:if test="${pedido.cupom != null && !pedido.cupom.isEmpty() && pedido.desconto > 0}">
                <span style="color:#28a745;"><strong>Cupom aplicado:</strong> ${pedido.cupom}</span>
            </c:if>
        </div>
        <a href="/pedidos/historico" class="btn-historico">Ver histórico de pedidos</a>
    </div>
</body>
</html>
