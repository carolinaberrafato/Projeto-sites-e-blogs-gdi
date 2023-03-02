CREATE TABLE Perfil (

  email VARCHAR2(255) NOT NULL,
  nome VARCHAR2(255) NOT NULL,
  sobrenome VARCHAR2(255) NOT NULL,
  data_nascimento DATE NOT NULL,
  data_cadastro DATE NOT NULL,

  CONSTRAINT perfil_pk PRIMARY KEY (email)

);