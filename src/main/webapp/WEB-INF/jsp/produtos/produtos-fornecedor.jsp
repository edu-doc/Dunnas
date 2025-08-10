<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Meus Produtos</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 900px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #007bff; margin-bottom: 30px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .add-btn {
            background: linear-gradient(90deg, #007bff 60%, #0056b3 100%);
            color: #fff;
            padding: 12px 28px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            transition: background 0.2s, box-shadow 0.2s;
            cursor: pointer;
            text-decoration: none;
        }
        .add-btn:hover {
            background: linear-gradient(90deg, #0056b3 60%, #007bff 100%);
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #007bff; color: #fff; }
        tr:hover { background: #f1f1f1; }
        .actions button, .actions a { margin-right: 8px; padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
        .edit-btn { background: #28a745; color: #fff; }
        .edit-btn:hover { background: #218838; }
        .delete-btn { background: #dc3545; color: #fff; }
        .delete-btn:hover { background: #a71d2a; }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar" style="justify-content:space-between;align-items:center;">
            <h2 style="margin:0;">Meus Produtos</h2>
            <div style="display:flex;gap:12px;align-items:center;">
                <a href="/produtos/cadastro?fornecedorId=${fornecedor.id}" class="add-btn">+ Cadastrar Novo Produto</a>
                <form action="/auth/logout" method="get" style="margin:0;display:inline;">
                    <button type="submit" style="background:#dc3545;color:#fff;border:none;padding:8px 18px;border-radius:5px;cursor:pointer;font-size:15px;font-weight:bold;">Logout</button>
                </form>
            </div>
        </div>
        <table>
            <tr>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Preço</th>
                <th>Preço com Desconto</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="produto" items="${produtos}">
                <tr>
                    <td>${produto.nome}</td>
                    <td>${produto.descricao}</td>
                    <td>R$ ${produto.preco}</td>
                    <td>
                        <c:choose>
                            <c:when test="${produto.precoComDesconto != null && produto.precoComDesconto > 0}">
                                R$ ${produto.precoComDesconto}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions">
                        <a href="/produtos/editar/${produto.id}" class="edit-btn">Editar</a>
                        <form action="/produtos/excluir" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${produto.id}">
                            <input type="hidden" name="fornecedorId" value="${fornecedor.id}">
                            <button type="submit" class="delete-btn">Excluir</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
