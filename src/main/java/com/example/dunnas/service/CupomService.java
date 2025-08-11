package com.example.dunnas.service;

import com.example.dunnas.dto.CupomRequestDTO;
import com.example.dunnas.dto.CupomResponseDTO;
import com.example.dunnas.model.entity.Cupom;
import com.example.dunnas.model.repository.CupomRepository;
import org.springframework.stereotype.Service;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.ArrayList;

@Service
public class CupomService {
    @PersistenceContext
    private EntityManager entityManager;
    public void excluirCupom(Long id) {
        Optional<Cupom> cupomOpt = cupomRepository.findById(id);
        if (cupomOpt.isEmpty()) {
            throw new RuntimeException("Cupom não encontrado.");
        }
        cupomRepository.deleteById(id);
    }

    private final CupomRepository cupomRepository;

    public CupomService(CupomRepository cupomRepository) {
        this.cupomRepository = cupomRepository;
    }

    public List<CupomResponseDTO> listarCupons() {
        List<Cupom> cupons = cupomRepository.findAll();
        List<CupomResponseDTO> dtos = new ArrayList<>();
        for (Cupom cupom : cupons) {
            CupomResponseDTO dto = new CupomResponseDTO();
            dto.setId(cupom.getId());
            dto.setCodigo(cupom.getCodigo());
            dto.setDesconto(cupom.getDesconto());
            dto.setDataValidade(cupom.getDataValidade());
            dto.setAtivo(cupom.isAtivo());
            dtos.add(dto);
        }
        return dtos;
    }

    public void criarCupom(CupomRequestDTO dto) {
        String codigo = dto.getCodigo() != null ? dto.getCodigo().trim() : "";
        if (codigo.isEmpty()) {
            throw new RuntimeException("O código do cupom não pode ser vazio.");
        }
        if (cupomRepository.findByCodigo(codigo).isPresent()) {
            throw new RuntimeException("Já existe um cupom com esse código.");
        }
        if (dto.getDesconto() == null || dto.getDesconto().doubleValue() <= 0) {
            throw new RuntimeException("O desconto deve ser maior que zero.");
        }
        if (dto.getDataValidade() == null || dto.getDataValidade().isBefore(LocalDate.now().plusDays(1))) {
            throw new RuntimeException("A data de validade deve ser futura.");
        }
        Cupom cupom = new Cupom();
        cupom.setCodigo(codigo);
        cupom.setDesconto(dto.getDesconto());
        cupom.setDataValidade(dto.getDataValidade());
        cupom.setAtivo(dto.isAtivo());
        cupomRepository.save(cupom);
    }


    public Optional<Cupom> validarCupom(String codigo) {
        Optional<Cupom> cupomOpt = cupomRepository.findByCodigo(codigo);
        if (cupomOpt.isEmpty()) {
            return Optional.empty();
        }
        Cupom cupom = cupomOpt.get();
        if (!cupom.isAtivo()) {
            return Optional.empty();
        }
        if (cupom.getDataValidade() != null && cupom.getDataValidade().isBefore(java.time.LocalDate.now())) {
            return Optional.empty();
        }
        return Optional.of(cupom);
    }

    public void atualizarCupom(Long id, String codigo, double desconto, String dataValidade, boolean ativo) {
        Optional<Cupom> cupomOpt = cupomRepository.findById(id);
        if (cupomOpt.isEmpty()) {
            throw new RuntimeException("Cupom não encontrado");
        }
        Cupom cupom = cupomOpt.get();
        cupom.setCodigo(codigo);
        cupom.setDesconto(java.math.BigDecimal.valueOf(desconto));
        cupom.setDataValidade(LocalDate.parse(dataValidade));
        cupom.setAtivo(ativo);
        cupomRepository.save(cupom);
    }


    public CupomResponseDTO buscarPorId(Long id) {
        Optional<Cupom> cupomOpt = cupomRepository.findById(id);
        if (cupomOpt.isEmpty()) {
            throw new RuntimeException("Cupom não encontrado");
        }
        Cupom cupom = cupomOpt.get();
        CupomResponseDTO dto = new CupomResponseDTO();
        dto.setId(cupom.getId());
        dto.setCodigo(cupom.getCodigo());
        dto.setDesconto(cupom.getDesconto());
        dto.setDataValidade(cupom.getDataValidade());
        dto.setAtivo(cupom.isAtivo());
        return dto;
    }
}
