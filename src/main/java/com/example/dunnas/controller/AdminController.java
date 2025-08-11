
package com.example.dunnas.controller;

import com.example.dunnas.service.CupomService;
import com.example.dunnas.service.UsuarioService;
import com.example.dunnas.dto.CupomRequestDTO;
import com.example.dunnas.dto.CupomResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CupomService cupomService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private com.example.dunnas.security.JwtUtil jwtUtil;

    @GetMapping
    public String painelAdmin(Model model, @CookieValue("jwt_token") String jwtToken) {
        String role = jwtUtil.extractRole(jwtToken);
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }

    @PostMapping("/cupom/criar")
    public String criarCupom(@ModelAttribute CupomRequestDTO cupomRequestDTO,
                             Model model,
                             @CookieValue("jwt_token") String jwtToken) {
        String role = jwtUtil.extractRole(jwtToken);
        if (!"ADMIN".equals(role)) {
            return "redirect:/login";
        }
        try {
            cupomService.criarCupom(cupomRequestDTO);
            model.addAttribute("success", "Cupom criado com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }
}
