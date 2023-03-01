CREATE TABLE perfil (
  email VARCHAR(255) PRIMARY KEY,
  nome_completo VARCHAR(255) NOT NULL,
  data_nascimento DATE NOT NULL,
  data_cadastro DATE NOT NULL
);