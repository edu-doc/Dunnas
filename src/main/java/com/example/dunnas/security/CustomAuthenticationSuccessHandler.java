package com.example.dunnas.security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        for (GrantedAuthority auth : authentication.getAuthorities()) {
                if (auth.getAuthority().equals("ROLE_CLIENTE")) {
                        response.sendRedirect("/produtos/produto-cliente");
                    return;
                } else if (auth.getAuthority().equals("ROLE_FORNECEDOR")) {
                        response.sendRedirect("/produtos/produtos-fornecedor");
                    return;
                } else if (auth.getAuthority().equals("ROLE_ADMIN")) {
                    response.sendRedirect("/admin");
                    return;
                }
        }
        response.sendRedirect("/home");
    }
}
