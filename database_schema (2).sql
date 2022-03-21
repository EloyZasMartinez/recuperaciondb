CREATE SCHEMA horns_legend;

CREATE TABLE horns_legend.capitulos ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	cuando               varchar(100)      ,
	orden                tinyint UNSIGNED     
 );

CREATE TABLE horns_legend.caracteristicas_rol ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	fuerza               int UNSIGNED     ,
	destreza             int UNSIGNED     ,
	constitucion         int UNSIGNED     ,
	inteligencia         int UNSIGNED     ,
	sabiduria            int UNSIGNED     ,
	carisma              int UNSIGNED     
 );

CREATE TABLE horns_legend.carasteristicas_fisicas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	altura               int UNSIGNED     ,
	peso                 int UNSIGNED     ,
	genero               int UNSIGNED  DEFAULT 0   
 );

ALTER TABLE horns_legend.carasteristicas_fisicas MODIFY genero int UNSIGNED  DEFAULT 0  COMMENT '0 - masculino.\n1 - femenino.\n2 - otros';

CREATE TABLE horns_legend.habilidades ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	descripcion          varchar(250)      
 );

CREATE TABLE horns_legend.languages ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	code                 varchar(3)  NOT NULL    ,
	label                varchar(100)  NOT NULL    
 );

CREATE TABLE horns_legend.lugares ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	descripcion          text      
 );

CREATE TABLE horns_legend.persona ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apellidos            varchar(150)  NOT NULL    ,
	apodo                varchar(150)      
 );

CREATE TABLE horns_legend.raza ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE horns_legend.tipo_relacion ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE horns_legend.trabajo ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    
 );

CREATE TABLE horns_legend.anecdotas ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	titulo               varchar(150)  NOT NULL    ,
	description          text      ,
	id_persona           int UNSIGNED     ,
	cuando               timestamp  NOT NULL DEFAULT current_timestamp()   
 );

CREATE INDEX fk_anecdotas_persona ON horns_legend.anecdotas ( id_persona );

CREATE TABLE horns_legend.capitulos_cuerpo ( 
	id_capitulo          int UNSIGNED NOT NULL    ,
	id_language          int UNSIGNED NOT NULL    ,
	cuerpo               text      ,
	CONSTRAINT pk_capitulos_cuerpo PRIMARY KEY ( id_capitulo, id_language )
 );

CREATE INDEX fk_capitulos_cuerpo_languages ON horns_legend.capitulos_cuerpo ( id_language );

CREATE TABLE horns_legend.mn_anecdota_capitulo ( 
	id_anecdota          int UNSIGNED     ,
	id_capitulo          int UNSIGNED     ,
	CONSTRAINT idx_mn_anecdota_capitulo UNIQUE ( id_anecdota, id_capitulo ) 
 );

CREATE INDEX fk_mn_personaje_anectdota_0_capitulos ON horns_legend.mn_anecdota_capitulo ( id_capitulo );

CREATE INDEX fk_mn_personaje_anectdota_anecdotas_0 ON horns_legend.mn_anecdota_capitulo ( id_anecdota );

CREATE TABLE horns_legend.mn_anecdotas_relacionadas ( 
	id_anecdota          int UNSIGNED     ,
	id_relacionada       int UNSIGNED     ,
	CONSTRAINT idx_mn_anecdotas_relacionadas UNIQUE ( id_anecdota, id_relacionada ) 
 );

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas ON horns_legend.mn_anecdotas_relacionadas ( id_anecdota );

CREATE INDEX fk_mn_anecdotas_relacionadas_anecdotas_0 ON horns_legend.mn_anecdotas_relacionadas ( id_relacionada );

CREATE TABLE horns_legend.mn_lugares_anecdota ( 
	id_lugar             int UNSIGNED     ,
	id_anecdota          int UNSIGNED     ,
	CONSTRAINT idx_mn_lugares_anecdota UNIQUE ( id_lugar, id_anecdota ) 
 );

CREATE INDEX fk_mn_lugares_anecdota_anecdotas ON horns_legend.mn_lugares_anecdota ( id_anecdota );

CREATE INDEX fk_mn_lugares_anecdota_lugares ON horns_legend.mn_lugares_anecdota ( id_lugar );

CREATE TABLE horns_legend.personaje ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nombre               varchar(150)  NOT NULL    ,
	apodo                varchar(100)      ,
	id_raza              int UNSIGNED     ,
	id_trabajo           int UNSIGNED     ,
	edad                 int UNSIGNED     ,
	id_persona           int UNSIGNED     ,
	descripcion          text      ,
	id_fisicas           int UNSIGNED     ,
	id_rol               int UNSIGNED     
 );

CREATE INDEX fk_personaje_caracteristicas_rol ON horns_legend.personaje ( id_rol );

CREATE INDEX fk_personaje_carasteristicas_fisicas ON horns_legend.personaje ( id_fisicas );

CREATE INDEX fk_personaje_persona ON horns_legend.personaje ( id_persona );

CREATE INDEX fk_personaje_raza ON horns_legend.personaje ( id_raza );

CREATE INDEX fk_personaje_trabajo ON horns_legend.personaje ( id_trabajo );

CREATE TABLE horns_legend.relacion ( 
	id_personaje         int UNSIGNED     ,
	id_relacionado       int UNSIGNED     ,
	id_tipo_relacion     int UNSIGNED     ,
	CONSTRAINT idx_relacion UNIQUE ( id_personaje, id_relacionado ) 
 );

CREATE INDEX fk_mn_personaje_personaje_personaje ON horns_legend.relacion ( id_personaje );

CREATE INDEX fk_mn_personaje_personaje_personaje_0 ON horns_legend.relacion ( id_relacionado );

CREATE INDEX fk_relacion_tipo_relacion ON horns_legend.relacion ( id_tipo_relacion );

CREATE TABLE horns_legend.mn_habilidad_personaje ( 
	id_personaje         int UNSIGNED     ,
	id_habilidad         int UNSIGNED     
 );

CREATE INDEX fk_mn_habilidad_personaje_habilidades ON horns_legend.mn_habilidad_personaje ( id_habilidad );

CREATE INDEX fk_mn_habilidad_personaje_personaje ON horns_legend.mn_habilidad_personaje ( id_personaje );

CREATE TABLE horns_legend.mn_personaje_anectdota ( 
	id_anecdota          int UNSIGNED     ,
	id_personaje         int UNSIGNED     ,
	CONSTRAINT idx_mn_personaje_anectdota UNIQUE ( id_anecdota, id_personaje ) 
 );

CREATE INDEX fk_mn_personaje_anectdota_anecdotas ON horns_legend.mn_personaje_anectdota ( id_anecdota );

CREATE INDEX fk_mn_personaje_anectdota_personaje ON horns_legend.mn_personaje_anectdota ( id_personaje );

CREATE TABLE horns_legend.mn_personaje_capitulo ( 
	id_capitulo          int UNSIGNED     ,
	id_personaje         int UNSIGNED     
 );

CREATE INDEX fk_mn_personaje_anectdota_personaje_0 ON horns_legend.mn_personaje_capitulo ( id_personaje );

CREATE INDEX fk_mn_personaje_capitulo_capitulos ON horns_legend.mn_personaje_capitulo ( id_capitulo );

CREATE VIEW horns_legend.lista_datos_capitulo AS select `c`.`id` AS `id`,`c`.`titulo` AS `titulo`,`c`.`description` AS `description`,`c`.`cuando` AS `cuando`,`c`.`orden` AS `orden`,`cc`.`cuerpo` AS `cuerpo`,`l`.`code` AS `code` from ((`horns_legend`.`capitulos` `c` join `horns_legend`.`capitulos_cuerpo` `cc` on(`c`.`id` = `cc`.`id_capitulo`)) join `horns_legend`.`languages` `l` on(`l`.`id` = `cc`.`id_language`));

CREATE VIEW horns_legend.lista_personajes AS select `per`.`id` AS `id`,`per`.`nombre` AS `nombre`,`r`.`nombre` AS `raza`,`p`.`nombre` AS `persona` from ((`horns_legend`.`personaje` `per` join `horns_legend`.`persona` `p` on(`per`.`id_persona` = `p`.`id`)) join `horns_legend`.`raza` `r` on(`per`.`id_raza` = `r`.`id`));

CREATE VIEW horns_legend.lugaresrepetidos AS select `l`.`id` AS `id`,`l`.`nombre` AS `nombre`,`l`.`descripcion` AS `descripcion` from (`horns_legend`.`mn_lugares_anecdota` `mn` join `horns_legend`.`lugares` `l` on(`l`.`id` = `mn`.`id_lugar`)) where `mn`.`id_lugar` <> 0 group by `mn`.`id_lugar` having count(`mn`.`id_anecdota`) > 1 order by count(`mn`.`id_anecdota`) desc;

CREATE VIEW horns_legend.nextid AS select 1 + max(`horns_legend`.`languages`.`id`) AS `next_id` from `horns_legend`.`languages`;

CREATE TRIGGER insert_pj BEFORE INSERT ON personaje FOR EACH ROW SET NEW.nombre = UPPER(NEW.nombre);

ALTER TABLE horns_legend.anecdotas ADD CONSTRAINT fk_anecdotas_persona FOREIGN KEY ( id_persona ) REFERENCES horns_legend.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE horns_legend.capitulos_cuerpo ADD CONSTRAINT fk_capitulos_cuerpo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES horns_legend.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.capitulos_cuerpo ADD CONSTRAINT fk_capitulos_cuerpo_languages FOREIGN KEY ( id_language ) REFERENCES horns_legend.languages( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_0_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES horns_legend.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_anecdota_capitulo ADD CONSTRAINT fk_mn_anecdota_capitulo_anecdotas FOREIGN KEY ( id_anecdota ) REFERENCES horns_legend.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas_1 FOREIGN KEY ( id_anecdota ) REFERENCES horns_legend.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_anecdotas_relacionadas ADD CONSTRAINT fk_mn_anecdotas_relacionadas_anecdotas_2 FOREIGN KEY ( id_relacionada ) REFERENCES horns_legend.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_habilidades FOREIGN KEY ( id_habilidad ) REFERENCES horns_legend.habilidades( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_habilidad_personaje ADD CONSTRAINT fk_mn_habilidad_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES horns_legend.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_lugares FOREIGN KEY ( id_lugar ) REFERENCES horns_legend.lugares( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_lugares_anecdota ADD CONSTRAINT fk_mn_lugares_anecdota_anecdotas_0 FOREIGN KEY ( id_anecdota ) REFERENCES horns_legend.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_personaje FOREIGN KEY ( id_personaje ) REFERENCES horns_legend.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_personaje_anectdota ADD CONSTRAINT fk_mn_personaje_anectdota_anecdotas_1 FOREIGN KEY ( id_anecdota ) REFERENCES horns_legend.anecdotas( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_capitulo_capitulos FOREIGN KEY ( id_capitulo ) REFERENCES horns_legend.capitulos( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.mn_personaje_capitulo ADD CONSTRAINT fk_mn_personaje_anectdota_personaje_0 FOREIGN KEY ( id_personaje ) REFERENCES horns_legend.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.personaje ADD CONSTRAINT fk_personaje_caracteristicas_rol FOREIGN KEY ( id_rol ) REFERENCES horns_legend.caracteristicas_rol( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE horns_legend.personaje ADD CONSTRAINT fk_personaje_carasteristicas_fisicas FOREIGN KEY ( id_fisicas ) REFERENCES horns_legend.carasteristicas_fisicas( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE horns_legend.personaje ADD CONSTRAINT fk_personaje_persona FOREIGN KEY ( id_persona ) REFERENCES horns_legend.persona( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE horns_legend.personaje ADD CONSTRAINT fk_personaje_raza FOREIGN KEY ( id_raza ) REFERENCES horns_legend.raza( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE horns_legend.personaje ADD CONSTRAINT fk_personaje_trabajo FOREIGN KEY ( id_trabajo ) REFERENCES horns_legend.trabajo( id ) ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE horns_legend.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje FOREIGN KEY ( id_personaje ) REFERENCES horns_legend.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.relacion ADD CONSTRAINT fk_mn_personaje_personaje_personaje_0 FOREIGN KEY ( id_relacionado ) REFERENCES horns_legend.personaje( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE horns_legend.relacion ADD CONSTRAINT fk_relacion_tipo_relacion FOREIGN KEY ( id_tipo_relacion ) REFERENCES horns_legend.tipo_relacion( id ) ON DELETE CASCADE ON UPDATE NO ACTION;

