CREATE TABLE tb_usuario OF tp_usuario (
    email PRIMARY KEY,
    num_postagens NOT NULL,
    data_assinatura NOT NULL,
    telefones NOT NULL,
    nome NOT NULL,
    sobrenome NOT NULL, 
    data_nasc NOT NULL,
    data_cad NOT NULL
);
/

CREATE TABLE tb_moderador OF tp_moderador (
    email PRIMARY KEY,
    num_contas_banidas NOT NULL,
    nome NOT NULL,
    sobrenome NOT NULL,
    data_nasc NOT NULL,
    data_cad NOT NULL,
    telefones NOT NULL
);
/

CREATE TABLE tb_comentario OF tp_comentario (
    id PRIMARY KEY,
    data_publicacao NOT NULL,
    mensagem NOT NULL,
    num_curtidas NOT NULL
);
/

CREATE TABLE tb_topico OF tp_topico (
    PRIMARY KEY (nome_do_topico)
) NESTED TABLE acompanha STORE AS nt_acompanha;
/

CREATE TABLE tb_resposta OF tp_resposta (
    id_comentario REFERENCES tb_comentario,
    id_resposta PRIMARY KEY,
    data_publicacao NOT NULL,
    mensagem NOT NULL
);
/

CREATE TABLE tb_seguidor OF tp_seguidor (
    seguido NOT NULL,
    seguidor SCOPE IS tb_usuario
);
/

CREATE TABLE tb_postagem OF tp_postagem (
    id PRIMARY KEY,
    titulo_da_postagem NOT NULL,
    data_publicacao NOT NULL
);
/

CREATE TABLE tb_usuario_postagem OF tp_usuario_postagem (
    id_associado PRIMARY KEY,
    usuario WITH ROWID REFERENCES tb_usuario,
    postagem WITH ROWID REFERENCES tb_postagem
);
/

CREATE TABLE tb_postagem_comentario OF tp_postagem_comentario (
    id_associado PRIMARY KEY,
    postagem WITH ROWID REFERENCES tb_postagem,
    comentario WITH ROWID REFERENCES tb_comentario
);
/

CREATE TABLE tb_topico_postagem OF tp_topico_postagem (
    id_associado PRIMARY KEY,
    topico WITH ROWID REFERENCES tb_topico,
    postagem WITH ROWID REFERENCES tb_postagem
);
/