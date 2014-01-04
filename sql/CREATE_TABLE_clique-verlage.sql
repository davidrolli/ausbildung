-- Table: clique.verlage

-- DROP TABLE clique.verlage;

CREATE TABLE clique.verlage
(
  id serial NOT NULL,
  name character varying,
  ort character varying,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_verlage PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.verlage
  OWNER TO postgres;
GRANT ALL ON TABLE clique.verlage TO postgres;
GRANT ALL ON TABLE clique.verlage TO clique_admins;

-- Trigger: update_verlage_rec_last_updated on clique.verlage

-- DROP TRIGGER update_verlage_rec_last_updated ON clique.verlage;

CREATE TRIGGER update_verlage_rec_last_updated
  BEFORE UPDATE
  ON clique.verlage
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();
