CREATE TABLE clique.kompositionen
(
	id SERIAL NOT NULL,
	titel CHARACTER VARYING(120),
	datum DATE,
	verlag_id INTEGER,
	werk_id INTEGER,
	autor_id INTEGER,
	CONSTRAINT pk_kompositionen PRIMARY KEY (id)
);

CREATE TABLE clique.autoren
(
	id SERIAL NOT NULL,
	name CHARACTER VARYING(80) NOT NULL ,
	vorname CHARACTER VARYING(40) NOT NULL,
	CONSTRAINT pk_autoren PRIMARY KEY (id)
);

CREATE TABLE clique.skizzen
(
	id SERIAL NOT NULL,
	url CHARACTER VARYING(180) ,
	autor_id INTEGER ,
	werk_id INTEGER ,
	vers_nr CHARACTER VARYING ,
	rhytmus_gerade BOOL ,
	rhythmus_ungerade BOOL ,
	rhythmus_gemischt BOOL ,
	rhythmus_bemerkungen CHARACTER VARYING,
	CONSTRAINT pk_skizzen PRIMARY KEY (id)
);

CREATE TABLE clique.verlage
(
	id SERIAL NOT NULL,
	name CHARACTER VARYING,
	ort CHARACTER VARYING,
	CONSTRAINT pk_verlage PRIMARY KEY (id)
);

CREATE TABLE clique.werke
(
	id SERIAL NOT NULL,
	titel CHARACTER VARYING(120) NOT NULL ,
	verlag_id INTEGER,
	CONSTRAINT pk_werke PRIMARY KEY (id)
);


CREATE VIEW clique.v_kompositionen AS
	SELECT *
	FROM clique.kompositionen
	ORDER BY titel;

CREATE VIEW clique.v_personen AS
	SELECT *
	FROM clique.personen
	ORDER BY name, vorname;

CREATE VIEW clique.v_skizzen AS
	SELECT *
	FROM clique.skizzen
	ORDER BY id;

CREATE VIEW clique.v_verlage AS
	SELECT *
	FROM clique.verlage
	ORDER BY name;

CREATE VIEW clique.v_werke AS
	SELECT *
	FROM clique.werke
	ORDER BY titel;
