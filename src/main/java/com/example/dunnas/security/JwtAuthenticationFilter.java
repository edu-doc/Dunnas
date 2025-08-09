package com.example.dunnas.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Arrays;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, 
                                    FilterChain filterChain) throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        
        if (isPublicUrl(requestURI)) {
            filterChain.doFilter(request, response);
            return;
        }

        String token = extractTokenFromRequest(request);
        
        if (token != null && jwtUtil.isTokenValid(token)) {
            String username = jwtUtil.extractUsername(token);
            Long userId = jwtUtil.extractUserId(token);
            String role = jwtUtil.extractRole(token);
            
            request.setAttribute("username", username);
            request.setAttribute("userId", userId);
            request.setAttribute("userRole", role);
            request.setAttribute("authenticated", true);
            
            filterChain.doFilter(request, response);
        } else {
            if (isAjaxRequest(request)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\":\"Token inválido ou expirado\"}");
            } else {
                response.sendRedirect("/login?error=session_expired");
            }
        }
    }

    private String extractTokenFromRequest(HttpServletRequest request) {
        if (request.getCookies() != null) {
            Cookie jwtCookie = Arrays.stream(request.getCookies())
                    .filter(cookie -> "jwt_token".equals(cookie.getName()))
                    .findFirst()
                    .orElse(null);
            
            if (jwtCookie != null) {
                return jwtCookie.getValue();
            }
        }
    
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }
        
        return null;
    }

    private boolean isPublicUrl(String requestURI) {
        return requestURI.startsWith("/login") ||
               requestURI.startsWith("/auth/login") ||
               requestURI.startsWith("/clientes/novo") ||
               requestURI.startsWith("/clientes/salvar") ||
               requestURI.startsWith("/clientes/verificar") ||
               requestURI.startsWith("/clientes/sucesso") ||
               requestURI.startsWith("/fornecedores/novo") ||
               requestURI.startsWith("/fornecedores/salvar") ||
               requestURI.startsWith("/fornecedores/verificar") ||
               requestURI.startsWith("/fornecedores/sucesso") ||
               requestURI.startsWith("/css/") ||
               requestURI.startsWith("/js/") ||
               requestURI.startsWith("/images/") ||
               requestURI.equals("/") ||
               requestURI.startsWith("/error") ||
               requestURI.startsWith("/favicon.ico");
    }

    private boolean isAjaxRequest(HttpServletRequest request) {
        String xRequestedWith = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(xRequestedWith);
    }
}
