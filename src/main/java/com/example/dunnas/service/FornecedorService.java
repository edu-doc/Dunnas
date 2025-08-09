package com.example.dunnas.service;

import com.example.dunnas.enuns.UsuarioRole;
import com.example.dunnas.exception.FornecedorException;
import com.example.dunnas.model.entity.Fornecedor;
import com.example.dunnas.model.repository.FornecedorRepository;

import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FornecedorService {

    private final FornecedorRepository fornecedorRepository;

    private final EmailService emailService;

    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    public FornecedorService(FornecedorRepository fornecedorRepository, EmailService emailService, org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        this.fornecedorRepository = fornecedorRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }

    public com.example.dunnas.dto.FornecedorResponseDTO cadastrarFornecedor(com.example.dunnas.dto.FornecedorRequestDTO dto) {
    
        if (buscarPorUsuario(dto.getUsuario()).isPresent()) {
            throw new RuntimeException("Nome de usuário já cadastrado. Escolha outro.");
        }
        if (buscarPorEmail(dto.getEmail()).isPresent()) {
            throw new RuntimeException("Email já cadastrado. Use outro email.");
        }
        if (buscarPorCnpj(dto.getCnpj()).isPresent()) {
            throw new RuntimeException("CNPJ já cadastrado. Use outro CNPJ.");
        }

        Fornecedor fornecedor = new Fornecedor();
        fornecedor.setNome(dto.getNome());
        fornecedor.setCnpj(dto.getCnpj());
        fornecedor.setEmail(dto.getEmail());
        fornecedor.setUsuario(dto.getUsuario());
        fornecedor.setSenha(passwordEncoder.encode(dto.getSenha()));
        fornecedor.setRole(UsuarioRole.FORNECEDOR);
        fornecedor.setVerificado(false);

        String codigo = String.format("%06d", new java.util.Random().nextInt(999999));
        fornecedor.setCodigoVerificacao(codigo);

        Fornecedor fornecedorSalvo = fornecedorRepository.save(fornecedor);
        emailService.enviarEmailVerificacao(fornecedorSalvo.getEmail(), codigo);

        return new com.example.dunnas.dto.FornecedorResponseDTO(
            fornecedorSalvo.getId(),
            fornecedorSalvo.getNome(),
            fornecedorSalvo.getCnpj(),
            fornecedorSalvo.getEmail(),
            fornecedorSalvo.getUsuario(),
            fornecedorSalvo.isVerificado()
        );
    }

    public Fornecedor buscarPorId(Long id) {
        return fornecedorRepository.findById(id)
                .orElseThrow(()-> new RuntimeException
                        ("Fornecedor não encontrado com o id " + id + " no banco de dados"));
    }

    public Optional<Fornecedor> buscarPorUsuario(String usuario) {
        return fornecedorRepository.findByUsuario(usuario);
    }

    public Optional<Fornecedor> buscarPorEmail(String email) {
        return fornecedorRepository.findByEmail(email);
    }

    public Optional<Fornecedor> buscarPorCnpj(String cnpj) {
        return fornecedorRepository.findByCnpj(cnpj);
    }

    public Fornecedor alterarSenha(Long id, String senhaAntiga, String senhaNova) {

        Fornecedor fornecedor = buscarPorId(id);

        if (!passwordEncoder.matches(senhaAntiga, fornecedor.getSenha())) {
            throw new RuntimeException("Senha antiga não confere.");
        }

        fornecedor.setSenha(passwordEncoder.encode(senhaNova));
        return fornecedorRepository.save(fornecedor);
    }

    public void verificarConta(String email, String codigo){

        Fornecedor fornecedor = fornecedorRepository.findByEmail(email)
                .orElseThrow(() -> new FornecedorException("Usuário não encontrado com o email: " + email));

        if (fornecedor.isVerificado()){
            throw new FornecedorException("Conta já verificada.");
        }

        if (codigo.equals(fornecedor.getCodigoVerificacao())){
            fornecedor.setVerificado(true);
            fornecedor.setCodigoVerificacao(null);
            fornecedorRepository.save(fornecedor);
        } else {
            throw new FornecedorException("Código de verificação inválido");
        }

    }

}
