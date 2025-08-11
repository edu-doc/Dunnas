
package com.example.dunnas.controller;

import com.example.dunnas.dto.PedidoRequestDTO;
import com.example.dunnas.dto.PedidoResponseDTO;
import com.example.dunnas.model.entity.Cupom;
import com.example.dunnas.model.entity.Pedido;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.security.JwtUtil;
import com.example.dunnas.service.PedidoService;
import com.example.dunnas.service.FornecedorService;
import com.example.dunnas.service.ProdutoService;
import com.example.dunnas.service.PagamentoService;
import com.example.dunnas.service.CupomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/pedidos")
public class PedidoController {

    @Autowired
    private PagamentoService pagamentoService;

    @Autowired
    private CupomService cupomService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PedidoService pedidoService;

    @Autowired
    private FornecedorService fornecedorService;

    @Autowired
    private ProdutoService produtoService;

        @PostMapping("/cancelar/{id}")
        public String cancelarPedido(@PathVariable("id") Long pedidoId, RedirectAttributes redirectAttributes) {
            boolean cancelado = pedidoService.cancelarPedido(pedidoId);
            if (cancelado) {
                redirectAttributes.addFlashAttribute("success", "Pedido cancelado com sucesso!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Não foi possível cancelar o pedido. Apenas pedidos pendentes podem ser cancelados.");
            }
            return "redirect:/pedidos/historico";
        }
    @PostMapping("/pagar/{id}")
    public String pagarPedido(@PathVariable("id") Long pedidoId, RedirectAttributes redirectAttributes) {
        boolean pago = pagamentoService.processarPagamento(pedidoId);
        if (pago) {
            redirectAttributes.addFlashAttribute("success", "Pagamento realizado com sucesso!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Não foi possível realizar o pagamento. Pedido inexistente, já pago ou saldo insuficiente.");
        }
        return "redirect:/pedidos/historico";
    }

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
        if (dto.getCupom() != null && dto.getCupom().trim().isEmpty()) {
            dto.setCupom(null);
        }
        if (dto.getCupom() != null) {
            java.util.Optional<Cupom> cupomOpt = cupomService.validarCupom(dto.getCupom());
            if (cupomOpt.isEmpty()) {
                model.addAttribute("error", "Cupom informado é inválido ou expirado.");
                Fornecedor fornecedor = fornecedorService.buscarPorId(dto.getFornecedorId());
                List<Produto> produtos = produtoService.listarProdutosPorFornecedor(dto.getFornecedorId());
                model.addAttribute("fornecedor", fornecedor);
                model.addAttribute("produtos", produtos);
                return "pedidos/novo-pedido";
            }
        }
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
