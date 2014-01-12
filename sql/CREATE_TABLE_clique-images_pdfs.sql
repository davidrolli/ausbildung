-- Table: clique.images_pdfs

-- DROP TABLE clique.images_pdfs;

CREATE TABLE clique.images_pdfs
(
  id serial NOT NULL,
  prefix character varying(6),
  img_nr integer NOT NULL,
  img_subnr integer NOT NULL DEFAULT 1,
  doc_extension character varying(5) NOT NULL,
  rec_created timestamp with time zone DEFAULT now(),
  rec_last_updated timestamp with time zone,
  CONSTRAINT pk_id_images_pdfs PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE clique.images_pdfs
  OWNER TO postgres;
GRANT SELECT ON TABLE clique.images_pdfs TO public;
GRANT ALL ON TABLE clique.images_pdfs TO postgres;
GRANT ALL ON TABLE clique.images_pdfs TO clique_admin_group;

-- Index: clique.idx_doc_extension_images_pdfs

-- DROP INDEX clique.idx_doc_extension_images_pdfs;

CREATE INDEX idx_doc_extension_images_pdfs
  ON clique.images_pdfs
  USING btree
  (doc_extension COLLATE pg_catalog."default");

-- Index: clique.idx_id_images_pdfs

-- DROP INDEX clique.idx_id_images_pdfs;

CREATE UNIQUE INDEX idx_id_images_pdfs
  ON clique.images_pdfs
  USING btree
  (id);

-- Index: clique.idx_img_nr_images_pdfs

-- DROP INDEX clique.idx_img_nr_images_pdfs;

CREATE INDEX idx_img_nr_images_pdfs
  ON clique.images_pdfs
  USING btree
  (img_nr);

-- Index: clique.idx_img_subnr_images_pdfs

-- DROP INDEX clique.idx_img_subnr_images_pdfs;

CREATE INDEX idx_img_subnr_images_pdfs
  ON clique.images_pdfs
  USING btree
  (img_subnr);


-- Trigger: update_images_pdfs_rec_last_updated on clique.images_pdfs

-- DROP TRIGGER update_images_pdfs_rec_last_updated ON clique.images_pdfs;

CREATE TRIGGER update_images_pdfs_rec_last_updated
  BEFORE UPDATE
  ON clique.images_pdfs
  FOR EACH ROW
  EXECUTE PROCEDURE clique.update_rec_last_updated_column();
