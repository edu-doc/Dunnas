package com.example.dunnas.controller;

import com.example.dunnas.model.entity.Cliente;
import com.example.dunnas.service.ClienteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/clientes")
public class ClienteController {

    private final ClienteService clienteService;

    public ClienteController(ClienteService clienteService) {
        this.clienteService = clienteService;
    }

    @GetMapping("/novo")
    public String exibirCadastroCliente(Model model){

        model.addAttribute("cliente", new Cliente());

        return "cliente-formulario";
    }

    @PostMapping("/salvar")
    public String processarCadastroCliente(@ModelAttribute Cliente cliente){

        clienteService.cadastrarCliente(cliente);

        return "redirect:/clientes/sucesso";
    }

    @GetMapping("/sucesso")
    public String exibirPaginaSucesso(){

        return "cliente-sucesso";
    }
}
