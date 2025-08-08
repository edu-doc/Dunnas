package com.example.dunnas.service;

import com.example.dunnas.enuns.UsuarioRole;
import com.example.dunnas.exception.ClienteException;
import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.model.repository.ClienteRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Service
public class ClienteService {

    private final ClienteRepository clienteRepository;

    private final EmailService emailService;

    public  ClienteService(ClienteRepository clienteRepository, EmailService emailService) {
        this.clienteRepository = clienteRepository;
        this.emailService = emailService;
    }

    public Cliente cadastrarCliente(Cliente cliente) {

        String codigo = String.format("%06d", new Random().nextInt(999999));
        cliente.setCodigoVerificacao(codigo);
        cliente.setRole(UsuarioRole.CLIENTE);

        Cliente clienteSalvo = clienteRepository.save(cliente);

        emailService.enviarEmailVerificacao(clienteSalvo.getEmail(), codigo);

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

        return clienteRepository.save(cliente);
    }

    public void verificarConta(String email, String codigo){

        Cliente cliente = clienteRepository.findByEmail(email)
                .orElseThrow(() -> new ClienteException("Usuário não encontrado com o email: " + email));

        if (cliente.isVerificado()){
            throw new ClienteException("Conta já verificada.");
        }

        if (codigo.equals(cliente.getCodigoVerificacao())){
            cliente.setVerificado(true);
            cliente.setCodigoVerificacao(null);
            clienteRepository.save(cliente);
        } else {
            throw new ClienteException("Código de verificação inválido");
        }

    }

}
