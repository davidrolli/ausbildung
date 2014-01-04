-- View: clique.v_skizzen

-- DROP VIEW clique.v_skizzen;

CREATE OR REPLACE VIEW clique.v_skizzen AS 
 SELECT skizzen.id,
    skizzen.url,
    skizzen.autor_id,
    skizzen.werk_id,
    skizzen.vers_nr,
    skizzen.rhytmus_gerade,
    skizzen.rhythmus_ungerade,
    skizzen.rhythmus_gemischt,
    skizzen.rhythmus_bemerkungen,
    skizzen.copyright_datum,
    skizzen.rec_created,
    skizzen.rec_last_updated
   FROM clique.skizzen;

ALTER TABLE clique.v_skizzen
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_skizzen TO postgres;
GRANT ALL ON TABLE clique.v_skizzen TO clique_admins;
GRANT SELECT ON TABLE clique.v_skizzen TO public;
