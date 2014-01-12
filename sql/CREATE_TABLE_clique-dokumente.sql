-- Table: clique.dokumente

-- DROP TABLE clique.dokumente;

CREATE TABLE clique.dokumente
(
  id serial NOT NULL,
  titel character varying NOT NULL DEFAULT 'Notenskizze'::character varying,
  url character varying,
  autor_id integer,
  datum date,
  werk_id integer,
  verlag_id integer,
  notenschrift_cd integer NOT NULL DEFAULT 1,
  vers_nr character varying,
  rhythmus_gerade boolean,
  rhythmus_ungerade boolean,
  rhythmus_gemischt boolean,
  rhythmus_bemerkungen character varying,
  bemerkungen text,
  copyright_datum date,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_dokumente PRIMARY KEY (id),
  CONSTRAINT fk_dokument_autor_id FOREIGN KEY (autor_id)
		REFERENCES clique.autoren (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_dokument_verlag_id FOREIGN KEY (verlag_id)
		REFERENCES clique.verlage (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_dokument_werk_id FOREIGN KEY (werk_id)
		REFERENCES clique.werke (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.dokumente
  OWNER TO postgres;
GRANT ALL ON TABLE clique.dokumente TO postgres;
GRANT ALL ON TABLE clique.dokumente TO clique_admin_group;

-- Index: clique.fki_dokument_autor_id

-- DROP INDEX clique.fki_dokument_autor_id;

CREATE INDEX fki_dokument_autor_id
  ON clique.dokumente
  USING btree
  (autor_id);

-- Index: clique.fki_dokument_verlag_id

-- DROP INDEX clique.fki_dokument_verlag_id;

CREATE INDEX fki_dokument_verlag_id
  ON clique.dokumente
  USING btree
  (verlag_id);

-- Index: clique.fki_dokument_werk_id

-- DROP INDEX clique.fki_dokument_werk_id;

CREATE INDEX fki_dokument_werk_id
  ON clique.dokumente
  USING btree
  (werk_id);

-- Index: clique.idx_datum

-- DROP INDEX clique.idx_datum;

CREATE INDEX idx_datum
  ON clique.dokumente
  USING btree
  (datum);

-- Index: clique.idx_notenschrift_cd

-- DROP INDEX clique.idx_notenschrift_cd;

CREATE INDEX idx_notenschrift_cd
  ON clique.dokumente
  USING btree
  (notenschrift_cd);

-- Index: clique.idx_rhythmus_gemischt

-- DROP INDEX clique.idx_rhythmus_gemischt;

CREATE INDEX idx_rhythmus_gemischt
  ON clique.dokumente
  USING btree
  (rhythmus_gemischt);

-- Index: clique.idx_rhythmus_gerade

-- DROP INDEX clique.idx_rhythmus_gerade;

CREATE INDEX idx_rhythmus_gerade
  ON clique.dokumente
  USING btree
  (rhythmus_gerade);

-- Index: clique.idx_rhythmus_ungerade

-- DROP INDEX clique.idx_rhythmus_ungerade;

CREATE INDEX idx_rhythmus_ungerade
  ON clique.dokumente
  USING btree
  (rhythmus_ungerade);


-- Trigger: update_dokumente_rec_last_updated on clique.dokumente

-- DROP TRIGGER update_dokumente_rec_last_updated ON clique.dokumente;

CREATE TRIGGER update_dokumente_rec_last_updated
  BEFORE UPDATE
  ON clique.dokumente
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();

