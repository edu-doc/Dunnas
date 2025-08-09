<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Fornecedor</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 400px; margin: 50px auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="password"], input[type="email"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        button:hover { background-color: #0056b3; }
        .error { color: red; margin-bottom: 15px; }
        .success { color: green; margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>Cadastro de Fornecedor</h1>
    <c:if test="${error != null}">
        <div class="error">${error}</div>
    </c:if>
    <form action="/fornecedores/salvar" method="post">
        <div class="form-group">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>
        </div>
        <div class="form-group">
            <label for="cnpj">CNPJ:</label>
            <input type="text" id="cnpj" name="cnpj" required>
        </div>
        <div class="form-group">
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="usuario">Usuário:</label>
            <input type="text" id="usuario" name="usuario" required>
        </div>
        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>
        <button type="submit">Cadastrar</button>
    </form>
    <p style="text-align: center; margin-top: 20px;">
        <a href="/login">Já tem uma conta? Faça login</a>
    </p>
</body>
</html>
