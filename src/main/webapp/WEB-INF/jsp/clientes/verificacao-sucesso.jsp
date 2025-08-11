<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conta Verificada - Sistema Dunnas</title>
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
        .success-icon {
            font-size: 64px;
            color: #d32f2f;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }
        h1 {
            text-align: center;
            color: #d32f2f;
            margin-bottom: 28px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .message {
            color: #232323;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .btn {
            display: inline-block;
            background-color: #d32f2f;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 17px;
            margin: 10px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
        }
        .btn:hover {
            background-color: #c62828;
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div style="text-align:center; margin-bottom:18px;">
            <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px;">Projeto Dunnas</span>
        </div>
        <div class="success-icon celebration">🎉</div>
        <h1>Conta Verificada com Sucesso!</h1>
        <div class="message">
            <p><strong>Parabéns!</strong> Sua conta foi verificada e ativada com sucesso.</p>
            <p>Agora você pode fazer login no sistema e começar a usar todos os recursos disponíveis.</p>
        </div>
        <a href="/login" class="btn">Fazer Login Agora</a>
    </div>
</body>
</html>
