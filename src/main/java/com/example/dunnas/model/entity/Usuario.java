package com.example.dunnas.model.entity;

import com.example.dunnas.enuns.UsuarioRole;
import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "usuarios")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "usuario", nullable = false, unique = true,  length = 50)
    private String usuario;

    @Column(name = "senha", nullable = false)
    private String senha;

    @Column(name = "email",  nullable = false, unique = true,  length = 100)
    private String email;

    @Column(name = "codigo_verificacao", length = 6)
    private String codigoVerificacao;

    @Column(name = "verificado", nullable = false)
    private boolean verificado = false;

    @Enumerated(EnumType.STRING)
    private UsuarioRole role;

    public Long getId() {
        return id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCodigoVerificacao() {
        return codigoVerificacao;
    }

    public void setCodigoVerificacao(String codigoVerificacao) {
        this.codigoVerificacao = codigoVerificacao;
    }

    public boolean isVerificado() {
        return verificado;
    }

    public void setVerificado(boolean verificado) {
        this.verificado = verificado;
    }

    public UsuarioRole getRole() {
        return role;
    }

    public void setRole(UsuarioRole role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Usuario usuario1 = (Usuario) o;
        return verificado == usuario1.verificado && Objects.equals(id, usuario1.id) && Objects.equals(usuario, usuario1.usuario) && Objects.equals(senha, usuario1.senha) && Objects.equals(email, usuario1.email) && Objects.equals(codigoVerificacao, usuario1.codigoVerificacao);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, usuario, senha, email, codigoVerificacao, verificado);
    }

}
