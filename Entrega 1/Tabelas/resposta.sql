CREATE TABLE Resposta (

  id_comentario VARCHAR2(10),
  id_resposta VARCHAR2(10),
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,

  CONSTRAINT resposta_pk PRIMARY KEY (id_comentario, id_resposta),
  CONSTRAINT resposta_fk FOREIGN KEY (id_comentario) REFERENCES Comentario(id)
  
);