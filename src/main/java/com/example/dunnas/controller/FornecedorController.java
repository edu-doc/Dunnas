
package com.example.dunnas.controller;

import com.example.dunnas.dto.FornecedorRequestDTO;
import com.example.dunnas.dto.FornecedorResponseDTO;
import com.example.dunnas.service.FornecedorService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/fornecedores")
public class FornecedorController {

    @Autowired
    private FornecedorService fornecedorService;

    @GetMapping("/novo")
    public String novoCadastro(Model model) {
        model.addAttribute("fornecedor", new FornecedorRequestDTO());
        return "fornecedores/cadastro";
    }

    @PostMapping("/salvar")
    public String salvarFornecedor(@Valid @ModelAttribute FornecedorRequestDTO fornecedorRequestDTO, org.springframework.validation.BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("error", "CNPJ inválido.");
            model.addAttribute("fornecedor", fornecedorRequestDTO);
            return "fornecedores/cadastro";
        }
        try {
            FornecedorResponseDTO response = fornecedorService.cadastrarFornecedor(fornecedorRequestDTO);
            return "redirect:/fornecedores/sucesso?email=" + response.getEmail();
        } catch (Exception e) {
            String msg = e.getMessage();
            if (msg != null) {
                if (msg.contains("fornecedores_cnpj_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse CNPJ.");
                } else if (msg.contains("usuarios_email_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse e-mail.");
                } else if (msg.contains("usuarios_usuario_key")) {
                    model.addAttribute("error", "Já existe uma conta com esse nome de usuário.");
                } else {
                    model.addAttribute("error", msg);
                }
            } else {
                model.addAttribute("error", "Erro ao cadastrar fornecedor. Tente novamente mais tarde.");
            }
            model.addAttribute("fornecedor", fornecedorRequestDTO);
            return "fornecedores/cadastro";
        }
    }

    @GetMapping("/sucesso")
    public String sucessoCadastro(@RequestParam("email") String email, Model model) {
        model.addAttribute("email", email);
        return "fornecedores/sucesso";
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
        return "fornecedores/verificacao";
    }

    @PostMapping("/verificar")
    public String verificarConta(@RequestParam("email") String email,
                                @RequestParam("codigo") String codigo,
                                Model model) {
        try {
            fornecedorService.verificarConta(email, codigo);
            model.addAttribute("success", "Conta verificada com sucesso! Você já pode fazer login.");
            return "fornecedores/verificacao-sucesso";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("email", email);
            return "fornecedores/verificacao";
        }
    }
}
