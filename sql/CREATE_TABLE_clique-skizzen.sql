-- Table: clique.skizzen

-- DROP TABLE clique.skizzen;

CREATE TABLE clique.skizzen
(
  id serial NOT NULL,
  url character varying(180),
  autor_id integer,
  werk_id integer,
  vers_nr character varying,
  rhytmus_gerade boolean,
  rhythmus_ungerade boolean,
  rhythmus_gemischt boolean,
  rhythmus_bemerkungen character varying,
  copyright_datum date,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_skizzen PRIMARY KEY (id),
  CONSTRAINT fk_skizze_autor_id FOREIGN KEY (autor_id)
		REFERENCES clique.autoren (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT kf_skizze_werk_id FOREIGN KEY (werk_id)
		REFERENCES clique.werke (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.skizzen
  OWNER TO postgres;
GRANT ALL ON TABLE clique.skizzen TO postgres;
GRANT ALL ON TABLE clique.skizzen TO clique_admins;

-- Index: clique.fki_skizze_autor_id

-- DROP INDEX clique.fki_skizze_autor_id;

CREATE INDEX fki_skizze_autor_id
  ON clique.skizzen
  USING btree
  (autor_id);

-- Index: clique.fki_skizze_werk_id

-- DROP INDEX clique.fki_skizze_werk_id;

CREATE INDEX fki_skizze_werk_id
  ON clique.skizzen
  USING btree
  (werk_id);


-- Trigger: update_skizzen_rec_last_updated on clique.skizzen

-- DROP TRIGGER update_skizzen_rec_last_updated ON clique.skizzen;

CREATE TRIGGER update_skizzen_rec_last_updated
  BEFORE UPDATE
  ON clique.skizzen
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();

