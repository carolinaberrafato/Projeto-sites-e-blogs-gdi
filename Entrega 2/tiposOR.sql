-- Telefone ------------------------------------------

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    numero VARCHAR2(11),
    FINAL MAP MEMBER FUNCTION get_numero RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY tp_telefone AS
    MAP MEMBER FUNCTION get_numero RETURN VARCHAR2 IS
        BEGIN
            RETURN numero;
        END;
END;
/

-- VARRAY de telefones

CREATE OR REPLACE TYPE varray_tp_telefone AS VARRAY(5) OF tp_telefone;
/

-- Função que checa se há espaço disponível na varray_tp_telefone e, caso sim, insere um novo valor

CREATE OR REPLACE TYPE BODY varray_tp_telefone AS
    MEMBER FUNCTION adicionar_numero(num_tel VARCHAR2(11)) RETURN BOOLEAN IS
    BEGIN
        IF SELF.COUNT < SELF.LIMIT THEN
            SELF(SELF.COUNT + 1) := num_tel;
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
END;
/

-- Perfil => Usuário | Moderador (Herança) ------------------------------------------

CREATE OR REPLACE TYPE tp_perfil AS OBJECT (
    email VARCHAR2(60),
    nome VARCHAR2(255),
    sobrenome VARCHAR2(255),
    data_nasc DATE,
    telefones varray_tp_telefone,
    MEMBER PROCEDURE mostrar_info
) NOT FINAL NOT INSTANTIABLE;
/

-- Usuário

CREATE OR REPLACE TYPE tp_usuario UNDER tp_perfil (
    num_postagens NUMBER,
    data_assinatura DATE,
    OVERRIDING MEMBER PROCEDURE mostrar_info,
    CONSTRUCTOR FUNCTION tp_usuario(x1 tp_usuario) RETURN SELF AS RESULT
);
/

-- Moderador

CREATE OR REPLACE TYPE tp_moderador UNDER tp_perfil (
    num_contas_banidas NUMBER
);
/

ALTER TYPE tp_perfil ADD ATTRIBUTE (
  data_cad DATE
) CASCADE;

CREATE OR REPLACE TYPE BODY tp_usuario AS 
    OVERRIDING MEMBER PROCEDURE mostrar_info IS  
        BEGIN 
            DBMS_OUTPUT.PUT_LINE(email); 
            DBMS_OUTPUT.PUT_LINE(nome); 
            DBMS_OUTPUT.PUT_LINE(sobrenome); 
			DBMS_OUTPUT.PUT_LINE(data_nasc); 
			DBMS_OUTPUT.PUT_LINE(data_cad); 
			DBMS_OUTPUT.PUT_LINE(telefones); 
			DBMS_OUTPUT.PUT_LINE(num_postagens); 
			DBMS_OUTPUT.PUT_LINE(data_assinatura); 
        END; 
    CONSTRUCTOR FUNCTION tp_cliente (x1 tp_usuario) RETURN SELF AS RESULT IS 
        BEGIN 
            email := x1.email; 
            nome := x1.nome; 
            sobrenome := x1.sobrenome; 
            data_nasc := x1.data_nasc; 
            data_cad := x1.data_cad; 
            telefones := x1.telefones; 
            num_postagens := x1.num_postagens; 
            data_assinatura := x1.data_assinatura; 
            RETURN; 
        END; 
END;
/

-- Seguir (auto-relacionamento) ------------------------------------------

CREATE OR REPLACE TYPE tp_seguidor AS OBJECT (
    seguidor REF tp_usuario,
    seguido REF tp_usuario
);
/

-- NESTED TABLE (ACOMPANHA)
CREATE OR REPLACE TYPE tp_acompanha AS OBJECT(
    usuario_associado REF tp_usuario,
    data_inicial DATE,
    data_final DATE
);
/
CREATE OR REPLACE TYPE tp_nt_acompanha AS TABLE OF tp_acompanha;
/

CREATE OR REPLACE TYPE BODY tp_acompanha AS
    ORDER MEMBER FUNCTION compara_tempo_acompanhamento (SELF IN OUT NOCOPY tp_acompanha, t tp_acompanha) RETURN NUMBER
    BEGIN
        IF (SELF.data_final - SELF.data_inicial) >= t.data_final - t.data_inicial THEN
            RETURN (SELF.data_final - SELF.data_inicial);
        ELSE
            RETURN t.data_final - t.data_inicial;
        END IF;
    END;
END;
/

-- Tópico

CREATE OR REPLACE TYPE tp_topico AS OBJECT(
  nome_do_topico VARCHAR2(60),
  acompanha tp_nt_acompanha
);
/

-- Comentário

CREATE OR REPLACE TYPE tp_comentario AS OBJECT (

  id VARCHAR2(10),
  data_publicacao DATE,
  mensagem VARCHAR2(255),
  num_curtidas INT	
);
/

-- Postagem

CREATE OR REPLACE TYPE tp_postagem AS OBJECT(
    id NUMBER,
    usuario_associado VARCHAR2(60),
    titulo_da_postagem VARCHAR2(60),
    data_publicacao DATE
);
/

-- Resposta

CREATE OR REPLACE TYPE tp_resposta AS OBJECT(
    id_comentario REF tp_comentario,
    id_resposta VARCHAR2(10),
    data_publicacao DATE,
    mensagem VARCHAR2(255)
);
/