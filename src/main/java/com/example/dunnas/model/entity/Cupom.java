package com.example.dunnas.model.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "cupons")
public class Cupom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "codigo", nullable = false, unique = true, length = 50)
    private String codigo;

    @Column(name = "desconto", nullable = false, precision = 10, scale = 2)
    private BigDecimal desconto;

    @Column(name = "data_validade", nullable = false)
    private LocalDate dataValidade;

    @Column(name = "ativo", nullable = false)
    private boolean ativo = true;

    public Cupom() {}

    public Long getId() { return id; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public BigDecimal getDesconto() { return desconto; }
    public void setDesconto(BigDecimal desconto) { this.desconto = desconto; }
    public LocalDate getDataValidade() { return dataValidade; }
    public void setDataValidade(LocalDate dataValidade) { this.dataValidade = dataValidade; }
    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }
}
