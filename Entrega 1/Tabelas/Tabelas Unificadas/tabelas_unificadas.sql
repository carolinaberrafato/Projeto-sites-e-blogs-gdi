DROP TABLE Telefone;
DROP TABLE Associa2;
DROP TABLE Associa1;
DROP TABLE Segue;
DROP TABLE Acompanha;
DROP TABLE Usuario_Postagem;
DROP TABLE Resposta;
DROP TABLE Comentario;
DROP TABLE Topico;
DROP TABLE Postagem;
DROP TABLE Moderador;
DROP TABLE Usuario;
DROP TABLE Perfil;

CREATE TABLE Perfil (

  email VARCHAR2(60) NOT NULL,
  nome VARCHAR2(255) NOT NULL,
  sobrenome VARCHAR2(255) NOT NULL,
  data_nascimento DATE CHECK (EXTRACT(YEAR FROM data_nascimento) >= 1915) NOT NULL,
  data_cadastro DATE NOT NULL,

  CONSTRAINT perfil_pk PRIMARY KEY (email)

);

CREATE TABLE Usuario (

  email_usuario VARCHAR2(60) NOT NULL,
  data_assinatura DATE NOT NULL,
  numero_postagens INT,

  CONSTRAINT usuario_pk PRIMARY KEY (email_usuario),
  CONSTRAINT usuario_fk FOREIGN KEY (email_usuario) REFERENCES Perfil(email)

);

CREATE TABLE Moderador (

  email_moderador VARCHAR2(60),
  num_contas_banidas INT,

  CONSTRAINT moderador_pk PRIMARY KEY (email_moderador),
  CONSTRAINT moderador_fk FOREIGN KEY (email_moderador) REFERENCES Perfil(email)

);

CREATE TABLE Postagem (

  id VARCHAR2(10) NOT NULL,
  usuario_associado VARCHAR2(60) NOT NULL,
  titulo_da_postagem VARCHAR2(60) NOT NULL,
  data_publicacao DATE NOT NULL,

  CONSTRAINT postagem_pk PRIMARY KEY (id),
  CONSTRAINT postagem_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);

CREATE TABLE Topico (

  nome_do_topico VARCHAR2(60) NOT NULL,

  CONSTRAINT topico_pk PRIMARY KEY (nome_do_topico)

);

CREATE TABLE Comentario (

  id VARCHAR2(10) NOT NULL,
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,
  num_curtidas INT,

  CONSTRAINT comentario_pk PRIMARY KEY (id)

);

CREATE TABLE Resposta (

  id_comentario VARCHAR2(10),
  id_resposta VARCHAR2(10),
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,

  CONSTRAINT resposta_pk PRIMARY KEY (id_comentario, id_resposta),
  CONSTRAINT resposta_fk FOREIGN KEY (id_comentario) REFERENCES Comentario(id)
  
);

CREATE TABLE Usuario_Postagem (

  usuario VARCHAR2(60) NOT NULL,
  postagem VARCHAR2(10) NOT NULL,

  CONSTRAINT usuario_postagem_pk PRIMARY KEY (usuario, postagem),
  CONSTRAINT usuario_postagem_fk1 FOREIGN KEY (usuario) REFERENCES Usuario(email_usuario),
  CONSTRAINT usuario_postagem_fk2 FOREIGN KEY (postagem) REFERENCES Postagem(id)

);

CREATE TABLE Acompanha (

  topico_associado VARCHAR2(60) NOT NULL,
  usuario_associado VARCHAR2(60) NOT NULL,
  data_inicial DATE NOT NULL,
  data_final DATE,

  PRIMARY KEY (topico_associado, usuario_associado),
  CONSTRAINT topico_associado_acompanha_fk FOREIGN KEY (topico_associado) REFERENCES Topico(nome_do_topico),
  CONSTRAINT usuario_associado_acompanha_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);

CREATE TABLE Segue (

  seguidor VARCHAR2(60),
  seguido VARCHAR2(60),

  CONSTRAINT segue_pk PRIMARY KEY (seguidor, seguido),
  CONSTRAINT segue_fk1 FOREIGN KEY (seguidor) REFERENCES Usuario(email_usuario),
  CONSTRAINT segue_fk2 FOREIGN KEY (seguido) REFERENCES Usuario(email_usuario),
  CONSTRAINT segue_check CHECK (seguidor <> seguido)

);

CREATE TABLE Associa1 (

  postagem VARCHAR2(10),
  comentario VARCHAR2(10),

  CONSTRAINT associa1_pk PRIMARY KEY (postagem, comentario),
  CONSTRAINT associa1_fk1 FOREIGN KEY (postagem) REFERENCES Postagem(id),
  CONSTRAINT associa1_fk2 FOREIGN KEY (comentario) REFERENCES Comentario(id)

);

CREATE TABLE Associa2 (

  postagem VARCHAR2(10),
  topico VARCHAR2(60),

  CONSTRAINT associa2_pk PRIMARY KEY (postagem, topico),
  CONSTRAINT associa2_fk1 FOREIGN KEY (postagem) REFERENCES Postagem(id),
  CONSTRAINT associa2_fk2 FOREIGN KEY (topico) REFERENCES Topico(nome_do_topico)

);

CREATE TABLE Telefone (

  email_perfil VARCHAR2(60) NOT NULL,
  num_telefone VARCHAR2(11),

  CONSTRAINT telefone_pk PRIMARY KEY (email_perfil, num_telefone),
  CONSTRAINT telefone_fk FOREIGN KEY (email_perfil) REFERENCES Perfil(email)

);

