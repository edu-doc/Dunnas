/**
Codigo SQL para criar a tabela clientes no banco de dados.
 */

 CREATE TABLE usuarios (
     id BIGSERIAL PRIMARY KEY,
     usuario VARCHAR(50) NOT NULL UNIQUE,
     senha VARCHAR(255) NOT NULL,
     email VARCHAR(100) NOT NULL UNIQUE,
     codigo_verificacao VARCHAR(6),
     verificado BOOLEAN NOT NULL DEFAULT FALSE,
     user_tipo VARCHAR(50) NOT NULL
 );