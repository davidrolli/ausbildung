--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-01-08 16:35:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 18328)
-- Name: clique; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA clique;


ALTER SCHEMA clique OWNER TO postgres;

SET search_path = clique, pg_catalog;

--
-- TOC entry 202 (class 1255 OID 18511)
-- Name: update_rec_last_updated_column(); Type: FUNCTION; Schema: clique; Owner: postgres
--

CREATE FUNCTION update_rec_last_updated_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.rec_last_updated = now(); 
   RETURN NEW;
END;
$$;


ALTER FUNCTION clique.update_rec_last_updated_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 18578)
-- Name: autoren; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE autoren (
    id integer NOT NULL,
    name character varying(80) NOT NULL,
    vorname character varying(40) NOT NULL,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.autoren OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 18455)
-- Name: autoren_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE autoren_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.autoren_id_seq OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 18576)
-- Name: autoren_id_seq1; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE autoren_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.autoren_id_seq1 OWNER TO postgres;

--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 172
-- Name: autoren_id_seq1; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE autoren_id_seq1 OWNED BY autoren.id;


--
-- TOC entry 185 (class 1259 OID 18825)
-- Name: dokumente; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE dokumente (
    id integer NOT NULL,
    titel character varying,
    url character varying,
    autor_id integer,
    datum date,
    werk_id integer,
    verlag_id integer,
    notenschrift_cd integer DEFAULT 1 NOT NULL,
    vers_nr character varying,
    rhythmus_gerade boolean,
    rhythmus_ungerade boolean,
    rhythmus_gemischt boolean,
    rhythmus_bemerkungen character varying,
    bemerkungen text,
    copyright_datum date,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.dokumente OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 18823)
-- Name: dokumente_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE dokumente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.dokumente_id_seq OWNER TO postgres;

--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 184
-- Name: dokumente_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE dokumente_id_seq OWNED BY dokumente.id;


--
-- TOC entry 179 (class 1259 OID 18735)
-- Name: lt_notenschrift; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE lt_notenschrift (
    id integer NOT NULL,
    cd integer NOT NULL,
    notenschrift character varying(80) NOT NULL
);


ALTER TABLE clique.lt_notenschrift OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 18733)
-- Name: lt_schrift_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE lt_schrift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.lt_schrift_id_seq OWNER TO postgres;

--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 178
-- Name: lt_schrift_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE lt_schrift_id_seq OWNED BY lt_notenschrift.id;


--
-- TOC entry 180 (class 1259 OID 18741)
-- Name: v_autoren; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_autoren AS
 SELECT autoren.id,
    autoren.name,
    autoren.vorname,
    autoren.rec_created,
    autoren.rec_last_updated
   FROM autoren
  ORDER BY autoren.name, autoren.vorname;


ALTER TABLE clique.v_autoren OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 18903)
-- Name: v_dokumente; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_dokumente AS
 SELECT dokumente.id,
    dokumente.titel,
    dokumente.url,
    dokumente.autor_id,
    dokumente.datum,
    dokumente.werk_id,
    dokumente.verlag_id,
    dokumente.notenschrift_cd,
    dokumente.vers_nr,
    dokumente.rhythmus_gerade AS rhytmus_gerade,
    dokumente.rhythmus_ungerade,
    dokumente.rhythmus_gemischt,
    dokumente.rhythmus_bemerkungen,
    dokumente.bemerkungen,
    dokumente.copyright_datum,
    dokumente.rec_created,
    dokumente.rec_last_updated
   FROM dokumente
  ORDER BY dokumente.id;


ALTER TABLE clique.v_dokumente OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 18612)
-- Name: verlage; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE verlage (
    id integer NOT NULL,
    name character varying,
    ort character varying,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.verlage OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 18625)
-- Name: werke; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE werke (
    id integer NOT NULL,
    titel character varying(120) NOT NULL,
    verlag_id integer,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.werke OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 18907)
-- Name: v_r_dokumente; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_r_dokumente AS
 SELECT dokumente.id,
    dokumente.titel,
    dokumente.url,
    autoren.vorname AS autorenvorname,
    autoren.name AS autorenname,
    dokumente.datum,
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
   FROM ((((dokumente
   LEFT JOIN verlage ON ((dokumente.verlag_id = verlage.id)))
   LEFT JOIN werke ON ((dokumente.werk_id = werke.id)))
   LEFT JOIN autoren ON ((dokumente.autor_id = autoren.id)))
   LEFT JOIN lt_notenschrift ON ((dokumente.notenschrift_cd = lt_notenschrift.cd)))
  ORDER BY dokumente.id;


ALTER TABLE clique.v_r_dokumente OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 18781)
-- Name: v_r_werke; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_r_werke AS
 SELECT werke.id,
    werke.titel,
    werke.verlag_id,
    verlage.name,
    verlage.ort,
    werke.rec_created,
    werke.rec_last_updated
   FROM (werke
   LEFT JOIN verlage ON ((werke.verlag_id = verlage.id)));


ALTER TABLE clique.v_r_werke OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 18753)
-- Name: v_verlage; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_verlage AS
 SELECT verlage.id,
    verlage.name,
    verlage.ort,
    verlage.rec_created,
    verlage.rec_last_updated
   FROM verlage;


ALTER TABLE clique.v_verlage OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 18757)
-- Name: v_werke; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_werke AS
 SELECT werke.id,
    werke.titel,
    werke.verlag_id,
    werke.rec_created,
    werke.rec_last_updated
   FROM werke;


ALTER TABLE clique.v_werke OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 18610)
-- Name: verlage_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE verlage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.verlage_id_seq OWNER TO postgres;

--
-- TOC entry 2060 (class 0 OID 0)
-- Dependencies: 174
-- Name: verlage_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE verlage_id_seq OWNED BY verlage.id;


--
-- TOC entry 176 (class 1259 OID 18623)
-- Name: werke_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE werke_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.werke_id_seq OWNER TO postgres;

--
-- TOC entry 2061 (class 0 OID 0)
-- Dependencies: 176
-- Name: werke_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE werke_id_seq OWNED BY werke.id;


--
-- TOC entry 1878 (class 2604 OID 18581)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY autoren ALTER COLUMN id SET DEFAULT nextval('autoren_id_seq1'::regclass);


--
-- TOC entry 1885 (class 2604 OID 18828)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente ALTER COLUMN id SET DEFAULT nextval('dokumente_id_seq'::regclass);


--
-- TOC entry 1884 (class 2604 OID 18738)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY lt_notenschrift ALTER COLUMN id SET DEFAULT nextval('lt_schrift_id_seq'::regclass);


--
-- TOC entry 1880 (class 2604 OID 18615)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY verlage ALTER COLUMN id SET DEFAULT nextval('verlage_id_seq'::regclass);


--
-- TOC entry 1882 (class 2604 OID 18628)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke ALTER COLUMN id SET DEFAULT nextval('werke_id_seq'::regclass);


--
-- TOC entry 2031 (class 0 OID 18578)
-- Dependencies: 173
-- Data for Name: autoren; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO autoren VALUES (1, 'Rolli', 'David', '2014-01-01 15:55:57.558+01', NULL);
INSERT INTO autoren VALUES (2, 'Kym', 'Ivan', '2014-01-01 15:56:20.145+01', NULL);
INSERT INTO autoren VALUES (3, 'Ischi', 'Marcel', '2014-01-01 15:56:26.715+01', NULL);
INSERT INTO autoren VALUES (4, 'Gehrig', 'Urs', '2014-01-01 15:56:32.354+01', NULL);


--
-- TOC entry 2062 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('autoren_id_seq', 1, false);


--
-- TOC entry 2063 (class 0 OID 0)
-- Dependencies: 172
-- Name: autoren_id_seq1; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('autoren_id_seq1', 4, true);


--
-- TOC entry 2039 (class 0 OID 18825)
-- Dependencies: 185
-- Data for Name: dokumente; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO dokumente VALUES (2, NULL, 'IMG_0002_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (3, NULL, 'IMG_0003_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (4, NULL, 'IMG_0004_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (5, NULL, 'IMG_0005_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (6, NULL, 'IMG_0006_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (7, NULL, 'IMG_0007_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (8, NULL, 'IMG_0008_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (9, NULL, 'IMG_0009_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (10, NULL, 'IMG_0010_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (11, NULL, 'IMG_0011_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (12, NULL, 'IMG_0012_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (13, NULL, 'IMG_0013_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (14, NULL, 'IMG_0014_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (15, NULL, 'IMG_0015_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (16, NULL, 'IMG_0016_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (17, NULL, 'IMG_0017_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (18, NULL, 'IMG_0018_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (19, NULL, 'IMG_0019_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (20, NULL, 'IMG_0020_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (21, NULL, 'IMG_0021_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (22, NULL, 'IMG_0022_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (23, NULL, 'IMG_0023_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (24, NULL, 'IMG_0024_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (25, NULL, 'IMG_0025_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (26, NULL, 'IMG_0026_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (27, NULL, 'IMG_0027_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (28, NULL, 'IMG_0028_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (29, NULL, 'IMG_0029_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (30, NULL, 'IMG_0030_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (31, NULL, 'IMG_0031_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (32, NULL, 'IMG_0032_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (33, NULL, 'IMG_0033_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (34, NULL, 'IMG_0034_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (35, NULL, 'IMG_0035_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (36, NULL, 'IMG_0036_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (37, NULL, 'IMG_0037_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (38, NULL, 'IMG_0038_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (39, NULL, 'IMG_0039_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (40, NULL, 'IMG_0040_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (41, NULL, 'IMG_0041_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (42, NULL, 'IMG_0042_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (43, NULL, 'IMG_0043_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (44, NULL, 'IMG_0044_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (45, NULL, 'IMG_0045_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (46, NULL, 'IMG_0046_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (47, NULL, 'IMG_0047_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (48, NULL, 'IMG_0048_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (49, NULL, 'IMG_0049_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (50, NULL, 'IMG_0050_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (51, NULL, 'IMG_0051_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (52, NULL, 'IMG_0052_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (53, NULL, 'IMG_0053_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (54, NULL, 'IMG_0054_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (55, NULL, 'IMG_0055_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (56, NULL, 'IMG_0056_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (57, NULL, 'IMG_0057_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (58, NULL, 'IMG_0058_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (59, NULL, 'IMG_0059_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (60, NULL, 'IMG_0060_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (61, NULL, 'IMG_0061_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (62, NULL, 'IMG_0062_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (63, NULL, 'IMG_0063_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (64, NULL, 'IMG_0064_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (65, NULL, 'IMG_0064_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (66, NULL, 'IMG_0065_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (67, NULL, 'IMG_0065_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (68, NULL, 'IMG_0066_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (69, NULL, 'IMG_0067_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (70, NULL, 'IMG_0068_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (71, NULL, 'IMG_0069_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (72, NULL, 'IMG_0069_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (73, NULL, 'IMG_0070_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (74, NULL, 'IMG_0071_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (75, NULL, 'IMG_0072_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (76, NULL, 'IMG_0072_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (77, NULL, 'IMG_0073_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (78, NULL, 'IMG_0074_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (79, NULL, 'IMG_0128_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (80, NULL, 'IMG_0129_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (81, NULL, 'IMG_0130_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (82, NULL, 'IMG_0131_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (83, NULL, 'IMG_0132_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (84, NULL, 'IMG_0133_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (85, NULL, 'IMG_0134_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (86, NULL, 'IMG_0135_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (87, NULL, 'IMG_0135_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (88, NULL, 'IMG_0136_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (89, NULL, 'IMG_0137_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (90, NULL, 'IMG_0137_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (91, NULL, 'IMG_0138_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (92, NULL, 'IMG_0139_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (93, NULL, 'IMG_0140_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (94, NULL, 'IMG_0141_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (95, NULL, 'IMG_0141_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (96, NULL, 'IMG_0142_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (97, NULL, 'IMG_0142_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (98, NULL, 'IMG_0143_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (99, NULL, 'IMG_0143_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (100, NULL, 'IMG_0143_03.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (101, NULL, 'IMG_0144_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (102, NULL, 'IMG_0145_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (103, NULL, 'IMG_0146_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (104, NULL, 'IMG_0147_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (105, NULL, 'IMG_0148_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (106, NULL, 'IMG_0149_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (107, NULL, 'IMG_0150_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (108, NULL, 'IMG_0151_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (109, NULL, 'IMG_0152_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (110, NULL, 'IMG_0153_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (111, NULL, 'IMG_0154_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (112, NULL, 'IMG_0155_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (113, NULL, 'IMG_0156_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (114, NULL, 'IMG_0158_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (115, NULL, 'IMG_0159_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (116, NULL, 'IMG_0160_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (117, NULL, 'IMG_0161_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (118, NULL, 'IMG_0162_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (119, NULL, 'IMG_0163_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (120, NULL, 'IMG_0164_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (121, NULL, 'IMG_0165_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (122, NULL, 'IMG_0166_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (123, NULL, 'IMG_0167_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (124, NULL, 'IMG_0167_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (125, NULL, 'IMG_0168_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (126, NULL, 'IMG_0169_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (127, NULL, 'IMG_0170_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (128, NULL, 'IMG_0171_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (129, NULL, 'IMG_0172_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (130, NULL, 'IMG_0173_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (131, NULL, 'IMG_0173_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (132, NULL, 'IMG_0174_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (133, NULL, 'IMG_0175_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (134, NULL, 'IMG_0176_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (135, NULL, 'IMG_0177_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (136, NULL, 'IMG_0178_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (137, NULL, 'IMG_0179_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (138, NULL, 'IMG_0180_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (139, NULL, 'IMG_0181_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (140, NULL, 'IMG_0182_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (141, NULL, 'IMG_0183_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (142, NULL, 'IMG_0184_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (143, NULL, 'IMG_0185_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (144, NULL, 'IMG_0185_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (145, NULL, 'IMG_0186_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (146, NULL, 'IMG_0187_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (147, NULL, 'IMG_0188_00.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (148, NULL, 'IMG_0188_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (149, NULL, 'IMG_0188_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (150, NULL, 'IMG_0188_03.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (151, NULL, 'IMG_0189_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (152, NULL, 'IMG_0190_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (153, NULL, 'IMG_0191_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (154, NULL, 'IMG_0192_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (155, NULL, 'IMG_0193_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (156, NULL, 'IMG_0194_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (157, NULL, 'IMG_0195_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (158, NULL, 'IMG_0196_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (159, NULL, 'IMG_0197_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (160, NULL, 'IMG_0198_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (161, NULL, 'IMG_0199_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (162, NULL, 'IMG_0200_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (163, NULL, 'IMG_0201_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (164, NULL, 'IMG_0202_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (165, NULL, 'IMG_0203_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (166, NULL, 'IMG_0204_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (167, NULL, 'IMG_0205_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (168, NULL, 'IMG_0206_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (169, NULL, 'IMG_0207_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (170, NULL, 'IMG_0208_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (171, NULL, 'IMG_0209_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (172, NULL, 'IMG_0210_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (173, NULL, 'IMG_0211_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (174, NULL, 'IMG_0212_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (175, NULL, 'IMG_0213_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (176, NULL, 'IMG_0214_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (177, NULL, 'IMG_0215_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (178, NULL, 'IMG_0216_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (179, NULL, 'IMG_0217_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (180, NULL, 'IMG_0218_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (181, NULL, 'IMG_0219_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (182, NULL, 'IMG_0220_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (183, NULL, 'IMG_0221_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (184, NULL, 'IMG_0222_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (185, NULL, 'IMG_0223_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (186, NULL, 'IMG_0224_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (187, NULL, 'IMG_0225_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (188, NULL, 'IMG_0226_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (189, NULL, 'IMG_0227_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (190, NULL, 'IMG_0228_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (191, NULL, 'IMG_0229_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (192, NULL, 'IMG_0230_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (193, NULL, 'IMG_0231_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (194, NULL, 'IMG_0232_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (195, NULL, 'IMG_0233_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (196, NULL, 'IMG_0234_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (197, NULL, 'IMG_0235_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (198, NULL, 'IMG_0237_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (199, NULL, 'IMG_0238_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (200, NULL, 'IMG_0239_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (201, NULL, 'IMG_0240_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (202, NULL, 'IMG_0240_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (203, NULL, 'IMG_0241_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (204, NULL, 'IMG_0242_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (205, NULL, 'IMG_0243_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (206, NULL, 'IMG_0244_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (207, NULL, 'IMG_0245_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (208, NULL, 'IMG_0246_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (209, NULL, 'IMG_0247_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (210, NULL, 'IMG_0248_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (211, NULL, 'IMG_0249_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (212, NULL, 'IMG_0250_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (213, NULL, 'IMG_0251_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (214, NULL, 'IMG_0252_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (215, NULL, 'IMG_0253_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (216, NULL, 'IMG_0254_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (217, NULL, 'IMG_0255_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (218, NULL, 'IMG_0256_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (219, NULL, 'IMG_0257_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (220, NULL, 'IMG_0258_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (221, NULL, 'IMG_0259_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (222, NULL, 'IMG_0260_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (223, NULL, 'IMG_0261_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (224, NULL, 'IMG_0262_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (225, NULL, 'IMG_0263_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', NULL);
INSERT INTO dokumente VALUES (1, NULL, 'IMG_0001_01.jpg', 1, '2012-03-03', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:54:13.997+01', '2014-01-05 18:06:47.119+01');


--
-- TOC entry 2064 (class 0 OID 0)
-- Dependencies: 184
-- Name: dokumente_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('dokumente_id_seq', 225, true);


--
-- TOC entry 2037 (class 0 OID 18735)
-- Dependencies: 179
-- Data for Name: lt_notenschrift; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO lt_notenschrift VALUES (1, 1, 'Zündstoff');
INSERT INTO lt_notenschrift VALUES (2, 3, 'Basler Hieroglyphen, Stil: J.B.-Clique Santihans');
INSERT INTO lt_notenschrift VALUES (3, 2, 'Berger-Noten');
INSERT INTO lt_notenschrift VALUES (5, 4, 'Basler Hieroglyphen, Stil: Basler Mittwoch Gesellschaft');


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 178
-- Name: lt_schrift_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('lt_schrift_id_seq', 5, true);


--
-- TOC entry 2033 (class 0 OID 18612)
-- Dependencies: 175
-- Data for Name: verlage; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO verlage VALUES (1, 'STV', 'Wallis', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (2, 'Berger', 'Basel', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (3, 'Zenker', 'Basel', '2014-01-01 16:14:43.025+01', NULL);


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 174
-- Name: verlage_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('verlage_id_seq', 3, true);


--
-- TOC entry 2035 (class 0 OID 18625)
-- Dependencies: 177
-- Data for Name: werke; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO werke VALUES (1, 'STV Band 1', 1, '2014-01-01 16:15:58.323+01', NULL);


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 176
-- Name: werke_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('werke_id_seq', 1, true);


--
-- TOC entry 1890 (class 2606 OID 18584)
-- Name: pk_autoren; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autoren
    ADD CONSTRAINT pk_autoren PRIMARY KEY (id);


--
-- TOC entry 1907 (class 2606 OID 18835)
-- Name: pk_dokumente; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT pk_dokumente PRIMARY KEY (id);


--
-- TOC entry 1897 (class 2606 OID 18740)
-- Name: pk_lt_notenschrift; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lt_notenschrift
    ADD CONSTRAINT pk_lt_notenschrift PRIMARY KEY (id);


--
-- TOC entry 1892 (class 2606 OID 18621)
-- Name: pk_verlage; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY verlage
    ADD CONSTRAINT pk_verlage PRIMARY KEY (id);


--
-- TOC entry 1895 (class 2606 OID 18631)
-- Name: pk_werke; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT pk_werke PRIMARY KEY (id);


--
-- TOC entry 1898 (class 1259 OID 18851)
-- Name: fki_dokument_autor_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_autor_id ON dokumente USING btree (autor_id);


--
-- TOC entry 1899 (class 1259 OID 18852)
-- Name: fki_dokument_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_verlag_id ON dokumente USING btree (verlag_id);


--
-- TOC entry 1900 (class 1259 OID 18853)
-- Name: fki_dokument_werk_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_werk_id ON dokumente USING btree (werk_id);


--
-- TOC entry 1893 (class 1259 OID 18637)
-- Name: fki_werk_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_werk_verlag_id ON werke USING btree (verlag_id);


--
-- TOC entry 1901 (class 1259 OID 18854)
-- Name: idx_datum; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_datum ON dokumente USING btree (datum);


--
-- TOC entry 1902 (class 1259 OID 18858)
-- Name: idx_notenschrift_cd; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_notenschrift_cd ON dokumente USING btree (notenschrift_cd);


--
-- TOC entry 1903 (class 1259 OID 18855)
-- Name: idx_rhythmus_gemischt; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_gemischt ON dokumente USING btree (rhythmus_gemischt);


--
-- TOC entry 1904 (class 1259 OID 18856)
-- Name: idx_rhythmus_gerade; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_gerade ON dokumente USING btree (rhythmus_gerade);


--
-- TOC entry 1905 (class 1259 OID 18857)
-- Name: idx_rhythmus_ungerade; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_ungerade ON dokumente USING btree (rhythmus_ungerade);


--
-- TOC entry 1888 (class 1259 OID 18585)
-- Name: idx_skizzen_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_skizzen_id ON autoren USING btree (id);


--
-- TOC entry 1912 (class 2620 OID 18586)
-- Name: update_autoren_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_autoren_rec_last_updated BEFORE UPDATE ON autoren FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1915 (class 2620 OID 18859)
-- Name: update_dokumente_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_dokumente_rec_last_updated BEFORE UPDATE ON dokumente FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1913 (class 2620 OID 18622)
-- Name: update_verlage_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_verlage_rec_last_updated BEFORE UPDATE ON verlage FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1914 (class 2620 OID 18638)
-- Name: update_werke_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_werke_rec_last_updated BEFORE UPDATE ON werke FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1909 (class 2606 OID 18836)
-- Name: fk_dokument_autor_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_autor_id FOREIGN KEY (autor_id) REFERENCES autoren(id);


--
-- TOC entry 1910 (class 2606 OID 18841)
-- Name: fk_dokument_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 1911 (class 2606 OID 18846)
-- Name: fk_dokument_werk_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_werk_id FOREIGN KEY (werk_id) REFERENCES werke(id);


--
-- TOC entry 1908 (class 2606 OID 18632)
-- Name: fk_werk_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT fk_werk_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 7
-- Name: clique; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA clique FROM PUBLIC;
REVOKE ALL ON SCHEMA clique FROM postgres;
GRANT ALL ON SCHEMA clique TO postgres;
GRANT ALL ON SCHEMA clique TO clique_admins;


--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 173
-- Name: autoren; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE autoren FROM PUBLIC;
REVOKE ALL ON TABLE autoren FROM postgres;
GRANT ALL ON TABLE autoren TO postgres;
GRANT ALL ON TABLE autoren TO clique_admins;


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE autoren_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE autoren_id_seq FROM postgres;
GRANT ALL ON SEQUENCE autoren_id_seq TO postgres;
GRANT ALL ON SEQUENCE autoren_id_seq TO clique_admins;


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 185
-- Name: dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE dokumente FROM PUBLIC;
REVOKE ALL ON TABLE dokumente FROM postgres;
GRANT ALL ON TABLE dokumente TO postgres;
GRANT ALL ON TABLE dokumente TO clique_admins;


--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 179
-- Name: lt_notenschrift; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE lt_notenschrift FROM PUBLIC;
REVOKE ALL ON TABLE lt_notenschrift FROM postgres;
GRANT ALL ON TABLE lt_notenschrift TO postgres;
GRANT ALL ON TABLE lt_notenschrift TO clique_admins;


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 180
-- Name: v_autoren; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_autoren FROM PUBLIC;
REVOKE ALL ON TABLE v_autoren FROM postgres;
GRANT ALL ON TABLE v_autoren TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_autoren TO clique_admins;
GRANT SELECT ON TABLE v_autoren TO PUBLIC;


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 186
-- Name: v_dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_dokumente FROM PUBLIC;
REVOKE ALL ON TABLE v_dokumente FROM postgres;
GRANT ALL ON TABLE v_dokumente TO postgres;
GRANT SELECT ON TABLE v_dokumente TO PUBLIC;
GRANT ALL ON TABLE v_dokumente TO clique_admins;


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 175
-- Name: verlage; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE verlage FROM PUBLIC;
REVOKE ALL ON TABLE verlage FROM postgres;
GRANT ALL ON TABLE verlage TO postgres;
GRANT ALL ON TABLE verlage TO clique_admins;


--
-- TOC entry 2055 (class 0 OID 0)
-- Dependencies: 177
-- Name: werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE werke FROM PUBLIC;
REVOKE ALL ON TABLE werke FROM postgres;
GRANT ALL ON TABLE werke TO postgres;
GRANT ALL ON TABLE werke TO clique_admins;


--
-- TOC entry 2056 (class 0 OID 0)
-- Dependencies: 187
-- Name: v_r_dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_r_dokumente FROM PUBLIC;
REVOKE ALL ON TABLE v_r_dokumente FROM postgres;
GRANT ALL ON TABLE v_r_dokumente TO postgres;
GRANT SELECT ON TABLE v_r_dokumente TO PUBLIC;
GRANT ALL ON TABLE v_r_dokumente TO clique_admins;


--
-- TOC entry 2057 (class 0 OID 0)
-- Dependencies: 183
-- Name: v_r_werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_r_werke FROM PUBLIC;
REVOKE ALL ON TABLE v_r_werke FROM postgres;
GRANT ALL ON TABLE v_r_werke TO postgres;
GRANT SELECT ON TABLE v_r_werke TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_r_werke TO clique_admins;


--
-- TOC entry 2058 (class 0 OID 0)
-- Dependencies: 181
-- Name: v_verlage; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_verlage FROM PUBLIC;
REVOKE ALL ON TABLE v_verlage FROM postgres;
GRANT ALL ON TABLE v_verlage TO postgres;
GRANT SELECT ON TABLE v_verlage TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_verlage TO clique_admins;


--
-- TOC entry 2059 (class 0 OID 0)
-- Dependencies: 182
-- Name: v_werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_werke FROM PUBLIC;
REVOKE ALL ON TABLE v_werke FROM postgres;
GRANT ALL ON TABLE v_werke TO postgres;
GRANT SELECT ON TABLE v_werke TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_werke TO clique_admins;


-- Completed on 2014-01-08 16:35:06

--
-- PostgreSQL database dump complete
--

