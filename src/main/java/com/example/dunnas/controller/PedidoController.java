package com.example.dunnas.controller;

import com.example.dunnas.dto.PedidoRequestDTO;
import com.example.dunnas.dto.PedidoResponseDTO;
import com.example.dunnas.model.entity.Pedido;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.service.PedidoService;
import com.example.dunnas.service.FornecedorService;
import com.example.dunnas.service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/pedidos")
public class PedidoController {
    @Autowired
    private com.example.dunnas.security.JwtUtil jwtUtil;

    @Autowired
    private PedidoService pedidoService;
    @Autowired
    private FornecedorService fornecedorService;
    @Autowired
    private ProdutoService produtoService;

    @GetMapping("/novo")
    public String novoPedido(@RequestParam Long fornecedorId, Model model) {
        Fornecedor fornecedor = fornecedorService.buscarPorId(fornecedorId);
        List<Produto> produtos = produtoService.listarProdutosPorFornecedor(fornecedorId);
        model.addAttribute("fornecedor", fornecedor);
        model.addAttribute("produtos", produtos);
        return "pedidos/novo-pedido";
    }

    @PostMapping("/criar")
    public String criarPedido(@ModelAttribute PedidoRequestDTO dto, Model model, @CookieValue("jwt_token") String jwtToken) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        dto.setClienteId(clienteId);
        PedidoResponseDTO pedido = pedidoService.criarPedido(dto);
        model.addAttribute("pedido", pedido);
        return "pedidos/sucesso";
    }

    @GetMapping("/historico")
    public String historicoPedidos(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        List<Pedido> pedidos = pedidoService.listarPedidosPorCliente(clienteId);
        model.addAttribute("pedidos", pedidos);
        return "pedidos/historico";
    }

}
