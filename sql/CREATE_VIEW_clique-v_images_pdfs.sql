-- View: clique.v_images_pdfs

-- DROP VIEW clique.v_images_pdfs;

CREATE OR REPLACE VIEW clique.v_images_pdfs AS 
	SELECT
		images_pdfs.id,
		images_pdfs.prefix,	
		images_pdfs.img_nr,
		images_pdfs.img_subnr,
		images_pdfs.doc_extension,
		images_pdfs.rec_created,
		images_pdfs.rec_last_updated
	FROM clique.images_pdfs;

ALTER TABLE clique.v_images_pdfs
  OWNER TO postgres;
GRANT SELECT ON TABLE clique.v_images_pdfs TO public;
GRANT ALL ON TABLE clique.v_images_pdfs TO postgres;
GRANT ALL ON TABLE clique.v_images_pdfs TO clique_admin_group;
