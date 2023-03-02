CREATE TABLE Segue (
  seguidor VARCHAR2(255) NOT NULL,
  seguido VARCHAR2(255) NOT NULL,

  PRIMARY KEY (seguidor, seguido),
  CONSTRAINT seguidor_fk FOREIGN KEY (seguidor) REFERENCES Usuario(email_usuario),
  CONSTRAINT seguido_fk FOREIGN KEY (seguido) REFERENCES Usuario(email_usuario)
);