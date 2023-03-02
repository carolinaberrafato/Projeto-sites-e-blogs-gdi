CREATE TABLE Comentario (
  id VARCHAR2(255) PRIMARY KEY,
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,
  num_curtidas INT
);