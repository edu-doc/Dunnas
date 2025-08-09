package com.example.dunnas.security;

import com.example.dunnas.model.entity.Usuario;
import com.example.dunnas.model.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class CustomUserDetails implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado com o nome: " + username));

        var authorities = Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + usuario.getRole().name()));

        return new org.springframework.security.core.userdetails.User(usuario.getUsuario(), usuario.getSenha(), authorities);
    }
}
