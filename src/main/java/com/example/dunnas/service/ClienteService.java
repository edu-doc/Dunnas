package com.example.dunnas.service;

import com.example.dunnas.dto.ClienteRequestDTO;
import com.example.dunnas.dto.ClienteResponseDTO;
import com.example.dunnas.enuns.UsuarioRole;
import com.example.dunnas.exception.ClienteException;
import com.example.dunnas.model.entity.Cliente;
import br.com.caelum.stella.validation.CPFValidator;
import org.apache.commons.validator.routines.EmailValidator;
import br.com.caelum.stella.validation.CPFValidator;
import org.apache.commons.validator.routines.EmailValidator;
import com.example.dunnas.model.repository.ClienteRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ClienteService {

    @PersistenceContext
    private EntityManager entityManager;
    private final ClienteRepository clienteRepository;

    private final EmailService emailService;

    private final PasswordEncoder passwordEncoder;

    public  ClienteService(ClienteRepository clienteRepository, EmailService emailService, org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        this.clienteRepository = clienteRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }

    public ClienteResponseDTO cadastrarCliente(ClienteRequestDTO dto) {
    
        if (buscarPorUsuario(dto.getUsuario()).isPresent()) {
            throw new RuntimeException("Nome de usuário já cadastrado. Escolha outro.");
        }
        if (buscarPorEmail(dto.getEmail()).isPresent()) {
            throw new RuntimeException("Email já cadastrado. Use outro email.");
        }
        if (buscarPorCpf(dto.getCpf()).isPresent()) {
            throw new RuntimeException("CPF já cadastrado. Use outro CPF.");
        }

        // Validação de CPF
        try {
            new CPFValidator().assertValid(dto.getCpf());
        } catch (br.com.caelum.stella.validation.InvalidStateException e) {
            throw new RuntimeException("CPF inválido! Por favor, insira um CPF válido.");
        }
        
            // Validação de e-mail
            if (dto.getEmail() != null && !EmailValidator.getInstance().isValid(dto.getEmail())) {
                throw new RuntimeException("E-mail inválido");
            }

        Cliente cliente = new Cliente();
        cliente.setNome(dto.getNome());
        cliente.setCpf(dto.getCpf());
        cliente.setDataNascimento(dto.getDataNascimento());
        cliente.setEmail(dto.getEmail());
        cliente.setUsuario(dto.getUsuario());
        cliente.setSenha(passwordEncoder.encode(dto.getSenha()));
        cliente.setSaldo(java.math.BigDecimal.ZERO);
        cliente.setRole(UsuarioRole.CLIENTE);
        cliente.setVerificado(false);

        String codigo = String.format("%06d", new java.util.Random().nextInt(999999));
        cliente.setCodigoVerificacao(codigo);

        Cliente clienteSalvo = clienteRepository.save(cliente);
        emailService.enviarEmailVerificacao(clienteSalvo.getEmail(), codigo);

        return new com.example.dunnas.dto.ClienteResponseDTO(
            clienteSalvo.getId(),
            clienteSalvo.getNome(),
            clienteSalvo.getCpf(),
            clienteSalvo.getDataNascimento(),
            clienteSalvo.getEmail(),
            clienteSalvo.getUsuario(),
            clienteSalvo.getSaldo(),
            clienteSalvo.getRole(),
            clienteSalvo.isVerificado()
        );
    }

    @Transactional
    public boolean adicionarSaldo(Long clienteId, java.math.BigDecimal valor) {
        Boolean result = (Boolean) entityManager
                .createNativeQuery("SELECT adicionar_saldo_cliente(:clienteId, :valor)")
                .setParameter("clienteId", clienteId)
                .setParameter("valor", valor)
                .getSingleResult();
        return result != null && result;
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id)
                .orElseThrow(()-> new RuntimeException
                        ("Cliente não encontrado com o id " + id + " no banco de dados"));
    }

    public Optional<Cliente> buscarPorUsuario(String usuario) {
        return clienteRepository.findByUsuario(usuario);
    }

    public Optional<Cliente> buscarPorEmail(String email) {
        return clienteRepository.findByEmail(email);
    }

    public Optional<Cliente> buscarPorCpf(String cpf) {
        return clienteRepository.findByCpf(cpf);
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
    
    public Cliente criarClienteAdmin(String usuario, String senha, String email) {
            // Validação de CPF
            if (usuario != null && usuario.length() == 11) {
                new CPFValidator().assertValid(usuario);
            }
            // Validação de e-mail
            if (!EmailValidator.getInstance().isValid(email)) {
                throw new RuntimeException("E-mail inválido");
            }
        if (buscarPorUsuario(usuario).isPresent()) {
            throw new RuntimeException("Usuário admin já existe.");
        }
        Cliente cliente = new Cliente();
        cliente.setUsuario(usuario);
        cliente.setSenha(passwordEncoder.encode(senha));
        cliente.setEmail(email);
        cliente.setRole(com.example.dunnas.enuns.UsuarioRole.ADMIN);
        cliente.setVerificado(true);
        cliente.setSaldo(java.math.BigDecimal.ZERO);
        cliente.setNome("Administrador");
        cliente.setCpf("00000000000");
        cliente.setDataNascimento(java.time.LocalDate.of(2000,1,1));
        cliente.setCodigoVerificacao(null);
        return clienteRepository.save(cliente);
    }

}
