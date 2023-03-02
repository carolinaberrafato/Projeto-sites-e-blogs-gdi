CREATE TABLE Telefone (
  email_perfil VARCHAR2(255),
  num_telefone VARCHAR2(255),

  PRIMARY KEY (email_perfil, num_telefone),
  CONSTRAINT email_perfil_fk FOREIGN KEY (email_perfil) REFERENCES Perfil(email)
);