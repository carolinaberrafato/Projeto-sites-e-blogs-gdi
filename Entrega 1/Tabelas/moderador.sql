CREATE TABLE Moderador (

  email_moderador VARCHAR2(255),
  num_contas_banidas INT,

  CONSTRAINT email_moderador_pk PRIMARY KEY (email_moderador),
  CONSTRAINT email_moderador_fk FOREIGN KEY (email_moderador) REFERENCES Perfil(email)

);