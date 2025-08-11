package com.example.dunnas.model.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "fornecedores")
@PrimaryKeyJoinColumn(name = "id")
public class Fornecedor extends Usuario{
    @OneToMany(mappedBy = "fornecedor", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List <Produto> produtos;

    @Column(name = "nome", nullable = false,  length = 50)
    private String nome;

    @Column(name = "cnpj",  nullable = false, unique = true, length = 14)
    private String cnpj;

    @Column(name = "saldo", nullable = false)
    private BigDecimal saldo = BigDecimal.ZERO;

    public Fornecedor() {}

    public BigDecimal getSaldo() {
        return saldo;
    }

    public void setSaldo(BigDecimal saldo) {
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
