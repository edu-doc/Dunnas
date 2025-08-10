package com.example.dunnas.service;

import com.example.dunnas.model.entity.Cupom;
import com.example.dunnas.model.repository.CupomRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
public class CupomService {
    private final CupomRepository cupomRepository;

    public CupomService(CupomRepository cupomRepository) {
        this.cupomRepository = cupomRepository;
    }

    public Optional<Cupom> validarCupom(String codigo) {
        Optional<Cupom> cupomOpt = cupomRepository.findByCodigoAndAtivoTrue(codigo);
        if (cupomOpt.isPresent()) {
            Cupom cupom = cupomOpt.get();
            if (cupom.getDataValidade().isBefore(LocalDate.now())) {
                return Optional.empty();
            }
            return Optional.of(cupom);
        }
        return Optional.empty();
    }

    public java.util.List<Cupom> listarCupons() {
        return cupomRepository.findAll();
    }

    public Cupom criarCupom(String codigo, java.math.BigDecimal desconto, java.time.LocalDate dataValidade, boolean ativo) {
        if (cupomRepository.findByCodigoAndAtivoTrue(codigo).isPresent()) {
            throw new RuntimeException("Já existe um cupom ativo com esse código.");
        }
        if (dataValidade.isBefore(java.time.LocalDate.now())) {
            throw new RuntimeException("A data de validade deve ser futura.");
        }
        Cupom cupom = new Cupom();
        cupom.setCodigo(codigo);
        cupom.setDesconto(desconto);
        cupom.setDataValidade(dataValidade);
        cupom.setAtivo(ativo);
        return cupomRepository.save(cupom);
    }
}
