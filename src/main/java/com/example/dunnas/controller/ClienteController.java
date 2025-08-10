package com.example.dunnas.controller;

import com.example.dunnas.dto.ClienteRequestDTO;
import com.example.dunnas.dto.ClienteResponseDTO;
import com.example.dunnas.service.ClienteService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    @Autowired
    private com.example.dunnas.security.JwtUtil jwtUtil;

    @GetMapping("/novo")
    public String novoCadastro(Model model) {
    model.addAttribute("cliente", new ClienteRequestDTO());
        return "clientes/cadastro";
    }

    @PostMapping("/salvar")
    public String salvarCliente(@Valid @ModelAttribute ClienteRequestDTO clienteRequestDTO, org.springframework.validation.BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("error", "CPF inválido.");
            model.addAttribute("cliente", clienteRequestDTO);
            return "clientes/cadastro";
        }
        try {
            ClienteResponseDTO response = clienteService.cadastrarCliente(clienteRequestDTO);
            model.addAttribute("email", response.getEmail());
            return "clientes/sucesso";
        } catch (Exception e) {
            String msg = e.getMessage();
            if (msg != null) {
                if (msg.contains("clientes_cpf_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse CPF.");
                } else if (msg.contains("usuarios_email_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse e-mail.");
                } else if (msg.contains("usuarios_usuario_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse nome de usuário.");
                } else {
                    model.addAttribute("error", msg);
                }
            } else {
                model.addAttribute("error", "Erro ao cadastrar cliente. Tente novamente mais tarde.");
            }
            model.addAttribute("cliente", clienteRequestDTO);
            return "clientes/cadastro";
        }
    }

    @GetMapping("/sucesso")
    public String sucessoCadastro(Model model) {
        // O email já está no model se vier do cadastro, senão apenas renderiza a tela
        return "clientes/sucesso";
    }

    @GetMapping("/perfil")
    public String perfilCliente(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        com.example.dunnas.model.entity.Cliente clienteEntity = clienteService.buscarPorId(clienteId);
        // Adiciona dados do cliente como 'usuario' para home.jsp
        model.addAttribute("usuario", clienteEntity);
        return "home";
    }

    @GetMapping("/verificar")
    public String mostrarFormularioVerificacao(@RequestParam(value = "email", required = false) String email, Model model) {
        model.addAttribute("email", email);
        return "clientes/verificacao";
    }

    @PostMapping("/verificar")
    public String verificarConta(@RequestParam("email") String email,
                                @RequestParam("codigo") String codigo,
                                Model model) {
        try {
            clienteService.verificarConta(email, codigo);
            model.addAttribute("success", "Conta verificada com sucesso! Você já pode fazer login.");
            return "clientes/verificacao-sucesso";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("email", email);
            return "clientes/verificacao";
        }
    }
}
