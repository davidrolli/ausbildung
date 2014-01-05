-- View: clique.v_r_dokumente

-- DROP VIEW clique.v_r_dokumente;

CREATE OR REPLACE VIEW clique.v_r_dokumente AS 
	SELECT
		dokumente.id AS d_id,
		dokumente.titel AS d_titel,
		dokumente.url AS d_url,
		autoren.vorname AS a_vorname,
		autoren.name AS a_name,
		dokumente.datum AS d_datum,
		lt_schrift.schriftart AS d_schriftart,
		verlage.name AS v_name,
		verlage.ort AS v_ort,
		werke.titel AS w_titel,
		dokumente.vers_nr AS d_,
		dokumente.rhytmus_gerade AS d_rhytmus_gerade,
		dokumente.rhythmus_ungerade AS d_rhythmus_ungerade,
		dokumente.rhythmus_gemischt AS d_rhythmus_gemischt,
		dokumente.rhythmus_bemerkungen AS d_rhythmus_bemerkungen,
		dokumente.bemerkungen AS d_bemerkungen,
		dokumente.copyright_datum AS d_copyright_datum,		
		dokumente.rec_created AS d_rec_created,
		dokumente.rec_last_updated AS d_rec_last_updated
	FROM clique.dokumente
		LEFT JOIN clique.verlage ON dokumente.verlag_id = verlage.id
		LEFT JOIN clique.werke ON dokumente.werk_id = werke.id
		LEFT JOIN clique.autoren ON dokumente.autor_id = autoren.id
		LEFT JOIN clique.lt_schrift ON dokumente.schrift_cd = lt_schrift.cd
	ORDER BY dokumente.id;

ALTER TABLE clique.v_r_dokumente
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_r_dokumente TO postgres;
GRANT SELECT ON TABLE clique.v_r_dokumente TO public;
GRANT ALL ON TABLE clique.v_r_dokumente TO clique_admins;
