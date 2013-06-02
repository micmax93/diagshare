--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.4
-- Started on 2013-06-02 17:01:45

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE iwm;
--
-- TOC entry 2036 (class 1262 OID 16395)
-- Name: iwm; Type: DATABASE; Schema: -; Owner: iwm
--

CREATE DATABASE iwm WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Polish_Poland.1250' LC_CTYPE = 'Polish_Poland.1250';


ALTER DATABASE iwm OWNER TO iwm;

\connect iwm

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: iwm
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO iwm;

--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: iwm
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 185 (class 3079 OID 11727)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2039 (class 0 OID 0)
-- Dependencies: 185
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 16397)
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
-- TOC entry 169 (class 1259 OID 16405)
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
-- TOC entry 2040 (class 0 OID 0)
-- Dependencies: 169
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- TOC entry 170 (class 1259 OID 16407)
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
-- TOC entry 171 (class 1259 OID 16414)
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
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 171
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- TOC entry 172 (class 1259 OID 16416)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    chat_id integer,
    owner_id integer,
    content text,
    chat_type character varying(20)
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16423)
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
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 173
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- TOC entry 174 (class 1259 OID 16425)
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
-- TOC entry 175 (class 1259 OID 16427)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16434)
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16437)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rooms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    owner_id integer
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16440)
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
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 178
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 179 (class 1259 OID 16442)
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
-- TOC entry 180 (class 1259 OID 16448)
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
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 180
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 181 (class 1259 OID 16450)
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
-- TOC entry 182 (class 1259 OID 16456)
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
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 182
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 183 (class 1259 OID 16568)
-- Name: views; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE views (
    id integer NOT NULL,
    owner_id integer,
    status character varying(50) DEFAULT NULL::character varying,
    state text,
    start character varying(255),
    "end" character varying(255)
);


ALTER TABLE public.views OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16575)
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
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 184
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1970 (class 2604 OID 16561)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 16562)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1973 (class 2604 OID 16563)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1975 (class 2604 OID 16564)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1979 (class 2604 OID 16565)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1980 (class 2604 OID 16566)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 16577)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 2015 (class 0 OID 16397)
-- Dependencies: 168
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO patients (id, name, date, status, description, room_id, owner_id) VALUES (1, 'Jasiu', '2013-03-24', 'CRITICAL', 'Ostry przypadek niewydolności mózgowej spowodowanej wystawieniem na szkodliwy wpływ pseudo-bazy danych.', 1, 7);
INSERT INTO patients (id, name, date, status, description, room_id, owner_id) VALUES (24, 'Pacjent_3245', '2013-03-24', NULL, NULL, 2, 7);


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 169
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patients_id_seq', 24, true);


--
-- TOC entry 2017 (class 0 OID 16407)
-- Dependencies: 170
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (1, 1, 'xray.jpg', 'Prześwietlenie', 1, 1, 200, 200);
INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (38, 1, 'Katie_Melua_by_Swezzels.jpg', 'Katie_Grafika', 6, 6, 1548, 1308);
INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (45, 1, '3137.jpg', 'Kate', 4, 3, 900, 675);
INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (46, 24, '3172.jpg', 'xyz', 1, 3, 501, 750);
INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (47, 24, '3174.jpg', 'black', 1, 3, 563, 750);
INSERT INTO photos (id, patient_id, filename, title, x_count, y_count, width, height) VALUES (48, 1, '1152.jpg', 'Susan', 2, 3, 500, 750);


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 171
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 48, true);


--
-- TOC entry 2019 (class 0 OID 16416)
-- Dependencies: 172
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (5, 117, 7, 'Tak to jest palec', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (7, 117, 7, ':>', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (9, 117, 7, '', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (11, 130, 7, 'Witam.', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (13, 131, 7, 'RG', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (12, 130, 7, 'Znowu ja.', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (10, 117, 7, '', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (8, 117, 7, 'lol', 'tags');
INSERT INTO posts (id, chat_id, owner_id, content, chat_type) VALUES (6, 117, 7, '', 'tags');


--
-- TOC entry 2049 (class 0 OID 0)
-- Dependencies: 173
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 13, true);


--
-- TOC entry 2022 (class 0 OID 16427)
-- Dependencies: 175
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles (id, name, description) VALUES (1, 'login', 'Podstawowa rola umożliwiająca logowanie');


--
-- TOC entry 2050 (class 0 OID 0)
-- Dependencies: 174
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 2023 (class 0 OID 16434)
-- Dependencies: 176
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO roles_users (user_id, role_id) VALUES (7, 1);
INSERT INTO roles_users (user_id, role_id) VALUES (8, 1);
INSERT INTO roles_users (user_id, role_id) VALUES (9, 1);


--
-- TOC entry 2024 (class 0 OID 16437)
-- Dependencies: 177
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rooms (id, name, owner_id) VALUES (1, 'OIOM', 7);
INSERT INTO rooms (id, name, owner_id) VALUES (2, 'Neurologia', 7);


--
-- TOC entry 2051 (class 0 OID 0)
-- Dependencies: 178
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 2, true);


--
-- TOC entry 2026 (class 0 OID 16442)
-- Dependencies: 179
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (115, 1, 7, 'Kciuk prawej ręki', 110, 87);
INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (117, 1, 7, 'Palec wskazujący prawej dłoni', 129, 22);
INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (129, 1, 7, 'Lewy palec', 70, 21);
INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (130, 45, 7, 'Chat1', 804, 244);
INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (131, 38, 7, 'TigTag', 1420, 1224);
INSERT INTO tags (id, photo_id, owner_id, title, x, y) VALUES (116, 1, 7, 'Kciuk lewej dłoni', 95, 111);


--
-- TOC entry 2052 (class 0 OID 0)
-- Dependencies: 180
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 131, true);


--
-- TOC entry 2028 (class 0 OID 16450)
-- Dependencies: 181
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users (id, email, username, password, logins, last_login, full_name) VALUES (8, 'user@user.pl', 'user', '890d1ca8fcd713f2ebbcdaa090a7820cc0a00bbaf1e2ab4cebec935934207afa', NULL, 1369070450, 'Jan Kowalski');
INSERT INTO users (id, email, username, password, logins, last_login, full_name) VALUES (9, 'test@user.pl', 'test', '6db5e888bf97568ce6ae62b08d47d6a6411363b39265270c6c701eb3a7e25217', NULL, 1369078715, 'Janusz Jan');
INSERT INTO users (id, email, username, password, logins, last_login, full_name) VALUES (7, 'admin@admin.pl', 'admin', '586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6', NULL, 1370169682, 'Administrator');


--
-- TOC entry 2053 (class 0 OID 0)
-- Dependencies: 182
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 9, true);


--
-- TOC entry 2030 (class 0 OID 16568)
-- Dependencies: 183
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO views (id, owner_id, status, state, start, "end") VALUES (12, 7, 'PUBLIC', '[{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"","gridLeft":"","gridHeight":"200px","gridWidth":"200px","display":"","firstPlan":"0"},{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-190.3px","gridLeft":"-220px","gridHeight":"1884px","gridWidth":"2229.6px","display":"","firstPlan":"1"}]', 'Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)', 'Sat Apr 27 2013 19:35:41 GMT+0200 (CEST)');
INSERT INTO views (id, owner_id, status, state, start, "end") VALUES (13, 7, 'PUBLIC', '[{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-1195px","gridLeft":"-2598px","gridHeight":"4688.4px","gridWidth":"5548.8px","display":"","firstPlan":"0"},{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"-690px","gridLeft":"-800px","gridHeight":"2144.4px","gridWidth":"2144.4px","display":"","firstPlan":"1"}]', 'Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)', 'Sat Apr 27 2013 19:36:32 GMT+0200 (CEST)');
INSERT INTO views (id, owner_id, status, state, start, "end") VALUES (14, 7, 'PUBLIC', '[{"title":"xyz","photoId":"46","top":"-116px","left":"1172px","zoom":"1172px","gridTop":"1px","gridLeft":"51px","gridHeight":"900px","gridWidth":"601.2px","display":"","firstPlan":"0"},{"title":"Kate","photoId":"45","top":"88px","left":"323px","zoom":"323px","gridTop":"","gridLeft":"","gridHeight":"675px","gridWidth":"900px","display":"","firstPlan":"1"}]', 'Sat May 11 2013 15:41:25 GMT+0200', 'Sat May 11 2013 15:41:57 GMT+0200');


--
-- TOC entry 2054 (class 0 OID 0)
-- Dependencies: 184
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('views_id_seq', 14, true);


--
-- TOC entry 1984 (class 2606 OID 16475)
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1986 (class 2606 OID 16477)
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1990 (class 2606 OID 16479)
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 16481)
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1992 (class 2606 OID 16483)
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1994 (class 2606 OID 16485)
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1996 (class 2606 OID 16487)
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1998 (class 2606 OID 16489)
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 2000 (class 2606 OID 16491)
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 16493)
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 2004 (class 2606 OID 16495)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 16579)
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 2007 (class 2606 OID 16498)
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 2008 (class 2606 OID 16503)
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- TOC entry 2009 (class 2606 OID 16508)
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 2010 (class 2606 OID 16513)
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 2011 (class 2606 OID 16528)
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 2012 (class 2606 OID 16533)
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 2013 (class 2606 OID 16538)
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;


--
-- TOC entry 2014 (class 2606 OID 16580)
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 2038 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: iwm
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM iwm;
GRANT ALL ON SCHEMA public TO iwm;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-06-02 17:01:45

--
-- PostgreSQL database dump complete
--

