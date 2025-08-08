<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Cliente</title>
    </head>
    <body>
        <h1>Cadastro de Novo Cliente</h1>

        <form:form modelAttribute="cliente" action="/clientes/salvar" method="post">

        <div>
            <label for="nome">Nome:</label>
            <form:input path="nome" id="nome" required="true" />
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <form:input path="cpf" id="cpf" required="true" />
        </div>
        <div>
            <label for="dataNascimento">Data de Nascimento (AAAA-MM-DD):</label>
            <form:input type="date" path="dataNascimento" id="dataNascimento" required="true" />
        </div>
        <div>
            <label for="usuario">Usuário:</label>
            <form:input path="usuario" id="usuario" required="true" />
        </div>
        <div>
            <label for="senha">Senha:</label>
            <form:password path="senha" id="senha" required="true" />
        </div>
        <div>
            <label for="saldo">Saldo Inicial:</label>
            <form:input type="number" step="0.01" path="saldo" id="saldo" required="true" />
        </div>
        <br/>
        <button type="submit">Cadastrar</button>
        </form:form>

    </body>
</html>