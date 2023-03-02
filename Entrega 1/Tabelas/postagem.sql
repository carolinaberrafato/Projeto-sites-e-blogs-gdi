CREATE TABLE Postagem (

  id VARCHAR2(255) NOT NULL,
  usuario_associado VARCHAR2(255) NOT NULL,
  titulo_da_postagem VARCHAR2(255) NOT NULL,
  data_publicacao DATE NOT NULL,

  CONSTRAINT id_pk PRIMARY KEY (id),
  CONSTRAINT usuario_associado_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);