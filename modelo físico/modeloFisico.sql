CREATE TABLE usuario (
    id_usuario      SERIAL       PRIMARY KEY,
    nome_completo   VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    senha           VARCHAR(100) NOT NULL,
    tipo_usuario    VARCHAR(20)  NOT NULL
);

CREATE TABLE cliente (
    id_cliente    SERIAL       PRIMARY KEY,
    nome_cliente  VARCHAR(100) NOT NULL
);

CREATE TABLE material (
    id_material        SERIAL        PRIMARY KEY,
    nome_material      VARCHAR(100)  NOT NULL,
    descricao_material VARCHAR(255),
    valor_material     NUMERIC(10,2) NOT NULL CHECK (valor_material >= 0),
    quant_estoque      INTEGER       NOT NULL CHECK (quant_estoque >= 0)
);

CREATE TABLE servico (
    id_servico     SERIAL        PRIMARY KEY,
    nome_servico   VARCHAR(100)  NOT NULL,
    valor_servico  NUMERIC(10,2) NOT NULL CHECK (valor_servico >= 0)
);

CREATE TABLE venda (
    id_venda           SERIAL        PRIMARY KEY,
    data_venda         DATE          NOT NULL,
    valor_total_venda  NUMERIC(10,2) NOT NULL CHECK (valor_total_venda >= 0),
    forma_pagamento    VARCHAR(20)   NOT NULL,
    status_pagamento   VARCHAR(20)   NOT NULL,
    id_usuario         INTEGER       NOT NULL,
    id_cliente         INTEGER       NULL,

    CONSTRAINT fk_venda_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT fk_venda_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE despesa (
    id_despesa     SERIAL        PRIMARY KEY,
    nome_despesa   VARCHAR(100)  NOT NULL,
    categoria      VARCHAR(50)   NOT NULL,
    valor_despesa  NUMERIC(10,2) NOT NULL CHECK (valor_despesa >= 0),
    data_despesa   DATE          NOT NULL,
    id_usuario     INTEGER       NOT NULL,

    CONSTRAINT fk_despesa_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE nota_fiscal (
    id_nota                 SERIAL      PRIMARY KEY,
    data_emissao            DATE        NOT NULL,
    data_prevista_pagamento DATE        NULL,
    data_pagamento          DATE        NULL,
    status_pagamento        VARCHAR(20) NOT NULL,
    id_venda                INTEGER     NOT NULL UNIQUE,
    id_cliente              INTEGER     NOT NULL,

    CONSTRAINT fk_nota_venda
        FOREIGN KEY (id_venda)  REFERENCES venda(id_venda),

    CONSTRAINT fk_nota_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_venda_servico (
    id_item_venda_servico  SERIAL        PRIMARY KEY,
    id_venda               INTEGER       NOT NULL,
    id_servico             INTEGER       NOT NULL,
    quantidade_servico     INTEGER       NOT NULL CHECK (quantidade_servico > 0),
    valor_servico          NUMERIC(10,2) NOT NULL CHECK (valor_servico >= 0),

    CONSTRAINT fk_item_serv_venda
        FOREIGN KEY (id_venda)  REFERENCES venda(id_venda),

    CONSTRAINT fk_item_serv_servico
        FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);

CREATE TABLE item_venda_material (
    id_item_venda_material SERIAL        PRIMARY KEY,
    id_venda               INTEGER       NOT NULL,
    id_material            INTEGER       NOT NULL,
    quantidade_material    INTEGER       NOT NULL CHECK (quantidade_material > 0),
    valor_unitario         NUMERIC(10,2) NOT NULL CHECK (valor_unitario >= 0),

    CONSTRAINT fk_item_mat_venda
        FOREIGN KEY (id_venda)   REFERENCES venda(id_venda),

    CONSTRAINT fk_item_mat_material
        FOREIGN KEY (id_material) REFERENCES material(id_material)
);
