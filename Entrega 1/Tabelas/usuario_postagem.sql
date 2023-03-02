CREATE TABLE Usuario_Postagem (

  usuario VARCHAR2(60) NOT NULL,
  postagem VARCHAR2(10) NOT NULL,

  CONSTRAINT usuario_postagem_pk PRIMARY KEY (usuario, postagem),
  CONSTRAINT usuario_postagem_fk1 FOREIGN KEY (usuario) REFERENCES Usuario(email_usuario),
  CONSTRAINT usuario_postagem_fk2 FOREIGN KEY (postagem) REFERENCES Postagem(id)

);