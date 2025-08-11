package com.example.dunnas.service;

import com.example.dunnas.dto.ProdutoRequestDTO;
import com.example.dunnas.dto.ProdutoResponseDTO;
import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.repository.ProdutoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProdutoService {

    private ProdutoRepository produtoRepository;

    private FornecedorService fornecedorService;

    public ProdutoService(ProdutoRepository produtoRepository, FornecedorService fornecedorService) {
        this.produtoRepository = produtoRepository;
        this.fornecedorService = fornecedorService;
    }

    public ProdutoResponseDTO cadastrarProduto(ProdutoRequestDTO dto) {
        Fornecedor fornecedor = fornecedorService.buscarPorId(dto.getFornecedorId());
        Produto produto = new Produto();
        produto.setNome(dto.getNome());
        produto.setDescricao(dto.getDescricao());
        produto.setPreco(dto.getPreco());
        produto.setFornecedor(fornecedor);
        produto.setAtivo(true);
        Produto salvo = produtoRepository.save(produto);

        ProdutoResponseDTO response = new ProdutoResponseDTO();
        response.setId(salvo.getId());
        response.setNome(salvo.getNome());
        response.setDescricao(salvo.getDescricao());
        response.setPreco(salvo.getPreco());
        response.setFornecedorId(fornecedor.getId());
        response.setFornecedorNome(fornecedor.getNome());
        response.setAtivo(salvo.isAtivo());
        return response;
    }

    public List<ProdutoResponseDTO> listarProdutos() {
        List<Produto> produtos = produtoRepository.findByAtivoTrue();
        return produtos.stream().map(produto -> {
            ProdutoResponseDTO dto = new ProdutoResponseDTO();
            dto.setId(produto.getId());
            dto.setNome(produto.getNome());
            dto.setDescricao(produto.getDescricao());
            dto.setPreco(produto.getPreco());
            dto.setFornecedorId(produto.getFornecedor().getId());
            dto.setFornecedorNome(produto.getFornecedor().getNome());
            dto.setAtivo(produto.isAtivo());
            return dto;
        }).toList();
    }

    public List<Produto> listarProdutosPorFornecedor(Long fornecedorId) {
        return produtoRepository.findByFornecedorIdAndAtivoTrue(fornecedorId);
    }

    public Optional<Produto> buscarPorId(Long id) {
        return produtoRepository.findById(id);
    }

    public Produto atualizarProduto(Produto produto) {
        Produto existente = produtoRepository.findById(produto.getId()).orElseThrow();
        existente.setNome(produto.getNome());
        existente.setDescricao(produto.getDescricao());
        existente.setPreco(produto.getPreco());
        existente.setPrecoComDesconto(produto.getPrecoComDesconto());
        existente.setFornecedor(produto.getFornecedor());
        existente.setAtivo(produto.isAtivo());
        return produtoRepository.save(existente);
    }

    public void excluirProduto(Long id) {
        Produto produto = produtoRepository.findById(id).orElseThrow();
        produto.setAtivo(false);
        produtoRepository.save(produto);
    }

}
