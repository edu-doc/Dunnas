package com.example.dunnas.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class CupomRequestDTO {
    private String codigo;
    private BigDecimal desconto;
    private LocalDate dataValidade;
    private boolean ativo;

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public BigDecimal getDesconto() { return desconto; }
    public void setDesconto(BigDecimal desconto) { this.desconto = desconto; }

    public LocalDate getDataValidade() { return dataValidade; }
    public void setDataValidade(LocalDate dataValidade) { this.dataValidade = dataValidade; }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }
}
