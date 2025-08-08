/**
Codigo SQL para criar a tabela fornecedores no banco de dados.
 */

 CREATE TABLE fornecedores (
     id BIGSERIAL PRIMARY KEY,
     nome VARCHAR(50) NOT NULL,
     cnpj VARCHAR(14) NOT NULL UNIQUE,
     usuario VARCHAR(50) NOT NULL UNIQUE,
     senha VARCHAR(255) NOT NULL,

     -- Criação da chave estrangeira --
     CONSTRAINT fk_fornecedores_usuarios
        FOREIGN KEY (id)
        REFERENCES usuarios (id)
 );