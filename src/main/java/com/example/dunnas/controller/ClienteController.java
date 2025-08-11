package com.example.dunnas.controller;

import com.example.dunnas.dto.ClienteRequestDTO;
import com.example.dunnas.dto.ClienteResponseDTO;
import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.security.JwtUtil;
import com.example.dunnas.service.ClienteService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/clientes")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/pix")
    public String mostrarFormularioPix(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        model.addAttribute("clienteId", clienteId);
        return "clientes/pix";
    }

    @PostMapping("/pix")
    public String processarPix(@RequestParam("valor") java.math.BigDecimal valor,
                              @CookieValue("jwt_token") String jwtToken,
                              org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        boolean sucesso = clienteService.adicionarSaldo(clienteId, valor);
        if (sucesso) {
            redirectAttributes.addFlashAttribute("success", "Saldo adicionado com sucesso!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Não foi possível adicionar saldo. Valor inválido ou cliente inexistente.");
        }
        return "redirect:/clientes/perfil";
    }

    @GetMapping("/novo")
    public String novoCadastro(Model model) {
    model.addAttribute("cliente", new ClienteRequestDTO());
        return "clientes/cadastro";
    }

    @PostMapping("/salvar")
    public String salvarCliente(@Valid @ModelAttribute ClienteRequestDTO clienteRequestDTO, BindingResult result, Model model) {
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
        return "clientes/sucesso";
    }

    @GetMapping("/perfil")
    public String perfilCliente(Model model, @CookieValue("jwt_token") String jwtToken) {
        Long clienteId = jwtUtil.extractUserId(jwtToken);
        Cliente clienteEntity = clienteService.buscarPorId(clienteId);

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
