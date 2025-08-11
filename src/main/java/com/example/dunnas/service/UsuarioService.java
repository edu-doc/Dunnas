package com.example.dunnas.service;

import com.example.dunnas.enuns.UsuarioRole;
import com.example.dunnas.model.entity.Usuario;
import com.example.dunnas.model.repository.UsuarioRepository;
import com.example.dunnas.model.repository.ClienteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
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

    public List<Usuario> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    public void atualizarUsuario(Long id, String usuario, String email, String role, boolean verificado) {
        Optional<Usuario> userOpt = usuarioRepository.findById(id);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Usuário não encontrado");
        }
        Usuario user = userOpt.get();
        user.setUsuario(usuario);
        user.setEmail(email);
        user.setRole(UsuarioRole.valueOf(role.toUpperCase()));
        user.setVerificado(verificado);
        usuarioRepository.save(user);
    }

    public void atualizarUsuarioAdmin(Long id, String usuario, String email, String senha) {
        Optional<Usuario> userOpt = usuarioRepository.findById(id);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Usuário não encontrado");
        }
        Usuario user = userOpt.get();
        user.setUsuario(usuario);
        user.setEmail(email);
        if (senha != null && !senha.isBlank()) {
            user.setSenha(senha);
        }
        usuarioRepository.save(user);
    }

    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id).orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }
    
    public Optional<Usuario> buscarPorEmail(String email) {
        Optional<Usuario> user = usuarioRepository.findByEmail(email);
        if (user.isPresent()) {
            return user;
        }
        return clienteRepository.findByEmail(email).map(c -> (Usuario) c);
    }

    public void excluirUsuario(Long id) {
        Optional<Usuario> userOpt = usuarioRepository.findById(id);
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Usuário não encontrado");
        }
        usuarioRepository.deleteById(id);
    }

}
