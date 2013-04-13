--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-04-14 01:00:06 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1979 (class 1262 OID 16588)
-- Name: iwm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE iwm WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'pl_PL.UTF-8' LC_CTYPE = 'pl_PL.UTF-8';


ALTER DATABASE iwm OWNER TO postgres;

\connect iwm

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 178 (class 3079 OID 11645)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 178
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 190 (class 1255 OID 16589)
-- Dependencies: 540 6
-- Name: xor(boolean, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xor(arg1 boolean, arg2 boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN
RETURN ( arg1 and not arg2) or ( not arg1 and arg2);
END$$;


ALTER FUNCTION public.xor(arg1 boolean, arg2 boolean) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 16590)
-- Dependencies: 1904 1905 6
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE patients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date date DEFAULT '2013-03-24'::date,
    status character varying(50) DEFAULT NULL::character varying,
    description text,
    room_id integer,
    owner_id integer
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 16598)
-- Dependencies: 6 161
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patients_id_seq OWNER TO postgres;

--
-- TOC entry 1983 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- TOC entry 163 (class 1259 OID 16600)
-- Dependencies: 1907 6
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE photos (
    id integer NOT NULL,
    patient_id integer,
    filename character varying(255) DEFAULT NULL::character varying,
    title character varying(255),
    x_count integer,
    y_count integer,
    width integer,
    height integer
);


ALTER TABLE public.photos OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 16607)
-- Dependencies: 163 6
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO postgres;

--
-- TOC entry 1984 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- TOC entry 165 (class 1259 OID 16609)
-- Dependencies: 1910 6
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    patient_id integer,
    tag_id integer,
    owner_id integer,
    content text,
    CONSTRAINT thread_fk CHECK (xor((patient_id IS NULL), (tag_id IS NULL)))
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 16616)
-- Dependencies: 6 165
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO postgres;

--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- TOC entry 176 (class 1259 OID 16734)
-- Dependencies: 6
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 16731)
-- Dependencies: 1922 6
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16743)
-- Dependencies: 6
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 16618)
-- Dependencies: 6
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rooms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    owner_id integer
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 16621)
-- Dependencies: 6 167
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO postgres;

--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 168
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 169 (class 1259 OID 16623)
-- Dependencies: 1912 1913 1914 6
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    photo_id integer,
    owner_id integer,
    title character varying(255) DEFAULT ''::character varying,
    x integer DEFAULT 0,
    y integer DEFAULT 0
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 16629)
-- Dependencies: 6 169
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 170
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 171 (class 1259 OID 16631)
-- Dependencies: 6
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255),
    logins integer,
    last_login integer,
    full_name character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16637)
-- Dependencies: 171 6
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 172
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 173 (class 1259 OID 16639)
-- Dependencies: 1917 1918 1919 1920 6
-- Name: views; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE views (
    id integer NOT NULL,
    owner_id integer,
    status character varying(50) DEFAULT NULL::character varying,
    photo_id integer,
    x integer DEFAULT 0,
    y integer DEFAULT 0,
    scale double precision DEFAULT 1,
    contrast double precision,
    brightness double precision
);


ALTER TABLE public.views OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16646)
-- Dependencies: 6 173
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.views_id_seq OWNER TO postgres;

--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 174
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1906 (class 2604 OID 16648)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1908 (class 2604 OID 16649)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1909 (class 2604 OID 16650)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1911 (class 2604 OID 16651)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1915 (class 2604 OID 16652)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 16653)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1921 (class 2604 OID 16654)
-- Dependencies: 174 173
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 1958 (class 0 OID 16590)
-- Dependencies: 161 1975
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO patients VALUES (1, 'Jan', '2013-03-24', 'CRITICAL', 'Ostry przypadek niewydolności mózgowej spowodowanej wystawieniem na szkodliwy wpływ pseudo-bazy danych.', 1, 2);


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patients_id_seq', 1, true);


--
-- TOC entry 1960 (class 0 OID 16600)
-- Dependencies: 163 1975
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO photos VALUES (1, 1, 'xray.jpg', 'Prześwietlenie', 1, 1, 200, 200);
INSERT INTO photos VALUES (11, 1, 'Katie_Melua_9_1600x1200_Wallpaper.jpg', 'Katie', 8, 6, 1600, 1200);
INSERT INTO photos VALUES (14, 1, 'Skull_x-ray.jpg', 'Czaszka', 3, 1, 648, 463);
INSERT INTO photos VALUES (13, 1, 'monica.jpeg', 'Monica', 4, 1, 800, 533);


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 14, true);


--
-- TOC entry 1962 (class 0 OID 16609)
-- Dependencies: 165 1975
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO posts VALUES (1, 1, NULL, 2, 'Zalecam pavulonik.');
INSERT INTO posts VALUES (2, NULL, 1, 1, 'Chyba tak.');
INSERT INTO posts VALUES (3, NULL, 2, 1, 'Chyba nie.');
INSERT INTO posts VALUES (4, NULL, 1, 2, 'Na pewno nie.');


--
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 4, true);


--
-- TOC entry 1972 (class 0 OID 16731)
-- Dependencies: 175 1975
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles VALUES (1, 'login', 'Podstawowa rola umożliwiająca logowanie');


--
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 176
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 1974 (class 0 OID 16743)
-- Dependencies: 177 1975
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles_users VALUES (7, 1);


--
-- TOC entry 1964 (class 0 OID 16618)
-- Dependencies: 167 1975
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rooms VALUES (1, 'OIOM', 1);


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 168
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 1, true);


--
-- TOC entry 1966 (class 0 OID 16623)
-- Dependencies: 169 1975
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tags VALUES (1, 1, 1, 'Guz', 5, 8);
INSERT INTO tags VALUES (2, 1, 2, 'Tasiemiec', 12, 15);


--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 170
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 2, true);


--
-- TOC entry 1968 (class 0 OID 16631)
-- Dependencies: 171 1975
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES (1, 'test_user', 'user', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (2, 'nxt_user', 'paswd', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (7, 'admin@admin.pl', 'admin', '586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6', NULL, NULL, 'Administrator');


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 172
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- TOC entry 1970 (class 0 OID 16639)
-- Dependencies: 173 1975
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO views VALUES (1, 1, 'PUBLIC', 1, 0, 0, 1, NULL, NULL);
INSERT INTO views VALUES (2, 2, 'PRIVATE', 1, 10, 10, 1.19999999999999996, NULL, NULL);


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 174
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('views_id_seq', 2, true);


--
-- TOC entry 1924 (class 2606 OID 16656)
-- Dependencies: 161 161 1976
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1926 (class 2606 OID 16658)
-- Dependencies: 161 161 1976
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1930 (class 2606 OID 16660)
-- Dependencies: 165 165 1976
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1928 (class 2606 OID 16662)
-- Dependencies: 163 163 1976
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1944 (class 2606 OID 16749)
-- Dependencies: 175 175 1976
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1946 (class 2606 OID 16747)
-- Dependencies: 177 177 177 1976
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1932 (class 2606 OID 16664)
-- Dependencies: 167 167 1976
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1934 (class 2606 OID 16666)
-- Dependencies: 167 167 1976
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 1936 (class 2606 OID 16668)
-- Dependencies: 169 169 1976
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 1938 (class 2606 OID 16670)
-- Dependencies: 171 171 1976
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 1940 (class 2606 OID 16672)
-- Dependencies: 171 171 1976
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1942 (class 2606 OID 16674)
-- Dependencies: 173 173 1976
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 16675)
-- Dependencies: 1939 161 171 1976
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1948 (class 2606 OID 16680)
-- Dependencies: 1933 167 161 1976
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- TOC entry 1949 (class 2606 OID 16685)
-- Dependencies: 163 161 1925 1976
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1950 (class 2606 OID 16690)
-- Dependencies: 165 171 1939 1976
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1951 (class 2606 OID 16695)
-- Dependencies: 165 161 1925 1976
-- Name: posts_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1952 (class 2606 OID 16700)
-- Dependencies: 165 169 1935 1976
-- Name: posts_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- TOC entry 1953 (class 2606 OID 16705)
-- Dependencies: 1939 171 167 1976
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1954 (class 2606 OID 16710)
-- Dependencies: 1939 169 171 1976
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1955 (class 2606 OID 16715)
-- Dependencies: 163 169 1927 1976
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);


--
-- TOC entry 1956 (class 2606 OID 16720)
-- Dependencies: 1939 171 173 1976
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1957 (class 2606 OID 16725)
-- Dependencies: 163 1927 173 1976
-- Name: views_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-04-14 01:00:06 CEST

--
-- PostgreSQL database dump complete
--

