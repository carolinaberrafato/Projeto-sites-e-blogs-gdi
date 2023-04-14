-- Telefone ------------------------------------------

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    numero VARCHAR2(11),
    FINAL MAP MEMBER FUNCTION get_ddd RETURN VARCHAR2
);
/

-- VARRAY de telefones

CREATE OR REPLACE TYPE varray_tp_telefone AS VARRAY(5) OF tp_telefone;
/

-- Função que retorna o DDD do número de telefone (2 primeiros caracteres)

CREATE OR REPLACE TYPE BODY tp_telefone AS
    FINAL MAP MEMBER FUNCTION get_ddd RETURN VARCHAR2 IS
        BEGIN
            RETURN SUBSTR(numero, 1, 2);
        END;
END;
/

CREATE OR REPLACE TYPE tp_varray_tp_telefone AS OBJECT (
    varray_telefone varray_tp_telefone,
    MEMBER FUNCTION listar_numeros (SELF_OBJ IN tp_varray_tp_telefone) RETURN VARCHAR2
);
/
-- Função que checa se há espaço disponível na varray_tp_telefone e, caso sim, insere um novo valor

CREATE OR REPLACE TYPE BODY tp_varray_tp_telefone AS
    MEMBER FUNCTION listar_numeros (SELF_OBJ IN tp_varray_tp_telefone) RETURN VARCHAR2 IS
        v_numeros VARCHAR2(500);
    BEGIN
        v_numeros := '';
        FOR i IN 1..self_obj.varray_telefone.COUNT LOOP
            v_numeros := v_numeros || self_obj.varray_telefone(i).numero || ', ';
        END LOOP;
        -- Remove a última vírgula e espaço da string
        v_numeros := RTRIM(v_numeros, ', ');

        RETURN v_numeros;
    END listar_numeros;
END;
/

-- Perfil => Usuário | Moderador (Herança) ------------------------------------------

CREATE OR REPLACE TYPE tp_perfil AS OBJECT (
    email VARCHAR2(60),
    nome VARCHAR2(255),
    sobrenome VARCHAR2(255),
    data_nasc DATE,
    telefones varray_tp_telefone,
    MEMBER PROCEDURE mostrar_info  (SELF tp_perfil)
) NOT FINAL NOT INSTANTIABLE;
/

-- Usuário

CREATE OR REPLACE TYPE tp_usuario UNDER tp_perfil (
    num_postagens NUMBER,
    data_assinatura DATE,
    OVERRIDING MEMBER PROCEDURE mostrar_info ( SELF tp_usuario),
    CONSTRUCTOR FUNCTION tp_usuario(
        p_email VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_data_nasc DATE,
        p_data_cad DATE,
        p_telefones varray_tp_telefone,
        p_num_postagens NUMBER,
        p_data_assinatura DATE
    ) RETURN SELF AS RESULT
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
    OVERRIDING MEMBER PROCEDURE mostrar_info ( SELF tp_usuario) IS
    BEGIN 
            DBMS_OUTPUT.PUT_LINE(email); 
            DBMS_OUTPUT.PUT_LINE(nome); 
            DBMS_OUTPUT.PUT_LINE(sobrenome); 
			DBMS_OUTPUT.PUT_LINE(data_nasc); 
			DBMS_OUTPUT.PUT_LINE(data_cad); 
			DBMS_OUTPUT.PUT_LINE(num_postagens); 
			DBMS_OUTPUT.PUT_LINE(data_assinatura); 
        END; 

    CONSTRUCTOR FUNCTION tp_usuario(
        p_email VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_data_nasc DATE,
        p_data_cad DATE,
        p_telefones varray_tp_telefone,
        p_num_postagens NUMBER,
        p_data_assinatura DATE
    ) RETURN SELF AS RESULT IS
    BEGIN 
        email := p_email; 
        nome := p_nome; 
        sobrenome := p_sobrenome; 
        data_nasc := p_data_nasc; 
        data_cad := p_data_cad; 
        telefones := p_telefones; 
        num_postagens := p_num_postagens; 
        data_assinatura := p_data_assinatura; 
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
    data_final DATE,
    ORDER MEMBER FUNCTION compara_tempo_acompanhamento (SELF IN OUT NOCOPY tp_acompanha, t tp_acompanha) RETURN NUMBER
);
/
CREATE OR REPLACE TYPE tp_nt_acompanha AS TABLE OF tp_acompanha;
/

CREATE OR REPLACE TYPE BODY tp_acompanha AS
    ORDER MEMBER FUNCTION compara_tempo_acompanhamento (SELF IN OUT NOCOPY tp_acompanha, t tp_acompanha) RETURN NUMBER IS
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

-- Postagem

CREATE OR REPLACE TYPE tp_postagem AS OBJECT(
    id VARCHAR2(10),
    titulo_da_postagem VARCHAR2(60),
    data_publicacao DATE
);
/

CREATE OR REPLACE TYPE tp_usuario_postagem AS OBJECT (
    usuario REF tp_usuario,
    postagem REF tp_postagem
);
/

ALTER TYPE tp_usuario_postagem ADD ATTRIBUTE (
  id_associado VARCHAR2(10)
) CASCADE;
/

CREATE OR REPLACE TYPE tp_nt_usuario_postagem AS TABLE OF tp_usuario_postagem;
/

-- Comentário

CREATE OR REPLACE TYPE tp_comentario AS OBJECT (

  id VARCHAR2(10),
  data_publicacao DATE,
  mensagem VARCHAR2(255),
  num_curtidas INT	
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

-- Associa1 (postagem - comentário)
CREATE OR REPLACE TYPE tp_postagem_comentario AS OBJECT (
    postagem REF tp_postagem,
    comentario REF tp_comentario
);
/

ALTER TYPE tp_postagem_comentario ADD ATTRIBUTE (
  id_associado VARCHAR2(10)
) CASCADE;
/

CREATE OR REPLACE TYPE tp_nt_postagem_comentario AS TABLE OF tp_postagem_comentario;
/

-- Associa2 (tópico - postagem)
CREATE OR REPLACE TYPE tp_topico_postagem AS OBJECT (
    topico REF tp_topico,
    postagem REF tp_postagem
);
/

ALTER TYPE tp_topico_postagem ADD ATTRIBUTE (
  id_associado VARCHAR2(10)
) CASCADE;
/

CREATE OR REPLACE TYPE tp_nt_topico_postagem AS TABLE OF tp_topico_postagem;
/