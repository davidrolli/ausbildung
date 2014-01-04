-- View: clique.v_r_werke

-- DROP VIEW clique.v_r_werke;

CREATE OR REPLACE VIEW clique.v_r_werke AS 
 SELECT werke.id,
    werke.titel,
    werke.verlag_id,
    verlage.name,
    verlage.ort,
    werke.rec_created,
    werke.rec_last_updated
   FROM clique.werke
   LEFT JOIN clique.verlage ON werke.verlag_id = verlage.id;

ALTER TABLE clique.v_r_werke
  OWNER TO postgres;
GRANT ALL ON TABLE clique.v_r_werke TO postgres;
GRANT SELECT ON TABLE clique.v_r_werke TO public;
GRANT ALL ON TABLE clique.v_r_werke TO clique_admins;
