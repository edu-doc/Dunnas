<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login - Sistema Dunnas</title>
        <style>
            body { font-family: Arial, sans-serif; max-width: 400px; margin: 50px auto; padding: 20px; }
            .form-group { margin-bottom: 15px; }
            label { display: block; margin-bottom: 5px; font-weight: bold; }
            input[type="text"], input[type="password"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
            button { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
            button:hover { background-color: #0056b3; }
            .error { color: red; margin-bottom: 15px; }
            .success { color: green; margin-bottom: 15px; }
        </style>
    </head>
<body>
    <h1>Login</h1>

    <c:if test="${error != null}">
        <div class="error">${error}</div>
    </c:if>

    <c:if test="${param.error != null}">
        <div class="error">Usuário ou senha inválidos.</div>
    </c:if>

    <c:if test="${param.logout != null}">
        <div class="success">Você saiu do sistema.</div>
    </c:if>

    <form action="/auth/login" method="post">
        <div class="form-group">
            <label for="username">Usuário:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button type="submit">Entrar</button>
    </form>

    <p style="text-align: center; margin-top: 20px;">
        Não tem uma conta? Cadastre-se como:
        <br>
        <a href="/clientes/novo" style="margin-right: 10px;">Cliente</a>
        <a href="/fornecedores/novo">Fornecedor</a>
    </p>
</body>
</html>