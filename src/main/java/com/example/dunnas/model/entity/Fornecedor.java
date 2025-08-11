package com.example.dunnas.model.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "fornecedores")
@PrimaryKeyJoinColumn(name = "id")
public class Fornecedor extends Usuario{

    @Column(name = "nome", nullable = false,  length = 50)
    private String nome;

    @Column(name = "cnpj",  nullable = false, unique = true, length = 14)
    private String cnpj;

    @Column(name = "saldo", nullable = false)
    private java.math.BigDecimal saldo = java.math.BigDecimal.ZERO;

    public Fornecedor() {}

    public java.math.BigDecimal getSaldo() {
        return saldo;
    }

    public void setSaldo(java.math.BigDecimal saldo) {
        this.saldo = saldo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Fornecedor that = (Fornecedor) o;
        return Objects.equals(nome, that.nome) && Objects.equals(cnpj, that.cnpj);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), nome, cnpj);
    }

}
