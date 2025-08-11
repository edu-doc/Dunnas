<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro Realizado - Sistema Dunnas</title>
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
        .success-container {
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
        .success-icon {
            font-size: 48px;
            color: #388e3c;
            margin-bottom: 20px;
        }
        .message {
            color: #232323;
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 30px;
        }
        .email-highlight {
            background-color: #f8fafc;
            padding: 10px;
            border-radius: 4px;
            border-left: 4px solid #d32f2f;
            margin: 20px 0;
            color: #232323;
        }
        .btn {
            display: inline-block;
            background-color: #d32f2f;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            margin: 10px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
        }
        .btn:hover {
            background-color: #c62828;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #232323;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div style="text-align:center; margin-bottom:18px;">
            <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px;">Projeto Dunnas</span>
        </div>
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
