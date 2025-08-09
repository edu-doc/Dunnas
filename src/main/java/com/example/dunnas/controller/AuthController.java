package com.example.dunnas.controller;

import com.example.dunnas.model.entity.Usuario;
import com.example.dunnas.service.UsuarioService;
import com.example.dunnas.security.JwtUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class AuthController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/")
    public String index(HttpServletRequest request) {
        if (request.getAttribute("authenticated") != null) {
            return "redirect:/home";
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout,
                           @RequestParam(value = "session_expired", required = false) String sessionExpired,
                           Model model, HttpServletRequest request) {
        
        if (request.getAttribute("authenticated") != null) {
            return "redirect:/home";
        }
        
        if (error != null) {
            if ("session_expired".equals(error)) {
                model.addAttribute("error", "Sua sessão expirou. Faça login novamente.");
            } else {
                model.addAttribute("error", "Usuário ou senha inválidos.");
            }
        }
        
        if (logout != null) {
            model.addAttribute("logout", "Você saiu do sistema.");
        }
        
        return "login";
    }

    @PostMapping("/auth/login")
    public String processLogin(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpServletResponse response,
                              Model model) {
        try {
            Optional<Usuario> usuarioOpt = usuarioService.buscarPorUsuario(username);
            if (usuarioOpt.isEmpty()) {
                model.addAttribute("error", "Usuário ou senha inválidos.");
                return "login";
            }
            Usuario usuario = usuarioOpt.get();
            if (!usuario.isVerificado()) {
                model.addAttribute("error", "Conta não verificada. Verifique seu email.");
                return "login";
            }
            if (!passwordEncoder.matches(password, usuario.getSenha())) {
                model.addAttribute("error", "Usuário ou senha inválidos.");
                return "login";
            }
            String token = jwtUtil.generateToken(usuario.getUsuario(), usuario.getId(), usuario.getRole().name());
            Cookie jwtCookie = new Cookie("jwt_token", token);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(false);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(24 * 60 * 60);
            response.addCookie(jwtCookie);
            return "redirect:/home";
        } catch (Exception e) {
            model.addAttribute("error", "Usuário ou senha inválidos.");
            return "login";
        }
    }

    @GetMapping("/auth/logout")
    public String logout(HttpServletResponse response) {
        Cookie jwtCookie = new Cookie("jwt_token", null);
        jwtCookie.setHttpOnly(true);
        jwtCookie.setSecure(false);
        jwtCookie.setPath("/");
        jwtCookie.setMaxAge(0);
        response.addCookie(jwtCookie);
        
        return "redirect:/login?logout=true";
    }

    @GetMapping("/home")
    public String home(HttpServletRequest request, Model model) {
        if (request.getAttribute("authenticated") == null) {
            return "redirect:/login";
        }
        String username = (String) request.getAttribute("username");
        Optional<Usuario> usuarioOpt = usuarioService.buscarPorUsuario(username);
        usuarioOpt.ifPresent(usuario -> model.addAttribute("usuario", usuario));
        return "home";
    }
}
