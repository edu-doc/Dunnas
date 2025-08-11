<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Fornecedor - Sistema Dunnas</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #232323;
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .form-container {
            background: #fff;
            padding: 40px 30px 30px 30px;
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.18);
            max-width: 400px;
            width: 100%;
        }
        .logo {
            display: block;
            margin: 0 auto 18px auto;
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: #232323;
            box-shadow: 0 2px 8px rgba(211,47,47,0.12);
        }
        h1 {
            text-align: center;
            color: #d32f2f;
            margin-bottom: 28px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 7px; font-weight: 500; color: #232323; }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d9e6;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            background: #f8fafc;
            color: #232323;
            transition: border-color 0.2s;
        }
        input:focus {
            border-color: #d32f2f;
            outline: none;
            box-shadow: 0 0 5px rgba(211,47,47,0.18);
        }
        button {
            background-color: #d32f2f;
            color: #fff;
            padding: 12px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 17px;
            font-weight: 500;
            margin-top: 5px;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
        }
        button:hover {
            background-color: #c62828;
        }
        .error {
            color: #fff;
            background: #d32f2f;
            border: 1px solid #c62828;
            border-radius: 5px;
            margin-bottom: 18px;
            padding: 10px;
            text-align: center;
            font-weight: 500;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #d32f2f;
            text-decoration: none;
            font-weight: 500;
        }
        .back-link a:hover {
            text-decoration: underline;
            color: #232323;
        }
        .required {
            color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div style="text-align:center; margin-bottom:18px;">
            <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px;"></span>
        </div>
        <h1>Cadastro de Fornecedor</h1>

        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>


    <form action="/fornecedores/salvar" method="post" id="formCadastroFornecedor">
            <div class="form-group">
                <label for="nome">Nome da Empresa <span class="required">*</span></label>
                <input type="text" id="nome" name="nome" required maxlength="50" value="${fornecedor.nome}">
            </div>
            <div class="form-group">
                <label for="cnpj">CNPJ <span class="required">*</span></label>
                <input type="text" id="cnpj" name="cnpj" required maxlength="18" placeholder="CNPJ" value="${fornecedor.cnpj}">
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#cnpj').mask('00.000.000/0000-00');
                $('#formCadastroFornecedor').on('submit', function() {
                    var cnpj = $('#cnpj').val().replace(/\D/g, '');
                    $('#cnpj').val(cnpj);
                });
            });
        </script>
        <script>
        $(document).ready(function(){
            $('#cnpj').mask('00.000.000/0000-00');
        });
        </script>

        <div class="back-link">
            <a href="/login">← Voltar para o Login</a>
        </div>
    </div>

    <!-- Script removido: máscara já faz a formatação -->
</body>
</html>
