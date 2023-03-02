CREATE TABLE Moderador (

  email_moderador VARCHAR2(60),
  num_contas_banidas INT,

  CONSTRAINT moderador_pk PRIMARY KEY (email_moderador),
  CONSTRAINT moderador_fk FOREIGN KEY (email_moderador) REFERENCES Perfil(email)

);