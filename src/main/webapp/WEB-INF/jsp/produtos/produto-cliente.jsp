<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Produtos Disponíveis</title>
</head>
<body>
    <h2>Produtos Disponíveis</h2>
    <table border="1">
        <tr>
            <th>Nome</th>
            <th>Descrição</th>
            <th>Preço</th>
            <th>Ação</th>
        </tr>
        <c:forEach var="produto" items="${produtos}">
            <tr>
                <td>${produto.nome}</td>
                <td>${produto.descricao}</td>
                <td>R$ ${produto.preco}</td>
                <td>
                    <form action="/pedidos/novo" method="get">
                        <input type="hidden" name="produtoId" value="${produto.id}">
                        <button type="submit">Comprar</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>