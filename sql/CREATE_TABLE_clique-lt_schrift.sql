-- Table: clique.lt_schrift

-- DROP TABLE clique.lt_schrift;

CREATE TABLE clique.lt_schrift
(
  id serial NOT NULL,
  cd integer NOT NULL,
  schriftart character varying(80) NOT NULL,
  CONSTRAINT pk_lt_schrift PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.lt_schrift
  OWNER TO postgres;
