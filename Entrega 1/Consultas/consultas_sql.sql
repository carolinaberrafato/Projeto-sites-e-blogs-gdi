-- ALTER TABLE ------------------------- [OK]

-- Modificando o tamanho máximo da coluna num_telefone para que suporte o código de país no número (sem o "+")
ALTER TABLE Telefone
MODIFY COLUMN num_telefone VARCHAR2(14);

-- CREATE INDEX -------------------------



-- INSERT INTO -------------------------



-- UPDATE ------------------------- [OK]
-- Atualiza a mensagem de um comentário já existente.
UPDATE comentario
SET mensagem = 'Achei muito bom'
WHERE id = '2';

-- DELETE -------------------------



-- SELECT-FROM-WHERE -------------------------



-- BETWEEN ------------------------- [OK]
-- Seleciona o título da postagem e a data de publicação das postagens feitas em 2022 e 2023
SELECT titulo_da_postagem, data_publicacao FROM Postagem
WHERE data_publicacao BETWEEN '01-JAN-22' AND '31-DEC-23';


-- IN -------------------------



-- LIKE -------------------------



-- IS NULL ou IS NOT NULL ------------------------- [OK]

-- Seleciona o email do usuário associado ao tópico "Ciência e Tecnologia" cuja data_final é nula (o que significa que o usuário ainda acompanha o tópico)
SELECT A.usuario_associado
FROM Acompanha A
WHERE A.topico_associado = 'Ciência e Tecnologia'
AND A.data_final IS NULL;

-- INNER JOIN ------------------------- [OK]
-- Seleciona os usuários que possuem alguma postagem publicada, bem como o título da postagem
SELECT pf.nome, pt.titulo_da_postagem FROM Usuario_Postagem up
INNER JOIN Perfil pf ON pf.email = up.usuario
INNER JOIN Postagem pt ON pt.usuario_associado = pf.email;

-- MAX ------------------------- [OK]

-- Seleciona o número máximo de contas banidas por cada moderador, bem como seus emails
SELECT email_moderador, MAX(num_contas_banidas)
FROM Moderador
GROUP BY email_moderador;

-- MIN ------------------------- [OK]

-- Seleciona o número mínimo de postagens feitas por um usuário na tabela Usuario
SELECT MIN(numero_postagens)
FROM Usuario;

-- AVG -------------------------



-- COUNT ------------------------- [OK]
-- Seleciona o nome do tópico e conta quantas postagens tem em cada tópico
SELECT t.nome_do_topico, COUNT(*) FROM Topico t
RIGHT OUTER JOIN associa2 a ON t.nome_do_topico = a.topico
RIGHT OUTER JOIN postagem p ON a.postagem = p.id
GROUP BY t.nome_do_topico;


-- LEFT ou RIGHT ou FULL OUTER JOIN -------------------------



-- SUBCONSULTA COM OPERADOR RELACIONAL -------------------------



-- SUBCONSULTA COM IN -------------------------



-- SUBCONSULTA COM ANY -------------------------



-- SUBCONSULTA COM ALL -------------------------



-- ORDER BY ------------------------- [OK]

-- Seleciona nome, sobrenome, email, e data de assinatura dos perfis associados a usuários em ordem alfabética
SELECT P.nome, P.sobrenome, P.email, U.data_assinatura
FROM Perfil P, Usuario U
WHERE P.email = U.email_usuario
ORDER BY P.nome, P.sobrenome;

-- GROUP BY ------------------------- [OK]

-- Seleciona a quantidade de seguidores de todos os usuários que possuem ao menos um seguidor cadastrado
SELECT seguido, COUNT(seguidor) AS seguidores
FROM Segue
GROUP BY seguido;

-- HAVING -------------------------



-- UNION ou INTERSECT ou MINUS -------------------------



-- CREATE VIEW -------------------------



-- GRANT / REVOKE -------------------------

