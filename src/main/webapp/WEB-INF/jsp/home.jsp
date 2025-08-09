<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home - Sistema Dunnas</title>
        <style>
            body { font-family: Arial, sans-serif; max-width: 800px; margin: 20px auto; padding: 20px; }
            .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
            .user-info { background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
            .logout-btn { background-color: #dc3545; color: white; padding: 8px 16px; border: none; border-radius: 4px; text-decoration: none; }
            .logout-btn:hover { background-color: #c82333; }
        </style>
    </head>
<body>
    <div class="header">
        <h1>Sistema Dunnas</h1>
        <a href="/auth/logout" class="logout-btn">Sair</a>
    </div>

    <div class="user-info">
        <h2>Bem-vindo!</h2>
        <c:if test="${usuario != null}">
            <p><strong>Usuário:</strong> ${usuario.usuario}</p>
            <p><strong>Email:</strong> ${usuario.email}</p>
            <p><strong>Perfil:</strong> ${usuario.role}</p>
        </c:if>
        <p>Você está logado no sistema.</p>
    </div>

    <div>
        <h3>Menu Principal</h3>
        <ul>
            <li><a href="/clientes">Gerenciar Clientes</a></li>
            <li><a href="/fornecedores">Gerenciar Fornecedores</a></li>
            <li><a href="/produtos">Gerenciar Produtos</a></li>
        </ul>
    </div>
</body>
</html>