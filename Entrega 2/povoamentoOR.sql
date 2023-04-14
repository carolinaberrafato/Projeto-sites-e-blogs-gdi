-- tabela usuario

INSERT INTO tb_usuario (email, num_postagens, data_assinatura, telefones, nome, sobrenome, data_nasc, data_cad)
VALUES ('joaof@example.com', 10, TO_DATE('2022-01-01', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('12345678901')), 'João', 'Fulanoton', TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'));

INSERT INTO tb_usuario (email, num_postagens, data_assinatura, telefones, nome, sobrenome, data_nasc, data_cad)
VALUES ('mariaf@example.com', 5, TO_DATE('2022-02-15', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('98765432101'), tp_telefone('45678912301')), 'Maria', 'McFulano', TO_DATE('2001-01-01', 'YYYY-MM-DD'), TO_DATE('2022-02-16', 'YYYY-MM-DD'));

INSERT INTO tb_usuario (email, num_postagens, data_assinatura, telefones, nome, sobrenome, data_nasc, data_cad)
VALUES ('filipec@example.com', 20, TO_DATE('2021-11-30', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('78912345601')), 'Filipe', 'Ciclanoton', TO_DATE('1999-01-01', 'YYYY-MM-DD'), TO_DATE('2021-12-05', 'YYYY-MM-DD'));

INSERT INTO tb_usuario (email, num_postagens, data_assinatura, telefones, nome, sobrenome, data_nasc, data_cad)
VALUES ('thiagom@example.com', 8, TO_DATE('2022-03-10', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('65478932101'), tp_telefone('98765412301')), 'Thiago', 'McCiclano', TO_DATE('1998-01-01', 'YYYY-MM-DD'), TO_DATE('2022-03-25', 'YYYY-MM-DD'));

INSERT INTO tb_usuario (email, num_postagens, data_assinatura, telefones, nome, sobrenome, data_nasc, data_cad)
VALUES ('gabrielb@example.com', 15, TO_DATE('2021-09-20', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('45678998701')), 'Thiago', 'Beltranoson', TO_DATE('1997-01-01', 'YYYY-MM-DD'), TO_DATE('2021-10-21', 'YYYY-MM-DD'));

-- tabela moderador [OK]

INSERT INTO tb_moderador (email, num_contas_banidas, nome, sobrenome, data_nasc, data_cad, telefones) 
VALUES ('julianam@example.com', 3, 'Juliana', 'Machado', TO_DATE('1985-03-15', 'YYYY-MM-DD'), TO_DATE('2005-07-10', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('11111111111'),
                                                                                                                                                      tp_telefone('12222222222'),                                                                                                             tp_telefone('13333333333')));

INSERT INTO tb_moderador (email, num_contas_banidas, nome, sobrenome, data_nasc, data_cad, telefones) 
VALUES ('brenow@example.com', 5, 'Breno', 'Wellington', TO_DATE('1990-08-25', 'YYYY-MM-DD'), TO_DATE('2020-11-19', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('22222222222'),
                                                                                                                                                     tp_telefone('23333333333')));

INSERT INTO tb_moderador (email, num_contas_banidas, nome, sobrenome, data_nasc, data_cad, telefones) 
VALUES ('fernandoc@example.com', 2, 'Fernando', 'Costa', TO_DATE('1978-11-10', 'YYYY-MM-DD'), TO_DATE('2015-01-14', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('33333333333'),
                                                                                                                                                      tp_telefone('34444444444'),                                                                                                                        tp_telefone('35555555555'),
                                                                                                                                                      tp_telefone('36666666666')));

INSERT INTO tb_moderador (email, num_contas_banidas, nome, sobrenome, data_nasc, data_cad, telefones) 
VALUES ('rayannes@example.com', 7, 'Rayanne', 'Soares', TO_DATE('1982-05-01', 'YYYY-MM-DD'), TO_DATE('2010-08-02', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('44444444444')));

INSERT INTO tb_moderador (email, num_contas_banidas, nome, sobrenome, data_nasc, data_cad, telefones) 
VALUES ('erlandoc@example.com', 4, 'Erlando', 'Campos', TO_DATE('1995-12-20', 'YYYY-MM-DD'), TO_DATE('2014-10-20', 'YYYY-MM-DD'), varray_tp_telefone(tp_telefone('55555555555'),
                                                                                                                                                     tp_telefone('56666666666')));

-- tabela comentario [OK]

INSERT INTO tb_comentario (id, data_publicacao, mensagem, num_curtidas) 
VALUES ('1', TO_DATE('2023-04-04', 'YYYY-MM-DD'), 'Ótimo post!', 10);

INSERT INTO tb_comentario (id, data_publicacao, mensagem, num_curtidas) 
VALUES ('2', TO_DATE('2023-04-03', 'YYYY-MM-DD'), 'Gostei do conteúdo.', 5);

INSERT INTO tb_comentario (id, data_publicacao, mensagem, num_curtidas) 
VALUES ('3', TO_DATE('2023-04-02', 'YYYY-MM-DD'), 'Interessante!', 3);

INSERT INTO tb_comentario (id, data_publicacao, mensagem, num_curtidas) 
VALUES ('4', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Parabéns pelo artigo.', 8);

INSERT INTO tb_comentario (id, data_publicacao, mensagem, num_curtidas) 
VALUES ('5', TO_DATE('2023-03-31', 'YYYY-MM-DD'), 'Excelente postagem!', 15);

-- tabela resposta

INSERT INTO tb_resposta (id_comentario, id_resposta, data_publicacao, mensagem)
VALUES ((SELECT REF(c) FROM tb_comentario c WHERE c.id = '1'), '001', TO_DATE('01-04-2023', 'dd-mm-yyyy'), 'Obrigado pelo seu comentário!');

INSERT INTO tb_resposta (id_comentario, id_resposta, data_publicacao, mensagem)
VALUES ((SELECT REF(c) FROM tb_comentario c WHERE c.id = '1'), '002', TO_DATE('02-04-2023', 'dd-mm-yyyy'), 'Fico feliz que tenha gostado!');

INSERT INTO tb_resposta (id_comentario, id_resposta, data_publicacao, mensagem)
VALUES ((SELECT REF(c) FROM tb_comentario c WHERE c.id = '1'), '003', TO_DATE('03-04-2023', 'dd-mm-yyyy'), 'Vamos verificar essa questão');

INSERT INTO tb_resposta (id_comentario, id_resposta, data_publicacao, mensagem)
VALUES ((SELECT REF(c) FROM tb_comentario c WHERE c.id = '4'), '004', TO_DATE('04-04-2023', 'dd-mm-yyyy'), 'Espero ter ajudado!');

INSERT INTO tb_resposta (id_comentario, id_resposta, data_publicacao, mensagem)
VALUES ((SELECT REF(c) FROM tb_comentario c WHERE c.id = '5'), '005', TO_DATE('05-04-2023', 'dd-mm-yyyy'), 'De nada!');

-- tabela acompanha (nested table)

INSERT INTO tb_topico
VALUES (tp_topico('Política', tp_nt_acompanha(tp_acompanha((SELECT REF(u) FROM tb_usuario u WHERE u.email = 'joaof@example.com'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD')))));

INSERT INTO tb_topico
VALUES (tp_topico('Humor', tp_nt_acompanha(tp_acompanha((SELECT REF(u) FROM tb_usuario u WHERE u.email = 'mariaf@example.com'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD')))));
                                                                                                                                                                                                                                                                  
INSERT INTO tb_topico
VALUES (tp_topico('Noticias', tp_nt_acompanha(tp_acompanha((SELECT REF(u) FROM tb_usuario u WHERE u.email = 'filipec@example.com'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD')))));
                                                                                                                                  
INSERT INTO tb_topico
VALUES (tp_topico('Ciência', tp_nt_acompanha(tp_acompanha((SELECT REF(u) FROM tb_usuario u WHERE u.email = 'thiagom@example.com'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD')))));
                                                                                                                                  
INSERT INTO tb_topico
VALUES (tp_topico('Esportes', tp_nt_acompanha(tp_acompanha((SELECT REF(u) FROM tb_usuario u WHERE u.email = 'gabrielb@example.com'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD')))));

-- tabela seguidor

INSERT INTO tb_seguidor (seguido, seguidor) VALUES (
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'joaof@example.com'),
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'gabrielb@example.com')
);

INSERT INTO tb_seguidor (seguido, seguidor) VALUES (
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'thiagom@example.com'),
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'filipec@example.com')
);

INSERT INTO tb_seguidor (seguido, seguidor) VALUES (
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'mariaf@example.com'),
    (SELECT REF(u) FROM tb_usuario u WHERE u.email = 'filipec@example.com')
);

-- tabela postagem

INSERT INTO tb_postagem (id, titulo_da_postagem, data_publicacao)
VALUES (1, 'Título da Postagem 1', TO_DATE('2023-03-30', 'YYYY-MM-DD'));

INSERT INTO tb_postagem (id, titulo_da_postagem, data_publicacao)
VALUES (2, 'Título da Postagem 2', TO_DATE('2023-03-31', 'YYYY-MM-DD'));

INSERT INTO tb_postagem (id, titulo_da_postagem, data_publicacao)
VALUES (3, 'Título da Postagem 3', TO_DATE('2023-04-01', 'YYYY-MM-DD'));

INSERT INTO tb_postagem (id, titulo_da_postagem, data_publicacao)
VALUES (4, 'Título da Postagem 4', TO_DATE('2023-04-02', 'YYYY-MM-DD'));

INSERT INTO tb_postagem (id, titulo_da_postagem, data_publicacao)
VALUES (5, 'Título da Postagem 5', TO_DATE('2023-04-03', 'YYYY-MM-DD'));

-- associa1
INSERT INTO tb_postagem_comentario (id_associado, postagem, comentario)
VALUES (
    '1', 
    (SELECT REF(P) FROM tb_postagem P where P.id = '1'), 
    (SELECT REF(C) FROM tb_comentario C where C.id = '1')
);

INSERT INTO tb_postagem_comentario (id_associado, postagem, comentario)
VALUES (
    '2', 
    (SELECT REF(P) FROM tb_postagem P where P.id = '2'), 
    (SELECT REF(C) FROM tb_comentario C where C.id = '2') 
);

INSERT INTO tb_postagem_comentario (id_associado, postagem, comentario)
VALUES (
    '3', 
    (SELECT REF(P) FROM tb_postagem P where P.id = '3'), 
    (SELECT REF(C) FROM tb_comentario C where C.id = '3') 
);

INSERT INTO tb_postagem_comentario (id_associado, postagem, comentario)
VALUES (
    '4', 
    (SELECT REF(P) FROM tb_postagem P where P.id = '4'), 
    (SELECT REF(C) FROM tb_comentario C where C.id = '4') 
);

INSERT INTO tb_postagem_comentario (id_associado, postagem, comentario)
VALUES (
    '5', 
    (SELECT REF(P) FROM tb_postagem P where P.id = '5'), 
    (SELECT REF(C) FROM tb_comentario C where C.id = '5') 
);

-- associa2
INSERT INTO tb_topico_postagem (id_associado, topico, postagem)
VALUES (
    '1', 
    (SELECT REF(T) FROM tb_topico T where T.nome_do_topico = 'Política'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '1')
);

INSERT INTO tb_topico_postagem (id_associado, topico, postagem)
VALUES (
    '2', 
    (SELECT REF(T) FROM tb_topico T where T.nome_do_topico = 'Humor'),  
    (SELECT REF(P) FROM tb_postagem P where P.id = '2')
);

INSERT INTO tb_topico_postagem (id_associado, topico, postagem)
VALUES (
    '3', 
    (SELECT REF(T) FROM tb_topico T where T.nome_do_topico = 'Noticias'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '3')
);

INSERT INTO tb_topico_postagem (id_associado, topico, postagem)
VALUES (
    '4', 
    (SELECT REF(T) FROM tb_topico T where T.nome_do_topico = 'Ciência'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '4')
);

INSERT INTO tb_topico_postagem (id_associado, topico, postagem)
VALUES (
    '5', 
    (SELECT REF(T) FROM tb_topico T where T.nome_do_topico = 'Esportes'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '5')
);

-- Usuario_Postagem
INSERT INTO tb_usuario_postagem (id_associado, usuario, postagem)
VALUES (
    '1',
    (SELECT REF(U) FROM tb_usuario U where U.email = 'joaof@example.com'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '1')
);

INSERT INTO tb_usuario_postagem (id_associado, usuario, postagem)
VALUES (
    '2',
    (SELECT REF(U) FROM tb_usuario U where U.email = 'mariaf@example.com'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '2')
);

INSERT INTO tb_usuario_postagem (id_associado, usuario, postagem)
VALUES (
    '3',
    (SELECT REF(U) FROM tb_usuario U where U.email = 'filipec@example.com'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '3')
);

INSERT INTO tb_usuario_postagem (id_associado, usuario, postagem)
VALUES (
    '4',
    (SELECT REF(U) FROM tb_usuario U where U.email = 'thiagom@example.com'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '4')
);

INSERT INTO tb_usuario_postagem (id_associado, usuario, postagem)
VALUES (
    '5',
    (SELECT REF(U) FROM tb_usuario U where U.email = 'gabrielb@example.com'), 
    (SELECT REF(P) FROM tb_postagem P where P.id = '5')
);