<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Painel do Administrador</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 980px;
            margin: 56px auto;
            background: #fff;
            padding: 44px 36px 36px 36px;
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
        h1 {
            text-align: center;
            color: #d90429;
            margin-bottom: 32px;
            font-size: 2.1rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .section-title {
            margin-top: 40px;
            color: #232526;
            font-size: 1.35rem;
            font-weight: 700;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: #f8f9fa;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }
        th, td {
            padding: 13px 10px;
            border-bottom: 1.5px solid #eaeaea;
            text-align: left;
            font-size: 1.08rem;
        }
        th {
            background: #eaeaea;
            color: #d90429;
            font-weight: 700;
        }
        .actions {
            display: flex;
            gap: 7px;
        }
        .btn {
            background: linear-gradient(90deg, #d90429 60%, #232526 100%);
            color: #fff;
            padding: 9px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.08rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(220,4,41,0.10);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn:disabled {
            background: #aaa;
        }
        .btn:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
        .btn[style*="background:#c0392b;"] {
            background: linear-gradient(90deg, #c0392b 60%, #d90429 100%) !important;
        }
        .form-inline {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        input, select {
            padding: 10px;
            border-radius: 8px;
            border: 1.5px solid #d90429;
            font-size: 1.08rem;
            background: #f8f9fa;
            transition: border 0.2s;
        }
        input:focus, select:focus {
            border-color: #232526;
            outline: none;
        }
        .error-msg {
            color: #d90429;
            background: #fbeeea;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: bold;
            border: 1px solid #d90429;
        }
        .success-msg {
            color: #27ae60;
            background: #eafaf1;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: bold;
            border: 1px solid #27ae60;
        }
    </style>
</head>
<body>
    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="success-msg">${success}</div>
    </c:if>
    <div class="container">
        <div class="branding">Dunnas - Painel do Administrador</div>
        <h1>Painel do Administrador</h1>
    <h2 class="section-title">Usuários</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Usuário</th>
            <th>Email</th>
            <th>Role</th>
            <th>Verificado</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="usuario" items="${usuarios}">
            <tr>
                <td>${usuario.id}</td>
                <td>${usuario.usuario}</td>
                <td>${usuario.email}</td>
                <td>${usuario.role}</td>
                <td><c:choose><c:when test="${usuario.verificado}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
                <td class="actions">
                    <form action="/admin/usuario/editar" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="${usuario.id}">
                        <button type="submit" class="btn">Editar</button>
                    </form>
                    <c:if test="${usuario.role ne 'ADMIN'}">
                        <form action="/admin/usuario/excluir" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja excluir este usuário?');">
                            <input type="hidden" name="id" value="${usuario.id}">
                            <button type="submit" class="btn" style="background:#c0392b;">Excluir</button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <h2 class="section-title">Cupons</h2>
    <form class="form-inline" action="/admin/cupom/criar" method="post">
        <input type="text" name="codigo" placeholder="Código" required>
        <input type="number" name="desconto" placeholder="Desconto" step="0.01" required>
        <input type="date" name="dataValidade" required>
        <select name="ativo">
            <option value="true">Ativo</option>
            <option value="false">Inativo</option>
        </select>
        <button type="submit" class="btn">Criar Cupom</button>
    </form>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Código</th>
            <th>Desconto</th>
            <th>Validade</th>
            <th>Ativo</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cupom" items="${cupons}">
            <tr>
                <td>${cupom.id}</td>
                <td>${cupom.codigo}</td>
                <td>${cupom.desconto}</td>
                <td>${cupom.dataValidade}</td>
                <td><c:choose><c:when test="${cupom.ativo}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></td>
                <td class="actions">
                    <form action="/admin/cupom/editar" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="${cupom.id}">
                        <button type="submit" class="btn">Editar</button>
                    </form>
                    <form action="/admin/cupom/excluir" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja excluir este cupom?');">
                        <input type="hidden" name="id" value="${cupom.id}">
                        <button type="submit" class="btn" style="background:#c0392b;">Excluir</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="/auth/logout" class="btn">Sair</a>
</div>
</body>
</html>
