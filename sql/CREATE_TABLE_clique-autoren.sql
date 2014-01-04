-- Table: clique.autoren

-- DROP TABLE clique.autoren;

CREATE TABLE clique.autoren
(
  id serial NOT NULL,
  name character varying(80) NOT NULL,
  vorname character varying(40) NOT NULL,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_autoren PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.autoren
  OWNER TO postgres;
GRANT ALL ON TABLE clique.autoren TO postgres;
GRANT ALL ON TABLE clique.autoren TO clique_admins;

-- Index: clique.idx_skizzen_id

-- DROP INDEX clique.idx_skizzen_id;

CREATE INDEX idx_skizzen_id
  ON clique.autoren
  USING btree
  (id);


-- Trigger: update_autoren_rec_last_updated on clique.autoren

-- DROP TRIGGER update_autoren_rec_last_updated ON clique.autoren;

CREATE TRIGGER update_autoren_rec_last_updated
  BEFORE UPDATE
  ON clique.autoren
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();
