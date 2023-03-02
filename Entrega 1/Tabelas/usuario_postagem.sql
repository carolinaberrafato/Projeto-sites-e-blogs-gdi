CREATE TABLE Usuario_Postagem (

  usuario VARCHAR2(255) NOT NULL,
  postagem VARCHAR2(255) NOT NULL,

  CONSTRAINT usuario_postagem_pk PRIMARY KEY (usuario, postagem),
  CONSTRAINT usuario_us_post_fk FOREIGN KEY (usuario) REFERENCES Usuario(email_usuario),
  CONSTRAINT postagem_us_post_fk FOREIGN KEY (postagem) REFERENCES Postagem(id)

);