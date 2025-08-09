package com.example.dunnas.dto;

import com.example.dunnas.enuns.UsuarioRole;
import java.math.BigDecimal;
import java.time.LocalDate;

public class ClienteResponseDTO {
    private Long id;
    private String nome;
    private String cpf;
    private LocalDate dataNascimento;
    private String email;
    private String usuario;
    private BigDecimal saldo;
    private UsuarioRole role;
    private boolean verificado;

    public ClienteResponseDTO() {}

    public ClienteResponseDTO(Long id, String nome, String cpf, LocalDate dataNascimento, String email, String usuario, BigDecimal saldo, UsuarioRole role, boolean verificado) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
        this.email = email;
        this.usuario = usuario;
        this.saldo = saldo;
        this.role = role;
        this.verificado = verificado;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }
    public LocalDate getDataNascimento() { return dataNascimento; }
    public void setDataNascimento(LocalDate dataNascimento) { this.dataNascimento = dataNascimento; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public BigDecimal getSaldo() { return saldo; }
    public void setSaldo(BigDecimal saldo) { this.saldo = saldo; }
    public UsuarioRole getRole() { return role; }
    public void setRole(UsuarioRole role) { this.role = role; }
    public boolean isVerificado() { return verificado; }
    public void setVerificado(boolean verificado) { this.verificado = verificado; }
}
