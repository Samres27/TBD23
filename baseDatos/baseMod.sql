drop index IF  EXISTS ACCEDE2_FK;

drop index IF  EXISTS ACCEDE_PK;

drop table IF  EXISTS ACCEDE;

drop index IF  EXISTS ALBUM_FK;

drop index IF  EXISTS ALBUM_PK;

drop table IF  EXISTS ALBUM;

drop index IF  EXISTS RELATIONSHIP_32_FK;

drop index IF  EXISTS RELATIONSHIP_20_FK;

drop index IF  EXISTS ARTISTA_PK;

drop table IF  EXISTS ARTISTA;

drop index IF  EXISTS RELATIONSHIP_22_FK;

drop index IF  EXISTS RELATIONSHIP_21_FK;

drop index IF  EXISTS AUTOR_PK;

drop table IF  EXISTS AUTOR;

drop index IF  EXISTS TIENE3_FK;

drop index IF  EXISTS CAMBIOCATEGORIA_PK;

drop table IF  EXISTS CAMBIOCATEGORIA;

drop index IF  EXISTS CANCIONES_FK;

drop index IF  EXISTS CANCION_PK;

drop table IF  EXISTS CANCION;

drop index IF  EXISTS TIENE4_FK;

drop index IF  EXISTS CATEGORIA_FK;

drop index IF  EXISTS CATEGORIA_PK;

drop table IF  EXISTS CATEGORIA;

drop index IF  EXISTS RELATIONSHIP_18_FK;

drop index IF  EXISTS CIUDAD_PK;

drop table IF  EXISTS CIUDAD;

drop index IF  EXISTS CLIENTE_PK;

drop table IF  EXISTS CLIENTE;

drop index IF  EXISTS RELATIONSHIP_31_FK;

drop index IF  EXISTS CUENTAUSUARIO_PK;

drop table IF  EXISTS CUENTAUSUARIO;

drop index IF  EXISTS EMPRESAPRODUCTORA_PK;

drop table IF  EXISTS EMPRESAPRODUCTORA;

drop index IF  EXISTS RELATIONSHIP_17_FK;

drop index IF  EXISTS EVENTO_PK;

drop table IF  EXISTS EVENTO;

drop index IF  EXISTS TIENE_FK;

drop index IF  EXISTS TIENE2_FK;

drop index IF  EXISTS EXPERIENCIA_PK;

drop table IF  EXISTS EXPERIENCIA;

drop index IF  EXISTS TIENE6_FK;

drop index IF  EXISTS TIENE5_FK;

drop index IF  EXISTS FINANCIA_PK;

drop table IF  EXISTS FINANCIA;

drop index IF  EXISTS GRUPOMUSICAL_PK;

drop table IF  EXISTS GRUPOMUSICAL;

drop index IF  EXISTS HABILIDAD_PK;

drop table IF  EXISTS HABILIDAD;

drop index IF  EXISTS CREA_FK;

drop index IF  EXISTS LISTAREPRODUCCION_PK;

drop table IF  EXISTS LISTAREPRODUCCION;

drop index IF  EXISTS TIENE7_FK;

drop index IF  EXISTS RELATIONSHIP_16_FK;

drop index IF  EXISTS PREMIOC_FK;

drop index IF  EXISTS PREMIOA_FK;

drop index IF  EXISTS NOMINADO_PK;

drop table IF  EXISTS NOMINADO;

drop index IF  EXISTS RELATIONSHIP_29_FK;

drop index IF  EXISTS RELATIONSHIP_28_FK;

drop index IF  EXISTS OFERTA_PK;

drop table IF  EXISTS OFERTA;

drop index IF  EXISTS PAIS_PK;

drop table IF  EXISTS PAIS;

drop index IF  EXISTS RELATIONSHIP_30_FK;

drop index IF  EXISTS PLANDEPAGOS_PK;

drop table IF  EXISTS PLANDEPAGOS;

drop index IF  EXISTS RELATIONSHIP_25_FK;

drop index IF  EXISTS RANKING_PK;

drop table IF  EXISTS RANKING;

drop index IF  EXISTS RELATIONSHIP_24_FK;

drop index IF  EXISTS REPRODUCCIONPORLISTA_PK;

drop table IF  EXISTS REPRODUCCIONPORLISTA;

drop index IF  EXISTS SIGUE2_FK;

drop index IF  EXISTS SIGUE_PK;

drop table IF  EXISTS SIGUE;

drop index IF  EXISTS SUSCRIPCION_PK;

drop table IF  EXISTS SUSCRIPCION;

drop index IF  EXISTS TIENE9_FK;

drop index IF  EXISTS TIENE8_PK;

drop table IF  EXISTS TIENE;

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
IDPAIS        INTEGER not null,
NOMBREPAIS           VARCHAR(32),
CONTINENTE           VARCHAR(32),
primary key (IDPAIS)
);

create table CIUDAD (
IDCIUDAD       INTEGER not null,
NOMBRECIUDAD         VARCHAR(32),
NOMBREPAIS           VARCHAR(32),
FECHAFUNDACIONC      DATE,
primary key (IDCIUDAD),
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
IDCATEGORIA INTEGER not null,
NOMBRECATEGORIA      VARCHAR(32),
IDARTISTA            INTEGER,
FECHACAMBIO          DATE,
DESCRIPCIONCATEGORIA VARCHAR(256)                   not null,
primary key (IDCATEGORIA),
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
LETRAAUTOR           VARCHAR(32),
MUSICAAUTOR          CHAR(32),
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

create  index CATEGORIA_PK on CATEGORIA (
NOMBRECATEGORIA ASC
);

create  index CATEGORIA_FK on CATEGORIA (
IDARTISTA ASC
);

create  index TIENE4_FK on CATEGORIA (
FECHACAMBIO ASC
);

create index CIUDAD_PK on CIUDAD (
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
NOMBREEVENTO         VARCHAR(32),
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
IDEXPERIENCIA        INTEGER not null,
NIVEL                VARCHAR(32)                    not null,
NOMBREHABILIDAD      VARCHAR(32),
IDARTISTA            INTEGER,
primary key (IDEXPERIENCIA),
foreign key (NOMBREHABILIDAD)
      references HABILIDAD (NOMBREHABILIDAD),
foreign key (IDARTISTA)
      references ARTISTA (IDARTISTA)
);

create  index EXPERIENCIA_PK on EXPERIENCIA (
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

create  index FINANCIA_PK on FINANCIA (
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
FORMAPAGOSUSP        VARCHAR(32),
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

create index PAIS_PK on PAIS (
NOMBREPAIS ASC
);

create table PLANDEPAGOS (
IDPLANDEPAGOS        INTEGER not null,
FECHADEPAGO          DATE          ,                 
IDSUSCRIPCION        INTEGER,
FECHAREALPAGO        DATE,
FORMAPAGO            VARCHAR(32),
MONTO                VARCHAR(32),
primary key (IDPLANDEPAGOS),
foreign key (IDSUSCRIPCION)
      references SUSCRIPCION (IDSUSCRIPCION)
);

create  index PLANDEPAGOS_PK on PLANDEPAGOS (
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

create table IF NOT EXISTS BITACORAPLANDEPAGOS (
IDBPP       INTEGER not null,
OLD_ID INT,
NEW_ID INT,
OLD_FECHADEPAGO          DATE,                 
OLD_IDSUSCRIPCION        INTEGER,
OLD_FECHAREALPAGO        DATE,
OLD_FORMAPAGO            VARCHAR(32),
OLD_MONTO                VARCHAR(32),
accion                   VARCHAR(32),
fechaMod                 VARCHAR(20),   
primary key (IDBPP)
);


create trigger IF NOT EXISTS bitacora_after_update_plandepagos
      after update on PLANDEPAGOS
      WHEN OLD.FECHADEPAGO <> new.FECHADEPAGO
      or old.FORMAPAGO <> new.FORMAPAGO
      or old.MONTO <> new.MONTO
      or old.FECHAREALPAGO <> new.FECHAREALPAGO
begin 
      INSERT into BITACORAPLANDEPAGOS(
            OLD_ID,
            NEW_ID,
            OLD_FECHADEPAGO,                 
            OLD_IDSUSCRIPCION,
            OLD_FECHAREALPAGO,
            OLD_FORMAPAGO,
            OLD_MONTO,
            accion,
            fechaMod   
      )

      VALUES
      (
            old.IDPLANDEPAGOS,
            new.IDPLANDEPAGOS,
            old.FECHADEPAGO,
            old.IDSUSCRIPCION,
            old.FECHAREALPAGO,
            old.FORMAPAGO,
            old.MONTO,
            'UPDATE',
            datetime('now')
      );
end;


create trigger IF NOT EXISTS bitacora_after_update_plandepagos
      after insert on SUSCRIPCION
      WHEN FORMAPAGOSUSP =='contado'
begin 
      update  SUSCRIPCION
            
      set PRECIOSUSCRIPCION =PRECIOSUSCRIPCION*0.9;

      
end;
