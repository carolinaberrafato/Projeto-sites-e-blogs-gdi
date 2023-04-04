CREATE TABLE tb_usuario OF tp_usuario (
    email PRIMARY KEY,
    num_postagens NOT NULL,
    data_assinatura NOT NULL,
    telefones NOT NULL
);


CREATE TABLE tb_moderador OF tp_moderador (
    email PRIMARY KEY,
    num_contas_banidas NOT NULL,
    nome NOT NULL,
    sobrenome NOT NULL,
    data_nasc NOT NULL,
    data_cad NOT NULL,
    telefones NOT NULL
);


CREATE TABLE tb_comentario OF tp_comentario (
    id PRIMARY KEY,
    data_publicacao NOT NULL,
    mensagem NOT NULL,
    num_curtidas NOT NULL
);

CREATE TABLE tb_topico OF tp_topico (
    PRIMARY KEY (nome_do_topico)
) NESTED TABLE acompanha STORE AS nt_acompanha;

CREATE TABLE tb_resposta OF tp_resposta (
    id_comentario REFERENCES tb_comentario,
    id_resposta PRIMARY KEY,
    data_publicacao NOT NULL,
    mensagem NOT NULL
);

CREATE TABLE tb_seguidor OF tp_seguidor;

CREATE TABLE tb_postagem OF tp_postagem;




