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
            return "redirect:/clientes/sucesso?email=" + response.getEmail();
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
    public String sucessoCadastro(@RequestParam("email") String email, Model model) {
        model.addAttribute("email", email);
        return "clientes/sucesso";
    }

    @GetMapping("/verificar")
    public String paginaVerificacao(@RequestParam(value = "email", required = false) String email,
                                   @RequestParam(value = "error", required = false) String error,
                                   Model model) {
        if (email != null) {
            model.addAttribute("email", email);
        }
        
        if (error != null) {
            model.addAttribute("error", "Código de verificação inválido ou expirado.");
        }
        
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
