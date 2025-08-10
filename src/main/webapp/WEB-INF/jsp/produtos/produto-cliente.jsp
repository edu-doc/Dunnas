<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Produtos Disponíveis</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 900px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #007bff; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #007bff; color: #fff; }
        tr:hover { background: #f1f1f1; }
        .pedido-btn { background: #28a745; color: #fff; border: none; padding: 8px 18px; border-radius: 5px; cursor: pointer; font-size: 15px; font-weight: bold; }
        .pedido-btn:hover { background: #218838; }
    </style>
</head>
<body>
    <div class="container">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;gap:12px;">
            <h2 style="margin:0;">Produtos Disponíveis</h2>
            <div style="display:flex;gap:12px;align-items:center;">
                <form action="/clientes/perfil" method="get" style="margin:0;">
                    <button type="submit" style="background:#6c757d;color:#fff;padding:10px 28px;border:none;border-radius:7px;text-decoration:none;font-size:1.08rem;font-weight:bold;box-shadow:0 2px 8px rgba(0,0,0,0.08);transition:background 0.2s,box-shadow 0.2s;cursor:pointer;display:inline-block;">Meu Perfil</button>
                </form>
                <form action="/pedidos/historico" method="get" style="margin:0;">
                    <button type="submit" style="background:linear-gradient(90deg,#007bff 60%,#0056b3 100%);color:#fff;padding:10px 28px;border:none;border-radius:7px;text-decoration:none;font-size:1.08rem;font-weight:bold;box-shadow:0 2px 8px rgba(0,0,0,0.08);transition:background 0.2s,box-shadow 0.2s;cursor:pointer;display:inline-block;">Histórico de Pedidos</button>
                </form>
                <form action="/auth/logout" method="get" style="margin:0;display:inline;">
                    <button type="submit" style="background:#dc3545;color:#fff;border:none;padding:10px 28px;border-radius:7px;cursor:pointer;font-size:1.08rem;font-weight:bold;">Logout</button>
                </form>
            </div>
        </div>
        <table>
            <tr>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Preço</th>
                <th>Fornecedor</th>
                <th>Ação</th>
            </tr>
            <c:forEach var="produto" items="${produtos}">
                <tr>
                    <td>${produto.nome}</td>
                    <td>${produto.descricao}</td>
                    <td>R$ ${produto.preco}</td>
                    <td>${produto.fornecedor.nome}</td>
                    <td>
                        <form action="/pedidos/novo" method="get">
                            <input type="hidden" name="fornecedorId" value="${produto.fornecedor.id}">
                            <button type="submit" class="pedido-btn">Fazer Pedido</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>