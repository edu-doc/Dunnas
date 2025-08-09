<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verificação de Conta - Sistema Dunnas</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            max-width: 500px; 
            margin: 50px auto; 
            padding: 20px; 
            background-color: #f5f5f5;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 { 
            color: #333;
            margin-bottom: 20px;
        }
        .verification-icon {
            font-size: 48px;
            color: #007bff;
            margin-bottom: 20px;
        }
        .message {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .email-display {
            background-color: #e7f3ff;
            padding: 10px;
            border-radius: 4px;
            margin: 20px 0;
            font-weight: bold;
            color: #007bff;
        }
        .form-group { 
            margin-bottom: 20px; 
            text-align: left;
        }
        label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: bold; 
            color: #555;
        }
        input[type="text"], input[type="email"] { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid #ddd; 
            border-radius: 4px; 
            font-size: 16px;
            box-sizing: border-box;
            text-align: center;
            font-weight: bold;
            letter-spacing: 2px;
        }
        input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        button { 
            background-color: #28a745; 
            color: white; 
            padding: 12px 24px; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-size: 16px;
            margin: 10px;
        }
        button:hover { 
            background-color: #218838; 
        }
        .error { 
            color: red; 
            margin-bottom: 15px; 
            padding: 10px;
            background-color: #ffe6e6;
            border: 1px solid #ff9999;
            border-radius: 4px;
        }
        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
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
        // Formatação do código - apenas números
        document.getElementById('codigo').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
        
        // Auto-focus no campo do código
        window.onload = function() {
            document.getElementById('codigo').focus();
        };
    </script>
</body>
</html>
