<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastrar Produto</title>
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
        h2 {
            text-align: center;
            color: #d90429;
            margin-bottom: 32px;
            font-size: 2.1rem;
            font-weight: 800;
            letter-spacing: 1px;
        }
        label {
            font-weight: bold;
            color: #232526;
            display: block;
            margin-top: 18px;
            font-size: 1.08rem;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1.5px solid #d90429;
            border-radius: 8px;
            margin-top: 7px;
            font-size: 1.08rem;
            background: #f8f9fa;
            transition: border 0.2s;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #232526;
            outline: none;
        }
        .btn-cadastrar {
            background: linear-gradient(90deg, #d90429 60%, #232526 100%);
            color: #fff;
            border: none;
            padding: 14px 0;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 28px;
            width: 100%;
            font-size: 1.15rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(220,4,41,0.10);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn-cadastrar:hover {
            background: linear-gradient(90deg, #232526 60%, #d90429 100%);
            box-shadow: 0 4px 18px rgba(220,4,41,0.16);
        }
        .btn-voltar {
            background: linear-gradient(90deg, #6c757d 60%, #343a40 100%);
            color: #fff;
            border: none;
            padding: 14px 0;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 14px;
            width: 100%;
            font-size: 1.12rem;
            font-weight: bold;
            box-shadow: 0 2px 10px rgba(0,0,0,0.10);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .btn-voltar:hover {
            background: linear-gradient(90deg, #343a40 60%, #6c757d 100%);
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Cadastro de Produto</div>
        <h2>Cadastrar Produto</h2>
        <form action="/produtos/salvar" method="post">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>

            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" required>

            <label for="preco">Preço:</label>
            <input type="number" id="preco" name="preco" step="0.01" required>

            <button type="submit" class="btn-cadastrar">Cadastrar</button>
        </form>
        <form action="/produtos/produtos-fornecedor" method="get">
            <button type="submit" class="btn-voltar">Voltar</button>
        </form>
    </div>
</body>
</html>