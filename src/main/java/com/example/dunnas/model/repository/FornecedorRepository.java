package com.example.dunnas.model.repository;

import com.example.dunnas.model.entity.Fornecedor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FornecedorRepository extends JpaRepository<Fornecedor, Long> {

    Optional<Fornecedor> findByUsuario(String usuario);

    Optional<Fornecedor> findByEmail(String email);

    Optional<Fornecedor> findByCnpj(String cnpj);

}
