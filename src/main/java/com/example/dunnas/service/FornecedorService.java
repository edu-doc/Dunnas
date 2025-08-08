package com.example.dunnas.service;

import com.example.dunnas.model.repository.FornecedorRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class FornecedorService {

    private FornecedorRepository fornecedorRepository;

    private PasswordEncoder passwordEncoder;

    public FornecedorService(FornecedorRepository fornecedorRepository, PasswordEncoder passwordEncoder) {
        this.fornecedorRepository = fornecedorRepository;
        this.passwordEncoder = passwordEncoder;
    }


}
