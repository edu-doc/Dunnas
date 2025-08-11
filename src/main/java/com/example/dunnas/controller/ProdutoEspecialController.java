package com.example.dunnas.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProdutoViewController {
    @GetMapping("/produtos-fornecedor")
    public String produtosFornecedor(Model model, Authentication authentication) {
        // Adicione dados ao model se necessário
        return "produtos/produtos-fornecedor";
    }

    @GetMapping("/produtos-cliente")
    public String produtosCliente(Model model, Authentication authentication) {
        // Adicione dados ao model se necessário
        return "produtos/produto-cliente";
    }
}
