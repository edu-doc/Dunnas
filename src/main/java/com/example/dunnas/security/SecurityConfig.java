package com.example.dunnas.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.userDetailsService(customUserDetailsService);
    return http
        .authorizeHttpRequests(authorize -> authorize
            .requestMatchers(
                "/",
                "/login",
                "/clientes/novo",
                "/clientes/salvar",
                "/fornecedores/novo",
                "/fornecedores/salvar",
                "/clientes/verificar/**",
                "/fornecedores/verificar/**",
                "/css/**",
                "/js/**",
                "/images/**",
                "/static/**",
                "/webjars/**",
                "/WEB-INF/jsp/**"
            ).permitAll()
                .requestMatchers("/produtos-cliente").hasRole("CLIENTE")
                .requestMatchers("/produtos-fornecedor").hasRole("FORNECEDOR")
                .requestMatchers("/produtos/cadastro","/produtos/salvar","/produtos/produtos-fornecedor").hasRole("FORNECEDOR")
                .requestMatchers("/pedidos/**").hasRole("CLIENTE")
                .requestMatchers("/clientes/pix").hasRole("CLIENTE")
            .requestMatchers("/admin/**").hasRole("ADMIN")
            .anyRequest().authenticated()
        )
        .formLogin(form -> form
                .loginPage("/login")
                .successHandler(customAuthenticationSuccessHandler)
                .permitAll()
        )
        .logout(logout -> logout
            .logoutUrl("/auth/logout")
            .logoutSuccessUrl("/login?logout=true")
            .permitAll()
        )
        .csrf(csrf -> csrf.disable())
        .build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}