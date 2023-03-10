-- USO DE RECORD -------------------------
-- Cria um registro (record) telefone_rec. Faz-se uma consulta à tabela Telefone com WHERE especificando email_perfil com valor nivan@cin.ufpe.br e então se armazena os resultados na variável telefone_rec
DECLARE
telefone_rec Telefone%ROWTYPE;
BEGIN
SELECT *
INTO telefone_rec
FROM Telefone
WHERE email_perfil = 'nivan@cin.ufpe.br';

DBMS_OUTPUT.PUT_LINE('Email do Perfil: ' || telefone_rec.email_perfil);
DBMS_OUTPUT.PUT_LINE('Número de Telefone: ' || telefone_rec.num_telefone);
END;


-- USO DE ESTRUTURA DE DADOS DO TIPO TABLE -------------------------
-- Faz a cópia do tipo da tabela de Topico.nome_do_topico e printa todos os topicos
DECLARE
    TYPE topico_type IS TABLE OF Topico.nome_do_topico%TYPE
    INDEX BY BINARY_INTEGER;
    nome_do_topico_table topico_type;
    i BINARY_INTEGER;

BEGIN
    i := 0;
    FOR topicos IN (SELECT nome_do_topico FROM Topico) LOOP
        nome_do_topico_table(i) := topicos.nome_do_topico;
        DBMS_OUTPUT.PUT_LINE(nome_do_topico_table(i));
        i := i + 1;
    END LOOP;
END;


-- BLOCO ANÔNIMO -------------------------
-- Atualizando o número de postagens de um usuário
DECLARE
   v_email_usuario Usuario.email_usuario%TYPE := 'valeria@cin.ufpe.br';
   v_numero_postagens Usuario.numero_postagens%TYPE := 10;
BEGIN
   UPDATE Usuario
   SET numero_postagens = v_numero_postagens
   WHERE email_usuario = v_email_usuario;
   DBMS_OUTPUT.PUT_LINE('O número de postagens do usuário foi atualizado com sucesso!');
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nenhum usuário encontrado com o e-mail informado.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Ocorreu um erro ao atualizar o número de postagens do usuário: ' || SQLERRM);
END;


-- CREATE PROCEDURE -------------------------
-- atualizar a data de uma publicação

CREATE OR REPLACE PROCEDURE atualizar_data_publicacao (p_id IN NUMBER, p_data IN DATE)
AS
BEGIN
  UPDATE Postagem SET data_publicacao = p_data WHERE id = p_id;
  COMMIT;
END;
/

EXEC atualizar_data_publicacao(1, to_date('01/01/2023', 'dd/mm/yy'));


-- CREATE FUNCTION -------------------------
-- retorna o numero de postagens para cada email
CREATE OR REPLACE FUNCTION get_post_count (p_usuario_associado IN VARCHAR2)
RETURN NUMBER
IS
  v_post_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_post_count FROM Postagem WHERE usuario_associado = p_usuario_associado;
  RETURN v_post_count;
END;
/
SELECT email_usuario, get_post_count(email_usuario) AS num_posts FROM Usuario;


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
--verificar se a data fornecida corresponde a alguma das datas de publicação
DECLARE
  data_procurada DATE := to_date('12/08/2022', 'dd/mm/yy');
BEGIN
  FOR postagem IN (SELECT * FROM Postagem) LOOP
    IF postagem.data_publicacao = data_procurada THEN
      DBMS_OUTPUT.PUT_LINE('Postagem encontrada: ' || postagem.titulo_da_postagem);
    ELSIF postagem.data_publicacao < data_procurada THEN
      DBMS_OUTPUT.PUT_LINE('Postagem anterior: ' || postagem.titulo_da_postagem);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Postagem posterior: ' || postagem.titulo_da_postagem);
    END IF;
  END LOOP;
END;


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



-- LOOP EXIT WHEN  e EXCEPTION WHEN ------------------------- [OK]
-- Lista o nome dos usuários e quais as postagens que eles fizeram

DECLARE
  v_nome perfil.nome%TYPE;
  v_titulo_postagem postagem.titulo_da_postagem%TYPE;

CURSOR cursor_postagem IS
  SELECT pf.nome, pt.titulo_da_postagem
  FROM perfil pf, postagem pt
  WHERE pf.email = pt.usuario_associado;

BEGIN
  OPEN cursor_postagem;
  LOOP
    FETCH cursor_postagem into v_nome, v_titulo_postagem;
    EXIT WHEN cursor_postagem%NOTFOUND;
    dbms_output.put_line('O usuário '|| TO_CHAR(v_nome)|| ' fez a postagem ' ||TO_CHAR(v_titulo_postagem));
  END LOOP;
  CLOSE cursor_postagem;
  EXCEPTION
  WHEN INVALID_CURSOR THEN
    DBMS_OUTPUT.put_line('Erro!');
END;


-- WHILE LOOP ------------------------- [OK]
-- Mostra quantos usuários cada moderador já baniu, e incrementa o valor total de contas banidas a cada iteração do while loop.
DECLARE
   total INTEGER := 0;
   email moderador.email_moderador%TYPE;
   banidas moderador.num_contas_banidas%TYPE;
BEGIN
  SELECT email_moderador, num_contas_banidas INTO email, banidas FROM moderador 
  ORDER BY email_moderador
  FETCH FIRST 1 ROWS ONLY;
   
  WHILE email IS NOT NULL LOOP
    dbms_output.put_line('Usuário [' || email || '] baniu ' || banidas ||' contas');
    total := total + banidas;
    
    BEGIN
        SELECT email_moderador, num_contas_banidas INTO email, banidas FROM moderador WHERE email_moderador > email ORDER BY email_moderador FETCH FIRST 1 ROWS ONLY;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          email := NULL;
          banidas := NULL;
    END;
   END LOOP;
   
   dbms_output.put_line('Número total de contas banidas: ' || total);
END;



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
-- selecionar o título da postagem com ID igual a 2 na tabela "Postagem" e exibindo esse valor

DECLARE
v_titulo_da_postagem Postagem.titulo_da_postagem%TYPE;
BEGIN
SELECT titulo_da_postagem
INTO v_titulo_da_postagem
FROM Postagem
WHERE id = 2;

DBMS_OUTPUT.PUT_LINE('O título da postagem com ID 2 é: ' || v_titulo_da_postagem);
END;
/

-- CURSOR (OPEN, FETCH e CLOSE) -------------------------
-- uma lista das postagens da tabela "Postagem", ordenadas por data de publicação em ordem decrescente, exibindo o ID, título e data de cada postagem
DECLARE
  CURSOR cur_postagens IS
    SELECT id, titulo_da_postagem, data_publicacao
    FROM Postagem
    ORDER BY data_publicacao DESC;
    
  v_id Postagem.id%TYPE;
  v_titulo Postagem.titulo_da_postagem%TYPE;
  v_data Postagem.data_publicacao%TYPE;
BEGIN
  OPEN cur_postagens;
  LOOP
    FETCH cur_postagens INTO v_id, v_titulo, v_data;
    EXIT WHEN cur_postagens%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' - Título: ' || v_titulo || ' - Data: ' || v_data);
  END LOOP;
  CLOSE cur_postagens;
END;
/

-- USO DE PARÂMETROS (IN, OUT ou IN OUT) -------------------------
-- Cria um procedimento para adicionar um perfil novo.
CREATE OR REPLACE PROCEDURE adicionar_perfil (
   p_email IN Perfil.email%TYPE,
   p_nome IN Perfil.nome%TYPE,
   P_sobrenome IN Perfil.sobrenome%TYPE,
   p_data_nascimento IN Perfil.data_nascimento%TYPE,
   p_data_cadastro IN Perfil.data_cadastro%TYPE
)
IS
BEGIN
   INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES (p_email, p_nome, p_sobrenome, p_data_nascimento, p_data_cadastro);
   COMMIT;
END adicionar_perfil;
/
-- CREATE OR REPLACE PACKAGE -------------------------
--  O package vai ser um admin responsável por chamar os métodos para excluir comentários das postagens ou excluir respostas dos comentários. Quando um comentário é excluído na tabela 'comentario', também tem que ser excluído nas tabelas de 'associa2' e 'resposta'.
CREATE OR REPLACE PACKAGE Admin AS
procedure excluir_comentario(
  p_id IN comentario.id%TYPE 
);

procedure excluir_resposta(
  p_id_resposta in resposta.id_resposta%TYPE,
  p_id_comentario in resposta.id_comentario%TYPE
);
END Admin;
/

-- CREATE OR REPLACE PACKAGE BODY -------------------------
CREATE OR REPLACE PACKAGE BODY Admin AS
  PROCEDURE excluir_comentario(
    p_id IN comentario.id%TYPE 
  ) IS
  BEGIN
    DELETE FROM resposta
    WHERE id_comentario = p_id;

    DELETE FROM Associa1
    WHERE comentario = p_id;

    DELETE FROM comentario
    WHERE id = p_id;
  END excluir_comentario;

  PROCEDURE excluir_resposta(
  p_id_resposta in resposta.id_resposta%TYPE,
  p_id_comentario in resposta.id_comentario%TYPE
) IS
  BEGIN
    DELETE FROM resposta
    WHERE id_comentario = p_id_comentario AND id_resposta = p_id_resposta;
  END excluir_resposta;
END Admin;
/

-- CREATE OR REPLACE TRIGGER (COMANDO) -------------------------

-- Trigger acionado após a inserção de uma nova postagem
CREATE OR REPLACE TRIGGER nova_postagem
AFTER INSERT ON Postagem
  BEGIN
    dbms_output.put_line('Postagem inserida com sucesso!');
  END;

  /*  Exemplo para teste:
      INSERT INTO Postagem(id, usuario_associado, titulo_da_postagem, data_publicacao) VALUES (DEFAULT,'silvio@cin.ufpe.br', 'abram boldrini na pagina 200', to_date('12/08/2022', 'dd/mm/yy'));
  */

-- CREATE OR REPLACE TRIGGER (LINHA) -------------------------

-- Trigger acionado após quaisquer atualizações em postagens
CREATE OR REPLACE TRIGGER atualizacao_postagem
AFTER UPDATE ON Postagem
FOR EACH ROW
  BEGIN
    dbms_output.put_line('Postagem atualizada com sucesso!');
  END;

  /*  Exemplo para teste:
      UPDATE Postagem
      SET titulo_da_postagem = 'uma análise crítica do livro de boldrini, volume 2'
      WHERE id = '1';
  */
