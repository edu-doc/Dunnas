<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    <title>Detalhes do Produto</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 500px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #28a745; margin-bottom: 30px; }
        .info { margin-bottom: 20px; }
        .info p { font-size: 18px; color: #333; margin: 10px 0; }
        .price { font-size: 22px; color: #007bff; font-weight: bold; }
        .discount { font-size: 20px; color: #dc3545; font-weight: bold; }
        button { background: #28a745; color: #fff; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; margin-top: 20px; width: 100%; font-size: 16px; }
        button:hover { background: #218838; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Detalhes do Produto</h2>
        <div class="info">
            <p><strong>Nome:</strong> ${produto.nome}</p>
            <p><strong>Descrição:</strong> ${produto.descricao}</p>
            <p class="price"><strong>Preço:</strong> R$ ${produto.preco}</p>
            <c:if test="${produto.precoComDesconto != null && produto.precoComDesconto > 0}">
                <p class="discount"><strong>Preço com Desconto:</strong> R$ ${produto.precoComDesconto}</p>
            </c:if>
        </div>
        <form action="/pedidos/novo" method="get">
            <input type="hidden" name="produtoId" value="${produto.id}">
            <button type="submit">Comprar</button>
        </form>
    </div>
</body>
</html>
