<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home - Sistema Dunnas</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: linear-gradient(120deg, #e0e7ff 0%, #f5f5f5 100%);
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 600px;
                margin: 50px auto;
                background: #fff;
                padding: 38px 32px 32px 32px;
                border-radius: 18px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.10);
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            .logout-btn {
                background: linear-gradient(90deg, #dc3545 60%, #c82333 100%);
                color: white;
                padding: 10px 28px;
                border: none;
                border-radius: 7px;
                text-decoration: none;
                font-size: 1.08rem;
                font-weight: bold;
                box-shadow: 0 2px 8px rgba(220,53,69,0.08);
                transition: background 0.2s, box-shadow 0.2s;
                cursor: pointer;
            }
            .logout-btn:hover {
                background: linear-gradient(90deg, #c82333 60%, #dc3545 100%);
                box-shadow: 0 4px 16px rgba(220,53,69,0.12);
            }
            .profile {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 28px 24px;
                margin-bottom: 28px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.06);
                text-align: center;
            }
            .profile h2 {
                color: #007bff;
                margin-bottom: 18px;
                font-size: 2rem;
                font-weight: 700;
            }
            .profile-info {
                font-size: 1.08rem;
                color: #333;
                margin-bottom: 10px;
            }
            .profile-label {
                font-weight: bold;
                color: #007bff;
            }
            .menu {
                display: flex;
                flex-direction: column;
                gap: 18px;
                margin-top: 18px;
            }
            .menu-btn {
                background: linear-gradient(90deg, #007bff 60%, #0056b3 100%);
                color: #fff;
                padding: 14px 0;
                border: none;
                border-radius: 7px;
                font-size: 1.08rem;
                font-weight: bold;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                transition: background 0.2s, box-shadow 0.2s;
                cursor: pointer;
                text-decoration: none;
            }
            .menu-btn:hover {
                background: linear-gradient(90deg, #0056b3 60%, #007bff 100%);
                box-shadow: 0 4px 16px rgba(0,0,0,0.12);
            }
        </style>
    </head>
<body>
    <div class="container">
        <div class="header">
            <h1 style="color:#007bff;margin:0 auto;font-size:2.2rem;font-weight:800;text-align:center;width:100%;">Meu Perfil</h1>
        </div>
        <div class="profile">
            <h2>Bem-vindo!</h2>
            <c:if test="${usuario != null}">
                <div class="profile-info"><span class="profile-label">Usuário:</span> ${usuario.usuario}</div>
                <div class="profile-info"><span class="profile-label">Email:</span> ${usuario.email}</div>
                <div class="profile-info"><span class="profile-label">Perfil:</span> ${usuario.role}</div>
                <div class="profile-info"><span class="profile-label">Saldo:</span> R$ ${usuario.saldo}</div>
            </c:if>
            <div style="margin-top:18px;color:#555;font-size:1rem;">Você está logado no sistema.</div>
        </div>
        <div class="menu">
            <form action="/clientes/pix" method="get" style="margin:0;">
                <button type="submit" class="menu-btn" style="background:#28a745;">Adicionar Saldo via PIX</button>
            </form>
        </div>
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