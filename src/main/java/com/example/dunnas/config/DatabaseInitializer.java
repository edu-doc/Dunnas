package com.example.dunnas.config;

import jakarta.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Component;

import com.example.dunnas.service.ClienteService;

import org.springframework.context.event.EventListener;
import org.springframework.boot.context.event.ApplicationReadyEvent;

@Component
public class DatabaseInitializer {

    @Value("${spring.datasource.url}")
    private String dbUrl;

    @Value("${spring.datasource.username}")
    private String dbUsername;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    /**
     Metodo para criação e verificação do banco,
     Se o banco não existir, ele cria.
     Se o banco existir, ele retorna uma mensagem com nome do banco.
     */
    @PostConstruct
    public void initializeDatabase() {

        String dbName = extractDatabaseName(dbUrl);

        DriverManagerDataSource adminDataSource = new DriverManagerDataSource();
        adminDataSource.setUrl(dbUrl.replace("/" + dbName, "/postgres"));
        adminDataSource.setUsername(dbUsername);
        adminDataSource.setPassword(dbPassword);

        JdbcTemplate jdbcTemplate = new JdbcTemplate(adminDataSource);

        try {

            String checkDbQuery = "SELECT COUNT(*) FROM pg_database WHERE datname = ?";
            Integer dbCount = jdbcTemplate.queryForObject(checkDbQuery, Integer.class, dbName);

            if (dbCount == 0) {
                System.out.println("Criando banco de dados: " + dbName);
                jdbcTemplate.execute("CREATE DATABASE " + dbName);
            } else {
                System.out.println("Banco de dados '" + dbName + "' já existe. Nenhuma ação necessária.");
            }
        } catch (Exception e) {
            throw new RuntimeException("Falha ao inicializar o banco de dados: " + e.getMessage(), e);
        }
    }

    /**
     * Método para criar o usuário admin.
     */
    @EventListener(ApplicationReadyEvent.class)
    public void criarAdminQuandoPronto(ApplicationReadyEvent event) {

        ClienteService clienteService = event.getApplicationContext().getBean(ClienteService.class);
        if (clienteService.buscarPorUsuario("admin").isEmpty()) {
            clienteService.criarClienteAdmin("admin", "admin123", "admin@dunnas.com");
        }

    }

    /**
     * Método para auxiliar na extração do nome do banco.
     */
    private String extractDatabaseName(String url) {
        int lastSlash = url.lastIndexOf("/");
        int questionMark = url.indexOf("?");
        if (questionMark == -1) {
            return url.substring(lastSlash + 1);
        }
        return url.substring(lastSlash + 1, questionMark);
    }
}
