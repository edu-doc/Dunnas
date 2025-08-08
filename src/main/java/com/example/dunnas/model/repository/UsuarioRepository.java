package com.example.dunnas.model.repository;

import com.example.dunnas.model.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByEmail(String email);
    Optional<Usuario> findByUsuario(String usuario);
}
