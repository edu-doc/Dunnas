package com.example.dunnas.service;

import com.example.dunnas.model.entity.Usuario;
import com.example.dunnas.model.repository.UsuarioRepository;
import com.example.dunnas.model.repository.ClienteRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UsuarioService {

    private UsuarioRepository usuarioRepository;

    private ClienteRepository clienteRepository;

    public UsuarioService(UsuarioRepository usuarioRepository, ClienteRepository clienteRepository) {
        this.usuarioRepository = usuarioRepository;
        this.clienteRepository = clienteRepository;
    }

    public Optional<Usuario> buscarPorUsuario(String usuario) {
        Optional<Usuario> user = usuarioRepository.findByUsuario(usuario);
        if (user.isPresent()) {
            return user;
        }
        return clienteRepository.findByUsuario(usuario).map(c -> (Usuario) c);
    }

        public java.util.List<Usuario> listarUsuarios() {
            return usuarioRepository.findAll();
        }
    
    public Optional<Usuario> buscarPorEmail(String email) {
        Optional<Usuario> user = usuarioRepository.findByEmail(email);
        if (user.isPresent()) {
            return user;
        }
        return clienteRepository.findByEmail(email).map(c -> (Usuario) c);
    }

}
