<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Produtos Disponíveis</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #232323;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            max-width: 950px;
            margin: 48px auto;
            background: #fff;
            padding: 38px 32px 32px 32px;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.18);
        }
        .branding {
            text-align:center;
            margin-bottom:18px;
        }
        .branding span {
            font-size:2rem;
            font-weight:700;
            color:#d32f2f;
            letter-spacing:2px;
        }
        h2 {
            text-align: center;
            color: #d32f2f;
            margin-bottom: 18px;
            font-size:2rem;
            font-weight:700;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: #f8fafc;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
            font-size: 1.08rem;
        }
        th {
            background: #d32f2f;
            color: #fff;
            font-weight: 600;
            border-bottom: 2px solid #c62828;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .pedido-btn {
            background: #d32f2f;
            color: #fff;
            border: none;
            padding: 10px 22px;
            border-radius: 7px;
            cursor: pointer;
            font-size: 1.08rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
        }
        .pedido-btn:hover {
            background: #c62828;
        }
        .top-btn {
            background: #d32f2f;
            color: #fff;
            padding: 10px 28px;
            border: none;
            border-radius: 7px;
            font-size: 1.08rem;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
            cursor: pointer;
            display: inline-block;
        }
        .top-btn:hover {
            background: #c62828;
        }
        .saldo {
            margin-bottom:18px;
            font-size:1.15rem;
            color:#d32f2f;
            font-weight:600;
            text-align:right;
        }
    </style>
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">
            <span>Projeto Dunnas</span>
        </div>
        <h2>Produtos Disponíveis</h2>
        <div style="display:flex;gap:12px;align-items:center;justify-content:center;margin-bottom:24px;flex-wrap:wrap;">
            <form action="/clientes/perfil" method="get" style="margin:0;">
                <button type="submit" class="top-btn" style="background:#6c757d;">Meu Perfil</button>
            </form>
            <form action="/pedidos/historico" method="get" style="margin:0;">
                <button type="submit" class="top-btn" style="background:#d32f2f;">Histórico de Pedidos</button>
            </form>
            <form action="/clientes/pix" method="get" style="margin:0;display:inline;">
                <button type="submit" class="top-btn" style="background:#388e3c;">Adicionar Saldo via PIX</button>
            </form>
            <form action="/auth/logout" method="get" style="margin:0;display:inline;">
                <button type="submit" class="top-btn" style="background:#c62828;">Logout</button>
            </form>
        </div>
        <div class="saldo">Saldo atual: R$ <c:out value="${usuario.saldo}"/></div>
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
                <td>${produto.fornecedorNome}</td>
                    <td>
                        <form action="/pedidos/novo" method="get">
                    <input type="hidden" name="fornecedorId" value="${produto.fornecedorId}">
                            <button type="submit" class="pedido-btn">Fazer Pedido</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>