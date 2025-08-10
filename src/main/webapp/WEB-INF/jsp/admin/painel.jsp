<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Painel do Administrador</title>
    <link rel="stylesheet" href="/static/style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 900px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        th, td { padding: 10px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #eaeaea; }
        .section-title { margin-top: 40px; color: #34495e; }
        .btn { background: #2980b9; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; margin-right: 5px; }
        .btn:disabled { background: #aaa; }
        .actions { display: flex; gap: 5px; }
        .form-inline { display: flex; gap: 10px; margin-bottom: 20px; }
        input, select { padding: 6px; border-radius: 4px; border: 1px solid #ccc; }
    </style>
</head>
<body>
<div class="container">
    <h1>Painel do Administrador</h1>
    <h2 class="section-title">Usuários</h2>
    <form class="form-inline" action="/admin/usuario/criar" method="post">
        <input type="text" name="usuario" placeholder="Usuário" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="senha" placeholder="Senha" required>
        <select name="role">
            <option value="CLIENTE">Cliente</option>
            <option value="FORNECEDOR">Fornecedor</option>
            <option value="ADMIN">Admin</option>
        </select>
        <button type="submit" class="btn">Criar Usuário</button>
    </form>
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
                    <form action="/admin/usuario/excluir" method="post" style="display:inline;" onsubmit="return confirm('Tem certeza que deseja excluir este usuário?');">
                        <input type="hidden" name="id" value="${usuario.id}">
                        <button type="submit" class="btn" style="background:#c0392b;">Excluir</button>
                    </form>
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
