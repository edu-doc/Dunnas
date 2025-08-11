package com.example.dunnas.controller;

import com.example.dunnas.service.CupomService;
import com.example.dunnas.service.UsuarioService;
import com.example.dunnas.dto.CupomRequestDTO;
import com.example.dunnas.dto.CupomResponseDTO;
import com.example.dunnas.model.entity.Usuario;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CupomService cupomService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping
    public String painelAdmin(Model model, Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
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
                             Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
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
    @PostMapping("/cupom/editar")
    public String salvarEdicaoCupom(@RequestParam("id") Long id,
                                   @RequestParam("codigo") String codigo,
                                   @RequestParam("desconto") double desconto,
                                   @RequestParam("dataValidade") String dataValidade,
                                   @RequestParam("ativo") boolean ativo,
                                   Model model,
                                   Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
        try {
            cupomService.atualizarCupom(id, codigo, desconto, dataValidade, ativo);
            model.addAttribute("success", "Cupom atualizado com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }
    @GetMapping("/cupom/editar")
    public String editarCupom(@RequestParam("id") Long id, Model model, Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
    CupomResponseDTO cupom = cupomService.buscarPorId(id);
    model.addAttribute("cupom", cupom);
    model.addAttribute("usuarios", usuarioService.listarUsuarios());
    List<CupomResponseDTO> cupons = cupomService.listarCupons();
    model.addAttribute("cupons", cupons);
    return "admin/editar-cupom";
    }
    @PostMapping("/usuario/editar")
    public String salvarEdicaoUsuario(@RequestParam("id") Long id,
                                     @RequestParam("usuario") String usuario,
                                     @RequestParam("email") String email,
                                     @RequestParam(value = "senha", required = false) String senha,
                                     Model model,
                                     Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
        try {
            usuarioService.atualizarUsuarioAdmin(id, usuario, email, senha);
            model.addAttribute("success", "Usuário atualizado com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }
    @GetMapping("/usuario/editar")
    public String editarUsuario(@RequestParam("id") Long id, Model model, Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
    Usuario usuario = usuarioService.buscarPorId(id);
    model.addAttribute("usuario", usuario);
    model.addAttribute("usuarios", usuarioService.listarUsuarios());
    List<CupomResponseDTO> cupons = cupomService.listarCupons();
    model.addAttribute("cupons", cupons);
    return "admin/editar-usuario";
    }

    @PostMapping("/usuario/excluir")
    public String excluirUsuario(@RequestParam("id") Long id, Model model, Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
        try {
            usuarioService.excluirUsuario(id);
            model.addAttribute("success", "Usuário excluído com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }
    @PostMapping("/cupom/excluir")
    public String excluirCupom(@RequestParam("id") Long id, Model model, Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/login";
        }
        try {
            cupomService.excluirCupom(id);
            model.addAttribute("success", "Cupom excluído com sucesso!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("usuarios", usuarioService.listarUsuarios());
        List<CupomResponseDTO> cupons = cupomService.listarCupons();
        model.addAttribute("cupons", cupons);
        return "admin/painel";
    }

}
