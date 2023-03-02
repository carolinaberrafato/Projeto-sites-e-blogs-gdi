CREATE TABLE Segue (

  seguidor VARCHAR2(60),
  seguido VARCHAR2(60),

  CONSTRAINT segue_pk PRIMARY KEY (seguidor, seguido),
  CONSTRAINT segue_fk1 FOREIGN KEY (seguidor) REFERENCES Usuario(email_usuario),
  CONSTRAINT segue_fk2 FOREIGN KEY (seguido) REFERENCES Usuario(email_usuario)

);