--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.2
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-01-01 16:48:16

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
-- TOC entry 198 (class 1255 OID 18511)
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
-- TOC entry 175 (class 1259 OID 18578)
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
-- TOC entry 174 (class 1259 OID 18576)
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
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 174
-- Name: autoren_id_seq1; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE autoren_id_seq1 OWNED BY autoren.id;


--
-- TOC entry 181 (class 1259 OID 18675)
-- Name: kompositionen; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE kompositionen (
    id integer NOT NULL,
    titel character varying(120),
    datum date,
    schrift_cd integer DEFAULT 1 NOT NULL,
    verlag_id integer,
    werk_id integer,
    autor_id integer,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.kompositionen OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 18673)
-- Name: kompositionen_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE kompositionen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.kompositionen_id_seq OWNER TO postgres;

--
-- TOC entry 2031 (class 0 OID 0)
-- Dependencies: 180
-- Name: kompositionen_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE kompositionen_id_seq OWNED BY kompositionen.id;


--
-- TOC entry 183 (class 1259 OID 18735)
-- Name: lt_schrift; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE lt_schrift (
    id integer NOT NULL,
    cd integer NOT NULL,
    schriftart character varying(80) NOT NULL
);


ALTER TABLE clique.lt_schrift OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 18733)
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
-- TOC entry 2032 (class 0 OID 0)
-- Dependencies: 182
-- Name: lt_schrift_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE lt_schrift_id_seq OWNED BY lt_schrift.id;


--
-- TOC entry 173 (class 1259 OID 18521)
-- Name: skizzen; Type: TABLE; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE TABLE skizzen (
    id integer NOT NULL,
    url character varying(180),
    autor_id integer,
    werk_id integer,
    vers_nr character varying,
    rhytmus_gerade boolean,
    rhythmus_ungerade boolean,
    rhythmus_gemischt boolean,
    rhythmus_bemerkungen character varying,
    copyright_datum date,
    rec_created timestamp with time zone DEFAULT now(),
    rec_last_updated timestamp with time zone
);


ALTER TABLE clique.skizzen OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 18519)
-- Name: skizzen_id_seq; Type: SEQUENCE; Schema: clique; Owner: postgres
--

CREATE SEQUENCE skizzen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clique.skizzen_id_seq OWNER TO postgres;

--
-- TOC entry 2034 (class 0 OID 0)
-- Dependencies: 172
-- Name: skizzen_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE skizzen_id_seq OWNED BY skizzen.id;


--
-- TOC entry 177 (class 1259 OID 18612)
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
-- TOC entry 176 (class 1259 OID 18610)
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
-- TOC entry 2036 (class 0 OID 0)
-- Dependencies: 176
-- Name: verlage_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE verlage_id_seq OWNED BY verlage.id;


--
-- TOC entry 179 (class 1259 OID 18625)
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
-- TOC entry 178 (class 1259 OID 18623)
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
-- TOC entry 2038 (class 0 OID 0)
-- Dependencies: 178
-- Name: werke_id_seq; Type: SEQUENCE OWNED BY; Schema: clique; Owner: postgres
--

ALTER SEQUENCE werke_id_seq OWNED BY werke.id;


--
-- TOC entry 1862 (class 2604 OID 18581)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY autoren ALTER COLUMN id SET DEFAULT nextval('autoren_id_seq1'::regclass);


--
-- TOC entry 1868 (class 2604 OID 18678)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY kompositionen ALTER COLUMN id SET DEFAULT nextval('kompositionen_id_seq'::regclass);


--
-- TOC entry 1871 (class 2604 OID 18738)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY lt_schrift ALTER COLUMN id SET DEFAULT nextval('lt_schrift_id_seq'::regclass);


--
-- TOC entry 1860 (class 2604 OID 18524)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY skizzen ALTER COLUMN id SET DEFAULT nextval('skizzen_id_seq'::regclass);


--
-- TOC entry 1864 (class 2604 OID 18615)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY verlage ALTER COLUMN id SET DEFAULT nextval('verlage_id_seq'::regclass);


--
-- TOC entry 1866 (class 2604 OID 18628)
-- Name: id; Type: DEFAULT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke ALTER COLUMN id SET DEFAULT nextval('werke_id_seq'::regclass);


--
-- TOC entry 2013 (class 0 OID 18578)
-- Dependencies: 175
-- Data for Name: autoren; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO autoren VALUES (1, 'Rolli', 'David', '2014-01-01 15:55:57.558+01', NULL);
INSERT INTO autoren VALUES (2, 'Kym', 'Ivan', '2014-01-01 15:56:20.145+01', NULL);
INSERT INTO autoren VALUES (3, 'Ischi', 'Marcel', '2014-01-01 15:56:26.715+01', NULL);
INSERT INTO autoren VALUES (4, 'Gehrig', 'Urs', '2014-01-01 15:56:32.354+01', NULL);


--
-- TOC entry 2039 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('autoren_id_seq', 1, false);


--
-- TOC entry 2040 (class 0 OID 0)
-- Dependencies: 174
-- Name: autoren_id_seq1; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('autoren_id_seq1', 4, true);


--
-- TOC entry 2019 (class 0 OID 18675)
-- Dependencies: 181
-- Data for Name: kompositionen; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO kompositionen VALUES (1, 'Parkinson & Son', '1984-02-11', 1, NULL, NULL, 1, '2014-01-01 16:34:57.507+01', NULL);


--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 180
-- Name: kompositionen_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('kompositionen_id_seq', 1, true);


--
-- TOC entry 2021 (class 0 OID 18735)
-- Dependencies: 183
-- Data for Name: lt_schrift; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO lt_schrift VALUES (1, 1, 'Zündstoff');
INSERT INTO lt_schrift VALUES (2, 3, 'Basler Hieroglyphen, Stil: J.B.-Clique Santihans');
INSERT INTO lt_schrift VALUES (3, 2, 'Berger-Noten');
INSERT INTO lt_schrift VALUES (5, 4, 'Basler Hieroglyphen, Stil: Basler Mittwoch Gesellschaft');


--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 182
-- Name: lt_schrift_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('lt_schrift_id_seq', 5, true);


--
-- TOC entry 2011 (class 0 OID 18521)
-- Dependencies: 173
-- Data for Name: skizzen; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO skizzen VALUES (2, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0002_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:35:56.581+01', NULL);
INSERT INTO skizzen VALUES (1, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0001_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:34:42.781+01', '2014-01-01 15:36:42.278+01');
INSERT INTO skizzen VALUES (3, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0003_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (4, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0004_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (5, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0005_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (6, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0006_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (7, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0007_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (8, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0008_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (9, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0009_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (10, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0010_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (11, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0011_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (12, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0012_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (13, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0013_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (14, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0014_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (15, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0015_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (16, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0016_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (17, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0017_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (18, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0018_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (19, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0019_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (20, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0020_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (21, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0021_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (22, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0022_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (23, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0023_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (24, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0024_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (25, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0025_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (26, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0026_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (27, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0027_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (28, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0028_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (29, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0029_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (30, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0030_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (31, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0031_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (32, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0032_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (33, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0033_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (34, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0034_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (35, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0035_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (36, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0036_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (37, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0037_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (38, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0038_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (39, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0039_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (40, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0040_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (41, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0041_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (42, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0042_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (43, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0043_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (44, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0044_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (45, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0045_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (46, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0046_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (47, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0047_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (48, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0048_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (49, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0049_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (50, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0050_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (51, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0051_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (52, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0052_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (53, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0053_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (54, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0054_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (55, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0055_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (56, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0056_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (57, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0057_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (58, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0058_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (59, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0059_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (60, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0060_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (61, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0061_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (62, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0062_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (63, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0063_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (64, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0064_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (65, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0064_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (66, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0065_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (67, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0065_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (68, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0066_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (69, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0067_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (70, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0068_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (71, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0069_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (72, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0069_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (73, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0070_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (74, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0071_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (75, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0072_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (76, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0072_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (77, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0073_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (78, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0074_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (79, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0128_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (80, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0129_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (81, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0130_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (82, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0131_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (83, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0132_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (84, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0133_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (85, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0134_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (86, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0135_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (87, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0135_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (88, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0136_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (89, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0137_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (90, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0137_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (91, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0138_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (92, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0139_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (93, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0140_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (94, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0141_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (95, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0141_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (96, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0142_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (97, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0142_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (98, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0143_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (99, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0143_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (100, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0143_03.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (101, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0144_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (102, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0145_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (103, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0146_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (104, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0147_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (105, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0148_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (106, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0149_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (107, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0150_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (108, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0151_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (109, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0152_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (110, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0153_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (111, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0154_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (112, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0155_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (113, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0156_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (114, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0158_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (115, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0159_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (116, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0160_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (117, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0161_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (118, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0162_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (119, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0163_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (120, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0164_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (121, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0165_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (122, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0166_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (123, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0167_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (124, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0167_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (125, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0168_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (126, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0169_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (127, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0170_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (128, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0171_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (129, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0172_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (130, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0173_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (131, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0173_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (132, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0174_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (133, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0175_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (134, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0176_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (135, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0177_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (136, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0178_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (137, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0179_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (138, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0180_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (139, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0181_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (140, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0182_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (141, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0183_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (142, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0184_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (143, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0185_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (144, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0185_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (145, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0186_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (146, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0187_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (147, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0188_00.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (148, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0188_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (149, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0188_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (150, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0188_03.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (151, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0189_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (152, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0190_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (153, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0191_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (154, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0192_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (155, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0193_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (156, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0194_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (157, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0195_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (158, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0196_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (159, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0197_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (160, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0198_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (161, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0199_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (162, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0200_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (163, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0201_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (164, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0202_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (165, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0203_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (166, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0204_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (167, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0205_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (168, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0206_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (169, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0207_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (170, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0208_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (171, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0209_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (172, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0210_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (173, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0211_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (174, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0212_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (175, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0213_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (176, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0214_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (177, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0215_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (178, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0216_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (179, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0217_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (180, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0218_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (181, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0219_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (182, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0220_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (183, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0221_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (184, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0222_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (185, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0223_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (186, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0224_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (187, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0225_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (188, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0226_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (189, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0227_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (190, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0228_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (191, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0229_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (192, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0230_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (193, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0231_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (194, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0232_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (195, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0233_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (196, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0234_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (197, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0235_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (198, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0237_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (199, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0238_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (200, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0239_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (201, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0240_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (202, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0240_02.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (203, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0241_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (204, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0242_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (205, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0243_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (206, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0244_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (207, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0245_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (208, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0246_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (209, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0247_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (210, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0248_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (211, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0249_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (212, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0250_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (213, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0251_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (214, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0252_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (215, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0253_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (216, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0254_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (217, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0255_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (218, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0256_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (219, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0257_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (220, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0258_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (221, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0259_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (222, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0260_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (223, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0261_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (224, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0262_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);
INSERT INTO skizzen VALUES (225, 'http://www.rbrains.ch/clique/ausbildung/skizzen/IMG_0263_01.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2013-03-03', '2014-01-01 15:36:59.718+01', NULL);


--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 172
-- Name: skizzen_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('skizzen_id_seq', 225, true);


--
-- TOC entry 2015 (class 0 OID 18612)
-- Dependencies: 177
-- Data for Name: verlage; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO verlage VALUES (1, 'STV', 'Wallis', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (2, 'Berger', 'Basel', '2014-01-01 16:14:43.025+01', NULL);
INSERT INTO verlage VALUES (3, 'Zenker', 'Basel', '2014-01-01 16:14:43.025+01', NULL);


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 176
-- Name: verlage_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('verlage_id_seq', 3, true);


--
-- TOC entry 2017 (class 0 OID 18625)
-- Dependencies: 179
-- Data for Name: werke; Type: TABLE DATA; Schema: clique; Owner: postgres
--

INSERT INTO werke VALUES (1, 'STV Band 1', 1, '2014-01-01 16:15:58.323+01', NULL);


--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 178
-- Name: werke_id_seq; Type: SEQUENCE SET; Schema: clique; Owner: postgres
--

SELECT pg_catalog.setval('werke_id_seq', 1, true);


--
-- TOC entry 1878 (class 2606 OID 18584)
-- Name: pk_autoren; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autoren
    ADD CONSTRAINT pk_autoren PRIMARY KEY (id);


--
-- TOC entry 1888 (class 2606 OID 18682)
-- Name: pk_kompositionen; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY kompositionen
    ADD CONSTRAINT pk_kompositionen PRIMARY KEY (id);


--
-- TOC entry 1890 (class 2606 OID 18740)
-- Name: pk_lt_schrift; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lt_schrift
    ADD CONSTRAINT pk_lt_schrift PRIMARY KEY (id);


--
-- TOC entry 1875 (class 2606 OID 18530)
-- Name: pk_skizzen; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY skizzen
    ADD CONSTRAINT pk_skizzen PRIMARY KEY (id);


--
-- TOC entry 1880 (class 2606 OID 18621)
-- Name: pk_verlage; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY verlage
    ADD CONSTRAINT pk_verlage PRIMARY KEY (id);


--
-- TOC entry 1883 (class 2606 OID 18631)
-- Name: pk_werke; Type: CONSTRAINT; Schema: clique; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT pk_werke PRIMARY KEY (id);


--
-- TOC entry 1884 (class 1259 OID 18698)
-- Name: fki_komposition_autor_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_komposition_autor_id ON kompositionen USING btree (autor_id);


--
-- TOC entry 1885 (class 1259 OID 18699)
-- Name: fki_komposition_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_komposition_verlag_id ON kompositionen USING btree (verlag_id);


--
-- TOC entry 1886 (class 1259 OID 18700)
-- Name: fki_komposition_werk_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_komposition_werk_id ON kompositionen USING btree (werk_id);


--
-- TOC entry 1872 (class 1259 OID 18541)
-- Name: fki_skizze_autor_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_skizze_autor_id ON skizzen USING btree (autor_id);


--
-- TOC entry 1873 (class 1259 OID 18542)
-- Name: fki_skizze_werk_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_skizze_werk_id ON skizzen USING btree (werk_id);


--
-- TOC entry 1881 (class 1259 OID 18637)
-- Name: fki_werk_verlag_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_werk_verlag_id ON werke USING btree (verlag_id);


--
-- TOC entry 1876 (class 1259 OID 18585)
-- Name: idx_skizzen_id; Type: INDEX; Schema: clique; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_skizzen_id ON autoren USING btree (id);


--
-- TOC entry 1898 (class 2620 OID 18586)
-- Name: update_autoren_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_autoren_rec_last_updated BEFORE UPDATE ON autoren FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1901 (class 2620 OID 18701)
-- Name: update_kompositionen_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_kompositionen_rec_last_updated BEFORE UPDATE ON kompositionen FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1897 (class 2620 OID 18543)
-- Name: update_skizzen_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_skizzen_rec_last_updated BEFORE UPDATE ON skizzen FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1899 (class 2620 OID 18622)
-- Name: update_verlage_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_verlage_rec_last_updated BEFORE UPDATE ON verlage FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1900 (class 2620 OID 18638)
-- Name: update_werke_rec_last_updated; Type: TRIGGER; Schema: clique; Owner: postgres
--

CREATE TRIGGER update_werke_rec_last_updated BEFORE UPDATE ON werke FOR EACH ROW EXECUTE PROCEDURE update_rec_last_updated_column();


--
-- TOC entry 1894 (class 2606 OID 18683)
-- Name: fk_komposition_autor_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY kompositionen
    ADD CONSTRAINT fk_komposition_autor_id FOREIGN KEY (autor_id) REFERENCES autoren(id);


--
-- TOC entry 1895 (class 2606 OID 18688)
-- Name: fk_komposition_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY kompositionen
    ADD CONSTRAINT fk_komposition_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 1896 (class 2606 OID 18693)
-- Name: fk_komposition_werk_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY kompositionen
    ADD CONSTRAINT fk_komposition_werk_id FOREIGN KEY (werk_id) REFERENCES werke(id);


--
-- TOC entry 1891 (class 2606 OID 18655)
-- Name: fk_skizze_autor_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY skizzen
    ADD CONSTRAINT fk_skizze_autor_id FOREIGN KEY (autor_id) REFERENCES autoren(id);


--
-- TOC entry 1893 (class 2606 OID 18632)
-- Name: fk_werk_verlag_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY werke
    ADD CONSTRAINT fk_werk_verlag_id FOREIGN KEY (verlag_id) REFERENCES verlage(id);


--
-- TOC entry 1892 (class 2606 OID 18660)
-- Name: kf_skizze_werk_id; Type: FK CONSTRAINT; Schema: clique; Owner: postgres
--

ALTER TABLE ONLY skizzen
    ADD CONSTRAINT kf_skizze_werk_id FOREIGN KEY (werk_id) REFERENCES werke(id);


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 7
-- Name: clique; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA clique FROM PUBLIC;
REVOKE ALL ON SCHEMA clique FROM postgres;
GRANT ALL ON SCHEMA clique TO postgres;
GRANT ALL ON SCHEMA clique TO clique_admins;


--
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 175
-- Name: autoren; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE autoren FROM PUBLIC;
REVOKE ALL ON TABLE autoren FROM postgres;
GRANT ALL ON TABLE autoren TO postgres;
GRANT ALL ON TABLE autoren TO clique_admins;


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 171
-- Name: autoren_id_seq; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON SEQUENCE autoren_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE autoren_id_seq FROM postgres;
GRANT ALL ON SEQUENCE autoren_id_seq TO postgres;
GRANT ALL ON SEQUENCE autoren_id_seq TO clique_admins;


--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 181
-- Name: kompositionen; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE kompositionen FROM PUBLIC;
REVOKE ALL ON TABLE kompositionen FROM postgres;
GRANT ALL ON TABLE kompositionen TO postgres;
GRANT ALL ON TABLE kompositionen TO clique_admins;


--
-- TOC entry 2033 (class 0 OID 0)
-- Dependencies: 173
-- Name: skizzen; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE skizzen FROM PUBLIC;
REVOKE ALL ON TABLE skizzen FROM postgres;
GRANT ALL ON TABLE skizzen TO postgres;
GRANT ALL ON TABLE skizzen TO clique_admins;


--
-- TOC entry 2035 (class 0 OID 0)
-- Dependencies: 177
-- Name: verlage; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE verlage FROM PUBLIC;
REVOKE ALL ON TABLE verlage FROM postgres;
GRANT ALL ON TABLE verlage TO postgres;
GRANT ALL ON TABLE verlage TO clique_admins;


--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 179
-- Name: werke; Type: ACL; Schema: clique; Owner: postgres
--

REVOKE ALL ON TABLE werke FROM PUBLIC;
REVOKE ALL ON TABLE werke FROM postgres;
GRANT ALL ON TABLE werke TO postgres;
GRANT ALL ON TABLE werke TO clique_admins;


-- Completed on 2014-01-01 16:48:16

--
-- PostgreSQL database dump complete
--

