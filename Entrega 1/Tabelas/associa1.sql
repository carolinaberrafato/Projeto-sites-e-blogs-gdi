CREATE TABLE Associa1 (

  postagem VARCHAR2(10),
  comentario VARCHAR2(10),

  CONSTRAINT associa1_pk PRIMARY KEY (postagem, comentario),
  CONSTRAINT associa1_fk1 FOREIGN KEY (postagem) REFERENCES Postagem(id),
  CONSTRAINT associa1_fk2 FOREIGN KEY (comentario) REFERENCES Comentario(id)

);