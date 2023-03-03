CREATE SEQUENCE post_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE Postagem (

  id NUMBER DEFAULT post_seq.NEXTVAL, 
  usuario_associado VARCHAR2(60) NOT NULL,
  titulo_da_postagem VARCHAR2(60) NOT NULL,
  data_publicacao DATE NOT NULL,

  CONSTRAINT postagem_pk PRIMARY KEY (id),
  CONSTRAINT postagem_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);