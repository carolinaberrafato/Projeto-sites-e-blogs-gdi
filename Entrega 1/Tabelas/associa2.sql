CREATE TABLE Associa2 (

  postagem NUMBER,
  topico VARCHAR2(60),

  CONSTRAINT associa2_pk PRIMARY KEY (postagem, topico),
  CONSTRAINT associa2_fk1 FOREIGN KEY (postagem) REFERENCES Postagem(id),
  CONSTRAINT associa2_fk2 FOREIGN KEY (topico) REFERENCES Topico(nome_do_topico)

);