CREATE TABLE tb_boleta (
    id             VARCHAR2(10) NOT NULL,
    numero         VARCHAR2(10) NOT NULL,
    tipo           VARCHAR2(7) NOT NULL,
    estado         VARCHAR2(10) NOT NULL,
    total          NUMBER(6, 2) NOT NULL,
    fecha          DATE NOT NULL,
    tb_vendedor_id VARCHAR2(9) NOT NULL,
    tb_pago_id     VARCHAR2(5) NOT NULL,
    tb_tienda_id   VARCHAR2(5) NOT NULL
);

ALTER TABLE tb_boleta ADD CONSTRAINT tb_comprobante_pk PRIMARY KEY ( id );

CREATE TABLE tb_client (
    id                VARCHAR2(5) NOT NULL,
    dni               VARCHAR2(8) NOT NULL,
    nombre            VARCHAR2(50) NOT NULL,
    domicilio         VARCHAR2(150),
    telefono          VARCHAR2(9),
    correo            VARCHAR2(30),
    tb_comprobante_id VARCHAR2(10) NOT NULL,
    tb_pro_id         VARCHAR2(10) NOT NULL
);

ALTER TABLE tb_client ADD CONSTRAINT tb_cliente_pk PRIMARY KEY ( id );

CREATE TABLE tb_employee (
    id            VARCHAR2(9) NOT NULL,
    nombre        VARCHAR2(50) NOT NULL,
    domicilio     VARCHAR2(100) NOT NULL,
    telefono      VARCHAR2(9) NOT NULL,
    correo        VARCHAR2(30) NOT NULL,
    fecha_inicio  VARCHAR2(10),
    tb_empresa_id VARCHAR2(5) NOT NULL
);

ALTER TABLE tb_employee ADD CONSTRAINT tb_vendedor_pk PRIMARY KEY ( id );

CREATE TABLE tb_inc (
    id        VARCHAR2(5) NOT NULL,
    ruc       VARCHAR2(11) NOT NULL,
    nombre    VARCHAR2(20) NOT NULL,
    domicilio VARCHAR2(100) NOT NULL
);

ALTER TABLE tb_inc ADD CONSTRAINT tb_empresa_pk PRIMARY KEY ( id );

CREATE TABLE tb_pay (
    id         VARCHAR2(5) NOT NULL,
    numero_ref VARCHAR2(10),
    tipo       VARCHAR2(13),
    igv        NUMBER(9, 3) NOT NULL
);

ALTER TABLE tb_pay ADD CONSTRAINT tb_tipo_de_pago_pk PRIMARY KEY ( id );

CREATE TABLE tb_product (
    id             VARCHAR2(10) NOT NULL,
    nombre         VARCHAR2(50) NOT NULL,
    garantia       VARCHAR2(2) NOT NULL,
    cantidad       NUMBER(4) NOT NULL,
    precio         NUMBER(9, 2) NOT NULL,
    codigo         VARCHAR2(10),
    serie          VARCHAR2(20),
    tb_comp_id     VARCHAR2(10) NOT NULL
);

ALTER TABLE tb_product ADD CONSTRAINT tb_producto_pk PRIMARY KEY ( id );

CREATE TABLE tb_store (
    " id"         VARCHAR2(5) NOT NULL,
    nombre        VARCHAR2(10) NOT NULL,
    ciudad        VARCHAR2(15) NOT NULL,
    domicilio     VARCHAR2(100),
    tb_empresa_id VARCHAR2(5) NOT NULL
);

ALTER TABLE tb_store ADD CONSTRAINT tb_tienda_pk PRIMARY KEY ( " id" );

ALTER TABLE tb_client
    ADD CONSTRAINT tb_cliente_tb_comprobante_fk FOREIGN KEY ( tb_comprobante_id )
        REFERENCES tb_boleta ( id );

ALTER TABLE tb_client
    ADD CONSTRAINT tb_cliente_tb_pro_fk FOREIGN KEY ( tb_pro_id )
        REFERENCES tb_product ( id );

ALTER TABLE tb_boleta
    ADD CONSTRAINT tb_comprobante_tb_pago_fk FOREIGN KEY ( tb_pago_id )
        REFERENCES tb_pay ( id );

ALTER TABLE tb_boleta
    ADD CONSTRAINT tb_comprobante_tb_tienda_fk FOREIGN KEY ( tb_tienda_id )
        REFERENCES tb_store ( " id" );

ALTER TABLE tb_boleta
    ADD CONSTRAINT tb_comprobante_tb_vendedor_fk FOREIGN KEY ( tb_vendedor_id )
        REFERENCES tb_employee ( id );

ALTER TABLE tb_product
    ADD CONSTRAINT tb_producto_tb_comp_fk FOREIGN KEY ( tb_comp_id )
        REFERENCES tb_boleta ( id );

ALTER TABLE tb_store
    ADD CONSTRAINT tb_tienda_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_inc ( id );

ALTER TABLE tb_employee
    ADD CONSTRAINT tb_vendedor_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_inc ( id );
