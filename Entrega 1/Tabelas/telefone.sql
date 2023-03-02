CREATE TABLE Telefone (

  email_perfil VARCHAR2(60) NOT NULL,
  num_telefone VARCHAR2(11),

  CONSTRAINT telefone_pk PRIMARY KEY (email_perfil, num_telefone),
  CONSTRAINT telefone_fk FOREIGN KEY (email_perfil) REFERENCES Perfil(email)

);