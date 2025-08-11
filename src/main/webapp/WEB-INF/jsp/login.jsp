<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login - Sistema Dunnas</title>
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
            .login-container {
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
                color: #232323;
                margin-bottom: 28px;
                font-weight: 600;
                letter-spacing: 1px;
            }
            .form-group { margin-bottom: 20px; }
            label { display: block; margin-bottom: 7px; font-weight: 500; color: #232323; }
            input[type="text"], input[type="password"] {
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
            .success {
                color: #fff;
                background: #388e3c;
                border: 1px solid #2e7d32;
                border-radius: 5px;
                margin-bottom: 18px;
                padding: 10px;
                text-align: center;
                font-weight: 500;
            }
            .extra-links {
                text-align: center;
                margin-top: 25px;
                font-size: 15px;
                color: #232323;
            }
            .extra-links a {
                color: #d32f2f;
                text-decoration: none;
                margin: 0 8px;
                font-weight: 500;
            }
            .extra-links a:hover {
                text-decoration: underline;
                color: #fff;
            }
        </style>
    </head>
<body>
    <div class="login-container">
        <div style="text-align:center; margin-bottom:18px;">
            <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px;">Projeto Dunnas</span>
        </div>
        <h1>Login</h1>
        <c:if test="${param.error != null}">
            <div class="error">Usuário ou senha inválidos.</div>
        </c:if>
        <c:if test="${param.logout != null}">
            <div class="success">Você saiu do sistema.</div>
        </c:if>
        <form action="/login" method="post">
            <div class="form-group">
                <label for="username">Usuário</label>
                <input type="text" id="username" name="username" required autocomplete="username">
            </div>
            <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" required autocomplete="current-password">
            </div>
            <button type="submit">Entrar</button>
        </form>
        <form action="/clientes/verificar" method="get" style="margin-top:10px;">
            <button type="submit" style="width:100%;background:#28a745;">Verificar Conta</button>
        </form>
        <div class="extra-links">
            Não tem uma conta? Cadastre-se como:<br>
            <a href="/clientes/novo">Cliente</a> |
            <a href="/fornecedores/novo">Fornecedor</a>
        </div>
    </div>
</body>
</html>