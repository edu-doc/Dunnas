package com.example.dunnas.service;

import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.model.repository.ClienteRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ClienteService {

    private final ClienteRepository clienteRepository;

    private final PasswordEncoder passwordEncoder;

    public  ClienteService(ClienteRepository clienteRepository, PasswordEncoder passwordEncoder) {
        this.clienteRepository = clienteRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Cliente cadastrarCliente(Cliente cliente) {

        String senhaCriptografada = passwordEncoder.encode(cliente.getSenha());
        cliente.setSenha(senhaCriptografada);

        return clienteRepository.save(cliente);
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id)
                .orElseThrow(()-> new RuntimeException
                        ("Cliente não encontrado com o id " + id + " no banco de dados"));
    }

    public Optional<Cliente> buscarPorUsuario(String usuario) {
        return clienteRepository.findByUsuario(usuario);
    }

    public Cliente alterarSenha(Long id, String senhaAntiga, String senhaNova) {

        Cliente cliente = buscarPorId(id);

        if (!passwordEncoder.matches(senhaAntiga, cliente.getSenha())) {
            throw new RuntimeException("Senha incorreta");
        }

        cliente.setSenha(passwordEncoder.encode(senhaNova));
        return clienteRepository.save(cliente);
    }

}
