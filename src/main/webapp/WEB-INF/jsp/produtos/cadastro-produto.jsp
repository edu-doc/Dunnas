<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastrar Produto</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 500px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #007bff; margin-bottom: 30px; }
        label { font-weight: bold; color: #333; display: block; margin-top: 15px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-top: 5px; }
        button { background: #007bff; color: #fff; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; margin-top: 20px; width: 100%; font-size: 16px; }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Cadastrar Produto</h2>
        <form action="/produtos/salvar" method="post">
            <!-- Removido fornecedorId, será extraído do JWT no backend -->
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>

            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" required>

            <label for="preco">Preço:</label>
            <input type="number" id="preco" name="preco" step="0.01" required>

            <button type="submit">Cadastrar</button>
        </form>
        <form action="/produtos/produtos-fornecedor" method="get" style="margin-top:10px;">
            <button type="submit" style="background:#6c757d;color:#fff;width:100%;border:none;padding:12px 20px;border-radius:5px;cursor:pointer;font-size:16px;">Voltar</button>
        </form>
        </form>
    </div>
</body>
</html>