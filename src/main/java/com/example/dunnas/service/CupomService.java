
package com.example.dunnas.service;

import com.example.dunnas.dto.CupomRequestDTO;
import com.example.dunnas.dto.CupomResponseDTO;
import com.example.dunnas.model.entity.Cupom;
import com.example.dunnas.model.repository.CupomRepository;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.ArrayList;

@Service
public class CupomService {

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
        if (cupomRepository.findByCodigoAndAtivoTrue(dto.getCodigo()).isPresent()) {
            throw new RuntimeException("Já existe um cupom ativo com esse código.");
        }
        if (dto.getDataValidade().isBefore(LocalDate.now())) {
            throw new RuntimeException("A data de validade deve ser futura.");
        }
        Cupom cupom = new Cupom();
        cupom.setCodigo(dto.getCodigo());
        cupom.setDesconto(dto.getDesconto());
        cupom.setDataValidade(dto.getDataValidade());
        boolean ativo = dto.isAtivo();
        cupom.setAtivo(ativo);
        cupomRepository.save(cupom);
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

}
