package com.example.dunnas.service;

import com.example.dunnas.exception.EmailException;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void enviarEmailVerificacao(String email, String codigo){

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("testedunnas@gmail.com");
            message.setTo(email);
            message.setSubject("Código de Verificação da Conta");
            message.setText("Olá! Seu Código de verificação é: " + codigo);
            mailSender.send(message);
        } catch (MailException e){
            throw new EmailException("Não foi possível enviar o email de verificação.");
        }
    }

}
