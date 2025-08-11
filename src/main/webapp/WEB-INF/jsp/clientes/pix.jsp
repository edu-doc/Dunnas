<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Adicionar Saldo via PIX</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: linear-gradient(120deg, #e0e7ff 0%, #f5f5f5 100%); }
        .container { max-width: 500px; margin: 60px auto; background: #fff; padding: 32px 28px; border-radius: 14px; box-shadow: 0 4px 18px rgba(0,0,0,0.10); }
        h2 { color: #007bff; margin-bottom: 24px; font-size: 1.7rem; font-weight: 700; }
        .form-group { margin-bottom: 18px; }
        label { font-weight: 600; color: #333; }
        input[type="number"] { width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 1.08rem; }
        .btn-pix { background: linear-gradient(90deg, #28a745 60%, #218838 100%); color: #fff; padding: 10px 28px; border: none; border-radius: 7px; font-size: 1.08rem; font-weight: bold; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.08); transition: background 0.2s; }
        .btn-pix:hover { background: linear-gradient(90deg, #218838 60%, #28a745 100%); }
        .msg-success { background:#d4edda;color:#155724;padding:12px 18px;border-radius:7px;margin-bottom:18px;border:1px solid #c3e6cb;font-weight:500; }
        .msg-error { background:#f8d7da;color:#721c24;padding:12px 18px;border-radius:7px;margin-bottom:18px;border:1px solid #f5c6cb;font-weight:500; }
    </style>
</head>
<body>
    <div class="container">
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
    </div>
</body>
</html>
