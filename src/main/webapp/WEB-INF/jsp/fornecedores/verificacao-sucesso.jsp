<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conta Verificada - Sistema Dunnas</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 500px; margin: 50px auto; padding: 20px; background-color: #f5f5f5; }
        .success-container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .success-icon { font-size: 64px; color: #28a745; margin-bottom: 20px; }
        h1 { color: #28a745; margin-bottom: 20px; }
        .message { color: #333; font-size: 16px; line-height: 1.6; margin-bottom: 30px; }
        .btn { display: inline-block; background-color: #007bff; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; font-size: 16px; margin: 10px; }
        .btn:hover { background-color: #0056b3; }
        .celebration { animation: bounce 2s infinite; }
        @keyframes bounce { 0%, 20%, 50%, 80%, 100% { transform: translateY(0); } 40% { transform: translateY(-10px); } 60% { transform: translateY(-5px); } }
    </style>
</head>
<body>
    <div class="success-container">
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
