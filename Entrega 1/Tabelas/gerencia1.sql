CREATE TABLE Gerencia1 (

  moderador_associado VARCHAR2(255) NOT NULL,
  usuario VARCHAR2(255) NOT NULL,

  CONSTRAINT gerencia1_pk PRIMARY KEY (moderador_associado, usuario),
  CONSTRAINT moderador_associado_gerencia1_fk FOREIGN KEY (moderador_associado) REFERENCES Moderador(email_moderador),
  CONSTRAINT usuario_gerencia1_fk FOREIGN KEY (usuario) REFERENCES Usuario_Postagem(usuario)

);
