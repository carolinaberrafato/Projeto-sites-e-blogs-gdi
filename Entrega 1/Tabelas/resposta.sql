CREATE TABLE Resposta (
  id_comentario VARCHAR2(255),
  id_resposta VARCHAR2(255),
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,

  PRIMARY KEY (id_comentario, id_resposta),
  CONSTRAINT id_comentario_fk FOREIGN KEY (id_comentario) REFERENCES Comentario(id)
);