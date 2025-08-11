<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home - Sistema Dunnas</title>
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
            .container {
                max-width: 420px;
                margin: 48px auto;
                background: #fff;
                padding: 38px 32px 32px 32px;
                border-radius: 18px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.18);
            }
            .branding {
                text-align:center;
                margin-bottom:18px;
            }
            .branding span {
                font-size:2rem;
                font-weight:700;
                color:#d32f2f;
                letter-spacing:2px;
            }
            .header {
                margin-bottom: 10px;
                text-align:center;
            }
            .logout-btn {
                background: #d32f2f;
                color: white;
                padding: 14px 0;
                border: none;
                border-radius: 7px;
                text-decoration: none;
                font-size: 18px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(211,47,47,0.10);
                transition: background 0.2s, box-shadow 0.2s;
                cursor: pointer;
                width:100%;
            }
            .logout-btn:hover {
                background: #c62828;
                box-shadow: 0 4px 16px rgba(211,47,47,0.18);
            }
            .profile {
                background: #f8fafc;
                border-radius: 12px;
                padding: 28px 24px;
                margin-bottom: 28px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.06);
                text-align: center;
            }
            .profile h2 {
                color: #d32f2f;
                margin-bottom: 18px;
                font-size: 2rem;
                font-weight: 700;
            }
            .profile-info {
                font-size: 1.08rem;
                color: #232323;
                margin-bottom: 10px;
            }
            .profile-label {
                font-weight: bold;
                color: #d32f2f;
            }
            .menu {
                display: flex;
                flex-direction: column;
                gap: 18px;
                margin-top: 18px;
            }
            .menu-btn {
                background: #d32f2f;
                color: #fff;
                padding: 14px 0;
                border: none;
                border-radius: 7px;
                font-size: 18px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(211,47,47,0.10);
                transition: background 0.2s, box-shadow 0.2s;
                cursor: pointer;
                text-decoration: none;
                width:100%;
            }
            .menu-btn:hover {
                background: #c62828;
                box-shadow: 0 4px 16px rgba(211,47,47,0.18);
            }
        </style>
    </head>
<body>
    <div class="container">
        <div class="branding">
            <span>Projeto Dunnas</span>
        </div>
        <div class="header">
            <h1 style="color:#d32f2f;margin:0 auto;font-size:2.2rem;font-weight:800;text-align:center;width:100%;">Meu Perfil</h1>
        </div>
        <div class="profile">
            <h2>Bem-vindo!</h2>
            <c:if test="${usuario != null}">
                <div class="profile-info"><span class="profile-label">Usuário:</span> ${usuario.usuario}</div>
                <div class="profile-info"><span class="profile-label">Email:</span> ${usuario.email}</div>
                <div class="profile-info"><span class="profile-label">Perfil:</span> ${usuario.role}</div>
                <c:if test="${usuario.role == 'CLIENTE'}">
                    <div class="profile-info"><span class="profile-label">Saldo:</span> R$ ${usuario.saldo}</div>
                </c:if>
            </c:if>
            <div style="margin-top:18px;color:#555;font-size:1rem;">Você está logado no sistema.</div>
        </div>
        <c:if test="${usuario.role == 'CLIENTE'}">
            <div class="menu">
                <form action="/clientes/pix" method="get" style="margin:0;">
                    <button type="submit" class="menu-btn" style="background:#28a745;">Adicionar Saldo via PIX</button>
                </form>
            </div>
        </c:if>
        <div style="display:flex;gap:18px;justify-content:center;margin-top:28px;">
            <c:choose>
                <c:when test="${usuario.role == 'FORNECEDOR'}">
                    <form action="/produtos/produtos-fornecedor" method="get" style="margin:0;">
                        <button type="submit" class="menu-btn" style="background:#6c757d;color:#fff;text-align:center;width:160px;">Voltar</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form action="/produtos/produto-cliente" method="get" style="margin:0;">
                        <button type="submit" class="menu-btn" style="background:#6c757d;color:#fff;text-align:center;width:160px;">Voltar</button>
                    </form>
                </c:otherwise>
            </c:choose>
            <form action="/auth/logout" method="get" style="margin:0;">
                <button type="submit" class="logout-btn" style="text-align:center;width:160px;">Logout</button>
            </form>
        </div>
    </div>
</body>
</html>