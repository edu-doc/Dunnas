<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
    </head>
<body>
    <h1>Bem-vindo!</h1>
    <p>Você está logado no sistema.</p>

    <form action="/logout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit">Sair</button>
    </form>
</body>
</html>