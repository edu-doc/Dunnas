package com.example.dunnas.model.repository;

import com.example.dunnas.model.entity.Produto;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {

    List<Produto> findByFornecedorIdAndAtivoTrue(Long fornecedorId);

    List<Produto> findByAtivoTrue();
}
