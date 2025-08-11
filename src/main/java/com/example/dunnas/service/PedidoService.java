package com.example.dunnas.service;

import com.example.dunnas.dto.PedidoRequestDTO;
import com.example.dunnas.dto.PedidoResponseDTO;
import com.example.dunnas.model.entity.Pedido;
import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.model.repository.PedidoRepository;
import com.example.dunnas.model.repository.ProdutoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PedidoService {

    @PersistenceContext
    private EntityManager entityManager;

    private final PedidoRepository pedidoRepository;
    private final ClienteService clienteService;
    private final FornecedorService fornecedorService;
    private final ProdutoRepository produtoRepository;
    private final CupomService cupomService;

    public PedidoService(PedidoRepository pedidoRepository, ClienteService clienteService, FornecedorService fornecedorService, ProdutoRepository produtoRepository, CupomService cupomService) {
        this.pedidoRepository = pedidoRepository;
        this.clienteService = clienteService;
        this.fornecedorService = fornecedorService;
        this.produtoRepository = produtoRepository;
        this.cupomService = cupomService;
    }

    public PedidoResponseDTO criarPedido(PedidoRequestDTO dto) {

        Cliente cliente = clienteService.buscarPorId(dto.getClienteId());
        Fornecedor fornecedor = fornecedorService.buscarPorId(dto.getFornecedorId());
        List<Produto> produtos = produtoRepository.findAllById(dto.getProdutoIds());

        BigDecimal valorTotal = produtos.stream()
                .map(Produto::getPreco)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal desconto = BigDecimal.ZERO;
        if (dto.getCupom() != null && !dto.getCupom().isEmpty()) {
            var cupomOpt = cupomService.validarCupom(dto.getCupom());
            if (cupomOpt.isPresent()) {
                desconto = cupomOpt.get().getDesconto();
            }
        }

        Pedido pedido = new Pedido();
        pedido.setCliente(cliente);
        pedido.setFornecedor(fornecedor);
        pedido.setProdutos(produtos);
        pedido.setValorTotal(valorTotal.subtract(desconto));
        pedido.setDesconto(desconto);
        pedido.setCupom(dto.getCupom());
        pedido.setDataPedido(LocalDateTime.now());
        pedido.setStatus(com.example.dunnas.enuns.PedidoEnum.PENDENTE);

        pedido = pedidoRepository.save(pedido);

        entityManager.createNativeQuery("SELECT registrar_criacao_pedido(:pedidoId)")
                .setParameter("pedidoId", pedido.getId())
                .getSingleResult();

        PedidoResponseDTO response = new PedidoResponseDTO();
        response.setId(pedido.getId());
        response.setClienteId(cliente.getId());
        response.setFornecedorId(fornecedor.getId());
        response.setProdutoIds(dto.getProdutoIds());
        response.setValorTotal(pedido.getValorTotal());
        response.setDesconto(pedido.getDesconto());
        response.setCupom(pedido.getCupom());
        response.setDataPedido(pedido.getDataPedido());
        response.setStatus(pedido.getStatus());

        return response;
    }

    public Pedido buscarPorId(Long id) {
        return pedidoRepository.findById(id).orElse(null);
    }

    public PedidoResponseDTO salvarPedido(Pedido pedido) {
        Pedido saved = pedidoRepository.save(pedido);
        PedidoResponseDTO dto = new PedidoResponseDTO();
        dto.setId(saved.getId());
        dto.setClienteId(saved.getCliente().getId());
        dto.setFornecedorId(saved.getFornecedor().getId());
        dto.setProdutoIds(saved.getProdutos().stream().map(p -> p.getId()).toList());
        dto.setValorTotal(saved.getValorTotal());
        dto.setDesconto(saved.getDesconto());
        dto.setCupom(saved.getCupom());
        dto.setDataPedido(saved.getDataPedido());
        dto.setStatus(saved.getStatus());
        return dto;
    }

    @Transactional
    public boolean cancelarPedido(Long pedidoId) {
        Boolean result = (Boolean) entityManager
                .createNativeQuery("SELECT processar_cancelamento(:pedidoId)")
                .setParameter("pedidoId", pedidoId)
                .getSingleResult();
        return result != null && result;
    }

    public List<Pedido> listarPedidosPorCliente(Long clienteId) {
        return pedidoRepository.findByClienteId(clienteId);
    }

}