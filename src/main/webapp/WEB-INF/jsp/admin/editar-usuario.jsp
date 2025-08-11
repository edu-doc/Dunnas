<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Usuário</title>
    <link rel="stylesheet" href="/static/style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 500px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; }
        .form-group { margin-bottom: 18px; }
        label { font-weight: 600; color: #333; }
        input, select { width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc; margin-top: 5px; }
        .btn { background: #2980b9; color: #fff; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-top: 18px; }
        .btn-voltar { background: #6c757d; margin-left: 8px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Editar Usuário</h1>
    <form action="/admin/usuario/editar" method="post">
        <input type="hidden" name="id" value="${usuario.id}" />
        <div class="form-group">
            <label for="usuario">Usuário:</label>
            <input type="text" id="usuario" name="usuario" value="${usuario.usuario}" required />
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${usuario.email}" required />
        </div>
        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" placeholder="Digite nova senha se desejar alterar" />
        </div>
        <button type="submit" class="btn">Salvar Alterações</button>
        <a href="/admin" class="btn btn-voltar">Voltar</a>
    </form>
</div>
</body>
</html>
