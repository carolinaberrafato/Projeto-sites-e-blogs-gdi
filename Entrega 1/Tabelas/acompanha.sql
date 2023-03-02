CREATE TABLE Acompanha (

  topico_associado VARCHAR2(60) NOT NULL,
  usuario_associado VARCHAR2(60) NOT NULL,
  data_inicial DATE NOT NULL,
  data_final DATE,

  PRIMARY KEY (topico_associado, usuario_associado),
  CONSTRAINT topico_associado_acompanha_fk FOREIGN KEY (topico_associado) REFERENCES Topico(nome_do_topico),
  CONSTRAINT usuario_associado_acompanha_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);