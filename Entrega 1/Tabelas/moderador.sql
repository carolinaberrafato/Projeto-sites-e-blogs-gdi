CREATE TABLE moderador (
  email VARCHAR(255) PRIMARY KEY,
  numero_contas_banidas INT NOT NULL,
  FOREIGN KEY (email) REFERENCES perfil(email)
);