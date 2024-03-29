-- CONSULTAS REQUISITADAS ------------------------------

-- CONSULTA A NESTED TABLE + Consulta à tabela tb_usuario
--listar usuários que estão interessados no tópico de Ciência e queremos saber os nomes e sobrenomes desses usuários
SELECT u.nome, u.sobrenome
FROM tb_topico t, TABLE(t.acompanha) a, tb_usuario u
WHERE t.nome_do_topico = 'Ciência'
/

-- SELECT DEREF + Consulta à tabela tb_postagem 
--listar pessoas, suas postagens e os comentários feitos nessas postagens, e organizando tudo em ordem alfabética pelo nome do usuário e título da postagem
SELECT u.nome, p.titulo_da_postagem, DEREF(pc.comentario).mensagem AS mensagem
FROM tb_usuario u, tb_usuario_postagem up, tb_postagem p, tb_postagem_comentario pc
WHERE u.email = up.usuario.email AND up.postagem.id = p.id AND p.id = pc.postagem.id
ORDER BY u.nome, p.titulo_da_postagem
/

-- CONSULTA A VARRAY + Consulta à tabela tb_usuario
--listar usuários com seus nomes, sobrenomes e números de telefone organizados por nome e sobrenome
SELECT u.nome, u.sobrenome, t.numero
FROM tb_usuario u
JOIN TABLE(u.telefones) t ON 1=1
ORDER BY u.nome, u.sobrenome;
/

-- TESTES DOS MÉTODOS (FUNCTIONS E PROCEDURES) -----------------------

-- FINAL MAP MEMBER FUNCTION
-- Extrai o DDD dos números de telefone (2 primeiros dígitos) associados ao email 'mariaf@example.com'
SELECT u.nome, u.email, t.numero, t.get_ddd() AS DDD
FROM tb_usuario u, TABLE(u.telefones) t
WHERE u.email = 'mariaf@example.com';
/

-- OVERRIDING MEMBER PROCEDURE
-- Cria uma variável do tipo tp_usuario e mostra as informações
DECLARE
  u tp_usuario := tp_usuario(
    TO_CHAR('joaof@example.com'),
    TO_CHAR('João'), 
    TO_CHAR('Fulanoton'), 
    TO_DATE('2000-01-01', 'YYYY-MM-DD'), 
    TO_DATE('2022-01-01', 'YYYY-MM-DD'), 
    varray_tp_telefone(tp_telefone('12345678901')),
    TO_NUMBER(10), 
    TO_DATE('2022-01-01', 'YYYY-MM-DD')
  );
BEGIN
  u.mostrar_info;
END;
/

-- OVERRIDING MEMBER PROCEDURE/CONSTRUCTOR FUNCTION
-- Busca na tabela tb_usuario um usuario através de email, e mostra as informações
DECLARE
	us tp_usuario;
BEGIN
	SELECT VALUE(u) INTO us FROM tb_usuario u
	WHERE u.email = 'filipec@example.com';

	us.mostrar_info();
END;
/

-- ORDER MEMBER FUNCTION
-- Cria 2 objetos tp_acompanha e usa a função compara_tempo_acompanhamento para mostrar qual tem o maior tempo de acompanhamento
DECLARE
  ac1 tp_acompanha;
  ref1 REF tp_usuario;
  ac2 tp_acompanha;
  ref2 REF tp_usuario;
  tempo NUMBER;
BEGIN
  SELECT REF(US) INTO ref1 FROM tb_usuario US WHERE email = 'filipec@example.com';
  SELECT REF(US) INTO ref2 FROM tb_usuario US WHERE email = 'thiagom@example.com';
  ac1:= tp_acompanha(
    ref1,
    TO_DATE('2022-01-01', 'YYYY-MM-DD'),
    TO_DATE('2022-01-12', 'YYYY-MM-DD')
  );
  ac2:= tp_acompanha(
    ref2,
    TO_DATE('2022-01-01', 'YYYY-MM-DD'),
    TO_DATE('2022-01-20', 'YYYY-MM-DD')
  );
  tempo := ac1.compara_tempo_acompanhamento(ac2);
  DBMS_OUTPUT.PUT_LINE(tempo || ' dias');
END;
/

-- ORDER MEMBER FUNCTION
-- Seleciona os acompanhamentos de 'Maria' no tópico 'Humor', e 'Gabriel' no tópico 'Esportes' e compara usando 'compara_tempo_acompanhamento'
DECLARE
  ac1 tp_acompanha;
  ac2 tp_acompanha;
  tempo NUMBER;
BEGIN
  SELECT VALUE(a) INTO ac1 FROM tb_topico t, TABLE(t.acompanha) a WHERE a.usuario_associado.email = 'mariaf@example.com' AND t.nome_do_topico = 'Humor';
  SELECT VALUE(a) INTO ac2 FROM tb_topico t, TABLE(t.acompanha) a WHERE a.usuario_associado.email = 'gabrielb@example.com' AND t.nome_do_topico = 'Esportes';
  tempo := ac1.compara_tempo_acompanhamento(ac2);
  DBMS_OUTPUT.PUT_LINE(tempo || ' dias');
END;
/

-- MEMBER FUNCTION
-- Adiciona dois números de telefone e usa a MEMBER FUNCTION listar_numeros para printar os numeros adicionados
DECLARE
    telefones tp_varray_tp_telefone := tp_varray_tp_telefone(varray_tp_telefone(tp_telefone('8654987254'), tp_telefone('8265981239')));
BEGIN
    DBMS_OUTPUT.PUT_LINE('Telefones: ' || telefones.listar_numeros(telefones));
END;
/

-- TESTES DAS TABELAS (CONSULTAS BÁSICAS) ----------------------------

-- Consulta à tabela tb_resposta e tb_comentario
-- Resposta/Comentário
SELECT C.id AS id_comentario, C.mensagem AS comentario, R.id_resposta, R.data_publicacao, R.mensagem AS resposta
FROM tb_resposta R, tb_comentario C
WHERE C.id = '1' AND R.id_comentario = REF(C);
/

-- Consulta à tabela tb_topico
-- Lista os usuários e postagens feitas pelos usuários que acompanham os tópicos 'Noticias' e 'Humor'
SELECT t.nome_do_topico AS topico, a.usuario_associado.nome AS nome, p.titulo_da_postagem
FROM tb_topico t, TABLE(t.acompanha) a
JOIN tb_usuario u ON a.usuario_associado.email = u.email
JOIN tb_usuario_postagem up ON REF(u) = up.usuario
JOIN tb_postagem p ON up.postagem = ref(p)
WHERE t.nome_do_topico = 'Noticias' OR t.nome_do_topico = 'Humor'
/

-- Consulta à tabela tb_usuario_postagem
-- Mostra todas as postagens associadas a usuarios, com os títulos das postagens e email dos usuários
SELECT up.id_associado, DEREF(up.usuario).email AS email, DEREF(up.postagem).titulo_da_postagem AS titulo_da_postagem
FROM tb_usuario_postagem up;
/

-- Consulta à tabela tb_topico_postagem
-- Mostra todos os tópicos associados a postagens e os títulos das postagens associadas a esses tópicos
SELECT t.id_associado, DEREF(t.topico).nome_do_topico AS nome_do_topico, DEREF(t.postagem).titulo_da_postagem AS titulo_da_postagem
FROM tb_topico_postagem t;
/

-- Consulta à tabela tb_postagem_comentario
--Mostra todos os títulos de todas as postagens associadas a comentários e a mensagem desses comentários
SELECT pc.id_associado, DEREF(pc.postagem).titulo_da_postagem AS titulo_da_postagem, DEREF(pc.comentario).mensagem AS mensagem
FROM tb_postagem_comentario pc;
/

-- Consulta à tabela tb_topico
-- Mostra os usuários que fizeram postagem em tópicos que eles acompanham, bem como o nome do tópico e o título da postagem
SELECT a.usuario_associado.nome AS Nome, DEREF(tp.topico).nome_do_topico AS Topico, DEREF(tp.postagem).titulo_da_postagem AS Titulo_Postagem
    FROM tb_topico t, TABLE(t.acompanha) a
    JOIN tb_usuario_postagem up ON DEREF(up.usuario).email = a.usuario_associado.email
    JOIN tb_topico_postagem tp ON DEREF(tp.postagem).titulo_da_postagem = DEREF(up.postagem).titulo_da_postagem
    WHERE t.nome_do_topico = DEREF(tp.topico).nome_do_topico;
/

-- Consulta à tabela tb_seguidor
-- Busca na tabela tb_seguidor todos os seguidores de um usuário através de seu email e mostra seu nome, sobrenome, email e número de telefone
SELECT DEREF(s.seguidor).nome AS Nome, DEREF(s.seguidor).sobrenome AS Sobrenome, DEREF(s.seguidor).email AS Email, t.numero AS Telefone
FROM tb_seguidor s
JOIN TABLE(DEREF(s.seguidor).telefones) t ON 1=1
WHERE DEREF(s.seguido).email = 'thiagom@example.com';
/

-- Conulta à tabela tb_moderador
-- Consultar telefones de moderadores
SELECT M.email, T.*
FROM tb_moderador M, TABLE(M.telefones) T
/

-- Consulta à tabela tb_comentario
-- Consulta ao conteúdo da mensagem e número de curtidas dos comentários postados nos dias 04/04/2023 e 03/04/2023
SELECT c.mensagem, c.num_curtidas
FROM tb_comentario c
WHERE c.data_publicacao = TO_DATE('2023-04-04', 'YYYY-MM-DD')
OR c.data_publicacao = TO_DATE('2023-04-03', 'YYYY-MM-DD')
/
