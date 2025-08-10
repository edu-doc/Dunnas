package com.example.dunnas.enuns;

public enum PedidoEnum {

    PENDENTE("pendente"),
    PAGO("pago"),
    CANCELADO("cancelado");

    private String pedido;

    PedidoEnum(String pedido) { this.pedido = pedido;}

    public String getPedido() {
        return pedido;
    }
}
