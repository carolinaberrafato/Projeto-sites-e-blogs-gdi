-- NESTED TABLE

--listar usuários que estão interessados no tópico de Ciência e queremos saber os nomes e sobrenomes desses usuários
SELECT u.nome, u.sobrenome
FROM tb_topico t, TABLE(t.acompanha) a, tb_usuario u
WHERE t.nome_do_topico = 'Ciência'
/

-- DEREF

--listar pessoas, suas postagens e os comentários feitos nessas postagens, e organizando tudo em ordem alfabética pelo nome do usuário e título da postagem
SELECT u.nome, p.titulo_da_postagem, DEREF(pc.comentario).mensagem
FROM tb_usuario u, tb_usuario_postagem up, tb_postagem p, tb_postagem_comentario pc
WHERE u.email = up.usuario.email AND up.postagem.id = p.id AND p.id = pc.postagem.id
ORDER BY u.nome, p.titulo_da_postagem
/

-- VARRAY

--listar usuários com seus nomes, sobrenomes e números de telefone organizados por nome e sobrenome
SELECT u.nome, u.sobrenome, t.numero
FROM tb_usuario u
JOIN TABLE(u.telefones) t ON 1=1
ORDER BY u.nome, u.sobrenome;
/

-- Lista os usuários e postagens feitas pelos usuários que acompanham os tópicos 'Noticias' e 'Humor'
SELECT t.nome_do_topico AS topico, a.usuario_associado.nome AS nome, p.titulo_da_postagem
FROM tb_topico t, TABLE(t.acompanha) a
JOIN tb_usuario u ON a.usuario_associado.email = u.email
JOIN tb_usuario_postagem up ON REF(u) = up.usuario
JOIN tb_postagem p ON up.postagem = ref(p)
WHERE t.nome_do_topico = 'Noticias' OR t.nome_do_topico = 'Humor'
/
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

-- Busca na tabela tb_usuario um usuario através de email, e mostra as informações
DECLARE
	us tp_usuario;
BEGIN
	SELECT VALUE(u) INTO us FROM tb_usuario u
	WHERE u.email = 'filipec@example.com';

	us.mostrar_info();
END;
/

-- Busca na tabela tb_seguidor todos os seguidores de um usuário através de seu email e mostra seu nome, sobrenome, email e número de telefone

SELECT DEREF(s.seguidor).nome AS Nome, DEREF(s.seguidor).sobrenome AS Sobrenome, DEREF(s.seguidor).email AS Email, t.numero AS Telefone
FROM tb_seguidor s
JOIN TABLE(DEREF(s.seguidor).telefones) t ON 1=1
WHERE DEREF(s.seguido).email = 'thiagom@example.com';
/
