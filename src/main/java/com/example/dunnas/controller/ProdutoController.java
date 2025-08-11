package com.example.dunnas.controller;

import com.example.dunnas.dto.ProdutoRequestDTO;
import com.example.dunnas.dto.ProdutoResponseDTO;
import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.model.entity.Produto;
import java.math.BigDecimal;
import java.util.List;

import com.example.dunnas.service.ClienteService;
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
    private ClienteService clienteService;

    @Autowired
    private ProdutoService produtoService;

    @Autowired
    private FornecedorService fornecedorService;

    @GetMapping("/editar/{id}")
        public String editarProduto(@PathVariable Long id, Model model, @CookieValue("jwt_token") String jwtToken) {
            Long fornecedorId = jwtUtil.extractUserId(jwtToken);
            Produto produto = produtoService.buscarPorId(id).orElseThrow();
            if (!produto.getFornecedor().getId().equals(fornecedorId)) {
                return "redirect:/produtos/produtos-fornecedor?forbidden";
            }
            model.addAttribute("produto", produto);
            return "produtos/editar-produto";
    }

    @PostMapping("/atualizar")
    public String atualizarProduto(@RequestParam Long id,
                                   @RequestParam String nome,
                                   @RequestParam String descricao,
                                   @RequestParam BigDecimal preco,
                                   @RequestParam(required = false) BigDecimal precoComDesconto,
                                   @CookieValue("jwt_token") String jwtToken) {
        Long fornecedorId = jwtUtil.extractUserId(jwtToken);
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        if (!produto.getFornecedor().getId().equals(fornecedorId)) {
            return "redirect:/produtos/produtos-fornecedor?forbidden";
        }
        produto.setNome(nome);
        produto.setDescricao(descricao);
        produto.setPreco(preco);
        produto.setPrecoComDesconto(precoComDesconto);
        produtoService.atualizarProduto(produto);
        return "redirect:/produtos/produtos-fornecedor";
    }

    @PostMapping("/excluir")
    public String excluirProduto(@RequestParam Long id, @CookieValue("jwt_token") String jwtToken) {
        Long fornecedorId = jwtUtil.extractUserId(jwtToken);
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        if (!produto.getFornecedor().getId().equals(fornecedorId)) {
            return "redirect:/produtos/produtos-fornecedor?forbidden";
        }
        produtoService.excluirProduto(id);
        return "redirect:/produtos/produtos-fornecedor";
    }

    @GetMapping("/detalhe/{id}")
    public String detalheProduto(@PathVariable Long id, Model model) {
        Produto produto = produtoService.buscarPorId(id).orElseThrow();
        model.addAttribute("produto", produto);
        return "produtos/detalhe-produto";
    }

    @GetMapping("/produtos-fornecedor")
    public String produtosFornecedor(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long fornecedorId = jwtUtil.extractUserId(jwtToken);
        List<ProdutoResponseDTO> produtos = produtoService.listarProdutos().stream()
            .filter(p -> p.getFornecedorId().equals(fornecedorId)).toList();
        model.addAttribute("produtos", produtos);
        model.addAttribute("fornecedor", fornecedorService.buscarPorId(fornecedorId));
        return "produtos/produtos-fornecedor";
    }

    @Autowired
    private com.example.dunnas.security.JwtUtil jwtUtil;

    @GetMapping("/produto-cliente")
    public String produtosCliente(Model model, @CookieValue("jwt_token") String jwtToken) {
        List<ProdutoResponseDTO> produtos = produtoService.listarProdutos();
        model.addAttribute("produtos", produtos);
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        Cliente cliente = clienteService.buscarPorId(clienteId);
        model.addAttribute("usuario", cliente);
        return "produtos/produto-cliente";
    }

    @GetMapping("/cadastro")
    public String cadastroProduto(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long fornecedorId = jwtUtil.extractUserId(jwtToken);
        ProdutoRequestDTO produtoDTO = new ProdutoRequestDTO();
        produtoDTO.setFornecedorId(fornecedorId);
        model.addAttribute("produto", produtoDTO);
        model.addAttribute("fornecedor", fornecedorService.buscarPorId(fornecedorId));
        return "produtos/cadastro-produto";
    }

    @PostMapping("/salvar")
    public String salvarProduto(@ModelAttribute ProdutoRequestDTO produtoDTO, @CookieValue("jwt_token") String jwtToken) {
        produtoDTO.setFornecedorId(jwtUtil.extractUserId(jwtToken));
        produtoService.cadastrarProduto(produtoDTO);
        return "redirect:/produtos/produtos-fornecedor";
    }
}
