package com.example.dunnas.model.repository;

import com.example.dunnas.model.entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {

    Optional<Cliente> findByUsuario(String usuario);
    Optional<Cliente> findByEmail(String email);
    Optional<Cliente> findByCpf(String cpf);
}
