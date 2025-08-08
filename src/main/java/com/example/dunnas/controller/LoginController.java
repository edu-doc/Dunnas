package com.example.dunnas.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String paginaDeLogin() {
        return "login"; // Retorna o nome do arquivo login.jsp
    }

    @GetMapping("/home")
    public String paginaHome() {
        return "home"; // Retorna o nome do arquivo home.jsp
    }

}
