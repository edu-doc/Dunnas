
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
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
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
    </style>
</head>
<body>
        <div class="success-container">
            <div style="width:100%; display:flex; flex-direction:column; align-items:center;">
                <span style="font-size:2rem; font-weight:700; color:#d32f2f; letter-spacing:2px; text-align:center; width:100%; display:block; margin-bottom:18px;">Projeto Dunnas</span>
                <span style="font-size:3rem; color:#388e3c; text-align:center; width:100%; display:block; margin-bottom:10px;">&#10003;</span>
                <h1 style="margin-bottom:10px; width:100%; text-align:center;">Cadastro de Fornecedor</h1>
                <div style="text-align:center; color:#d32f2f; font-size:1.2rem; font-weight:500; margin-bottom:22px; width:100%;">Cadastro realizado com sucesso!</div>
                <div class="message" style="color:#232323; font-size:16px; line-height:1.5; margin-bottom:30px; width:100%; text-align:center;">
                    <div class="email-highlight" style="background:#f8fafc; padding:10px; border-radius:4px; border-left:4px solid #d32f2f; margin:20px 0; color:#d32f2f; display:inline-block; text-align:left;">
                        <strong>📧 Verificação de Email</strong><br>
                        Enviamos um código de verificação para:<br>
                        <strong>${email}</strong>
                    </div>
                    <p>Para ativar sua conta e fazer login, você precisa verificar seu email com o código que enviamos.</p>
                </div>
                <a href="/fornecedores/verificar" class="btn" style="display:block; background-color:#d32f2f; color:white; padding:14px 0; text-decoration:none; border-radius:6px; font-size:18px; margin:10px 0; font-weight:600; box-shadow:0 2px 8px rgba(211,47,47,0.10); transition:background 0.2s; width:90%; text-align:center;">Verificar Conta Agora</a>
                <a href="/login" class="btn btn-secondary" style="display:block; background-color:#6c757d; color:white; padding:14px 0; text-decoration:none; border-radius:6px; font-size:18px; margin:10px 0; font-weight:600; width:90%; text-align:center;">Voltar ao Login</a>
            </div>
    </div>
</body>
</html>
