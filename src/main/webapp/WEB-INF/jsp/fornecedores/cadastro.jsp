<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Fornecedor - Sistema Dunnas</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 500px; margin: 50px auto; padding: 20px; background-color: #f5f5f5; }
        .form-container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input[type="text"], input[type="email"], input[type="password"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; box-sizing: border-box; }
        input:focus { border-color: #007bff; outline: none; box-shadow: 0 0 5px rgba(0,123,255,0.3); }
        button { background-color: #007bff; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; margin-top: 10px; }
        button:hover { background-color: #0056b3; }
        .error { color: red; margin-bottom: 15px; padding: 10px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 4px; }
        .back-link { text-align: center; margin-top: 20px; }
        .back-link a { color: #007bff; text-decoration: none; }
        .back-link a:hover { text-decoration: underline; }
        .required { color: red; }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Cadastro de Fornecedor</h1>

        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>


        <form action="/fornecedores/salvar" method="post">
            <div class="form-group">
                <label for="nome">Nome da Empresa <span class="required">*</span></label>
                <input type="text" id="nome" name="nome" required maxlength="50" value="${fornecedor.nome}">
            </div>

            <div class="form-group">
                <label for="cnpj">CNPJ <span class="required">*</span></label>
                <input type="text" id="cnpj" name="cnpj" required maxlength="14" placeholder="Apenas números" value="${fornecedor.cnpj}">
            </div>

            <div class="form-group">
                <label for="email">Email <span class="required">*</span></label>
                <input type="email" id="email" name="email" required maxlength="100" value="${fornecedor.email}">
            </div>

            <div class="form-group">
                <label for="usuario">Nome de Usuário <span class="required">*</span></label>
                <input type="text" id="usuario" name="usuario" required maxlength="50" placeholder="Para fazer login" value="${fornecedor.usuario}">
            </div>

            <div class="form-group">
                <label for="senha">Senha <span class="required">*</span></label>
                <input type="password" id="senha" name="senha" required minlength="6" placeholder="Mínimo 6 caracteres">
            </div>

            <button type="submit">Cadastrar Fornecedor</button>
        </form>

        <div class="back-link">
            <a href="/login">← Voltar para o Login</a>
        </div>
    </div>

    <script>
        // Formatação do CNPJ
        document.getElementById('cnpj').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
    </script>
</body>
</html>
