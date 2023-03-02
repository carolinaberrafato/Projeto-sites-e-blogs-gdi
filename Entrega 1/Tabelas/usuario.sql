CREATE TABLE Usuario (

  email_usuario VARCHAR2(60) NOT NULL,
  data_assinatura DATE NOT NULL,
  numero_postagens INT,

  CONSTRAINT usuario_pk PRIMARY KEY (email_usuario),
  CONSTRAINT usuario_fk FOREIGN KEY (email_usuario) REFERENCES Perfil(email)

);