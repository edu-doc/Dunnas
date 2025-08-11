<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Meus Produtos</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1000px;
            margin: 48px auto;
            background: #fff;
            padding: 42px 36px 36px 36px;
            border-radius: 20px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.18);
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
        .add-btn {
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
        .add-btn:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
        .perfil-btn {
            background: linear-gradient(90deg, #6c757d 60%, #343a40 100%);
            color: #fff;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: bold;
            margin-right: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.10);
            cursor: pointer;
            transition: background 0.2s, box-shadow 0.2s;
        }
        .perfil-btn:hover {
            background: linear-gradient(90deg, #343a40 60%, #6c757d 100%);
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }
        .logout-btn {
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
        .logout-btn:hover {
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
        .actions button, .actions a {
            margin-right: 8px;
            padding: 10px 22px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.02rem;
            font-weight: bold;
        }
        .edit-btn {
            background: linear-gradient(90deg, #28a745 60%, #218838 100%);
            color: #fff;
        }
        .edit-btn:hover {
            background: linear-gradient(90deg, #218838 60%, #28a745 100%);
        }
        .delete-btn {
            background: linear-gradient(90deg, #dc3545 60%, #b71c1c 100%);
            color: #fff;
        }
        .delete-btn:hover {
            background: linear-gradient(90deg, #b71c1c 60%, #dc3545 100%);
        }
        .inativo {
            color: #888;
            font-size: 0.98rem;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Produtos do Fornecedor</div>
        <div class="saldo">Saldo atual: R$ <c:out value="${fornecedor.saldo}"/></div>
        <div class="top-bar">
            <h2>Meus Produtos</h2>
            <div style="display:flex;gap:12px;align-items:center;">
                <form action="/fornecedores/perfil" method="get" style="margin:0;display:inline;">
                    <button type="submit" class="perfil-btn">Meu Perfil</button>
                </form>
                <a href="/produtos/cadastro" class="add-btn">+ Cadastrar Novo Produto</a>
                <form action="/auth/logout" method="get" style="margin:0;display:inline;">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </div>
        </div>
        <table>
            <tr>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Preço</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="produto" items="${produtos}">
                <tr>
                    <td>${produto.nome}</td>
                    <td>${produto.descricao}</td>
                    <td>R$ ${produto.preco}</td>
                    <td class="actions">
                        <a href="/produtos/editar/${produto.id}" class="edit-btn">Editar</a>
                        <c:if test="${produto.ativo}">
                            <form action="/produtos/excluir" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${produto.id}">
                                <button type="submit" class="delete-btn">Excluir</button>
                            </form>
                        </c:if>
                        <c:if test="${!produto.ativo}">
                            <span class="inativo">Produto inativo</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
