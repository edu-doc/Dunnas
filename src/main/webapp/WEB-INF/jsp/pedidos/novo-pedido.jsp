<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Novo Pedido</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 600px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #007bff; margin-bottom: 30px; }
        label { font-weight: bold; color: #333; display: block; margin-top: 15px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-top: 5px; }
        .prod-list { margin-bottom: 20px; }
        .prod-item { display: flex; align-items: center; margin-bottom: 10px; }
        .prod-item label { flex: 1; margin: 0; }
        .prod-item input[type="checkbox"] { margin-right: 10px; }
        button { background: #007bff; color: #fff; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; margin-top: 20px; width: 100%; font-size: 16px; }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Novo Pedido - ${fornecedor.nome}</h2>
        <form action="/pedidos/criar" method="post">
            <input type="hidden" name="fornecedorId" value="${fornecedor.id}">
            <label>Selecione os produtos:</label>
            <div class="prod-list">
                <c:forEach var="produto" items="${produtos}">
                    <div class="prod-item">
                        <input type="checkbox" name="produtoIds" value="${produto.id}">
                        <label>${produto.nome} - R$ ${produto.preco} <span style="color:#888;">${produto.descricao}</span></label>
                    </div>
                </c:forEach>
            </div>
            <label for="cupom">Cupom de desconto:</label>
            <input type="text" id="cupom" name="cupom" placeholder="Digite o cupom se tiver">
            <button type="submit">Finalizar Pedido</button>
        </form>
        <form action="/produtos/produto-cliente" method="get" style="margin-top:10px;">
            <button type="submit" style="background:#6c757d;color:#fff;width:100%;border:none;padding:12px 20px;border-radius:5px;cursor:pointer;font-size:16px;">Voltar</button>
        </form>
        </form>
    </div>
</body>
</html>
