drop index ACCEDE2_FK;

drop index ACCEDE_PK;

drop table ACCEDE;

drop index ALBUM_FK;

drop index ALBUM_PK;

drop table ALBUM;

drop index RELATIONSHIP_32_FK;

drop index RELATIONSHIP_20_FK;

drop index ARTISTA_PK;

drop table ARTISTA;

drop index RELATIONSHIP_22_FK;

drop index RELATIONSHIP_21_FK;

drop index AUTOR_PK;

drop table AUTOR;

drop index TIENE3_FK;

drop index CAMBIOCATEGORIA_PK;

drop table CAMBIOCATEGORIA;

drop index CANCIONES_FK;

drop index CANCION_PK;

drop table CANCION;

drop index TIENE4_FK;

drop index CATEGORIA_FK;

drop index CATEGORIA_PK;

drop table CATEGORIA;

drop index RELATIONSHIP_18_FK;

drop index CIUDAD_PK;

drop table CIUDAD;

drop index CLIENTE_PK;

drop table CLIENTE;

drop index RELATIONSHIP_31_FK;

drop index CUENTAUSUARIO_PK;

drop table CUENTAUSUARIO;

drop index EMPRESAPRODUCTORA_PK;

drop table EMPRESAPRODUCTORA;

drop index RELATIONSHIP_17_FK;

drop index EVENTO_PK;

drop table EVENTO;

drop index TIENE_FK;

drop index TIENE2_FK;

drop index EXPERIENCIA_PK;

drop table EXPERIENCIA;

drop index TIENE6_FK;

drop index TIENE5_FK;

drop index FINANCIA_PK;

drop table FINANCIA;

drop index GRUPOMUSICAL_PK;

drop table GRUPOMUSICAL;

drop index HABILIDAD_PK;

drop table HABILIDAD;

drop index CREA_FK;

drop index LISTAREPRODUCCION_PK;

drop table LISTAREPRODUCCION;

drop index TIENE7_FK;

drop index RELATIONSHIP_16_FK;

drop index PREMIOC_FK;

drop index PREMIOA_FK;

drop index NOMINADO_PK;

drop table NOMINADO;

drop index RELATIONSHIP_29_FK;

drop index RELATIONSHIP_28_FK;

drop index OFERTA_PK;

drop table OFERTA;

drop index PAIS_PK;

drop table PAIS;

drop index RELATIONSHIP_30_FK;

drop index PLANDEPAGOS_PK;

drop table PLANDEPAGOS;

drop index RELATIONSHIP_25_FK;

drop index RANKING_PK;

drop table RANKING;

drop index RELATIONSHIP_24_FK;

drop index REPRODUCCIONPORLISTA_PK;

drop table REPRODUCCIONPORLISTA;

drop index SIGUE2_FK;

drop index SIGUE_PK;

drop table SIGUE;

drop index SUSCRIPCION_PK;

drop table SUSCRIPCION;

drop index TIENE9_FK;

drop index TIENE8_PK;

drop table TIENE;

create table CLIENTE (
IDCLIENTE            INTEGER                        not null,
NOMBRECLIENTE        VARCHAR(32),
FECHANACIMIENTOC     DATE,
PAISCLIENTE          VARCHAR(32),
CIUDADCLIENTE        VARCHAR(32),
CORREOELECTRONICOC   VARCHAR(32),
GENEROFAVORIITOC_    VARCHAR(84),
primary key (IDCLIENTE)
);

create table CUENTAUSUARIO (
IDCU                 INTEGER                        not null,
IDCLIENTE            INTEGER,
LOGINCU              VARCHAR(32),
PASSWORDCU           VARCHAR(32),
FECHACREACIONCU      DATE,
FECHACAMBIOPASSCU    DATE,
primary key (IDCU),
foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE)
);

create table LISTAREPRODUCCION (
IDLISTAREPRODUCCION  INTEGER                        not null,
IDCU                 INTEGER,
NOMBRELISTAREPRODUCCION VARCHAR(31),
FECHACREACION        DATE,
FECHAELIMINACION     DATE,
NROREPRODUCCIONESL   INTEGER,
primary key (IDLISTAREPRODUCCION),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU)
);

create table ACCEDE (
IDCU                 INTEGER                        not null,
IDLISTAREPRODUCCION  INTEGER                        not null,
primary key (IDCU, IDLISTAREPRODUCCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU)
);

create unique index ACCEDE_PK on ACCEDE (
IDCU ASC,
IDLISTAREPRODUCCION ASC
);

create  index ACCEDE2_FK on ACCEDE (
IDLISTAREPRODUCCION ASC
);

create table PAIS (
NOMBREPAIS           VARCHAR(32)                    not null,
CONTINENTE           VARCHAR(32),
primary key (NOMBREPAIS)
);

create table CIUDAD (
NOMBRECIUDAD         VARCHAR(32)                    not null,
NOMBREPAIS           VARCHAR(32),
FECHAFUNDACIONC      DATE,
primary key (NOMBRECIUDAD),
foreign key (NOMBREPAIS)
      references PAIS (NOMBREPAIS)
);

create table GRUPOMUSICAL (
IDGRUPO              INTEGER                        not null,
NOMBREGRUPO          VARCHAR(32),
GENEROMUSICAL        VARCHAR(32),
FECHADEAGRUPACION    DATE,
primary key (IDGRUPO)
);

create table ARTISTA (
IDARTISTA            INTEGER                        not null,
NOMBRECIUDAD         VARCHAR(32),
IDGRUPO              INTEGER,
NOMBREARTISTA        VARCHAR(32)                    not null,
NOMBREREAL           VARCHAR(32)                    not null,
FECHANACIMIENTOA     DATE                           not null,
PAISARTISTA          VARCHAR(32)                    not null,
ROLARTISTA           VARCHAR(32),
VIGENCIA             SMALLINT,
primary key (IDARTISTA),
foreign key (NOMBRECIUDAD)
      references CIUDAD (NOMBRECIUDAD),
foreign key (IDGRUPO)
      references GRUPOMUSICAL (IDGRUPO)
);

create table CAMBIOCATEGORIA (
FECHACAMBIO          DATE                           not null,
IDARTISTA            INTEGER,
MOTIVODECAMBIO       VARCHAR(256),
primary key (FECHACAMBIO),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

create table CATEGORIA (
NOMBRECATEGORIA      VARCHAR(32)                    not null,
IDARTISTA            INTEGER,
FECHACAMBIO          DATE,
DESCRIPCIONCATEGORIA VARCHAR(256)                   not null,
primary key (NOMBRECATEGORIA),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA),
foreign key (FECHACAMBIO)
      references CAMBIOCATEGORIA (FECHACAMBIO)
);

create table ALBUM (
IDALBUM              INTEGER                        not null,
NOMBRECATEGORIA      VARCHAR(32),
NOMBREALBUM          VARCHAR(32)                    not null,
ANIOESTRENO          DATE                           not null,
primary key (IDALBUM),
foreign key (NOMBRECATEGORIA)
      references CATEGORIA (NOMBRECATEGORIA)
);

create unique index ALBUM_PK on ALBUM (
IDALBUM ASC
);

create  index ALBUM_FK on ALBUM (
NOMBRECATEGORIA ASC
);

create unique index ARTISTA_PK on ARTISTA (
IDARTISTA ASC
);

create  index RELATIONSHIP_20_FK on ARTISTA (
NOMBRECIUDAD ASC
);

create  index RELATIONSHIP_32_FK on ARTISTA (
IDGRUPO ASC
);

create table CANCION (
IDCANCION            INTEGER                        not null,
IDALBUM              INTEGER,
NOMBRECANCION        VARCHAR(32)                    not null,
DURACIONMIN          TIME                           not null,
FORMATO              VARCHAR(32)                    not null,
primary key (IDCANCION),
foreign key (IDALBUM)
      references ALBUM (IDALBUM)
);

create table AUTOR (
NOMBREAUTOR          VARCHAR(32)                    not null,
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

create unique index AUTOR_PK on AUTOR (
NOMBREAUTOR ASC
);

create  index RELATIONSHIP_21_FK on AUTOR (
IDARTISTA ASC
);

create  index RELATIONSHIP_22_FK on AUTOR (
IDCANCION ASC
);

create unique index CAMBIOCATEGORIA_PK on CAMBIOCATEGORIA (
FECHACAMBIO ASC
);

create  index TIENE3_FK on CAMBIOCATEGORIA (
IDARTISTA ASC
);

create unique index CANCION_PK on CANCION (
IDCANCION ASC
);

create  index CANCIONES_FK on CANCION (
IDALBUM ASC
);

create unique index CATEGORIA_PK on CATEGORIA (
NOMBRECATEGORIA ASC
);

create  index CATEGORIA_FK on CATEGORIA (
IDARTISTA ASC
);

create  index TIENE4_FK on CATEGORIA (
FECHACAMBIO ASC
);

create unique index CIUDAD_PK on CIUDAD (
NOMBRECIUDAD ASC
);

create  index RELATIONSHIP_18_FK on CIUDAD (
NOMBREPAIS ASC
);

create unique index CLIENTE_PK on CLIENTE (
IDCLIENTE ASC
);

create unique index CUENTAUSUARIO_PK on CUENTAUSUARIO (
IDCU ASC
);

create  index RELATIONSHIP_31_FK on CUENTAUSUARIO (
IDCLIENTE ASC
);

create table EMPRESAPRODUCTORA (
IDEMPRESA            INTEGER                        not null,
NOMBREEMPRESA        VARCHAR(32),
primary key (IDEMPRESA)
);

create unique index EMPRESAPRODUCTORA_PK on EMPRESAPRODUCTORA (
IDEMPRESA ASC
);

create table EVENTO (
IDEVENTO             INTEGER                        not null,
NOMBRECIUDAD         VARCHAR(32),
NOMBREEVENTO         DATE,
FECHAEVENTO          DATE,
primary key (IDEVENTO),
foreign key (NOMBRECIUDAD)
      references CIUDAD (NOMBRECIUDAD)
);

create unique index EVENTO_PK on EVENTO (
IDEVENTO ASC
);

create  index RELATIONSHIP_17_FK on EVENTO (
NOMBRECIUDAD ASC
);

create table HABILIDAD (
NOMBREHABILIDAD      VARCHAR(32)                    not null,
DESCRIPCIONHABILIDAD VARCHAR(256)                   not null,
primary key (NOMBREHABILIDAD)
);

create table EXPERIENCIA (
NIVEL                VARCHAR(32)                    not null,
NOMBREHABILIDAD      VARCHAR(32),
IDARTISTA            INTEGER,
primary key (NIVEL),
foreign key (NOMBREHABILIDAD)
      references HABILIDAD (NOMBREHABILIDAD),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

create unique index EXPERIENCIA_PK on EXPERIENCIA (
NIVEL ASC
);

create  index TIENE2_FK on EXPERIENCIA (
NOMBREHABILIDAD ASC
);

create  index TIENE_FK on EXPERIENCIA (
IDARTISTA ASC
);

create table FINANCIA (
PRESUPUESTO          INTEGER                        not null,
IDEMPRESA            INTEGER,
IDALBUM              INTEGER,
FECHAINVERSION       DATE,
primary key (PRESUPUESTO),
foreign key (IDALBUM)
      references ALBUM (IDALBUM),
foreign key (IDEMPRESA)
      references EMPRESAPRODUCTORA (IDEMPRESA)
);

create unique index FINANCIA_PK on FINANCIA (
PRESUPUESTO ASC
);

create  index TIENE5_FK on FINANCIA (
IDALBUM ASC
);

create  index TIENE6_FK on FINANCIA (
IDEMPRESA ASC
);

create unique index GRUPOMUSICAL_PK on GRUPOMUSICAL (
IDGRUPO ASC
);

create unique index HABILIDAD_PK on HABILIDAD (
NOMBREHABILIDAD ASC
);

create unique index LISTAREPRODUCCION_PK on LISTAREPRODUCCION (
IDLISTAREPRODUCCION ASC
);

create  index CREA_FK on LISTAREPRODUCCION (
IDCU ASC
);

create table NOMINADO (
IDNOMINADO           INTEGER                        not null,
IDALBUM              INTEGER,
IDEVENTO             INTEGER,
IDARTISTA            INTEGER,
IDCANCION            INTEGER,
TIPONOMINADO         VARCHAR(32)                    not null,
DESCRIPCIONNOMINADO  VARCHAR(256)                   not null,
PREMIADO             SMALLINT                       not null,
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

create unique index NOMINADO_PK on NOMINADO (
IDNOMINADO ASC
);

create  index PREMIOA_FK on NOMINADO (
IDALBUM ASC
);

create  index PREMIOC_FK on NOMINADO (
IDCANCION ASC
);

create  index RELATIONSHIP_16_FK on NOMINADO (
IDEVENTO ASC
);

create  index TIENE7_FK on NOMINADO (
IDARTISTA ASC
);

create table SUSCRIPCION (
IDSUSCRIPCION        INTEGER                        not null,
PRECIOSUSCRIPCION    DECIMAL,
PERIODOSUSCRIP       VARCHAR(18),
FORMAPAGOSUSP        DATE,
FECHAFINSUSP         DATE,
primary key (IDSUSCRIPCION)
);

create table OFERTA (
IDOFERTA             INTEGER                        not null,
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

create unique index OFERTA_PK on OFERTA (
IDOFERTA ASC
);

create  index RELATIONSHIP_28_FK on OFERTA (
IDCU ASC
);

create  index RELATIONSHIP_29_FK on OFERTA (
IDSUSCRIPCION ASC
);

create unique index PAIS_PK on PAIS (
NOMBREPAIS ASC
);

create table PLANDEPAGOS (
FECHADEPAGO          DATE                           not null,
IDSUSCRIPCION        INTEGER,
FECHAREALPAGO        DATE,
FORMAPAGO            VARCHAR(32),
MONTO                VARCHAR(32),
primary key (FECHADEPAGO),
foreign key (IDSUSCRIPCION)
      references SUSCRIPCION (IDSUSCRIPCION)
);

create unique index PLANDEPAGOS_PK on PLANDEPAGOS (
FECHADEPAGO ASC
);

create  index RELATIONSHIP_30_FK on PLANDEPAGOS (
IDSUSCRIPCION ASC
);

create table RANKING (
IDRANKING            INTEGER                        not null,
IDLISTAREPRODUCCION  INTEGER,
NOMBRELISTA          VARCHAR(32),
PUESTO               INTEGER,
PERIODOSEG           INTEGER,
NROREPRODUCCIONESR   INTEGER,
primary key (IDRANKING),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

create unique index RANKING_PK on RANKING (
IDRANKING ASC
);

create  index RELATIONSHIP_25_FK on RANKING (
IDLISTAREPRODUCCION ASC
);

create table REPRODUCCIONPORLISTA (
IDREPRODUCCION       INTEGER                        not null,
IDLISTAREPRODUCCION  INTEGER,
CONTADORREPRODUCCION INTEGER,
FECHAREPRODUCCION    DATE,
primary key (IDREPRODUCCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

create unique index REPRODUCCIONPORLISTA_PK on REPRODUCCIONPORLISTA (
IDREPRODUCCION ASC
);

create  index RELATIONSHIP_24_FK on REPRODUCCIONPORLISTA (
IDLISTAREPRODUCCION ASC
);

create table SIGUE (
IDARTISTA            INTEGER                        not null,
IDCU                 INTEGER                        not null,
primary key (IDARTISTA, IDCU),
foreign key (IDCU)
      references CUENTAUSUARIO (IDCU),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

create unique index SIGUE_PK on SIGUE (
IDARTISTA ASC,
IDCU ASC
);

create  index SIGUE2_FK on SIGUE (
IDCU ASC
);

create unique index SUSCRIPCION_PK on SUSCRIPCION (
IDSUSCRIPCION ASC
);

create table TIENE (
IDLISTAREPRODUCCION  INTEGER                        not null,
IDCANCION            INTEGER                        not null,
primary key (IDLISTAREPRODUCCION, IDCANCION),
foreign key (IDCANCION)
      references CANCION (IDCANCION),
foreign key (IDLISTAREPRODUCCION)
      references LISTAREPRODUCCION (IDLISTAREPRODUCCION)
);

create unique index TIENE8_PK on TIENE (
IDLISTAREPRODUCCION ASC,
IDCANCION ASC
);

create  index TIENE9_FK on TIENE (
IDCANCION ASC
);

