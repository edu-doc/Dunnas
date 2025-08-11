
package com.example.dunnas.controller;

import com.example.dunnas.dto.PedidoRequestDTO;
import com.example.dunnas.dto.PedidoResponseDTO;
import com.example.dunnas.dto.QuantidadeProdutoDTO;
import com.example.dunnas.model.entity.Cupom;
import com.example.dunnas.model.entity.Pedido;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.service.PedidoService;
import com.example.dunnas.service.FornecedorService;
import com.example.dunnas.service.ProdutoService;
import com.example.dunnas.service.PagamentoService;
import com.example.dunnas.service.CupomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/pedidos")
public class PedidoController {

    @Autowired
    private PagamentoService pagamentoService;

    @Autowired
    private CupomService cupomService;


    @Autowired
    private PedidoService pedidoService;

    @Autowired
    private com.example.dunnas.service.ClienteService clienteService;

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
    public String criarPedido(@ModelAttribute PedidoRequestDTO dto, Model model, Authentication authentication) {
        String username = authentication.getName();
        Long clienteId = clienteService.buscarPorUsuario(username)
            .orElseThrow(() -> new RuntimeException("Cliente não encontrado")).getId();
        dto.setClienteId(clienteId);
        if (dto.getCupom() != null && dto.getCupom().trim().isEmpty()) {
            dto.setCupom(null);
        }
        if (dto.getProdutoIds() == null || dto.getProdutoIds().isEmpty()) {
            model.addAttribute("error", "Selecione ao menos um produto para finalizar o pedido.");
            Fornecedor fornecedor = fornecedorService.buscarPorId(dto.getFornecedorId());
            List<Produto> produtos = produtoService.listarProdutosPorFornecedor(dto.getFornecedorId());
            model.addAttribute("fornecedor", fornecedor);
            model.addAttribute("produtos", produtos);
            return "pedidos/novo-pedido";
        }
        if (dto.getCupom() != null) {
            Optional<Cupom> cupomOpt = cupomService.validarCupom(dto.getCupom());
            if (cupomOpt.isEmpty()) {
                model.addAttribute("error", "Cupom informado é inválido ou expirado.");
                Fornecedor fornecedor = fornecedorService.buscarPorId(dto.getFornecedorId());
                List<Produto> produtos = produtoService.listarProdutosPorFornecedor(dto.getFornecedorId());
                model.addAttribute("fornecedor", fornecedor);
                model.addAttribute("produtos", produtos);
                return "pedidos/novo-pedido";
            }
        }
        Map<Long, Integer> quantidades = new HashMap<>();
        if (dto.getQuantidades() != null) {
            for (QuantidadeProdutoDTO q : dto.getQuantidades()) {
                if (q.getProdutoId() != null && q.getQuantidade() != null) {
                    quantidades.put(q.getProdutoId(), q.getQuantidade());
                }
            }
        }
        PedidoResponseDTO pedido = pedidoService.criarPedido(dto, quantidades);
        model.addAttribute("pedido", pedido);
        return "pedidos/sucesso";
    }

    @GetMapping("/historico")
    public String historicoPedidos(Model model, Authentication authentication) {
        String username = authentication.getName();
        Long clienteId = clienteService.buscarPorUsuario(username)
            .orElseThrow(() -> new RuntimeException("Cliente não encontrado")).getId();
        List<Pedido> pedidos = pedidoService.listarPedidosPorCliente(clienteId);
        model.addAttribute("pedidos", pedidos);
        BigDecimal saldo = clienteService.buscarPorId(clienteId).getSaldo();
        model.addAttribute("saldo", saldo);
        return "pedidos/historico";
    }

}
