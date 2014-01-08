-- View: clique.v_r_dokumente

-- DROP VIEW clique.v_r_dokumente;

CREATE OR REPLACE VIEW clique.v_r_dokumente AS 
	SELECT
		dokumente.id,
		dokumente.titel,
		dokumente.url,
		autoren.vorname AS autorenvorname,
		autoren.name AS autorenname,
		dokumente.datum AS datum,
		lt_notenschrift.notenschrift,
		verlage.name AS verlagsname,
		verlage.ort AS verlagsort,
		werke.titel AS werkstitel,
		dokumente.vers_nr AS versnummer,
		dokumente.rhythmus_gerade,
		dokumente.rhythmus_ungerade,
		dokumente.rhythmus_gemischt,
		dokumente.rhythmus_bemerkungen,
		dokumente.bemerkungen,
		dokumente.copyright_datum,		
		dokumente.rec_created,
		dokumente.rec_last_updated
	FROM clique.dokumente
		LEFT JOIN clique.verlage ON dokumente.verlag_id = verlage.id
		LEFT JOIN clique.werke ON dokumente.werk_id = werke.id
		LEFT JOIN clique.autoren ON dokumente.autor_id = autoren.id
		LEFT JOIN clique.lt_notenschrift ON dokumente.notenschrift_cd = lt_notenschrift.cd
	ORDER BY dokumente.id;

ALTER TABLE clique.v_r_dokumente
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_r_dokumente TO postgres;
GRANT SELECT ON TABLE clique.v_r_dokumente TO public;
GRANT ALL ON TABLE clique.v_r_dokumente TO clique_admins;
