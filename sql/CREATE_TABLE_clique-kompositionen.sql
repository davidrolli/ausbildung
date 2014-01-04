-- Table: clique.kompositionen

-- DROP TABLE clique.kompositionen;

CREATE TABLE clique.kompositionen
(
  id serial NOT NULL,
  titel character varying(120),
  datum date,
  schrift_cd integer NOT NULL DEFAULT 1,
  verlag_id integer,
  werk_id integer,
  autor_id integer,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_kompositionen PRIMARY KEY (id),
  CONSTRAINT fk_komposition_autor_id FOREIGN KEY (autor_id)
      REFERENCES clique.autoren (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_komposition_verlag_id FOREIGN KEY (verlag_id)
      REFERENCES clique.verlage (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_komposition_werk_id FOREIGN KEY (werk_id)
      REFERENCES clique.werke (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.kompositionen
  OWNER TO postgres;
GRANT ALL ON TABLE clique.kompositionen TO postgres;
GRANT ALL ON TABLE clique.kompositionen TO clique_admins;

-- Index: clique.fki_komposition_autor_id

-- DROP INDEX clique.fki_komposition_autor_id;

CREATE INDEX fki_komposition_autor_id
  ON clique.kompositionen
  USING btree
  (autor_id);

-- Index: clique.fki_komposition_verlag_id

-- DROP INDEX clique.fki_komposition_verlag_id;

CREATE INDEX fki_komposition_verlag_id
  ON clique.kompositionen
  USING btree
  (verlag_id);

-- Index: clique.fki_komposition_werk_id

-- DROP INDEX clique.fki_komposition_werk_id;

CREATE INDEX fki_komposition_werk_id
  ON clique.kompositionen
  USING btree
  (werk_id);


-- Trigger: update_kompositionen_rec_last_updated on clique.kompositionen

-- DROP TRIGGER update_kompositionen_rec_last_updated ON clique.kompositionen;

CREATE TRIGGER update_kompositionen_rec_last_updated
  BEFORE UPDATE
  ON clique.kompositionen
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();

