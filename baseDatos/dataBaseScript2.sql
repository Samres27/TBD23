--==============================================================
-- DBMS name:      ANSI Level 2
-- Created on:     15/10/2023 19:06:49
--==============================================================


drop index ACCEDE2_FK;

drop index ACCEDE_PK;

drop table ACCEDE cascade;

drop index ALBUM_FK;

drop index ALBUM_PK;

drop table ALBUM cascade;

drop index RELATIONSHIP_32_FK;

drop index RELATIONSHIP_20_FK;

drop index ARTISTA_PK;

drop table ARTISTA cascade;

drop index RELATIONSHIP_22_FK;

drop index RELATIONSHIP_21_FK;

drop index AUTOR_PK;

drop table AUTOR cascade;

drop index TIENE3_FK;

drop index CAMBIOCATEGORIA_PK;

drop table CAMBIOCATEGORIA cascade;

drop index CANCIONES_FK;

drop index CANCION_PK;

drop table CANCION cascade;

drop index TIENE4_FK;

drop index CATEGORIA_FK;

drop index CATEGORIA_PK;

drop table CATEGORIA cascade;

drop index RELATIONSHIP_18_FK;

drop index CIUDAD_PK;

drop table CIUDAD cascade;

drop index CLIENTE_PK;

drop table CLIENTE cascade;

drop index RELATIONSHIP_31_FK;

drop index CUENTAUSUARIO_PK;

drop table CUENTAUSUARIO cascade;

drop index EMPRESAPRODUCTORA_PK;

drop table EMPRESAPRODUCTORA cascade;

drop index RELATIONSHIP_17_FK;

drop index EVENTO_PK;

drop table EVENTO cascade;

drop index TIENE_FK;

drop index TIENE2_FK;

drop index EXPERIENCIA_PK;

drop table EXPERIENCIA cascade;

drop index TIENE6_FK;

drop index TIENE5_FK;

drop index FINANCIA_PK;

drop table FINANCIA cascade;

drop index GRUPOMUSICAL_PK;

drop table GRUPOMUSICAL cascade;

drop index HABILIDAD_PK;

drop table HABILIDAD cascade;

drop index CREA_FK;

drop index LISTAREPRODUCCION_PK;

drop table LISTAREPRODUCCION cascade;

drop index TIENE7_FK;

drop index RELATIONSHIP_16_FK;

drop index PREMIOC_FK;

drop index PREMIOA_FK;

drop index NOMINADO_PK;

drop table NOMINADO cascade;

drop index RELATIONSHIP_29_FK;

drop index RELATIONSHIP_28_FK;

drop index OFERTA_PK;

drop table OFERTA cascade;

drop index PAIS_PK;

drop table PAIS cascade;

drop index RELATIONSHIP_30_FK;

drop index PLANDEPAGOS_PK;

drop table PLANDEPAGOS cascade;

drop index RELATIONSHIP_25_FK;

drop index RANKING_PK;

drop table RANKING cascade;

drop index RELATIONSHIP_24_FK;

drop index REPRODUCCIONPORLISTA_PK;

drop table REPRODUCCIONPORLISTA cascade;

drop index SIGUE2_FK;

drop index SIGUE_PK;

drop table SIGUE cascade;

drop index SUSCRIPCION_PK;

drop table SUSCRIPCION cascade;

drop index TIENE9_FK;

drop index TIENE8_PK;

drop table TIENE cascade;

--==============================================================
-- Table: CLIENTE
--==============================================================
create table CLIENTE (
IDCLIENTE            INTEGER              not null,
NOMBRECLIENTE        VARCHAR(32),
FECHANACIMIENTOC     DATE,
PAISCLIENTE          VARCHAR(32),
CIUDADCLIENTE        VARCHAR(32),
CORREOELECTRONICOC   VARCHAR(32),
GENEROFAVORIITOC_    VARCHAR(84),
primary key (IDCLIENTE)
);

--==============================================================
-- Table: CUENTAUSUARIO
--==============================================================
create table CUENTAUSUARIO (
IDCU                 INTEGER              not null,
IDCLIENTE            INTEGER,
LOGINCU              VARCHAR(32),
PASSWORDCU           VARCHAR(32),
FECHACREACIONCU      DATE,
FECHACAMBIOPASSCU    DATE,
primary key (IDCU),
foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE)
);

--==============================================================
-- Table: LISTAREPRODUCCION
--==============================================================
create table LISTAREPRODUCCION (
IDLISTAREPRODUCCION  INTEGER              not null,
IDCU                 INTEGER,
NOMBRELISTAREPRODUCCION VARCHAR(31),
FECHACREACION        DATE,
FECHAELIMINACION     DATE,
NROREPRODUCCIONESL   INTEGER,
primary key (IDLISTAREPRODUCCION),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU)
);

--==============================================================
-- Table: ACCEDE
--==============================================================
create table ACCEDE (
IDCU                 INTEGER              not null,
IDLISTAREPRODUCCION  INTEGER              not null,
primary key (IDCU, IDLISTAREPRODUCCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU)
);

--==============================================================
-- Index: ACCEDE_PK
--==============================================================
create unique index ACCEDE_PK on ACCEDE (
IDCU ASC,
IDLISTAREPRODUCCION ASC
);

--==============================================================
-- Index: ACCEDE2_FK
--==============================================================
create  index ACCEDE2_FK on ACCEDE (
IDLISTAREPRODUCCION ASC
);

--==============================================================
-- Table: PAIS
--==============================================================
create table PAIS (
NOMBREPAIS           VARCHAR(32)          not null,
CONTINENTE           VARCHAR(32),
primary key (NOMBREPAIS)
);

--==============================================================
-- Table: CIUDAD
--==============================================================
create table CIUDAD (
NOMBRECIUDAD         VARCHAR(32)          not null,
NOMBREPAIS           VARCHAR(32),
FECHAFUNDACIONC      DATE,
primary key (NOMBRECIUDAD),
foreign key (NOMBREPAIS)
      references PAIS (NOMBREPAIS)
);

--==============================================================
-- Table: GRUPOMUSICAL
--==============================================================
create table GRUPOMUSICAL (
IDGRUPO              INTEGER              not null,
NOMBREGRUPO          VARCHAR(32),
GENEROMUSICAL        VARCHAR(32),
FECHADEAGRUPACION    DATE,
primary key (IDGRUPO)
);

--==============================================================
-- Table: ARTISTA
--==============================================================
create table ARTISTA (
IDARTISTA            INTEGER              not null,
NOMBRECIUDAD         VARCHAR(32),
IDGRUPO              INTEGER,
NOMBREARTISTA        VARCHAR(32)          not null,
NOMBREREAL           VARCHAR(32)          not null,
FECHANACIMIENTOA     DATE                 not null,
PAISARTISTA          VARCHAR(32)          not null,
ROLARTISTA           VARCHAR(32),
VIGENCIA             SMALLINT,
primary key (IDARTISTA),
foreign key (NOMBRECIUDAD)
      references CIUDAD (NOMBRECIUDAD),
foreign key (IDGRUPO)
      references GRUPOMUSICAL (IDGRUPO)
);

--==============================================================
-- Table: CAMBIOCATEGORIA
--==============================================================
create table CAMBIOCATEGORIA (
FECHACAMBIO          DATE                 not null,
IDARTISTA            INTEGER,
MOTIVODECAMBIO       VARCHAR(256),
primary key (FECHACAMBIO),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

--==============================================================
-- Table: CATEGORIA
--==============================================================
create table CATEGORIA (
NOMBRECATEGORIA      VARCHAR(32)          not null,
IDARTISTA            INTEGER,
FECHACAMBIO          DATE,
DESCRIPCIONCATEGORIA VARCHAR(256)         not null,
primary key (NOMBRECATEGORIA),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA),
foreign key (FECHACAMBIO)
      references CAMBIOCATEGORIA (FECHACAMBIO)
);

--==============================================================
-- Table: ALBUM
--==============================================================
create table ALBUM (
IDALBUM              INTEGER              not null,
NOMBRECATEGORIA      VARCHAR(32),
NOMBREALBUM          VARCHAR(32)          not null,
ANIOESTRENO          DATE                 not null,
primary key (IDALBUM),
foreign key (NOMBRECATEGORIA)
      references CATEGORIA (NOMBRECATEGORIA)
);

--==============================================================
-- Index: ALBUM_PK
--==============================================================
create unique index ALBUM_PK on ALBUM (
IDALBUM ASC
);

--==============================================================
-- Index: ALBUM_FK
--==============================================================
create  index ALBUM_FK on ALBUM (
NOMBRECATEGORIA ASC
);

--==============================================================
-- Index: ARTISTA_PK
--==============================================================
create unique index ARTISTA_PK on ARTISTA (
IDARTISTA ASC
);

--==============================================================
-- Index: RELATIONSHIP_20_FK
--==============================================================
create  index RELATIONSHIP_20_FK on ARTISTA (
NOMBRECIUDAD ASC
);

--==============================================================
-- Index: RELATIONSHIP_32_FK
--==============================================================
create  index RELATIONSHIP_32_FK on ARTISTA (
IDGRUPO ASC
);

--==============================================================
-- Table: CANCION
--==============================================================
create table CANCION (
IDCANCION            INTEGER              not null,
IDALBUM              INTEGER,
NOMBRECANCION        VARCHAR(32)          not null,
DURACIONMIN          TIME                 not null,
FORMATO              VARCHAR(32)          not null,
primary key (IDCANCION),
foreign key (IDALBUM)
      references ALBUM (IDALBUM)
);

--==============================================================
-- Table: AUTOR
--==============================================================
create table AUTOR (
NOMBREAUTOR          VARCHAR(32)          not null,
IDCANCION            INTEGER,
IDARTISTA            INTEGER,
LETRAAUTOR           VARCHAR(1),
MUSICAAUTOR          CHAR(256),
primary key (NOMBREAUTOR),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA),
foreign key (IDCANCION)
      references CANCION (IDCANCION)
);

--==============================================================
-- Index: AUTOR_PK
--==============================================================
create unique index AUTOR_PK on AUTOR (
NOMBREAUTOR ASC
);

--==============================================================
-- Index: RELATIONSHIP_21_FK
--==============================================================
create  index RELATIONSHIP_21_FK on AUTOR (
IDARTISTA ASC
);

--==============================================================
-- Index: RELATIONSHIP_22_FK
--==============================================================
create  index RELATIONSHIP_22_FK on AUTOR (
IDCANCION ASC
);

--==============================================================
-- Index: CAMBIOCATEGORIA_PK
--==============================================================
create unique index CAMBIOCATEGORIA_PK on CAMBIOCATEGORIA (
FECHACAMBIO ASC
);

--==============================================================
-- Index: TIENE3_FK
--==============================================================
create  index TIENE3_FK on CAMBIOCATEGORIA (
IDARTISTA ASC
);

--==============================================================
-- Index: CANCION_PK
--==============================================================
create unique index CANCION_PK on CANCION (
IDCANCION ASC
);

--==============================================================
-- Index: CANCIONES_FK
--==============================================================
create  index CANCIONES_FK on CANCION (
IDALBUM ASC
);

--==============================================================
-- Index: CATEGORIA_PK
--==============================================================
create unique index CATEGORIA_PK on CATEGORIA (
NOMBRECATEGORIA ASC
);

--==============================================================
-- Index: CATEGORIA_FK
--==============================================================
create  index CATEGORIA_FK on CATEGORIA (
IDARTISTA ASC
);

--==============================================================
-- Index: TIENE4_FK
--==============================================================
create  index TIENE4_FK on CATEGORIA (
FECHACAMBIO ASC
);

--==============================================================
-- Index: CIUDAD_PK
--==============================================================
create unique index CIUDAD_PK on CIUDAD (
NOMBRECIUDAD ASC
);

--==============================================================
-- Index: RELATIONSHIP_18_FK
--==============================================================
create  index RELATIONSHIP_18_FK on CIUDAD (
NOMBREPAIS ASC
);

--==============================================================
-- Index: CLIENTE_PK
--==============================================================
create unique index CLIENTE_PK on CLIENTE (
IDCLIENTE ASC
);

--==============================================================
-- Index: CUENTAUSUARIO_PK
--==============================================================
create unique index CUENTAUSUARIO_PK on CUENTAUSUARIO (
IDCU ASC
);

--==============================================================
-- Index: RELATIONSHIP_31_FK
--==============================================================
create  index RELATIONSHIP_31_FK on CUENTAUSUARIO (
IDCLIENTE ASC
);

--==============================================================
-- Table: EMPRESAPRODUCTORA
--==============================================================
create table EMPRESAPRODUCTORA (
IDEMPRESA            INTEGER              not null,
NOMBREEMPRESA        VARCHAR(32),
primary key (IDEMPRESA)
);

--==============================================================
-- Index: EMPRESAPRODUCTORA_PK
--==============================================================
create unique index EMPRESAPRODUCTORA_PK on EMPRESAPRODUCTORA (
IDEMPRESA ASC
);

--==============================================================
-- Table: EVENTO
--==============================================================
create table EVENTO (
IDEVENTO             INTEGER              not null,
NOMBRECIUDAD         VARCHAR(32),
NOMBREEVENTO         DATE,
FECHAEVENTO          DATE,
primary key (IDEVENTO),
foreign key (NOMBRECIUDAD)
      references CIUDAD (NOMBRECIUDAD)
);

--==============================================================
-- Index: EVENTO_PK
--==============================================================
create unique index EVENTO_PK on EVENTO (
IDEVENTO ASC
);

--==============================================================
-- Index: RELATIONSHIP_17_FK
--==============================================================
create  index RELATIONSHIP_17_FK on EVENTO (
NOMBRECIUDAD ASC
);

--==============================================================
-- Table: HABILIDAD
--==============================================================
create table HABILIDAD (
NOMBREHABILIDAD      VARCHAR(32)          not null,
DESCRIPCIONHABILIDAD VARCHAR(256)         not null,
primary key (NOMBREHABILIDAD)
);

--==============================================================
-- Table: EXPERIENCIA
--==============================================================
create table EXPERIENCIA (
NIVEL                VARCHAR(32)          not null,
NOMBREHABILIDAD      VARCHAR(32),
IDARTISTA            INTEGER,
primary key (NIVEL),
foreign key (NOMBREHABILIDAD)
      references HABILIDAD (NOMBREHABILIDAD),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

--==============================================================
-- Index: EXPERIENCIA_PK
--==============================================================
create unique index EXPERIENCIA_PK on EXPERIENCIA (
NIVEL ASC
);

--==============================================================
-- Index: TIENE2_FK
--==============================================================
create  index TIENE2_FK on EXPERIENCIA (
NOMBREHABILIDAD ASC
);

--==============================================================
-- Index: TIENE_FK
--==============================================================
create  index TIENE_FK on EXPERIENCIA (
IDARTISTA ASC
);

--==============================================================
-- Table: FINANCIA
--==============================================================
create table FINANCIA (
PRESUPUESTO          INTEGER              not null,
IDEMPRESA            INTEGER,
IDALBUM              INTEGER,
FECHAINVERSION       DATE,
primary key (PRESUPUESTO),
foreign key (IDALBUM)
      references ALBUM (IDALBUM),
foreign key (IDEMPRESA)
      references EMPRESAPRODUCTORA (IDEMPRESA)
);

--==============================================================
-- Index: FINANCIA_PK
--==============================================================
create unique index FINANCIA_PK on FINANCIA (
PRESUPUESTO ASC
);

--==============================================================
-- Index: TIENE5_FK
--==============================================================
create  index TIENE5_FK on FINANCIA (
IDALBUM ASC
);

--==============================================================
-- Index: TIENE6_FK
--==============================================================
create  index TIENE6_FK on FINANCIA (
IDEMPRESA ASC
);

--==============================================================
-- Index: GRUPOMUSICAL_PK
--==============================================================
create unique index GRUPOMUSICAL_PK on GRUPOMUSICAL (
IDGRUPO ASC
);

--==============================================================
-- Index: HABILIDAD_PK
--==============================================================
create unique index HABILIDAD_PK on HABILIDAD (
NOMBREHABILIDAD ASC
);

--==============================================================
-- Index: LISTAREPRODUCCION_PK
--==============================================================
create unique index LISTAREPRODUCCION_PK on LISTAREPRODUCCION (
IDLISTAREPRODUCCION ASC
);

--==============================================================
-- Index: CREA_FK
--==============================================================
create  index CREA_FK on LISTAREPRODUCCION (
IDCU ASC
);

--==============================================================
-- Table: NOMINADO
--==============================================================
create table NOMINADO (
IDNOMINADO           INTEGER              not null,
IDALBUM              INTEGER,
IDEVENTO             INTEGER,
IDARTISTA            INTEGER,
IDCANCION            INTEGER,
TIPONOMINADO         VARCHAR(32)          not null,
DESCRIPCIONNOMINADO  VARCHAR(256)         not null,
PREMIADO             SMALLINT             not null,
primary key (IDNOMINADO),
foreign key (IDALBUM)
      references ALBUM (IDALBUM),
foreign key (IDCANCION)
      references CANCION (IDCANCION),
foreign key (IDEVENTO)
      references EVENTO (IDEVENTO),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

--==============================================================
-- Index: NOMINADO_PK
--==============================================================
create unique index NOMINADO_PK on NOMINADO (
IDNOMINADO ASC
);

--==============================================================
-- Index: PREMIOA_FK
--==============================================================
create  index PREMIOA_FK on NOMINADO (
IDALBUM ASC
);

--==============================================================
-- Index: PREMIOC_FK
--==============================================================
create  index PREMIOC_FK on NOMINADO (
IDCANCION ASC
);

--==============================================================
-- Index: RELATIONSHIP_16_FK
--==============================================================
create  index RELATIONSHIP_16_FK on NOMINADO (
IDEVENTO ASC
);

--==============================================================
-- Index: TIENE7_FK
--==============================================================
create  index TIENE7_FK on NOMINADO (
IDARTISTA ASC
);

--==============================================================
-- Table: SUSCRIPCION
--==============================================================
create table SUSCRIPCION (
IDSUSCRIPCION        INTEGER              not null,
PRECIOSUSCRIPCION    DECIMAL,
PERIODOSUSCRIP       VARCHAR(18),
FORMAPAGOSUSP        DATE,
FECHAFINSUSP         DATE,
primary key (IDSUSCRIPCION)
);

--==============================================================
-- Table: OFERTA
--==============================================================
create table OFERTA (
IDOFERTA             INTEGER              not null,
IDCU                 INTEGER,
IDSUSCRIPCION        INTEGER,
PRECIOOFERTA         DECIMAL,
INICIOOFERTA         DATE,
FINOFERTA            DATE,
primary key (IDOFERTA),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU),
foreign key (IDSUSCRIPCION)
      references SUSCRIPCION (IDSUSCRIPCION)
);

--==============================================================
-- Index: OFERTA_PK
--==============================================================
create unique index OFERTA_PK on OFERTA (
IDOFERTA ASC
);

--==============================================================
-- Index: RELATIONSHIP_28_FK
--==============================================================
create  index RELATIONSHIP_28_FK on OFERTA (
IDCU ASC
);

--==============================================================
-- Index: RELATIONSHIP_29_FK
--==============================================================
create  index RELATIONSHIP_29_FK on OFERTA (
IDSUSCRIPCION ASC
);

--==============================================================
-- Index: PAIS_PK
--==============================================================
create unique index PAIS_PK on PAIS (
NOMBREPAIS ASC
);

--==============================================================
-- Table: PLANDEPAGOS
--==============================================================
create table PLANDEPAGOS (
FECHADEPAGO          DATE                 not null,
IDSUSCRIPCION        INTEGER,
FECHAREALPAGO        DATE,
FORMAPAGO            VARCHAR(32),
MONTO                VARCHAR(32),
primary key (FECHADEPAGO),
foreign key (IDSUSCRIPCION)
      references SUSCRIPCION (IDSUSCRIPCION)
);

--==============================================================
-- Index: PLANDEPAGOS_PK
--==============================================================
create unique index PLANDEPAGOS_PK on PLANDEPAGOS (
FECHADEPAGO ASC
);

--==============================================================
-- Index: RELATIONSHIP_30_FK
--==============================================================
create  index RELATIONSHIP_30_FK on PLANDEPAGOS (
IDSUSCRIPCION ASC
);

--==============================================================
-- Table: RANKING
--==============================================================
create table RANKING (
IDRANKING            INTEGER              not null,
IDLISTAREPRODUCCION  INTEGER,
NOMBRELISTA          VARCHAR(32),
PUESTO               INTEGER,
PERIODOSEG           INTEGER,
NROREPRODUCCIONESR   INTEGER,
primary key (IDRANKING),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

--==============================================================
-- Index: RANKING_PK
--==============================================================
create unique index RANKING_PK on RANKING (
IDRANKING ASC
);

--==============================================================
-- Index: RELATIONSHIP_25_FK
--==============================================================
create  index RELATIONSHIP_25_FK on RANKING (
IDLISTAREPRODUCCION ASC
);

--==============================================================
-- Table: REPRODUCCIONPORLISTA
--==============================================================
create table REPRODUCCIONPORLISTA (
IDREPRODUCCION       INTEGER              not null,
IDLISTAREPRODUCCION  INTEGER,
CONTADORREPRODUCCION INTEGER,
FECHAREPRODUCCION    DATE,
primary key (IDREPRODUCCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

--==============================================================
-- Index: REPRODUCCIONPORLISTA_PK
--==============================================================
create unique index REPRODUCCIONPORLISTA_PK on REPRODUCCIONPORLISTA (
IDREPRODUCCION ASC
);

--==============================================================
-- Index: RELATIONSHIP_24_FK
--==============================================================
create  index RELATIONSHIP_24_FK on REPRODUCCIONPORLISTA (
IDLISTAREPRODUCCION ASC
);

--==============================================================
-- Table: SIGUE
--==============================================================
create table SIGUE (
IDARTISTA            INTEGER              not null,
IDCU                 INTEGER              not null,
primary key (IDARTISTA, IDCU),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

--==============================================================
-- Index: SIGUE_PK
--==============================================================
create unique index SIGUE_PK on SIGUE (
IDARTISTA ASC,
IDCU ASC
);

--==============================================================
-- Index: SIGUE2_FK
--==============================================================
create  index SIGUE2_FK on SIGUE (
IDCU ASC
);

--==============================================================
-- Index: SUSCRIPCION_PK
--==============================================================
create unique index SUSCRIPCION_PK on SUSCRIPCION (
IDSUSCRIPCION ASC
);

--==============================================================
-- Table: TIENE
--==============================================================
create table TIENE (
IDLISTAREPRODUCCION  INTEGER              not null,
IDCANCION            INTEGER              not null,
primary key (IDLISTAREPRODUCCION, IDCANCION),
foreign key (IDCANCION)
      references CANCION (IDCANCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

--==============================================================
-- Index: TIENE8_PK
--==============================================================
create unique index TIENE8_PK on TIENE (
IDLISTAREPRODUCCION ASC,
IDCANCION ASC
);

--==============================================================
-- Index: TIENE9_FK
--==============================================================
create  index TIENE9_FK on TIENE (
IDCANCION ASC
);

