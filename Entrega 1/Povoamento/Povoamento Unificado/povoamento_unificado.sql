-- Perfil:

INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('nivan@cin.ufpe.br', 'Nivan', 'Ferreira', to_date('02/10/1987', 'dd/mm/yy'), to_date('12/12/2012', 'dd/mm/yy'));
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('silvio@cin.ufpe.br', 'Silvio', 'Melo', to_date('04/10/1965', 'dd/mm/yy'), to_date('03/04/2016', 'dd/mm/yy'));
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('valeria@cin.ufpe.br', 'Valéria', 'Times', to_date('06/05/1976', 'dd/mm/yy'), to_date('31/12/2020', 'dd/mm/yy'));
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('alex@cin.ufpe.br', 'Alex', 'Sandro', to_date('16/06/1981', 'dd/mm/yy'), to_date('29/02/2008', 'dd/mm/yy'));
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('adriano@cin.ufpe.br', 'Adriano', 'Lorena', to_date('07/08/1961', 'dd/mm/yy'), to_date('25/11/2015', 'dd/mm/yy'));
INSERT INTO Perfil(email, nome, sobrenome, data_nascimento, data_cadastro) VALUES ('ruy@cin.ufpe.br', 'Ruy', 'Queiroz', to_date('30/06/1960', 'dd/mm/yy'), to_date('19/10/2004', 'dd/mm/yy'));


-- Usuario:

INSERT INTO Usuario(email_usuario, data_assinatura, numero_postagens) VALUES ('nivan@cin.ufpe.br', to_date('15/01/2014', 'dd/mm/yy'), 52);
INSERT INTO Usuario(email_usuario, data_assinatura, numero_postagens) VALUES ('silvio@cin.ufpe.br', to_date('27/03/2017', 'dd/mm/yy'), 14);
INSERT INTO Usuario(email_usuario, data_assinatura, numero_postagens) VALUES ('valeria@cin.ufpe.br', to_date('11/07/2022', 'dd/mm/yy'), 4);
INSERT INTO Usuario(email_usuario, data_assinatura, numero_postagens) VALUES ('ruy@cin.ufpe.br', to_date('14/10/2006', 'dd/mm/yy'), 86);


-- Moderador:

INSERT INTO Moderador(email_moderador , num_contas_banidas) VALUES ('nivan@cin.ufpe.br', 999999);
INSERT INTO Moderador(email_moderador , num_contas_banidas) VALUES ('alex@cin.ufpe.br', 2);
INSERT INTO Moderador(email_moderador , num_contas_banidas) VALUES ('valeria@cin.ufpe.br', 0);


-- Postagem:

INSERT INTO Postagem(id, usuario_associado, titulo_da_postagem, data_publicacao) VALUES (DEFAULT,'silvio@cin.ufpe.br', 'Processamento Gráfico é massa!', to_date('12/08/2022', 'dd/mm/yy'));
INSERT INTO Postagem(id, usuario_associado, titulo_da_postagem, data_publicacao) VALUES (DEFAULT,'valeria@cin.ufpe.br', 'Colocando um esquema relacional na quarta forma normal', to_date('02/03/2023', 'dd/mm/yy'));
INSERT INTO Postagem(id, usuario_associado, titulo_da_postagem, data_publicacao) VALUES (DEFAULT,'ruy@cin.ufpe.br', 'Como Alan Turing revolucionou a computação', to_date('05/07/1940', 'dd/mm/yy'));


-- Topico:

INSERT INTO Topico(nome_do_topico) VALUES ('Esportes');
INSERT INTO Topico(nome_do_topico) VALUES ('Moda');
INSERT INTO Topico(nome_do_topico) VALUES ('Beleza e Maquiagem');
INSERT INTO Topico(nome_do_topico) VALUES ('Carros');
INSERT INTO Topico(nome_do_topico) VALUES ('Política');
INSERT INTO Topico(nome_do_topico) VALUES ('Economia');
INSERT INTO Topico(nome_do_topico) VALUES ('Ciência e Tecnologia');


-- Comentario:

INSERT INTO Comentario (id, data_publicacao, mensagem, num_curtidas) VALUES ('1', TO_DATE('02-03-2023', 'DD-MM-YYYY'), 'Ótimo artigo! Muito informativo.', 10);
INSERT INTO Comentario (id, data_publicacao, mensagem, num_curtidas) VALUES ('2', TO_DATE('03-03-2023', 'DD-MM-YYYY'), 'muito bom', 17);
INSERT INTO Comentario (id, data_publicacao, mensagem, num_curtidas) VALUES ('3', TO_DATE('04-05-2023', 'DD-MM-YYYY'), 'Voltarei para apreciar novas postagens', 19);
INSERT INTO Comentario (id, data_publicacao, mensagem, num_curtidas) VALUES ('4', TO_DATE('05-06-2023', 'DD-MM-YYYY'), 'otimo escritor', 30);
INSERT INTO Comentario (id, data_publicacao, mensagem, num_curtidas) VALUES ('5', TO_DATE('06-07-2023', 'DD-MM-YYYY'), 'Amei!', 50);


-- Resposta:

INSERT INTO Resposta (id_comentario, id_resposta, data_publicacao, mensagem) VALUES ('1', '1', TO_DATE('11-04-2023', 'DD-MM-YYYY'), 'Obrigado pelo feedback! Ficamos felizes em ajudar.');
INSERT INTO Resposta (id_comentario, id_resposta, data_publicacao, mensagem) VALUES ('2', '2', TO_DATE('14-07-2023', 'DD-MM-YYYY'), 'Tambem adorei o artigo');
INSERT INTO Resposta (id_comentario, id_resposta, data_publicacao, mensagem) VALUES ('3', '3', TO_DATE('11-06-2023', 'DD-MM-YYYY'), 'ficamos felizes');
INSERT INTO Resposta (id_comentario, id_resposta, data_publicacao, mensagem) VALUES ('4', '4', TO_DATE('06-07-2023', 'DD-MM-YYYY'), 'melhorou meu dia');
INSERT INTO Resposta (id_comentario, id_resposta, data_publicacao, mensagem) VALUES ('5', '5', TO_DATE('08-07-2023', 'DD-MM-YYYY'), 'Seu comentario é muito importante para nós');


-- Usuario_Postagem:

INSERT INTO Usuario_Postagem(usuario, postagem, moderador) VALUES ('silvio@cin.ufpe.br', 1, 'nivan@cin.ufpe.br');
INSERT INTO Usuario_Postagem(usuario, postagem, moderador) VALUES ('valeria@cin.ufpe.br', 2, 'alex@cin.ufpe.br');
INSERT INTO Usuario_Postagem(usuario, postagem, moderador) VALUES ('ruy@cin.ufpe.br', 3, 'valeria@cin.ufpe.br');


-- Acompanha:

INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Economia', 'valeria@cin.ufpe.br', to_date('05/08/2022', 'dd/mm/yy'), NULL);
INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Moda', 'valeria@cin.ufpe.br', to_date('12/03/2021', 'dd/mm/yy'), NULL);
INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Esportes', 'nivan@cin.ufpe.br', to_date('02/09/2014', 'dd/mm/yy'), to_date('03/09/2014', 'dd/mm/yy'));
INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Ciência e Tecnologia', 'silvio@cin.ufpe.br', to_date('06/01/2018', 'dd/mm/yy'), NULL);
INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Ciência e Tecnologia', 'ruy@cin.ufpe.br', to_date('06/01/2009', 'dd/mm/yy'), NULL);
INSERT INTO Acompanha(topico_associado, usuario_associado, data_inicial, data_final) VALUES ('Política', 'ruy@cin.ufpe.br', to_date('06/01/2009', 'dd/mm/yy'), to_date('07/10/2010', 'dd/mm/yy'));


-- Segue:

INSERT INTO Segue(seguidor, seguido) VALUES ('nivan@cin.ufpe.br', 'silvio@cin.ufpe.br');
INSERT INTO Segue(seguidor, seguido) VALUES ('silvio@cin.ufpe.br','nivan@cin.ufpe.br');
INSERT INTO Segue(seguidor, seguido) VALUES ('silvio@cin.ufpe.br','ruy@cin.ufpe.br');
INSERT INTO Segue(seguidor, seguido) VALUES ('ruy@cin.ufpe.br','silvio@cin.ufpe.br');
INSERT INTO Segue(seguidor, seguido) VALUES ('valeria@cin.ufpe.br','silvio@cin.ufpe.br');


-- Associa1:

INSERT INTO Associa1(postagem, comentario) VALUES (1, '1');
INSERT INTO Associa1(postagem, comentario) VALUES (2, '2');
INSERT INTO Associa1(postagem, comentario) VALUES (3, '3');


-- Associa2:

INSERT INTO Associa2 (postagem, topico) VALUES (1, 'Ciência e Tecnologia');
INSERT INTO Associa2 (postagem, topico) VALUES (2, 'Ciência e Tecnologia');
INSERT INTO Associa2 (postagem, topico) VALUES (3, 'Ciência e Tecnologia');


-- Telefone:

INSERT INTO Telefone (email_perfil, num_telefone) VALUES ('nivan@cin.ufpe.br', '81999990000');
INSERT INTO Telefone (email_perfil, num_telefone) VALUES ('silvio@cin.ufpe.br', '81988880000');
INSERT INTO Telefone (email_perfil, num_telefone) VALUES ('valeria@cin.ufpe.br', '81977770000');
INSERT INTO Telefone (email_perfil, num_telefone) VALUES ('alex@cin.ufpe.br', '81966660000');
INSERT INTO Telefone (email_perfil, num_telefone) VALUES ('adriano@cin.ufpe.br', '81955550000');