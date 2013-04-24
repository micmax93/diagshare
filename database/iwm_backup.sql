--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-04-25 01:44:41 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1979 (class 1262 OID 16699)
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
-- TOC entry 190 (class 1255 OID 16700)
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
-- TOC entry 161 (class 1259 OID 16701)
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
-- TOC entry 162 (class 1259 OID 16709)
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
-- TOC entry 163 (class 1259 OID 16711)
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
-- TOC entry 164 (class 1259 OID 16718)
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
-- TOC entry 165 (class 1259 OID 16720)
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
-- TOC entry 166 (class 1259 OID 16727)
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
-- TOC entry 167 (class 1259 OID 16729)
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
-- TOC entry 168 (class 1259 OID 16731)
-- Dependencies: 1911 6
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 16738)
-- Dependencies: 6
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 16741)
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
-- TOC entry 171 (class 1259 OID 16744)
-- Dependencies: 170 6
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
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 172 (class 1259 OID 16746)
-- Dependencies: 1913 1914 1915 6
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
-- TOC entry 173 (class 1259 OID 16752)
-- Dependencies: 172 6
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
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 174 (class 1259 OID 16754)
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
-- TOC entry 175 (class 1259 OID 16760)
-- Dependencies: 6 174
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
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 176 (class 1259 OID 16762)
-- Dependencies: 1918 1919 1920 1921 6
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
-- TOC entry 177 (class 1259 OID 16769)
-- Dependencies: 6 176
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
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1906 (class 2604 OID 16771)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1908 (class 2604 OID 16772)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1909 (class 2604 OID 16773)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1912 (class 2604 OID 16774)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 16775)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 16776)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1922 (class 2604 OID 16777)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 1958 (class 0 OID 16701)
-- Dependencies: 161 1975
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO patients VALUES (1, 'Jasiu', '2013-03-24', 'CRITICAL', 'Ostry przypadek niewydolności mózgowej spowodowanej wystawieniem na szkodliwy wpływ pseudo-bazy danych.', 1, 2);


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patients_id_seq', 23, true);


--
-- TOC entry 1960 (class 0 OID 16711)
-- Dependencies: 163 1975
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO photos VALUES (1, 1, 'xray.jpg', 'Prześwietlenie', 1, 1, 200, 200);
INSERT INTO photos VALUES (38, 1, 'Katie_Melua_by_Swezzels.jpg', 'Katie_Grafika', 6, 6, 1548, 1308);


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 44, true);


--
-- TOC entry 1962 (class 0 OID 16720)
-- Dependencies: 165 1975
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO posts VALUES (5, NULL, 117, 7, 'Tak to jest palec');
INSERT INTO posts VALUES (6, NULL, 117, 7, '');
INSERT INTO posts VALUES (7, NULL, 117, 7, ':>');
INSERT INTO posts VALUES (8, NULL, 117, 7, 'lol');
INSERT INTO posts VALUES (9, NULL, 117, 7, '');
INSERT INTO posts VALUES (10, NULL, 117, 7, '');


--
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 10, true);


--
-- TOC entry 1965 (class 0 OID 16731)
-- Dependencies: 168 1975
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles VALUES (1, 'login', 'Podstawowa rola umożliwiająca logowanie');


--
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 167
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 1966 (class 0 OID 16738)
-- Dependencies: 169 1975
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles_users VALUES (7, 1);


--
-- TOC entry 1967 (class 0 OID 16741)
-- Dependencies: 170 1975
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rooms VALUES (1, 'OIOM', 1);
INSERT INTO rooms VALUES (2, 'Neurologia', 1);


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 2, true);


--
-- TOC entry 1969 (class 0 OID 16746)
-- Dependencies: 172 1975
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tags VALUES (115, 1, 7, 'Kciuk prawej ręki', 110, 87);
INSERT INTO tags VALUES (116, 1, 7, 'Kciuk lewej dłoni', 92, 93);
INSERT INTO tags VALUES (117, 1, 7, 'Palec wskazujący prawej dłoni', 129, 22);
INSERT INTO tags VALUES (129, 1, 7, 'Lewy palec', 70, 21);


--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 129, true);


--
-- TOC entry 1971 (class 0 OID 16754)
-- Dependencies: 174 1975
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES (1, 'test_user', 'user', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (2, 'nxt_user', 'paswd', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (7, 'admin@admin.pl', 'admin', '586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6', NULL, 1366846382, 'Administrator');


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- TOC entry 1973 (class 0 OID 16762)
-- Dependencies: 176 1975
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO views VALUES (1, 1, 'PUBLIC', 1, 0, 0, 1, NULL, NULL);
INSERT INTO views VALUES (2, 2, 'PRIVATE', 1, 10, 10, 1.19999999999999996, NULL, NULL);


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('views_id_seq', 2, true);


--
-- TOC entry 1924 (class 2606 OID 16779)
-- Dependencies: 161 161 1976
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1926 (class 2606 OID 16781)
-- Dependencies: 161 161 1976
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1930 (class 2606 OID 16783)
-- Dependencies: 165 165 1976
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1928 (class 2606 OID 16785)
-- Dependencies: 163 163 1976
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1932 (class 2606 OID 16787)
-- Dependencies: 168 168 1976
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1934 (class 2606 OID 16789)
-- Dependencies: 169 169 169 1976
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1936 (class 2606 OID 16791)
-- Dependencies: 170 170 1976
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1938 (class 2606 OID 16793)
-- Dependencies: 170 170 1976
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 1940 (class 2606 OID 16795)
-- Dependencies: 172 172 1976
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 1942 (class 2606 OID 16797)
-- Dependencies: 174 174 1976
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 1944 (class 2606 OID 16799)
-- Dependencies: 174 174 1976
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1946 (class 2606 OID 16801)
-- Dependencies: 176 176 1976
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 16802)
-- Dependencies: 161 1943 174 1976
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1948 (class 2606 OID 16807)
-- Dependencies: 161 1937 170 1976
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- TOC entry 1949 (class 2606 OID 16812)
-- Dependencies: 163 1925 161 1976
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1950 (class 2606 OID 16817)
-- Dependencies: 165 1943 174 1976
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1951 (class 2606 OID 16822)
-- Dependencies: 165 1925 161 1976
-- Name: posts_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1952 (class 2606 OID 16827)
-- Dependencies: 1939 172 165 1976
-- Name: posts_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- TOC entry 1953 (class 2606 OID 16832)
-- Dependencies: 174 1943 170 1976
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1954 (class 2606 OID 16837)
-- Dependencies: 174 1943 172 1976
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1955 (class 2606 OID 16842)
-- Dependencies: 163 1927 172 1976
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;


--
-- TOC entry 1956 (class 2606 OID 16847)
-- Dependencies: 174 1943 176 1976
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1957 (class 2606 OID 16852)
-- Dependencies: 1927 163 176 1976
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


-- Completed on 2013-04-25 01:44:41 CEST

--
-- PostgreSQL database dump complete
--

