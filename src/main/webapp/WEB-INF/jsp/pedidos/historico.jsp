<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Histórico de Pedidos</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            width: 95vw;
            margin: 48px auto;
            background: #fff;
            padding: 42px 36px 36px 36px;
            border-radius: 20px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.18);
            overflow-x: auto;
        }
        .branding {
            font-size: 1.25rem;
            color: #d90429;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 18px;
            text-align: center;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }
        h2 {
            color: #d90429;
            margin: 0;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .saldo {
            font-size: 1.15rem;
            color: #d90429;
            font-weight: 600;
            background: #f8f9fa;
            padding: 8px 18px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(220,4,41,0.08);
        }
        .btn-voltar {
            background: linear-gradient(90deg, #d90429 60%, #232526 100%);
            color: #fff;
            padding: 12px 32px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1.12rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(220,4,41,0.10);
            transition: background 0.2s, box-shadow 0.2s;
            cursor: pointer;
            display: inline-block;
        }
        .btn-voltar:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
        .btn-pagar {
            background: linear-gradient(90deg, #28a745 60%, #218838 100%);
            color: #fff;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: bold;
            margin-right: 6px;
            box-shadow: 0 2px 8px rgba(40,167,69,0.10);
            cursor: pointer;
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn-pagar:hover {
            background: linear-gradient(90deg, #218838 60%, #28a745 100%);
            box-shadow: 0 4px 16px rgba(40,167,69,0.16);
        }
        .btn-cancelar {
            background: linear-gradient(90deg, #dc3545 60%, #b71c1c 100%);
            color: #fff;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(220,53,69,0.10);
            cursor: pointer;
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn-cancelar:hover {
            background: linear-gradient(90deg, #b71c1c 60%, #dc3545 100%);
            box-shadow: 0 4px 16px rgba(220,53,69,0.16);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 32px;
            background: #f8f9fa;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
        }
        th, td {
            padding: 14px 10px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }
        td.acao {
            text-align: center;
            vertical-align: middle;
        }
        .acoes-btns {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-pagar, .btn-cancelar {
            min-width: 110px;
            max-width: 140px;
            width: 120px;
            text-align: center;
            margin: 0 !important;
        }
        th {
            background: #d90429;
            color: #fff;
            font-size: 1.08rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .status-pago { color: #28a745; font-weight: bold; }
        .status-cancelado { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Histórico de Pedidos</div>
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
            <div class="saldo">Saldo: R$ ${saldo}</div>
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
                <th style="text-align:center;">Ações</th>
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
                    <td>
                        <c:if test="${pedido.status == 'PENDENTE'}">
                            <span style="color:#d90429;font-weight:bold;">Pendente</span>
                        </c:if>
                        <c:if test="${pedido.status == 'PAGO'}">
                            <span class="status-pago">Pago</span>
                        </c:if>
                        <c:if test="${pedido.status == 'CANCELADO'}">
                            <span class="status-cancelado">Cancelado</span>
                        </c:if>
                    </td>
                    <td>${pedido.dataPedido}</td>
                    <td class="acao">
                        <div class="acoes-btns">
                            <c:if test="${pedido.status == 'PENDENTE'}">
                                <form action="/pedidos/pagar/${pedido.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn-pagar">Pagar</button>
                                </form>
                                <form action="/pedidos/cancelar/${pedido.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn-cancelar">Cancelar</button>
                                </form>
                            </c:if>
                            <c:if test="${pedido.status == 'PAGO'}">
                                <span class="status-pago">✔</span>
                            </c:if>
                            <c:if test="${pedido.status == 'CANCELADO'}">
                                <span class="status-cancelado">✖</span>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
