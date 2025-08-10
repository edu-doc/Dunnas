<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro Realizado - Sistema Dunnas</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            max-width: 500px; 
            margin: 50px auto; 
            padding: 20px; 
            background-color: #f5f5f5;
        }
        .success-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success-icon {
            font-size: 48px;
            color: #28a745;
            margin-bottom: 20px;
        }
        h1 { 
            color: #28a745;
            margin-bottom: 20px;
        }
        .message {
            color: #333;
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 30px;
        }
        .email-highlight {
            background-color: #e7f3ff;
            padding: 10px;
            border-radius: 4px;
            border-left: 4px solid #007bff;
            margin: 20px 0;
        }
        .btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 4px;
            margin: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">✓</div>
        
        <h1>Cadastro Realizado com Sucesso!</h1>
        
        <div class="message">
            <p>Seu cadastro foi realizado com sucesso!</p>
            
            <div class="email-highlight">
                <strong>📧 Verificação de Email</strong><br>
                Enviamos um código de verificação para:<br>
                <strong>${email}</strong>
            </div>
            
            <p>Para ativar sua conta e fazer login, você precisa verificar seu email com o código que enviamos.</p>
        </div>

    <a href="/clientes/verificar" class="btn">Verificar Conta Agora</a>
        <a href="/login" class="btn btn-secondary">Voltar ao Login</a>
    </div>
</body>
</html>
