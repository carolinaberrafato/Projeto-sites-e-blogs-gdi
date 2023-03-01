CREATE TABLE usuario (
  email VARCHAR(255) PRIMARY KEY,
  data_assinatura DATE NOT NULL,
  numero_postagens INT NOT NULL,
  FOREIGN KEY (email) REFERENCES perfil(email)
);