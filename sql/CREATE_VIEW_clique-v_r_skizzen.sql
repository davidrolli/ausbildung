-- View: clique.v_r_skizzen

-- DROP VIEW clique.v_r_skizzen;

CREATE OR REPLACE VIEW clique.v_r_skizzen AS 
 SELECT skizzen.id,
    skizzen.url,
    skizzen.werk_id,
    skizzen.vers_nr,
    skizzen.rhytmus_gerade,
    skizzen.rhythmus_ungerade,
    skizzen.rhythmus_gemischt,
    skizzen.rhythmus_bemerkungen,
    werke.titel,
    werke.verlag_id,
    verlage.name,
    verlage.ort
   FROM clique.skizzen
   LEFT JOIN clique.werke ON skizzen.werk_id = werke.id
   LEFT JOIN clique.verlage ON werke.verlag_id = verlage.id;

ALTER TABLE clique.v_r_skizzen
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_r_skizzen TO postgres;
GRANT SELECT ON TABLE clique.v_r_skizzen TO public;
GRANT ALL ON TABLE clique.v_r_skizzen TO clique_admins;
