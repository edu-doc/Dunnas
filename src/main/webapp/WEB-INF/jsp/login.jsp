<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
    </head>
<body>
    <h1>Login</h1>

        <c:if test="${param.error != null}">
        <p style="color:red;">Usuário ou senha inválidos.</p>
        </c:if>

        <c:if test="${param.logout != null}">
            <p style="color:green;">Você saiu do sistema.</p>
        </c:if>

<form action="/login" method="post">
    <div>
        <label for="username">Usuário:</label>
        <input type="text" id="username" name="username" required="true">
    </div>
    <div>
        <label for="password">Senha:</label>
        <input type="password" id="password" name="password" required="true">
    </div>

    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <br/>
    <button type="submit">Entrar</button>
</form>

<p><a href="/clientes/novo">Não tem uma conta? Cadastre-se</a></p>
</body>
</html>