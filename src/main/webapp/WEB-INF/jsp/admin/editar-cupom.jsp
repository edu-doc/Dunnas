<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Cupom</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 520px;
            margin: 56px auto;
            background: #fff;
            padding: 44px 36px 36px 36px;
            border-radius: 20px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.18);
        }
        .branding {
            font-size: 1.25rem;
            color: #d90429;
            font-weight: 700;
            letter-spacing: 1.5px;
            margin-bottom: 18px;
            text-align: center;
        }
        h1 {
            text-align: center;
            color: #d90429;
            margin-bottom: 32px;
            font-size: 2.1rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 22px;
        }
        label {
            font-weight: bold;
            color: #232526;
            display: block;
            margin-bottom: 7px;
            font-size: 1.08rem;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1.5px solid #d90429;
            margin-top: 7px;
            font-size: 1.08rem;
            background: #f8f9fa;
            transition: border 0.2s;
        }
        input:focus, select:focus {
            border-color: #232526;
            outline: none;
        }
        .btn {
            background: linear-gradient(90deg, #d90429 60%, #232526 100%);
            color: #fff;
            padding: 12px 0;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 18px;
            width: 100%;
            font-size: 1.15rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(220,4,41,0.10);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
        .btn-voltar {
            background: linear-gradient(90deg, #6c757d 60%, #343a40 100%);
            color: #fff;
            margin-top: 14px;
            width: 100%;
            font-size: 1.12rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
            transition: background 0.2s, box-shadow 0.2s;
            display: block;
        }
        .btn-voltar:hover {
            background: linear-gradient(90deg, #343a40 60%, #6c757d 100%);
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Editar Cupom</div>
        <h1>Editar Cupom</h1>
        <form action="/admin/cupom/editar" method="post">
            <input type="hidden" name="id" value="${cupom.id}" />
            <div class="form-group">
                <label for="codigo">Código:</label>
                <input type="text" id="codigo" name="codigo" value="${cupom.codigo}" required />
            </div>
            <div class="form-group">
                <label for="desconto">Desconto:</label>
                <input type="number" id="desconto" name="desconto" value="${cupom.desconto}" step="0.01" required />
            </div>
            <div class="form-group">
                <label for="dataValidade">Validade:</label>
                <input type="date" id="dataValidade" name="dataValidade" value="${cupom.dataValidade}" required />
            </div>
            <div class="form-group">
                <label for="ativo">Ativo:</label>
                <select id="ativo" name="ativo">
                    <option value="true" ${cupom.ativo ? 'selected' : ''}>Sim</option>
                    <option value="false" ${!cupom.ativo ? 'selected' : ''}>Não</option>
                </select>
            </div>
            <button type="submit" class="btn">Salvar Alterações</button>
        </form>
        <form action="/admin" method="get" style="margin-top:14px;">
            <div style="display:flex;justify-content:center;">
                <button type="submit" class="btn btn-voltar">Voltar</button>
            </div>
        </form>
    </div>
</body>
</html>
