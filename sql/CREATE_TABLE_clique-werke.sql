-- Table: clique.werke

-- DROP TABLE clique.werke;

CREATE TABLE clique.werke
(
  id serial NOT NULL,
  titel character varying(120) NOT NULL,
  verlag_id integer,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_werke PRIMARY KEY (id),
  CONSTRAINT fk_werk_verlag_id FOREIGN KEY (verlag_id)
		REFERENCES clique.verlage (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.werke
  OWNER TO postgres;
GRANT ALL ON TABLE clique.werke TO postgres;
GRANT ALL ON TABLE clique.werke TO clique_admins;

-- Index: clique.fki_werk_verlag_id

-- DROP INDEX clique.fki_werk_verlag_id;

CREATE INDEX fki_werk_verlag_id
  ON clique.werke
  USING btree
  (verlag_id);


-- Trigger: update_werke_rec_last_updated on clique.werke

-- DROP TRIGGER update_werke_rec_last_updated ON clique.werke;

CREATE TRIGGER update_werke_rec_last_updated
  BEFORE UPDATE
  ON clique.werke
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();
