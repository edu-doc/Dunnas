package com.example.dunnas.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PagamentoService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public boolean processarPagamento(Long pedidoId) {
        Boolean result = (Boolean) entityManager
            .createNativeQuery("SELECT processar_pagamento(:pedidoId)")
            .setParameter("pedidoId", pedidoId)
            .getSingleResult();
        return result != null && result;
    }
}