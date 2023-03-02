CREATE TABLE Comentario (

  id VARCHAR2(10) NOT NULL,
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,
  num_curtidas INT,

  CONSTRAINT comentario_pk PRIMARY KEY (id)

);