package com.example.dunnas.model.repository;

import com.example.dunnas.model.entity.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PedidoRepository extends JpaRepository<Pedido, Long> {

	List<Pedido> findByClienteId(Long clienteId);
    
}
