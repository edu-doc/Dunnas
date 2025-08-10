package com.example.dunnas.controller;

import com.example.dunnas.service.CupomService;
import com.example.dunnas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private UsuarioService usuarioService;
    @Autowired
    private CupomService cupomService;
    @Autowired
    private com.example.dunnas.security.JwtUtil jwtUtil;

    @GetMapping
    public String painelAdmin(Model model, @CookieValue("jwt_token") String jwtToken) {
        String role = jwtUtil.extractRole(jwtToken);
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        model.addAttribute("cupons", cupomService.listarCupons());
        return "admin/painel";
    }

    @PostMapping("/cupom/criar")
    public String criarCupom(@RequestParam("codigo") String codigo,
                             @RequestParam("desconto") java.math.BigDecimal desconto,
                             @RequestParam("dataValidade") java.time.LocalDate dataValidade,
                             @RequestParam("ativo") boolean ativo,
                             Model model,
                             @CookieValue("jwt_token") String jwtToken) {
        String role = jwtUtil.extractRole(jwtToken);
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }
        try {
            cupomService.criarCupom(codigo, desconto, dataValidade, ativo);
            model.addAttribute("success", "Cupom criado com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        model.addAttribute("cupons", cupomService.listarCupons());
        return "admin/painel";
    }
}
