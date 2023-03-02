CREATE TABLE Postagem (

  id VARCHAR2(10) NOT NULL,
  usuario_associado VARCHAR2(60) NOT NULL,
  titulo_da_postagem VARCHAR2(60) NOT NULL,
  data_publicacao DATE NOT NULL,

  CONSTRAINT postagem_pk PRIMARY KEY (id),
  CONSTRAINT postagem_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);