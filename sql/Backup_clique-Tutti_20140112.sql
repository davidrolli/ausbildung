--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-01-12 18:22:01

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
-- TOC entry 204 (class 1255 OID 18511)
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
-- TOC entry 172 (class 1259 OID 18578)
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
-- TOC entry 171 (class 1259 OID 18576)
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
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE autoren_id_seq OWNED BY autoren.id;


--
-- TOC entry 184 (class 1259 OID 18825)
-- Name: dokumente; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE dokumente (
    id integer NOT NULL,
    titel character varying DEFAULT 'Notenskizze'::character varying NOT NULL,
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
-- TOC entry 183 (class 1259 OID 18823)
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
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 183
-- Name: dokumente_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE dokumente_id_seq OWNED BY dokumente.id;


--
-- TOC entry 188 (class 1259 OID 19120)
-- Name: images_pdfs; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE images_pdfs (
    id integer NOT NULL,
    prefix character varying(6),
    img_nr integer NOT NULL,
    img_subnr integer DEFAULT 1 NOT NULL,
    doc_extension character varying(5) NOT NULL,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.images_pdfs OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 19118)
-- Name: images_pdfs_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE images_pdfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.images_pdfs_id_seq OWNER TO postgres;

--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 187
-- Name: images_pdfs_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE images_pdfs_id_seq OWNED BY images_pdfs.id;


--
-- TOC entry 178 (class 1259 OID 18735)
-- Name: lt_notenschrift; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE lt_notenschrift (
    id integer NOT NULL,
    cd integer NOT NULL,
    notenschrift character varying(80) NOT NULL
);


ALTER TABLE clique.lt_notenschrift OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 18733)
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
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 177
-- Name: lt_schrift_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE lt_schrift_id_seq OWNED BY lt_notenschrift.id;


--
-- TOC entry 179 (class 1259 OID 18741)
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
-- TOC entry 185 (class 1259 OID 18903)
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
-- TOC entry 189 (class 1259 OID 19133)
-- Name: v_images_pdfs; Type: VIEW; Schema: clique; Owner: postgres
--

CREATE VIEW v_images_pdfs AS
 SELECT images_pdfs.id,
    images_pdfs.prefix,
    images_pdfs.img_nr,
    images_pdfs.img_subnr,
    images_pdfs.doc_extension,
    images_pdfs.rec_created,
    images_pdfs.rec_last_updated
   FROM images_pdfs;


ALTER TABLE clique.v_images_pdfs OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 18612)
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
-- TOC entry 176 (class 1259 OID 18625)
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
-- TOC entry 186 (class 1259 OID 18907)
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
-- TOC entry 182 (class 1259 OID 18781)
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
-- TOC entry 180 (class 1259 OID 18753)
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
-- TOC entry 181 (class 1259 OID 18757)
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
-- TOC entry 173 (class 1259 OID 18610)
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
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 173
-- Name: verlage_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE verlage_id_seq OWNED BY verlage.id;


--
-- TOC entry 175 (class 1259 OID 18623)
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
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 175
-- Name: werke_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE werke_id_seq OWNED BY werke.id;


--
-- TOC entry 1888 (class 2604 OID 19038)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY autoren ALTER COLUMN id SET DEFAULT nextval('autoren_id_seq'::regclass);


--
-- TOC entry 1894 (class 2604 OID 18828)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente ALTER COLUMN id SET DEFAULT nextval('dokumente_id_seq'::regclass);


--
-- TOC entry 1898 (class 2604 OID 19123)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY images_pdfs ALTER COLUMN id SET DEFAULT nextval('images_pdfs_id_seq'::regclass);


--
-- TOC entry 1893 (class 2604 OID 18738)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY lt_notenschrift ALTER COLUMN id SET DEFAULT nextval('lt_schrift_id_seq'::regclass);


--
-- TOC entry 1889 (class 2604 OID 18615)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY verlage ALTER COLUMN id SET DEFAULT nextval('verlage_id_seq'::regclass);


--
-- TOC entry 1891 (class 2604 OID 18628)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke ALTER COLUMN id SET DEFAULT nextval('werke_id_seq'::regclass);


--
-- TOC entry 2051 (class 0 OID 18578)
-- Dependencies: 172
-- Data for Name: autoren; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO autoren VALUES (1, 'Rolli', 'David', '2014-01-01 15:55:57.558+01', NULL);
INSERT INTO autoren VALUES (2, 'Kym', 'Ivan', '2014-01-01 15:56:20.145+01', NULL);
INSERT INTO autoren VALUES (3, 'Ischi', 'Marcel', '2014-01-01 15:56:26.715+01', NULL);
INSERT INTO autoren VALUES (4, 'Gehrig', 'Urs', '2014-01-01 15:56:32.354+01', NULL);


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('autoren_id_seq', 4, true);


--
-- TOC entry 2059 (class 0 OID 18825)
-- Dependencies: 184
-- Data for Name: dokumente; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO dokumente VALUES (2, 'Notenskizze', 'IMG_0002_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (3, 'Notenskizze', 'IMG_0003_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (4, 'Notenskizze', 'IMG_0004_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (5, 'Notenskizze', 'IMG_0005_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (6, 'Notenskizze', 'IMG_0006_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (7, 'Notenskizze', 'IMG_0007_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (8, 'Notenskizze', 'IMG_0008_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (9, 'Notenskizze', 'IMG_0009_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (10, 'Notenskizze', 'IMG_0010_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (11, 'Notenskizze', 'IMG_0011_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (12, 'Notenskizze', 'IMG_0012_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (13, 'Notenskizze', 'IMG_0013_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (14, 'Notenskizze', 'IMG_0014_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (15, 'Notenskizze', 'IMG_0015_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (16, 'Notenskizze', 'IMG_0016_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (17, 'Notenskizze', 'IMG_0017_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (18, 'Notenskizze', 'IMG_0018_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (19, 'Notenskizze', 'IMG_0019_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (20, 'Notenskizze', 'IMG_0020_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (21, 'Notenskizze', 'IMG_0021_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (22, 'Notenskizze', 'IMG_0022_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (23, 'Notenskizze', 'IMG_0023_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (24, 'Notenskizze', 'IMG_0024_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (25, 'Notenskizze', 'IMG_0025_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (26, 'Notenskizze', 'IMG_0026_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (27, 'Notenskizze', 'IMG_0027_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (28, 'Notenskizze', 'IMG_0028_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (29, 'Notenskizze', 'IMG_0029_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (30, 'Notenskizze', 'IMG_0030_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (31, 'Notenskizze', 'IMG_0031_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (32, 'Notenskizze', 'IMG_0032_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (33, 'Notenskizze', 'IMG_0033_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (34, 'Notenskizze', 'IMG_0034_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (35, 'Notenskizze', 'IMG_0035_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (36, 'Notenskizze', 'IMG_0036_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (37, 'Notenskizze', 'IMG_0037_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (38, 'Notenskizze', 'IMG_0038_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (39, 'Notenskizze', 'IMG_0039_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (40, 'Notenskizze', 'IMG_0040_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (41, 'Notenskizze', 'IMG_0041_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (42, 'Notenskizze', 'IMG_0042_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (43, 'Notenskizze', 'IMG_0043_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (44, 'Notenskizze', 'IMG_0044_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (45, 'Notenskizze', 'IMG_0045_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (46, 'Notenskizze', 'IMG_0046_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (47, 'Notenskizze', 'IMG_0047_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (48, 'Notenskizze', 'IMG_0048_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (49, 'Notenskizze', 'IMG_0049_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (50, 'Notenskizze', 'IMG_0050_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (51, 'Notenskizze', 'IMG_0051_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (52, 'Notenskizze', 'IMG_0052_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (53, 'Notenskizze', 'IMG_0053_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (54, 'Notenskizze', 'IMG_0054_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (55, 'Notenskizze', 'IMG_0055_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (56, 'Notenskizze', 'IMG_0056_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (57, 'Notenskizze', 'IMG_0057_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (58, 'Notenskizze', 'IMG_0058_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (59, 'Notenskizze', 'IMG_0059_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (60, 'Notenskizze', 'IMG_0060_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (61, 'Notenskizze', 'IMG_0061_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (62, 'Notenskizze', 'IMG_0062_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (63, 'Notenskizze', 'IMG_0063_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (64, 'Notenskizze', 'IMG_0064_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (65, 'Notenskizze', 'IMG_0064_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (66, 'Notenskizze', 'IMG_0065_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (67, 'Notenskizze', 'IMG_0065_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (68, 'Notenskizze', 'IMG_0066_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (69, 'Notenskizze', 'IMG_0067_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (70, 'Notenskizze', 'IMG_0068_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (71, 'Notenskizze', 'IMG_0069_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (72, 'Notenskizze', 'IMG_0069_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (73, 'Notenskizze', 'IMG_0070_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (74, 'Notenskizze', 'IMG_0071_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (75, 'Notenskizze', 'IMG_0072_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (76, 'Notenskizze', 'IMG_0072_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (77, 'Notenskizze', 'IMG_0073_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (78, 'Notenskizze', 'IMG_0074_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (79, 'Notenskizze', 'IMG_0128_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (80, 'Notenskizze', 'IMG_0129_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (81, 'Notenskizze', 'IMG_0130_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (82, 'Notenskizze', 'IMG_0131_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (83, 'Notenskizze', 'IMG_0132_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (84, 'Notenskizze', 'IMG_0133_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (85, 'Notenskizze', 'IMG_0134_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (86, 'Notenskizze', 'IMG_0135_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (87, 'Notenskizze', 'IMG_0135_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (88, 'Notenskizze', 'IMG_0136_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (89, 'Notenskizze', 'IMG_0137_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (90, 'Notenskizze', 'IMG_0137_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (91, 'Notenskizze', 'IMG_0138_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (92, 'Notenskizze', 'IMG_0139_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (93, 'Notenskizze', 'IMG_0140_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (94, 'Notenskizze', 'IMG_0141_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (95, 'Notenskizze', 'IMG_0141_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (96, 'Notenskizze', 'IMG_0142_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (97, 'Notenskizze', 'IMG_0142_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (98, 'Notenskizze', 'IMG_0143_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (99, 'Notenskizze', 'IMG_0143_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (100, 'Notenskizze', 'IMG_0143_03.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (101, 'Notenskizze', 'IMG_0144_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (102, 'Notenskizze', 'IMG_0145_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (103, 'Notenskizze', 'IMG_0146_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (104, 'Notenskizze', 'IMG_0147_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (105, 'Notenskizze', 'IMG_0148_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (106, 'Notenskizze', 'IMG_0149_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (107, 'Notenskizze', 'IMG_0150_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (108, 'Notenskizze', 'IMG_0151_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (109, 'Notenskizze', 'IMG_0152_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (110, 'Notenskizze', 'IMG_0153_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (111, 'Notenskizze', 'IMG_0154_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (112, 'Notenskizze', 'IMG_0155_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (113, 'Notenskizze', 'IMG_0156_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (114, 'Notenskizze', 'IMG_0158_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (115, 'Notenskizze', 'IMG_0159_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (116, 'Notenskizze', 'IMG_0160_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (117, 'Notenskizze', 'IMG_0161_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (118, 'Notenskizze', 'IMG_0162_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (119, 'Notenskizze', 'IMG_0163_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (120, 'Notenskizze', 'IMG_0164_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (121, 'Notenskizze', 'IMG_0165_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (122, 'Notenskizze', 'IMG_0166_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (123, 'Notenskizze', 'IMG_0167_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (124, 'Notenskizze', 'IMG_0167_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (125, 'Notenskizze', 'IMG_0168_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (126, 'Notenskizze', 'IMG_0169_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (127, 'Notenskizze', 'IMG_0170_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (128, 'Notenskizze', 'IMG_0171_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (129, 'Notenskizze', 'IMG_0172_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (130, 'Notenskizze', 'IMG_0173_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (131, 'Notenskizze', 'IMG_0173_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (132, 'Notenskizze', 'IMG_0174_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (133, 'Notenskizze', 'IMG_0175_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (134, 'Notenskizze', 'IMG_0176_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (135, 'Notenskizze', 'IMG_0177_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (136, 'Notenskizze', 'IMG_0178_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (137, 'Notenskizze', 'IMG_0179_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (138, 'Notenskizze', 'IMG_0180_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (139, 'Notenskizze', 'IMG_0181_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (140, 'Notenskizze', 'IMG_0182_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (141, 'Notenskizze', 'IMG_0183_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (142, 'Notenskizze', 'IMG_0184_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (143, 'Notenskizze', 'IMG_0185_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (144, 'Notenskizze', 'IMG_0185_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (145, 'Notenskizze', 'IMG_0186_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (146, 'Notenskizze', 'IMG_0187_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (147, 'Notenskizze', 'IMG_0188_00.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (148, 'Notenskizze', 'IMG_0188_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (149, 'Notenskizze', 'IMG_0188_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (150, 'Notenskizze', 'IMG_0188_03.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (151, 'Notenskizze', 'IMG_0189_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (152, 'Notenskizze', 'IMG_0190_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (153, 'Notenskizze', 'IMG_0191_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (154, 'Notenskizze', 'IMG_0192_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (155, 'Notenskizze', 'IMG_0193_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (156, 'Notenskizze', 'IMG_0194_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (157, 'Notenskizze', 'IMG_0195_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (158, 'Notenskizze', 'IMG_0196_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (159, 'Notenskizze', 'IMG_0197_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (160, 'Notenskizze', 'IMG_0198_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (161, 'Notenskizze', 'IMG_0199_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (162, 'Notenskizze', 'IMG_0200_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (163, 'Notenskizze', 'IMG_0201_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (164, 'Notenskizze', 'IMG_0202_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (165, 'Notenskizze', 'IMG_0203_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (166, 'Notenskizze', 'IMG_0204_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (167, 'Notenskizze', 'IMG_0205_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (168, 'Notenskizze', 'IMG_0206_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (169, 'Notenskizze', 'IMG_0207_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (170, 'Notenskizze', 'IMG_0208_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (171, 'Notenskizze', 'IMG_0209_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (172, 'Notenskizze', 'IMG_0210_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (173, 'Notenskizze', 'IMG_0211_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (174, 'Notenskizze', 'IMG_0212_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (175, 'Notenskizze', 'IMG_0213_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (176, 'Notenskizze', 'IMG_0214_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (177, 'Notenskizze', 'IMG_0215_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (178, 'Notenskizze', 'IMG_0216_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (179, 'Notenskizze', 'IMG_0217_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (180, 'Notenskizze', 'IMG_0218_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (181, 'Notenskizze', 'IMG_0219_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (182, 'Notenskizze', 'IMG_0220_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (183, 'Notenskizze', 'IMG_0221_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (184, 'Notenskizze', 'IMG_0222_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (185, 'Notenskizze', 'IMG_0223_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (186, 'Notenskizze', 'IMG_0224_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (187, 'Notenskizze', 'IMG_0225_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (188, 'Notenskizze', 'IMG_0226_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (189, 'Notenskizze', 'IMG_0227_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (190, 'Notenskizze', 'IMG_0228_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (191, 'Notenskizze', 'IMG_0229_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (192, 'Notenskizze', 'IMG_0230_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (193, 'Notenskizze', 'IMG_0231_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (194, 'Notenskizze', 'IMG_0232_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (195, 'Notenskizze', 'IMG_0233_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (196, 'Notenskizze', 'IMG_0234_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (197, 'Notenskizze', 'IMG_0235_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (198, 'Notenskizze', 'IMG_0237_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (199, 'Notenskizze', 'IMG_0238_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (200, 'Notenskizze', 'IMG_0239_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (201, 'Notenskizze', 'IMG_0240_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (202, 'Notenskizze', 'IMG_0240_02.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (203, 'Notenskizze', 'IMG_0241_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (204, 'Notenskizze', 'IMG_0242_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (205, 'Notenskizze', 'IMG_0243_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (206, 'Notenskizze', 'IMG_0244_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (207, 'Notenskizze', 'IMG_0245_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (208, 'Notenskizze', 'IMG_0246_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (209, 'Notenskizze', 'IMG_0247_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (210, 'Notenskizze', 'IMG_0248_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (211, 'Notenskizze', 'IMG_0249_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (212, 'Notenskizze', 'IMG_0250_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (213, 'Notenskizze', 'IMG_0251_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (214, 'Notenskizze', 'IMG_0252_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (215, 'Notenskizze', 'IMG_0253_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (216, 'Notenskizze', 'IMG_0254_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (217, 'Notenskizze', 'IMG_0255_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (218, 'Notenskizze', 'IMG_0256_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (219, 'Notenskizze', 'IMG_0257_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (220, 'Notenskizze', 'IMG_0258_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (221, 'Notenskizze', 'IMG_0259_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (222, 'Notenskizze', 'IMG_0260_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (223, 'Notenskizze', 'IMG_0261_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (224, 'Notenskizze', 'IMG_0262_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (225, 'Notenskizze', 'IMG_0263_01.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:56:24.35+01', '2014-01-12 18:20:14.652+01');
INSERT INTO dokumente VALUES (1, 'Notenskizze', 'IMG_0001_01.jpg', 1, '2012-03-03', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-01-05 17:54:13.997+01', '2014-01-12 18:20:14.652+01');


--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 183
-- Name: dokumente_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('dokumente_id_seq', 225, true);


--
-- TOC entry 2061 (class 0 OID 19120)
-- Dependencies: 188
-- Data for Name: images_pdfs; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO images_pdfs VALUES (1, 'IMG', 1, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (2, 'IMG', 2, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (3, 'IMG', 3, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (4, 'IMG', 4, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (5, 'IMG', 5, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (6, 'IMG', 6, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (7, 'IMG', 7, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (8, 'IMG', 8, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (9, 'IMG', 9, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (10, 'IMG', 10, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (11, 'IMG', 11, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (12, 'IMG', 12, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (13, 'IMG', 13, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (14, 'IMG', 14, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (15, 'IMG', 15, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (16, 'IMG', 16, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (17, 'IMG', 17, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (18, 'IMG', 18, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (19, 'IMG', 19, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (20, 'IMG', 20, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (21, 'IMG', 21, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (22, 'IMG', 22, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (23, 'IMG', 23, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (24, 'IMG', 24, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (25, 'IMG', 25, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (26, 'IMG', 26, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (27, 'IMG', 27, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (28, 'IMG', 28, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (29, 'IMG', 29, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (30, 'IMG', 30, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (31, 'IMG', 31, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (32, 'IMG', 32, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (33, 'IMG', 33, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (34, 'IMG', 34, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (35, 'IMG', 35, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (36, 'IMG', 36, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (37, 'IMG', 37, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (38, 'IMG', 38, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (39, 'IMG', 39, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (40, 'IMG', 40, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (41, 'IMG', 41, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (42, 'IMG', 42, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (43, 'IMG', 43, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (44, 'IMG', 44, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (45, 'IMG', 45, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (46, 'IMG', 46, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (47, 'IMG', 47, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (48, 'IMG', 48, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (49, 'IMG', 49, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (50, 'IMG', 50, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (51, 'IMG', 51, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (52, 'IMG', 52, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (53, 'IMG', 53, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (54, 'IMG', 54, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (55, 'IMG', 55, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (56, 'IMG', 56, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (57, 'IMG', 57, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (58, 'IMG', 58, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (59, 'IMG', 59, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (60, 'IMG', 60, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (61, 'IMG', 61, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (62, 'IMG', 62, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (63, 'IMG', 63, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (64, 'IMG', 64, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (65, 'IMG', 64, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (66, 'IMG', 65, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (67, 'IMG', 65, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (68, 'IMG', 66, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (69, 'IMG', 67, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (70, 'IMG', 68, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (71, 'IMG', 69, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (72, 'IMG', 69, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (73, 'IMG', 70, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (74, 'IMG', 71, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (75, 'IMG', 72, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (76, 'IMG', 72, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (77, 'IMG', 73, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (78, 'IMG', 74, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (79, 'IMG', 128, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (80, 'IMG', 129, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (81, 'IMG', 130, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (82, 'IMG', 131, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (83, 'IMG', 132, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (84, 'IMG', 133, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (85, 'IMG', 134, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (86, 'IMG', 135, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (87, 'IMG', 135, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (88, 'IMG', 136, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (89, 'IMG', 137, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (90, 'IMG', 137, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (91, 'IMG', 138, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (92, 'IMG', 139, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (93, 'IMG', 140, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (94, 'IMG', 141, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (95, 'IMG', 141, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (96, 'IMG', 142, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (97, 'IMG', 142, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (98, 'IMG', 143, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (99, 'IMG', 143, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (100, 'IMG', 143, 3, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (101, 'IMG', 144, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (102, 'IMG', 145, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (103, 'IMG', 146, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (104, 'IMG', 147, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (105, 'IMG', 148, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (106, 'IMG', 149, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (107, 'IMG', 150, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (108, 'IMG', 151, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (109, 'IMG', 152, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (110, 'IMG', 153, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (111, 'IMG', 154, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (112, 'IMG', 155, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (113, 'IMG', 156, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (114, 'IMG', 158, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (115, 'IMG', 159, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (116, 'IMG', 160, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (117, 'IMG', 161, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (118, 'IMG', 162, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (119, 'IMG', 163, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (120, 'IMG', 164, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (121, 'IMG', 165, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (122, 'IMG', 166, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (123, 'IMG', 167, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (124, 'IMG', 167, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (125, 'IMG', 168, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (126, 'IMG', 169, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (127, 'IMG', 170, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (128, 'IMG', 171, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (129, 'IMG', 172, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (130, 'IMG', 173, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (131, 'IMG', 173, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (132, 'IMG', 174, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (133, 'IMG', 175, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (134, 'IMG', 176, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (135, 'IMG', 177, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (136, 'IMG', 178, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (137, 'IMG', 179, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (138, 'IMG', 180, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (139, 'IMG', 181, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (140, 'IMG', 182, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (141, 'IMG', 183, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (142, 'IMG', 184, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (143, 'IMG', 185, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (144, 'IMG', 185, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (145, 'IMG', 186, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (146, 'IMG', 187, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (147, 'IMG', 188, 0, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (148, 'IMG', 188, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (149, 'IMG', 188, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (150, 'IMG', 188, 3, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (151, 'IMG', 189, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (152, 'IMG', 190, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (153, 'IMG', 191, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (154, 'IMG', 192, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (155, 'IMG', 193, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (156, 'IMG', 194, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (157, 'IMG', 195, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (158, 'IMG', 196, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (159, 'IMG', 197, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (160, 'IMG', 198, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (161, 'IMG', 199, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (162, 'IMG', 200, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (163, 'IMG', 201, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (164, 'IMG', 202, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (165, 'IMG', 203, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (166, 'IMG', 204, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (167, 'IMG', 205, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (168, 'IMG', 206, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (169, 'IMG', 207, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (170, 'IMG', 208, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (171, 'IMG', 209, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (172, 'IMG', 210, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (173, 'IMG', 211, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (174, 'IMG', 212, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (175, 'IMG', 213, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (176, 'IMG', 214, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (177, 'IMG', 215, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (178, 'IMG', 216, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (179, 'IMG', 217, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (180, 'IMG', 218, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (181, 'IMG', 219, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (182, 'IMG', 220, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (183, 'IMG', 221, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (184, 'IMG', 222, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (185, 'IMG', 223, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (186, 'IMG', 224, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (187, 'IMG', 225, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (188, 'IMG', 226, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (189, 'IMG', 227, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (190, 'IMG', 228, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (191, 'IMG', 229, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (192, 'IMG', 230, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (193, 'IMG', 231, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (194, 'IMG', 232, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (195, 'IMG', 233, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (196, 'IMG', 234, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (197, 'IMG', 235, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (198, 'IMG', 237, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (199, 'IMG', 238, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (200, 'IMG', 239, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (201, 'IMG', 240, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (202, 'IMG', 240, 2, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (203, 'IMG', 241, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (204, 'IMG', 242, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (205, 'IMG', 243, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (206, 'IMG', 244, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (207, 'IMG', 245, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (208, 'IMG', 246, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (209, 'IMG', 247, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (210, 'IMG', 248, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (211, 'IMG', 249, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (212, 'IMG', 250, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (213, 'IMG', 251, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (214, 'IMG', 252, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (215, 'IMG', 253, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (216, 'IMG', 254, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (217, 'IMG', 255, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (218, 'IMG', 256, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (219, 'IMG', 257, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (220, 'IMG', 258, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (221, 'IMG', 259, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (222, 'IMG', 260, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (223, 'IMG', 261, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (224, 'IMG', 262, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);
INSERT INTO images_pdfs VALUES (225, 'IMG', 263, 1, 'jpg', '2014-01-12 17:46:01.668+01', NULL);


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 187
-- Name: images_pdfs_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('images_pdfs_id_seq', 1, false);


--
-- TOC entry 2057 (class 0 OID 18735)
-- Dependencies: 178
-- Data for Name: lt_notenschrift; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO lt_notenschrift VALUES (1, 1, 'Zündstoff');
INSERT INTO lt_notenschrift VALUES (2, 3, 'Basler Hieroglyphen, Stil: J.B.-Clique Santihans');
INSERT INTO lt_notenschrift VALUES (3, 2, 'Berger-Noten');
INSERT INTO lt_notenschrift VALUES (5, 4, 'Basler Hieroglyphen, Stil: Basler Mittwoch Gesellschaft');


--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 177
-- Name: lt_schrift_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('lt_schrift_id_seq', 5, true);


--
-- TOC entry 2053 (class 0 OID 18612)
-- Dependencies: 174
-- Data for Name: verlage; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO verlage VALUES (1, 'STV', 'Wallis', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (2, 'Berger', 'Basel', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (3, 'Zenker', 'Basel', '2014-01-01 16:14:43.025+01', NULL);


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 173
-- Name: verlage_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('verlage_id_seq', 3, true);


--
-- TOC entry 2055 (class 0 OID 18625)
-- Dependencies: 176
-- Data for Name: werke; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO werke VALUES (1, 'STV Band 1', 1, '2014-01-01 16:15:58.323+01', NULL);


--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 175
-- Name: werke_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('werke_id_seq', 1, true);


--
-- TOC entry 1903 (class 2606 OID 18584)
-- Name: pk_autoren; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autoren
    ADD CONSTRAINT pk_autoren PRIMARY KEY (id);


--
-- TOC entry 1920 (class 2606 OID 18835)
-- Name: pk_dokumente; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT pk_dokumente PRIMARY KEY (id);


--
-- TOC entry 1926 (class 2606 OID 19127)
-- Name: pk_id_images_pdfs; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY images_pdfs
    ADD CONSTRAINT pk_id_images_pdfs PRIMARY KEY (id);


--
-- TOC entry 1910 (class 2606 OID 18740)
-- Name: pk_lt_notenschrift; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lt_notenschrift
    ADD CONSTRAINT pk_lt_notenschrift PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 18621)
-- Name: pk_verlage; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY verlage
    ADD CONSTRAINT pk_verlage PRIMARY KEY (id);


--
-- TOC entry 1908 (class 2606 OID 18631)
-- Name: pk_werke; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT pk_werke PRIMARY KEY (id);


--
-- TOC entry 1911 (class 1259 OID 18851)
-- Name: fki_dokument_autor_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_autor_id ON dokumente USING btree (autor_id);


--
-- TOC entry 1912 (class 1259 OID 18852)
-- Name: fki_dokument_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_verlag_id ON dokumente USING btree (verlag_id);


--
-- TOC entry 1913 (class 1259 OID 18853)
-- Name: fki_dokument_werk_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_dokument_werk_id ON dokumente USING btree (werk_id);


--
-- TOC entry 1906 (class 1259 OID 18637)
-- Name: fki_werk_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_werk_verlag_id ON werke USING btree (verlag_id);


--
-- TOC entry 1914 (class 1259 OID 18854)
-- Name: idx_datum; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_datum ON dokumente USING btree (datum);


--
-- TOC entry 1921 (class 1259 OID 19128)
-- Name: idx_doc_extension_images_pdfs; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_doc_extension_images_pdfs ON images_pdfs USING btree (doc_extension);


--
-- TOC entry 1922 (class 1259 OID 19129)
-- Name: idx_id_images_pdfs; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_id_images_pdfs ON images_pdfs USING btree (id);


--
-- TOC entry 1923 (class 1259 OID 19130)
-- Name: idx_img_nr_images_pdfs; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img_nr_images_pdfs ON images_pdfs USING btree (img_nr);


--
-- TOC entry 1924 (class 1259 OID 19131)
-- Name: idx_img_subnr_images_pdfs; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_img_subnr_images_pdfs ON images_pdfs USING btree (img_subnr);


--
-- TOC entry 1915 (class 1259 OID 18858)
-- Name: idx_notenschrift_cd; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_notenschrift_cd ON dokumente USING btree (notenschrift_cd);


--
-- TOC entry 1916 (class 1259 OID 18855)
-- Name: idx_rhythmus_gemischt; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_gemischt ON dokumente USING btree (rhythmus_gemischt);


--
-- TOC entry 1917 (class 1259 OID 18856)
-- Name: idx_rhythmus_gerade; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_gerade ON dokumente USING btree (rhythmus_gerade);


--
-- TOC entry 1918 (class 1259 OID 18857)
-- Name: idx_rhythmus_ungerade; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_rhythmus_ungerade ON dokumente USING btree (rhythmus_ungerade);


--
-- TOC entry 1901 (class 1259 OID 18585)
-- Name: idx_skizzen_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_skizzen_id ON autoren USING btree (id);


--
-- TOC entry 1931 (class 2620 OID 18586)
-- Name: update_autoren_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_autoren_rec_last_updated BEFORE UPDATE ON autoren FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1934 (class 2620 OID 18859)
-- Name: update_dokumente_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_dokumente_rec_last_updated BEFORE UPDATE ON dokumente FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1935 (class 2620 OID 19132)
-- Name: update_images_pdfs_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_images_pdfs_rec_last_updated BEFORE UPDATE ON images_pdfs FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1932 (class 2620 OID 18622)
-- Name: update_verlage_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_verlage_rec_last_updated BEFORE UPDATE ON verlage FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1933 (class 2620 OID 18638)
-- Name: update_werke_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_werke_rec_last_updated BEFORE UPDATE ON werke FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1928 (class 2606 OID 18836)
-- Name: fk_dokument_autor_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_autor_id FOREIGN KEY (autor_id) REFERENCES autoren(id);


--
-- TOC entry 1929 (class 2606 OID 18841)
-- Name: fk_dokument_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 1930 (class 2606 OID 18846)
-- Name: fk_dokument_werk_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY dokumente
    ADD CONSTRAINT fk_dokument_werk_id FOREIGN KEY (werk_id) REFERENCES werke(id);


--
-- TOC entry 1927 (class 2606 OID 18632)
-- Name: fk_werk_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT fk_werk_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 7
-- Name: clique; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA clique FROM PUBLIC;
REVOKE ALL ON SCHEMA clique FROM postgres;
GRANT ALL ON SCHEMA clique TO postgres;
GRANT ALL ON SCHEMA clique TO clique_admin_group;


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 172
-- Name: autoren; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE autoren FROM PUBLIC;
REVOKE ALL ON TABLE autoren FROM postgres;
GRANT ALL ON TABLE autoren TO postgres;
GRANT ALL ON TABLE autoren TO clique_admin_group;


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE autoren_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE autoren_id_seq FROM postgres;
GRANT ALL ON SEQUENCE autoren_id_seq TO clique_admin_group;


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 184
-- Name: dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE dokumente FROM PUBLIC;
REVOKE ALL ON TABLE dokumente FROM postgres;
GRANT ALL ON TABLE dokumente TO postgres;
GRANT ALL ON TABLE dokumente TO clique_admin_group;


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 183
-- Name: dokumente_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE dokumente_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dokumente_id_seq FROM postgres;
GRANT ALL ON SEQUENCE dokumente_id_seq TO postgres;
GRANT ALL ON SEQUENCE dokumente_id_seq TO clique_admin_group;


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 188
-- Name: images_pdfs; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE images_pdfs FROM PUBLIC;
REVOKE ALL ON TABLE images_pdfs FROM postgres;
GRANT ALL ON TABLE images_pdfs TO postgres;
GRANT SELECT ON TABLE images_pdfs TO PUBLIC;
GRANT ALL ON TABLE images_pdfs TO clique_admin_group;


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 187
-- Name: images_pdfs_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE images_pdfs_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE images_pdfs_id_seq FROM postgres;
GRANT ALL ON SEQUENCE images_pdfs_id_seq TO postgres;
GRANT ALL ON SEQUENCE images_pdfs_id_seq TO clique_admin_group;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 178
-- Name: lt_notenschrift; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE lt_notenschrift FROM PUBLIC;
REVOKE ALL ON TABLE lt_notenschrift FROM postgres;
GRANT ALL ON TABLE lt_notenschrift TO postgres;
GRANT ALL ON TABLE lt_notenschrift TO clique_admin_group;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 177
-- Name: lt_schrift_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE lt_schrift_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE lt_schrift_id_seq FROM postgres;
GRANT ALL ON SEQUENCE lt_schrift_id_seq TO postgres;
GRANT ALL ON SEQUENCE lt_schrift_id_seq TO clique_admin_group;


--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 179
-- Name: v_autoren; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_autoren FROM PUBLIC;
REVOKE ALL ON TABLE v_autoren FROM postgres;
GRANT ALL ON TABLE v_autoren TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_autoren TO clique_admin_group;
GRANT SELECT ON TABLE v_autoren TO PUBLIC;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 185
-- Name: v_dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_dokumente FROM PUBLIC;
REVOKE ALL ON TABLE v_dokumente FROM postgres;
GRANT ALL ON TABLE v_dokumente TO postgres;
GRANT SELECT ON TABLE v_dokumente TO PUBLIC;
GRANT ALL ON TABLE v_dokumente TO clique_admin_group;


--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 189
-- Name: v_images_pdfs; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_images_pdfs FROM PUBLIC;
REVOKE ALL ON TABLE v_images_pdfs FROM postgres;
GRANT ALL ON TABLE v_images_pdfs TO postgres;
GRANT SELECT ON TABLE v_images_pdfs TO PUBLIC;
GRANT ALL ON TABLE v_images_pdfs TO clique_admin_group;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 174
-- Name: verlage; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE verlage FROM PUBLIC;
REVOKE ALL ON TABLE verlage FROM postgres;
GRANT ALL ON TABLE verlage TO postgres;
GRANT ALL ON TABLE verlage TO clique_admin_group;


--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 176
-- Name: werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE werke FROM PUBLIC;
REVOKE ALL ON TABLE werke FROM postgres;
GRANT ALL ON TABLE werke TO postgres;
GRANT ALL ON TABLE werke TO clique_admin_group;


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 186
-- Name: v_r_dokumente; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_r_dokumente FROM PUBLIC;
REVOKE ALL ON TABLE v_r_dokumente FROM postgres;
GRANT ALL ON TABLE v_r_dokumente TO postgres;
GRANT SELECT ON TABLE v_r_dokumente TO PUBLIC;
GRANT ALL ON TABLE v_r_dokumente TO clique_admin_group;


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 182
-- Name: v_r_werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_r_werke FROM PUBLIC;
REVOKE ALL ON TABLE v_r_werke FROM postgres;
GRANT ALL ON TABLE v_r_werke TO postgres;
GRANT SELECT ON TABLE v_r_werke TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_r_werke TO clique_admin_group;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 180
-- Name: v_verlage; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_verlage FROM PUBLIC;
REVOKE ALL ON TABLE v_verlage FROM postgres;
GRANT ALL ON TABLE v_verlage TO postgres;
GRANT SELECT ON TABLE v_verlage TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_verlage TO clique_admin_group;


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 181
-- Name: v_werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE v_werke FROM PUBLIC;
REVOKE ALL ON TABLE v_werke FROM postgres;
GRANT ALL ON TABLE v_werke TO postgres;
GRANT SELECT ON TABLE v_werke TO PUBLIC;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE v_werke TO clique_admin_group;


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 173
-- Name: verlage_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE verlage_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE verlage_id_seq FROM postgres;
GRANT ALL ON SEQUENCE verlage_id_seq TO postgres;
GRANT ALL ON SEQUENCE verlage_id_seq TO clique_admin_group;


--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 175
-- Name: werke_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE werke_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE werke_id_seq FROM postgres;
GRANT ALL ON SEQUENCE werke_id_seq TO postgres;
GRANT ALL ON SEQUENCE werke_id_seq TO clique_admin_group;


--
-- TOC entry 1555 (class 826 OID 18912)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: clique; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA clique REVOKE ALL ON TABLES  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA clique REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA clique GRANT SELECT ON TABLES  TO PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA clique GRANT ALL ON TABLES  TO clique_admin_group;


-- Completed on 2014-01-12 18:22:02

--
-- PostgreSQL database dump complete
--

