package com.example.dunnas.enuns;

public enum UsuarioRole {

    ADMIN("admin"),
    CLIENTE("cliente"),
    FORNECEDOR("fornecedor");

    private String role;

    UsuarioRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }

}
