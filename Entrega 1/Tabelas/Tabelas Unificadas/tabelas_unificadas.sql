DROP TABLE Perfil;
DROP TABLE Usuario;
DROP TABLE Moderador;
DROP TABLE Comentario;
DROP TABLE Resposta;
DROP TABLE Topico;
DROP TABLE Acompanha;
DROP TABLE Telefone;
DROP TABLE Postagem;
DROP TABLE Usuario_Postagem;
DROP TABLE Segue;

CREATE TABLE Perfil (

  email VARCHAR2(255) NOT NULL,
  nome VARCHAR2(255) NOT NULL,
  sobrenome VARCHAR2(255) NOT NULL,
  data_nascimento DATE NOT NULL,
  data_cadastro DATE NOT NULL,

  CONSTRAINT perfil_pk PRIMARY KEY (email)

);

CREATE TABLE Usuario (

  email_usuario VARCHAR2(255) NOT NULL,
  data_assinatura DATE NOT NULL,
  numero_postagens INT,

  CONSTRAINT usuario_pk PRIMARY KEY (email_usuario),
  CONSTRAINT usuario_fk FOREIGN KEY (email_usuario) REFERENCES Perfil(email)

);

CREATE TABLE Moderador (

  email_moderador VARCHAR2(255),
  num_contas_banidas INT,

  CONSTRAINT email_moderador_pk PRIMARY KEY (email_moderador),
  CONSTRAINT email_moderador_fk FOREIGN KEY (email_moderador) REFERENCES Perfil(email)

);

CREATE TABLE Postagem (

  id VARCHAR2(255) NOT NULL,
  usuario_associado VARCHAR2(255) NOT NULL,
  titulo_da_postagem VARCHAR2(255) NOT NULL,
  data_publicacao DATE NOT NULL,

  CONSTRAINT id_pk PRIMARY KEY (id),
  CONSTRAINT usuario_associado_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)

);

CREATE TABLE Comentario (
  id VARCHAR2(255) PRIMARY KEY,
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,
  num_curtidas INT
);

CREATE TABLE Resposta (
  id_comentario VARCHAR2(255),
  id_resposta VARCHAR2(255),
  data_publicacao DATE NOT NULL,
  mensagem VARCHAR2(255) NOT NULL,

  PRIMARY KEY (id_comentario, id_resposta),
  CONSTRAINT id_comentario_fk FOREIGN KEY (id_comentario) REFERENCES Comentario(id)
);

CREATE TABLE Usuario_Postagem (

	usuario VARCHAR2(255) NOT NULL,
  postagem VARCHAR2(255) NOT NULL,

  CONSTRAINT usuario_postagem_pk PRIMARY KEY (usuario, postagem),
  CONSTRAINT usuario_us_post_fk FOREIGN KEY (usuario) REFERENCES Usuario(email_usuario),
  CONSTRAINT postagem_us_post_fk FOREIGN KEY (postagem) REFERENCES Postagem(id)

);

CREATE TABLE Topico (
  nome_do_topico VARCHAR2(255) PRIMARY KEY
);

CREATE TABLE Acompanha (
  topico_associado VARCHAR2(255) NOT NULL,
  usuario_associado VARCHAR2(255) NOT NULL,
  data_inicial DATE NOT NULL,
  data_final DATE NOT NULL,

  PRIMARY KEY (topico_associado, usuario_associado),
  CONSTRAINT topico_associado_acompanha_fk FOREIGN KEY (topico_associado) REFERENCES Topico(nome_do_topico),
  CONSTRAINT usuario_associado_acompanha_fk FOREIGN KEY (usuario_associado) REFERENCES Usuario(email_usuario)
);

CREATE TABLE Segue (
  seguidor VARCHAR2(255) NOT NULL,
  seguido VARCHAR2(255) NOT NULL,

  PRIMARY KEY (seguidor, seguido),
  CONSTRAINT seguidor_fk FOREIGN KEY (seguidor) REFERENCES Usuario(email_usuario),
  CONSTRAINT seguido_fk FOREIGN KEY (seguido) REFERENCES Usuario(email_usuario)
);

CREATE TABLE Telefone (
  email_perfil VARCHAR2(255),
  num_telefone VARCHAR2(255),

  PRIMARY KEY (email_perfil, num_telefone),
  CONSTRAINT email_perfil_fk FOREIGN KEY (email_perfil) REFERENCES Perfil(email)
);

