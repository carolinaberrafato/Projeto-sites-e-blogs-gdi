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

-- TESTES DOS MÉTODOS (FUNCTIONS E PROCEDURES) -----------------------

-- FINAL MAP MEMBER FUNCTION
SELECT u.nome, u.email, t.numero, t.get_ddd() AS DDD
FROM tb_usuario u, TABLE(u.telefones) t
WHERE u.email = 'mariaf@example.com';
/

-- TESTES DAS TABELAS (CONSULTAS BÁSICAS) ----------------------------

-- Resposta/Comentário
SELECT C.id AS id_comentario, C.mensagem AS comentario, R.id_resposta, R.data_publicacao, R.mensagem AS resposta
FROM tb_resposta R, tb_comentario C
WHERE C.id = '1' AND R.id_comentario = REF(C);
/