--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.8
-- Dumped by pg_dump version 9.1.8
-- Started on 2013-04-15 21:19:05 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1986 (class 1262 OID 16882)
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
-- TOC entry 178 (class 3079 OID 11652)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 178
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 190 (class 1255 OID 16883)
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
-- TOC entry 161 (class 1259 OID 16884)
-- Dependencies: 1911 1912 6
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
-- TOC entry 162 (class 1259 OID 16892)
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
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- TOC entry 163 (class 1259 OID 16894)
-- Dependencies: 1914 6
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
-- TOC entry 164 (class 1259 OID 16901)
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
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- TOC entry 165 (class 1259 OID 16903)
-- Dependencies: 1917 6
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
-- TOC entry 166 (class 1259 OID 16910)
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
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- TOC entry 167 (class 1259 OID 16912)
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
-- TOC entry 168 (class 1259 OID 16914)
-- Dependencies: 1918 6
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 16921)
-- Dependencies: 6
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 16924)
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
-- TOC entry 171 (class 1259 OID 16927)
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
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 172 (class 1259 OID 16929)
-- Dependencies: 1920 1921 1922 6
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
-- TOC entry 173 (class 1259 OID 16935)
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
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 174 (class 1259 OID 16937)
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
-- TOC entry 175 (class 1259 OID 16943)
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
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 176 (class 1259 OID 16945)
-- Dependencies: 1925 1926 1927 1928 6
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
-- TOC entry 177 (class 1259 OID 16952)
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
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1913 (class 2604 OID 16954)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1915 (class 2604 OID 16955)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 16956)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1919 (class 2604 OID 16957)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1923 (class 2604 OID 16958)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1924 (class 2604 OID 16959)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 16960)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 1965 (class 0 OID 16884)
-- Dependencies: 161 1982
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO patients VALUES (1, 'Jan', '2013-03-24', 'CRITICAL', 'Ostry przypadek niewydolności mózgowej spowodowanej wystawieniem na szkodliwy wpływ pseudo-bazy danych.', 1, 2);


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patients_id_seq', 1, true);


--
-- TOC entry 1967 (class 0 OID 16894)
-- Dependencies: 163 1982
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO photos VALUES (1, 1, 'xray.jpg', 'Prześwietlenie', 1, 1, 200, 200);
INSERT INTO photos VALUES (11, 1, 'Katie_Melua_9_1600x1200_Wallpaper.jpg', 'Katie', 8, 6, 1600, 1200);
INSERT INTO photos VALUES (14, 1, 'Skull_x-ray.jpg', 'Czaszka', 3, 1, 648, 463);
INSERT INTO photos VALUES (13, 1, 'monica.jpeg', 'Monica', 4, 1, 800, 533);


--
-- TOC entry 1998 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 14, true);


--
-- TOC entry 1969 (class 0 OID 16903)
-- Dependencies: 165 1982
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO posts VALUES (1, 1, NULL, 2, 'Zalecam pavulonik.');
INSERT INTO posts VALUES (2, NULL, 1, 1, 'Chyba tak.');
INSERT INTO posts VALUES (3, NULL, 2, 1, 'Chyba nie.');
INSERT INTO posts VALUES (4, NULL, 1, 2, 'Na pewno nie.');


--
-- TOC entry 1999 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 4, true);


--
-- TOC entry 1972 (class 0 OID 16914)
-- Dependencies: 168 1982
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles VALUES (1, 'login', 'Podstawowa rola umożliwiająca logowanie');


--
-- TOC entry 2000 (class 0 OID 0)
-- Dependencies: 167
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 1973 (class 0 OID 16921)
-- Dependencies: 169 1982
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles_users VALUES (7, 1);


--
-- TOC entry 1974 (class 0 OID 16924)
-- Dependencies: 170 1982
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rooms VALUES (1, 'OIOM', 1);


--
-- TOC entry 2001 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 1, true);


--
-- TOC entry 1976 (class 0 OID 16929)
-- Dependencies: 172 1982
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tags VALUES (1, 1, 1, 'Guz', 5, 8);
INSERT INTO tags VALUES (2, 1, 2, 'Tasiemiec', 12, 15);
INSERT INTO tags VALUES (3, 1, 1, 'Nowy tag', 100, 100);
INSERT INTO tags VALUES (4, 1, 1, 'Nowy tag2', 200, 200);


--
-- TOC entry 2002 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 4, true);


--
-- TOC entry 1978 (class 0 OID 16937)
-- Dependencies: 174 1982
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users VALUES (1, 'test_user', 'user', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (2, 'nxt_user', 'paswd', NULL, NULL, NULL, NULL);
INSERT INTO users VALUES (7, 'admin@admin.pl', 'admin', '586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6', NULL, 1366042928, 'Administrator');


--
-- TOC entry 2003 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- TOC entry 1980 (class 0 OID 16945)
-- Dependencies: 176 1982
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO views VALUES (1, 1, 'PUBLIC', 1, 0, 0, 1, NULL, NULL);
INSERT INTO views VALUES (2, 2, 'PRIVATE', 1, 10, 10, 1.19999999999999996, NULL, NULL);


--
-- TOC entry 2004 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('views_id_seq', 2, true);


--
-- TOC entry 1931 (class 2606 OID 16962)
-- Dependencies: 161 161 1983
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1933 (class 2606 OID 16964)
-- Dependencies: 161 161 1983
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1937 (class 2606 OID 16966)
-- Dependencies: 165 165 1983
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 16968)
-- Dependencies: 163 163 1983
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1939 (class 2606 OID 16970)
-- Dependencies: 168 168 1983
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1941 (class 2606 OID 16972)
-- Dependencies: 169 169 169 1983
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1943 (class 2606 OID 16974)
-- Dependencies: 170 170 1983
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1945 (class 2606 OID 16976)
-- Dependencies: 170 170 1983
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 16978)
-- Dependencies: 172 172 1983
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 1949 (class 2606 OID 16980)
-- Dependencies: 174 174 1983
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 1951 (class 2606 OID 16982)
-- Dependencies: 174 174 1983
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1953 (class 2606 OID 16984)
-- Dependencies: 176 176 1983
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 1954 (class 2606 OID 16985)
-- Dependencies: 161 1950 174 1983
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1955 (class 2606 OID 16990)
-- Dependencies: 161 1944 170 1983
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- TOC entry 1956 (class 2606 OID 16995)
-- Dependencies: 163 1932 161 1983
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1957 (class 2606 OID 17000)
-- Dependencies: 165 1950 174 1983
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1958 (class 2606 OID 17005)
-- Dependencies: 165 1932 161 1983
-- Name: posts_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1959 (class 2606 OID 17010)
-- Dependencies: 1946 172 165 1983
-- Name: posts_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- TOC entry 1960 (class 2606 OID 17015)
-- Dependencies: 174 1950 170 1983
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1961 (class 2606 OID 17020)
-- Dependencies: 174 1950 172 1983
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1962 (class 2606 OID 17025)
-- Dependencies: 163 1934 172 1983
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);


--
-- TOC entry 1963 (class 2606 OID 17030)
-- Dependencies: 174 1950 176 1983
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1964 (class 2606 OID 17035)
-- Dependencies: 1934 163 176 1983
-- Name: views_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);


--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-04-15 21:19:06 CEST

--
-- PostgreSQL database dump complete
--

