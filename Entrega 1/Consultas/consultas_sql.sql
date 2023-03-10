-- ALTER TABLE ------------------------- [OK]

-- Modificando o tamanho máximo da coluna num_telefone para que suporte o código de país no número (sem o "+")
ALTER TABLE Telefone
MODIFY num_telefone VARCHAR2(14);

-- CREATE INDEX -------------------------
-- criar um índice na coluna "seguidor" da tabela "Segue" para acelerar a busca de todos os seguidores de um usuário específico
CREATE INDEX idx_seguidor ON Segue (seguidor);
SELECT seguidor
FROM Segue
WHERE seguido = 'nivan@cin.ufpe.br'
ORDER BY seguidor;



-- INSERT INTO -------------------------
-- Para a criação da conta de Gustavo no banco de dados, insere nas tabelas Perfil e Usuario
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('gustavo@cin.ufpe.br', 'Gusstavo', 'Carvalho', to_date('23/11/1984', 'dd/mm/yy'), to_date('10/09/2006', 'dd/mm/yy'));
INSERT INTO Usuario(email_usuario, data_assinatura, numero_postagens) VALUES ('gustavo@cin.ufpe.br', to_date('10/09/2006', 'dd/mm/yy'), 93);


-- UPDATE ------------------------- [OK]
-- Atualiza a mensagem de um comentário já existente.
UPDATE comentario
SET mensagem = 'Achei muito bom'
WHERE id = '2';

-- DELETE -------------------------
--Deleta a informação de que o usuário com email valeria@cin.ufpe.br acompanha o tópico Economia da tabela Acompanha
DELETE FROM Acompanha WHERE usuario_associado = 'valeria@cin.ufpe.br' AND  topico_associado = 'Economia';


-- SELECT-FROM-WHERE -------------------------
-- encontrar o email do usuário que possui o maior número de postagens e o título da sua última postagem

SELECT u.email_usuario, p.titulo_da_postagem
FROM Usuario u
JOIN Postagem p ON u.email_usuario = p.usuario_associado
WHERE u.numero_postagens = (SELECT MAX(numero_postagens) FROM Usuario)
ORDER BY p.data_publicacao DESC
FETCH FIRST 1 ROW ONLY;


-- BETWEEN ------------------------- [OK]
-- Seleciona o título da postagem e a data de publicação das postagens feitas em 2022 e 2023
SELECT titulo_da_postagem, data_publicacao FROM Postagem
WHERE data_publicacao BETWEEN '01-JAN-22' AND '31-DEC-23';


-- IN -------------------------
-- Seleciona o email e o nome dos usuários cujos nomes são Silvio, Nivan ou João
SELECT email, nome FROM Perfil
WHERE nome IN ('Silvio', 'Nivan', 'Joao');


-- LIKE -------------------------
-- Seleciona o email e o nome dos usuários cujos nomes possuem a letra "a" no meio do nome
SELECT email, nome FROM Perfil
WHERE nome LIKE '%a%';


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
-- calcular a média de postagens dos usuários que são seguidos por outros usuários
SELECT AVG(u.numero_postagens)
FROM Usuario u
JOIN Segue s ON u.email_usuario = s.seguido
WHERE u.numero_postagens IS NOT NULL;


-- COUNT ------------------------- [OK]
-- Seleciona o título do tópico e conta quantas postagens tem em cada tópico
SELECT t.nome_do_topico, COUNT(*) FROM Topico t
RIGHT OUTER JOIN associa2 a ON t.nome_do_topico = a.topico
RIGHT OUTER JOIN postagem p ON a.postagem = p.id
GROUP BY t.nome_do_topico;


-- LEFT ou RIGHT ou FULL OUTER JOIN -------------------------
-- Seleciona os moderadores que estão associado a cada postagem e mostra também os perfis que não moderam nenhuma postagem
SELECT pf.nome AS moderador, pt.titulo_da_postagem FROM Usuario_Postagem up
FULL OUTER JOIN Perfil pf on up.moderador = pf.email
FULL OUTER JOIN Postagem pt ON up.postagem = pt.id;


-- SUBCONSULTA COM OPERADOR RELACIONAL -------------------------
-- Seleciona os usuários que têm data de assinatura anterior à data de assinatura do usuário Silvio
SELECT * FROM Usuario
WHERE data_assinatura < 
  (SELECT data_assinatura 
  FROM Usuario 
  WHERE email_usuario = 'silvio@cin.ufpe.br');


-- SUBCONSULTA COM IN -------------------------
-- Seleciona os usuários que são seguidos por Silvio
SELECT * FROM Usuario
WHERE email_usuario IN 
  (SELECT seguido 
  FROM Segue 
  WHERE seguidor = 'silvio@cin.ufpe.br');


-- SUBCONSULTA COM ANY -------------------------
-- Selecionando id e mensagem dos comentários que tiveram mais curtidas do que os comentários feitos depois de 03/03/2023

SELECT id, mensagem
FROM Comentario
WHERE num_curtidas > ANY (
  SELECT num_curtidas
  FROM Comentario
  WHERE data_publicacao > TO_DATE('03-03-2023', 'DD-MM-YYYY')
);

-- SUBCONSULTA COM ALL -------------------------
-- Retorna o email do usuário que fez mais postagens 
SELECT email_usuario
FROM Usuario
WHERE numero_postagens >= ALL (SELECT numero_postagens FROM Usuario)


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
-- Seleciona a quantidade de seguidores de todos os usuários que têm ao menos dois seguidores cadastrados
SELECT seguido, COUNT(seguidor) AS seguidores
FROM Segue
GROUP BY seguido
HAVING COUNT(seguidor) > 2;


-- UNION ou INTERSECT ou MINUS -------------------------
-- Seleciona a data de publicação e a mensagem de todos os comentários e respostas
SELECT data_publicacao, mensagem 
FROM Comentario 
UNION
SELECT data_publicacao, mensagem
FROM Resposta;


-- CREATE VIEW -------------------------
-- Cria uma view na qual consta os usuários que acompanham o tópico Ciência e Tecnologia
CREATE VIEW Ciência_e_Tecnologia AS
SELECT usuario_associado, topico_associado
FROM Acompanha
WHERE topico_associado = 'Ciência e Tecnologia';


-- GRANT / REVOKE -------------------------
   --GRANT: Garantido todos os previlégios (select, insert, delete, update e todos os privilégios) para todos
   --REVOKE: Retirando os previlégios de DELETE, INSERT E UPDATE para todos */
GRANT ALL PRIVILEGES ON Perfil TO PUBLIC;
REVOKE DELETE, INSERT, UPDATE FROM PUBLIC;
