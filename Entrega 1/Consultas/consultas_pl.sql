-- USO DE RECORD -------------------------



-- USO DE ESTRUTURA DE DADOS DO TIPO TABLE -------------------------



-- BLOCO ANÔNIMO -------------------------



-- CREATE PROCEDURE -------------------------



-- CREATE FUNCTION -------------------------



-- %TYPE -------------------------
-- Essa consulta seleciona os dados da tabela Usuario para um usuário específico 
DECLARE
v_email_usuario Usuario.email_usuario%TYPE;
v_data_assinatura Usuario.data_assinatura%TYPE;
v_numero_postagens Usuario.numero_postagens%TYPE;
BEGIN
SELECT u.email_usuario, u.data_assinatura, u.numero_postagens
INTO v_email_usuario, v_data_assinatura, v_numero_postagens
FROM Usuario u
WHERE u.email_usuario = 'nivan@cin.ufpe.br';

DBMS_OUTPUT.PUT_LINE('Email do usuário: ' || v_email_usuario);
DBMS_OUTPUT.PUT_LINE('Data da assinatura: ' || TO_CHAR(v_data_assinatura, 'DD/MM/YYYY'));
DBMS_OUTPUT.PUT_LINE('Número de postagens: ' || v_numero_postagens);
END;
/


-- %ROWTYPE -------------------------
-- utilizamos a variável v_usuario do tipo %ROWTYPE para armazenar todas as colunas da tabela Usuario referentes a um usuário específico ('silvio@cin.ufpe.br'). Em seguida, contamos quantos seguidores esse usuário tem e armazenamos o resultado na variável v_seguidores. Finalmente, imprimimos os dados do usuário (email, data da assinatura, número de postagens) e o número de seguidores usando a função DBMS_OUTPUT.PUT_LINE(
DECLARE
v_usuario Usuario%ROWTYPE;
v_seguidores INTEGER;
BEGIN
SELECT *
INTO v_usuario
FROM Usuario u
WHERE u.email_usuario = 'silvio@cin.ufpe.br';

SELECT COUNT(*) INTO v_seguidores
FROM Segue s
WHERE s.seguido = v_usuario.email_usuario;

DBMS_OUTPUT.PUT_LINE('Dados do usuário:');
DBMS_OUTPUT.PUT_LINE('Email: ' || v_usuario.email_usuario);
DBMS_OUTPUT.PUT_LINE('Data da assinatura: ' || TO_CHAR(v_usuario.data_assinatura, 'DD/MM/YYYY'));
DBMS_OUTPUT.PUT_LINE('Número de postagens: ' || v_usuario.numero_postagens);
DBMS_OUTPUT.PUT_LINE('Seguidores: ' || v_seguidores);
END;
/

-- IF ELSIF -------------------------



-- CASE WHEN -------------------------
-- seleciona o número de postagens do usuário com o email 'nivan@cin.ufpe.br' da tabela Usuario e, em seguida, utiliza uma estrutura CASE WHEN para imprimir uma mensagem de acordo com o número de postagens desse usuário. Se o número de postagens for maior que 50, a mensagem "Este usuário é um usuário ativo e experiente." é impressa; se o número de postagens for maior que 20 e menor ou igual a 50, a mensagem "Este usuário é um usuário moderado." é impressa; caso contrário, a mensagem "Este usuário é um usuário iniciante." é impressa
DECLARE
  v_numero_postagens Usuario.numero_postagens%TYPE;
BEGIN
  SELECT numero_postagens INTO v_numero_postagens FROM Usuario WHERE email_usuario = 'nivan@cin.ufpe.br';
  
  CASE 
    WHEN v_numero_postagens > 50 THEN 
      DBMS_OUTPUT.PUT_LINE('Este usuário é um usuário ativo e experiente.');
    WHEN v_numero_postagens > 20 AND v_numero_postagens <= 50 THEN
      DBMS_OUTPUT.PUT_LINE('Este usuário é um usuário moderado.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Este usuário é um usuário iniciante.');
  END CASE;
END;



-- LOOP EXIT WHEN -------------------------



-- WHILE LOOP -------------------------



-- FOR IN LOOP -------------------------
-- loop FOR IN é utilizado para percorrer todos os usuários da tabela Usuario e somar o número total de postagens de todos eles. O resultado é armazenado na variável v_total_postagens e, em seguida, uma mensagem é impressa na tela com o total de postagens de todos os usuários.

DECLARE
  v_total_postagens NUMBER := 0;
BEGIN
  FOR usuario IN (SELECT email_usuario, numero_postagens FROM Usuario)
  LOOP
    v_total_postagens := v_total_postagens + usuario.numero_postagens;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('O total de postagens de todos os usuários é: ' || v_total_postagens);
END;


-- SELECT ... INTO -------------------------



-- CURSOR (OPEN, FETCH e CLOSE) -------------------------



-- EXCEPTION WHEN -------------------------



-- USO DE PARÂMETROS (IN, OUT ou IN OUT) -------------------------



-- CREATE OR REPLACE PACKAGE -------------------------



-- CREATE OR REPLACE PACKAGE BODY -------------------------



-- CREATE OR REPLACE TRIGGER (COMANDO) -------------------------



-- CREATE OR REPLACE TRIGGER (LINHA) -------------------------

