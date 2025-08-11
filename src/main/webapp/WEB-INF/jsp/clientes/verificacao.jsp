<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verificação de Conta - Sistema Dunnas</title>
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
            text-align: center;
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
        .verification-icon {
            font-size: 48px;
            color: #d32f2f;
            margin-bottom: 20px;
        }
        .message {
            color: #232323;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .email-display {
            background-color: #f8fafc;
            padding: 10px;
            border-radius: 4px;
            margin: 20px 0;
            font-weight: bold;
            color: #d32f2f;
            border-left: 4px solid #d32f2f;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 500;
            color: #232323;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d9e6;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            text-align: center;
            font-weight: bold;
            letter-spacing: 2px;
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
            margin-top: 20px;
            text-align: center;
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
    </style>
</head>
<body>
    <div class="form-container">
        <div style="text-align:center; margin-bottom:18px;">
            <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px;">Projeto Dunnas</span>
        </div>
        <div class="verification-icon">📧</div>
        <h1>Verificação de Conta</h1>
        <div class="message">
            <p>Digite o código de verificação de 6 dígitos que enviamos para seu email:</p>
            <c:if test="${email != null}">
                <div class="email-display">${email}</div>
            </c:if>
        </div>
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        <form action="/clientes/verificar" method="post">
            <c:if test="${email == null}">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
            </c:if>
            <c:if test="${email != null}">
                <input type="hidden" name="email" value="${email}">
            </c:if>
            <div class="form-group">
                <label for="codigo">Código de Verificação:</label>
                <input type="text" id="codigo" name="codigo" required maxlength="6" 
                       placeholder="000000" pattern="[0-9]{6}">
            </div>
            <button type="submit">Verificar Conta</button>
        </form>
        <div class="back-link">
            <a href="/login">← Voltar ao Login</a>
        </div>
    </div>

    <script>
        document.getElementById('codigo').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
        
        window.onload = function() {
            document.getElementById('codigo').focus();
        };
    </script>
</body>
</html>
