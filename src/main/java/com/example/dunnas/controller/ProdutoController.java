package com.example.dunnas.controller;

import com.example.dunnas.model.entity.Produto;
import java.math.BigDecimal;
import com.example.dunnas.service.FornecedorService;
import com.example.dunnas.service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @Autowired
    private FornecedorService fornecedorService;

    @GetMapping("/editar/{id}")
    public String editarProduto(@PathVariable Long id, Model model) {
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        model.addAttribute("produto", produto);
        return "produtos/editar-produto";
    }

    @PostMapping("/atualizar")
    public String atualizarProduto(@RequestParam Long id,
                                   @RequestParam String nome,
                                   @RequestParam String descricao,
                                   @RequestParam BigDecimal preco,
                                   @RequestParam(required = false) BigDecimal precoComDesconto,
                                   @RequestParam Long fornecedorId) {
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        produto.setNome(nome);
        produto.setDescricao(descricao);
        produto.setPreco(preco);
        produto.setPrecoComDesconto(precoComDesconto);
        produto.setFornecedor(fornecedorService.buscarPorId(fornecedorId));
        produtoService.atualizarProduto(produto);
        return "redirect:/produtos/produtos-fornecedor?fornecedorId=" + fornecedorId;
    }

    @PostMapping("/excluir")
    public String excluirProduto(@RequestParam Long id, @RequestParam Long fornecedorId) {
        produtoService.excluirProduto(id);
        return "redirect:/produtos/produtos-fornecedor?fornecedorId=" + fornecedorId;
    }

    @GetMapping("/detalhe/{id}")
    public String detalheProduto(@PathVariable Long id, Model model) {
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        model.addAttribute("produto", produto);
        return "produtos/detalhe-produto";
    }

    @GetMapping("/produtos-fornecedor")
    public String produtosFornecedor(Model model, @RequestParam Long fornecedorId) {
        model.addAttribute("produtos", produtoService.listarProdutosPorFornecedor(fornecedorId));
        model.addAttribute("fornecedor", fornecedorService.buscarPorId(fornecedorId));
        return "produtos/produtos-fornecedor";
    }

    @GetMapping("/produto-cliente")
    public String produtosCliente(Model model) {
        model.addAttribute("produtos", produtoService.listarProdutos());
        return "produtos/produto-cliente";
    }

    @GetMapping("/cadastro")
    public String cadastroProduto(Model model, @RequestParam Long fornecedorId) {
        model.addAttribute("produto", new Produto());
        model.addAttribute("fornecedor", fornecedorService.buscarPorId(fornecedorId));
        return "produtos/cadastro-produto";
    }

    @PostMapping("/salvar")
    public String salvarProduto(@ModelAttribute Produto produto, @RequestParam Long fornecedorId) {
        produtoService.cadastrarProduto(produto, fornecedorId);
        return "redirect:/produtos/produtos-fornecedor?fornecedorId=" + fornecedorId;
    }
}
