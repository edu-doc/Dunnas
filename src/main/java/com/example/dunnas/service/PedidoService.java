package com.example.dunnas.service;

import com.example.dunnas.dto.PedidoRequestDTO;
import com.example.dunnas.dto.PedidoResponseDTO;
import com.example.dunnas.model.entity.Pedido;
import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.model.repository.PedidoRepository;
import com.example.dunnas.model.repository.ClienteRepository;
import com.example.dunnas.model.repository.FornecedorRepository;
import com.example.dunnas.model.repository.ProdutoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class PedidoService {

    private PedidoRepository pedidoRepository;

    private ClienteService clienteService;

    private FornecedorService fornecedorService;

    private ProdutoRepository produtoRepository;

    public PedidoService(PedidoRepository pedidoRepository, ClienteService clienteService, FornecedorService fornecedorService, ProdutoRepository produtoRepository) {
        this.pedidoRepository = pedidoRepository;
        this.clienteService = clienteService;
        this.fornecedorService = fornecedorService;
        this.produtoRepository = produtoRepository;
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
           /*
            Cupom cupom = cupomRepository.findByCodigoAndFornecedorId(dto.getCupom(), fornecedor.getId())
                    .orElse(null);
            if (cupom != null && cupom.isValido()) {
                desconto = cupom.getValorDesconto();
            }
            */
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
}