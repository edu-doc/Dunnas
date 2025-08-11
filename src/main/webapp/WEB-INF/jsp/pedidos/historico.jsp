<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Histórico de Pedidos</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: linear-gradient(120deg, #e0e7ff 0%, #f5f5f5 100%); }
        .container { max-width: 950px; margin: 50px auto; background: #fff; padding: 38px 32px 32px 32px; border-radius: 18px; box-shadow: 0 4px 24px rgba(0,0,0,0.10); }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h2 { color: #007bff; margin: 0; font-size: 2rem; font-weight: 700; }
        .btn-voltar { background: linear-gradient(90deg, #6c757d 60%, #343a40 100%); color: #fff; padding: 10px 28px; border: none; border-radius: 7px; text-decoration: none; font-size: 1.08rem; font-weight: bold; box-shadow: 0 2px 8px rgba(0,0,0,0.08); transition: background 0.2s, box-shadow 0.2s; cursor: pointer; display: inline-block; }
        .btn-voltar:hover { background: linear-gradient(90deg, #343a40 60%, #6c757d 100%); box-shadow: 0 4px 16px rgba(0,0,0,0.12); }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 12px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #007bff; color: #fff; }
        tr:hover { background: #f1f1f1; }
    </style>
</head>
<body>
    <div class="container">
        <c:if test="${not empty success}">
            <div style="background:#d4edda;color:#155724;padding:12px 18px;border-radius:7px;margin-bottom:18px;border:1px solid #c3e6cb;font-weight:500;">
                ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div style="background:#f8d7da;color:#721c24;padding:12px 18px;border-radius:7px;margin-bottom:18px;border:1px solid #f5c6cb;font-weight:500;">
                ${error}
            </div>
        </c:if>
        <div class="top-bar">
            <h2>Histórico de Pedidos</h2>
            <form action="/produtos/produto-cliente" method="get" style="margin:0;">
                <button type="submit" class="btn-voltar">Voltar</button>
            </form>
        </div>
        <table>
            <tr>
                <th>Número</th>
                <th>Fornecedor</th>
                <th>Produtos</th>
                <th>Valor Total</th>
                <th>Desconto</th>
                <th>Status</th>
                <th>Data</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="pedido" items="${pedidos}">
                <tr>
                    <td>${pedido.id}</td>
                    <td>${pedido.fornecedor.nome}</td>
                    <td>
                        <c:forEach var="produto" items="${pedido.produtos}">
                            ${produto.nome}<br/>
                        </c:forEach>
                    </td>
                    <td>R$ ${pedido.valorTotal}</td>
                    <td>R$ ${pedido.desconto}</td>
                    <td>${pedido.status}</td>
                    <td>${pedido.dataPedido}</td>
                    <td>
                        <c:if test="${pedido.status == 'PENDENTE'}">
                            <form action="/pedidos/pagar/${pedido.id}" method="post" style="display:inline;">
                                <button type="submit" class="btn-voltar" style="background:#28a745;">Pagar</button>
                            </form>
                            <form action="/pedidos/cancelar/${pedido.id}" method="post" style="display:inline; margin-left:8px;">
                                <button type="submit" class="btn-voltar" style="background:#dc3545;">Cancelar</button>
                            </form>
                        </c:if>
                        <c:if test="${pedido.status == 'PAGO'}">
                            <span style="color:#28a745;">Pago</span>
                        </c:if>
                        <c:if test="${pedido.status == 'CANCELADO'}">
                            <span style="color:#dc3545;">Cancelado</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
