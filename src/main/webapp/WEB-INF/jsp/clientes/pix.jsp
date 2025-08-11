<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Adicionar Saldo via PIX</title>
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
        h2 {
            text-align: center;
            color: #d32f2f;
            margin-bottom: 18px;
            font-size:2rem;
            font-weight:700;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            font-weight: 600;
            color: #232323;
            margin-bottom: 7px;
            display: block;
        }
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #d1d9e6;
            font-size: 1.08rem;
            background: #f8fafc;
            color: #232323;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }
        input[type="number"]:focus {
            border-color: #d32f2f;
            outline: none;
            box-shadow: 0 0 5px rgba(211,47,47,0.18);
        }
        .btn-pix {
            background: #d32f2f;
            color: #fff;
            padding: 14px 0;
            border: none;
            border-radius: 7px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(211,47,47,0.10);
            transition: background 0.2s;
            width: 100%;
            margin-bottom: 8px;
        }
        .btn-pix:hover {
            background: #c62828;
        }
        .msg-success {
            background:#388e3c;
            color:#fff;
            padding:12px 18px;
            border-radius:7px;
            margin-bottom:18px;
            border:1px solid #2e7d32;
            font-weight:500;
            text-align:center;
        }
        .msg-error {
            background:#d32f2f;
            color:#fff;
            padding:12px 18px;
            border-radius:7px;
            margin-bottom:18px;
            border:1px solid #c62828;
            font-weight:500;
            text-align:center;
        }
    </style>
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">
            <span>Projeto Dunnas</span>
        </div>
        <h2>Adicionar Saldo via PIX</h2>
        <c:if test="${not empty success}">
            <div class="msg-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="msg-error">${error}</div>
        </c:if>
        <form action="/clientes/pix" method="post">
            <div class="form-group">
                <label for="valor">Valor a adicionar (R$):</label>
                <input type="number" step="0.01" min="0.01" name="valor" id="valor" required />
            </div>
            <button type="submit" class="btn-pix">Adicionar Saldo</button>
        </form>
            <form action="/produtos/produto-cliente" method="get" style="margin-top:14px;">
                <button type="submit" class="btn-pix" style="background:linear-gradient(90deg,#6c757d 60%,#343a40 100%);margin-top:0;">Voltar</button>
            </form>
    </div>
</body>
</html>
