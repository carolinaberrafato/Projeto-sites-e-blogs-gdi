CREATE SEQUENCE postagem_id_seq;

CREATE TABLE Postagem (
  id INT DEFAULT nextval('postagem_id_seq') PRIMARY KEY,
  usuario_associado VARCHAR(255) NOT NULL,
  titulo_da_postagem VARCHAR(255) NOT NULL,
  data_publicacao DATE NOT NULL,
  FOREIGN KEY (usuario_associado) REFERENCES usuario(email)
);