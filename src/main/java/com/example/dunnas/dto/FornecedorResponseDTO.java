package com.example.dunnas.dto;

public class FornecedorResponseDTO {
    private Long id;
    private String nome;
    private String cnpj;
    private String email;
    private String usuario;
    private boolean verificado;
    private java.math.BigDecimal saldo;

    public FornecedorResponseDTO() {}

    public FornecedorResponseDTO(Long id, String nome, String cnpj, String email, String usuario, boolean verificado) {
        this.id = id;
        this.nome = nome;
        this.cnpj = cnpj;
        this.email = email;
        this.usuario = usuario;
        this.verificado = verificado;
        this.saldo = java.math.BigDecimal.ZERO; // Initialize saldo to zero
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getCnpj() { return cnpj; }
    public void setCnpj(String cnpj) { this.cnpj = cnpj; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public boolean isVerificado() { return verificado; }
    public void setVerificado(boolean verificado) { this.verificado = verificado; }
    public java.math.BigDecimal getSaldo() { return saldo; }
    public void setSaldo(java.math.BigDecimal saldo) { this.saldo = saldo; }
}
