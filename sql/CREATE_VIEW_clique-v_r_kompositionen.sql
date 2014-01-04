-- View: clique.v_r_kompositionen

-- DROP VIEW clique.v_r_kompositionen;

CREATE OR REPLACE VIEW clique.v_r_kompositionen AS 
 SELECT kompositionen.id AS k_id,
    kompositionen.titel AS k_titel,
    kompositionen.datum AS k_datum,
    lt_schrift.schriftart AS k_schriftart,
    verlage.name AS v_name,
    verlage.ort AS v_ort,
    werke.titel AS w_titel,
    autoren.vorname AS a_vorname,
    autoren.name AS a_name,
    kompositionen.rec_created AS k_rec_created,
    kompositionen.rec_last_updated AS k_rec_last_updated
   FROM clique.kompositionen
   LEFT JOIN clique.verlage ON kompositionen.verlag_id = verlage.id
   LEFT JOIN clique.werke ON kompositionen.werk_id = werke.id
   LEFT JOIN clique.autoren ON kompositionen.autor_id = autoren.id
   LEFT JOIN clique.lt_schrift ON kompositionen.schrift_cd = lt_schrift.cd;

ALTER TABLE clique.v_r_kompositionen
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_r_kompositionen TO postgres;
GRANT SELECT ON TABLE clique.v_r_kompositionen TO public;
GRANT ALL ON TABLE clique.v_r_kompositionen TO clique_admins;
