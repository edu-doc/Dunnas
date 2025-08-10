package com.example.dunnas.service;

import com.example.dunnas.model.entity.Produto;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.repository.ProdutoRepository;
import com.example.dunnas.model.repository.FornecedorRepository;
import org.springframework.beans.factory.annotation.Autowired;
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

    public Produto cadastrarProduto(Produto produto, Long fornecedorId) {
        Fornecedor fornecedor = fornecedorService.buscarPorId(fornecedorId);
        produto.setFornecedor(fornecedor);
        return produtoRepository.save(produto);
    }

    public List<Produto> listarProdutos() {
        return produtoRepository.findAll();
    }

    public List<Produto> listarProdutosPorFornecedor(Long fornecedorId) {
        return produtoRepository.findByFornecedorId(fornecedorId);
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
        return produtoRepository.save(existente);
    }

    public void excluirProduto(Long id) {
        produtoRepository.deleteById(id);
    }
}
