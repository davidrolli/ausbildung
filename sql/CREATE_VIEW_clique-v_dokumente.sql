-- View: clique.v_dokumente

-- DROP VIEW clique.v_dokumente;

CREATE OR REPLACE VIEW clique.v_dokumente AS 
SELECT
	dokumente.id,
	dokumente.titel,
	dokumente.url,
	dokumente.autor_id,
	dokumente.datum,
	dokumente.werk_id,
	dokumente.verlag_id,
	dokumente.schrift_cd,
	dokumente.vers_nr,
	dokumente.rhytmus_gerade,
	dokumente.rhythmus_ungerade,
	dokumente.rhythmus_gemischt,
	dokumente.rhythmus_bemerkungen,
	dokumente.bemerkungen,
	dokumente.copyright_datum,
	dokumente.rec_created,
	dokumente.rec_last_updated
FROM clique.dokumente
ORDER BY dokumente.id;

ALTER TABLE clique.v_dokumente
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_dokumente TO postgres;
GRANT SELECT ON TABLE clique.v_dokumente TO public;
GRANT ALL ON TABLE clique.v_dokumente TO clique_admins;
