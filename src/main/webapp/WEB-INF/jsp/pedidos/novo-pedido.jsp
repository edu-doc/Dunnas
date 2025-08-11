<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Novo Pedido</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #232526 0%, #414345 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 620px;
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
        .prod-list {
            margin-bottom: 22px;
        }
        .prod-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.06);
        }
        .prod-item label {
            flex: 1;
            margin: 0;
            font-size: 1.05rem;
            color: #232526;
        }
        .prod-item input[type="checkbox"] {
            margin-right: 12px;
            accent-color: #d90429;
            width: 20px;
            height: 20px;
        }
        .btn-finalizar {
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
        .btn-finalizar:hover {
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
        .error-msg {
            color: #d90429;
            background: #fbeeea;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: bold;
            border: 1px solid #d90429;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="branding">Dunnas - Novo Pedido</div>
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>
        <h2>Novo Pedido - ${fornecedor.nome}</h2>
        <form action="/pedidos/criar" method="post">
            <input type="hidden" name="fornecedorId" value="${fornecedor.id}">
            <label>Selecione os produtos:</label>
            <div class="prod-list">
                <c:forEach var="produto" items="${produtos}" varStatus="status">
                    <div class="prod-item">
                        <input type="checkbox" name="produtoIds" value="${produto.id}" onchange="toggleQuantidade(this)">
                        <label>${produto.nome} - R$ ${produto.preco} <span style="color:#888;">${produto.descricao}</span></label>
                        <input type="hidden" name="quantidades[${status.index}].produtoId" value="${produto.id}">
                        <input type="number" name="quantidades[${status.index}].quantidade" min="1" value="1" style="width:80px;margin-left:16px;display:none;" title="Quantidade" placeholder="Qtd">
                    </div>
                </c:forEach>
            </div>
            <label for="cupom">Cupom de desconto:</label>
            <input type="text" id="cupom" name="cupom" placeholder="Digite o cupom se tiver">
            <button type="submit" class="btn-finalizar">Finalizar Pedido</button>
        </form>
        <script>
        function toggleQuantidade(checkbox) {
            var quantidadeInput = checkbox.parentElement.querySelector('input[type="number"]');
            if (checkbox.checked) {
                quantidadeInput.style.display = 'inline-block';
                quantidadeInput.disabled = false;
                if (quantidadeInput.value < 1) quantidadeInput.value = 1;
            } else {
                quantidadeInput.style.display = 'none';
                quantidadeInput.disabled = true;
            }
        }
        document.querySelector('form[action="/pedidos/criar"]').addEventListener('submit', function(e) {
            document.querySelectorAll('.prod-item').forEach(function(item) {
                var checkbox = item.querySelector('input[type="checkbox"]');
                var quantidadeInput = item.querySelector('input[type="number"]');
                var hiddenProdutoId = item.querySelector('input[type="hidden"]');
                if (!checkbox.checked) {
                    quantidadeInput.disabled = true;
                    quantidadeInput.value = '';
                }
            });
        });
        </script>
        <form action="/produtos/produto-cliente" method="get">
            <button type="submit" class="btn-voltar">Voltar</button>
        </form>
    </div>
</body>
</html>
