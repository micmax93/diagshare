--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-06-04 16:41:18 CEST

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
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 178
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 17710)
-- Dependencies: 1911 1912 6
-- Name: patients; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
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


ALTER TABLE public.patients OWNER TO iwm;

--
-- TOC entry 162 (class 1259 OID 17718)
-- Dependencies: 161 6
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patients_id_seq OWNER TO iwm;

--
-- TOC entry 1983 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- TOC entry 163 (class 1259 OID 17720)
-- Dependencies: 1914 6
-- Name: photos; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
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


ALTER TABLE public.photos OWNER TO iwm;

--
-- TOC entry 164 (class 1259 OID 17727)
-- Dependencies: 6 163
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO iwm;

--
-- TOC entry 1984 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- TOC entry 165 (class 1259 OID 17729)
-- Dependencies: 6
-- Name: posts; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    chat_id integer,
    owner_id integer,
    content text,
    chat_type character varying(20)
);


ALTER TABLE public.posts OWNER TO iwm;

--
-- TOC entry 166 (class 1259 OID 17735)
-- Dependencies: 165 6
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO iwm;

--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- TOC entry 167 (class 1259 OID 17737)
-- Dependencies: 6
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO iwm;

--
-- TOC entry 168 (class 1259 OID 17739)
-- Dependencies: 1917 6
-- Name: roles; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO iwm;

--
-- TOC entry 169 (class 1259 OID 17746)
-- Dependencies: 6
-- Name: roles_users; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO iwm;

--
-- TOC entry 170 (class 1259 OID 17749)
-- Dependencies: 6
-- Name: rooms; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE rooms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    owner_id integer
);


ALTER TABLE public.rooms OWNER TO iwm;

--
-- TOC entry 171 (class 1259 OID 17752)
-- Dependencies: 6 170
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO iwm;

--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 172 (class 1259 OID 17754)
-- Dependencies: 1919 1920 1921 6
-- Name: tags; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    photo_id integer,
    owner_id integer,
    title character varying(255) DEFAULT ''::character varying,
    x integer DEFAULT 0,
    y integer DEFAULT 0
);


ALTER TABLE public.tags OWNER TO iwm;

--
-- TOC entry 173 (class 1259 OID 17760)
-- Dependencies: 6 172
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO iwm;

--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 174 (class 1259 OID 17762)
-- Dependencies: 6
-- Name: users; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
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


ALTER TABLE public.users OWNER TO iwm;

--
-- TOC entry 175 (class 1259 OID 17768)
-- Dependencies: 174 6
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO iwm;

--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 176 (class 1259 OID 17770)
-- Dependencies: 1924 6
-- Name: views; Type: TABLE; Schema: public; Owner: iwm; Tablespace: 
--

CREATE TABLE views (
    id integer NOT NULL,
    owner_id integer,
    status character varying(50) DEFAULT NULL::character varying,
    state text,
    start character varying(255),
    "end" character varying(255)
);


ALTER TABLE public.views OWNER TO iwm;

--
-- TOC entry 177 (class 1259 OID 17777)
-- Dependencies: 176 6
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: iwm
--

CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.views_id_seq OWNER TO iwm;

--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iwm
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1913 (class 2604 OID 17850)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1915 (class 2604 OID 17851)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 17852)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1918 (class 2604 OID 17853)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1922 (class 2604 OID 17854)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1923 (class 2604 OID 17855)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1925 (class 2604 OID 17856)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 1958 (class 0 OID 17710)
-- Dependencies: 161 1975
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO patients VALUES (28, 'Adam Nowak', '2013-03-24', NULL, NULL, 4, NULL);
INSERT INTO patients VALUES (27, 'M. Kowalski', '2013-03-24', NULL, NULL, 3, NULL);
INSERT INTO patients VALUES (29, 'K. Nowak', '2013-03-24', NULL, NULL, 3, NULL);


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('patients_id_seq', 29, true);


--
-- TOC entry 1960 (class 0 OID 17720)
-- Dependencies: 163 1975
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO photos VALUES (52, 27, 'cat_scan_1968.jpg.png', 'Brain', 1, 2, 378, 440);
INSERT INTO photos VALUES (53, 27, 'image.jpg.png', 'RibCage', 2, 2, 540, 430);
INSERT INTO photos VALUES (54, 29, '17832308-broken-leg-x-rays-image-presenting-plate--screw-fixation-tibia-and-fibula-bone.jpg.png', 'Leg', 3, 6, 801, 1200);
INSERT INTO photos VALUES (55, 28, 'Microsoft-Research.jpg.png', 'MultiImage', 4, 3, 944, 738);
INSERT INTO photos VALUES (56, 28, 'xray.jpg', 'Hands', 1, 1, 200, 200);


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('photos_id_seq', 56, true);


--
-- TOC entry 1962 (class 0 OID 17729)
-- Dependencies: 165 1975
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO posts VALUES (5, 117, 7, 'Tak to jest palec', 'tags');
INSERT INTO posts VALUES (7, 117, 7, ':>', 'tags');
INSERT INTO posts VALUES (9, 117, 7, '', 'tags');
INSERT INTO posts VALUES (11, 130, 7, 'Witam.', 'tags');
INSERT INTO posts VALUES (13, 131, 7, 'RG', 'tags');
INSERT INTO posts VALUES (12, 130, 7, 'Znowu ja.', 'tags');
INSERT INTO posts VALUES (10, 117, 7, '', 'tags');
INSERT INTO posts VALUES (8, 117, 7, 'lol', 'tags');
INSERT INTO posts VALUES (6, 117, 7, '', 'tags');
INSERT INTO posts VALUES (14, 117, 7, 'dobry', 'tags');
INSERT INTO posts VALUES (15, 117, 7, 'tak', 'tags');
INSERT INTO posts VALUES (16, 117, 7, 'x', 'tags');
INSERT INTO posts VALUES (17, 117, 7, '<><>', 'tags');
INSERT INTO posts VALUES (18, 117, 7, '', 'tags');
INSERT INTO posts VALUES (19, 117, 7, 'teraz działa', 'tags');
INSERT INTO posts VALUES (20, 1, 7, 'Cześć', 'patients');
INSERT INTO posts VALUES (21, 24, 7, ';;;', 'patients');
INSERT INTO posts VALUES (22, 46, 7, 'elo', 'photos');
INSERT INTO posts VALUES (23, 46, 7, 'qq', 'photos');
INSERT INTO posts VALUES (24, 46, 7, 'wqd', 'photos');
INSERT INTO posts VALUES (25, 47, 8, 'kopkopk', 'photos');
INSERT INTO posts VALUES (26, 8, 8, ':]', 'live');
INSERT INTO posts VALUES (27, 7, 7, 'd', 'liveChat');
INSERT INTO posts VALUES (28, 7, 7, 'qwd', 'liveChat');
INSERT INTO posts VALUES (29, 8, 8, ':>', 'liveChat');
INSERT INTO posts VALUES (30, 8, 7, 'wef', 'liveChat');
INSERT INTO posts VALUES (31, 8, 8, 'q', 'liveChat');
INSERT INTO posts VALUES (32, 8, 8, ':D', 'liveChat');
INSERT INTO posts VALUES (33, 7, 7, ':D', 'liveChat');


--
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('posts_id_seq', 33, true);


--
-- TOC entry 1965 (class 0 OID 17739)
-- Dependencies: 168 1975
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO roles VALUES (1, 'login', 'Podstawowa rola umożliwiająca logowanie');


--
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 167
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 1966 (class 0 OID 17746)
-- Dependencies: 169 1975
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO roles_users VALUES (7, 1);
INSERT INTO roles_users VALUES (8, 1);
INSERT INTO roles_users VALUES (9, 1);


--
-- TOC entry 1967 (class 0 OID 17749)
-- Dependencies: 170 1975
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO rooms VALUES (3, 'OIOM', 8);
INSERT INTO rooms VALUES (4, 'Kardiochirurgia', 7);
INSERT INTO rooms VALUES (5, 'Chirurgia', 7);


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('rooms_id_seq', 5, true);


--
-- TOC entry 1969 (class 0 OID 17754)
-- Dependencies: 172 1975
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: iwm
--



--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('tags_id_seq', 132, true);


--
-- TOC entry 1971 (class 0 OID 17762)
-- Dependencies: 174 1975
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO users VALUES (9, 'test@user.pl', 'test', '6db5e888bf97568ce6ae62b08d47d6a6411363b39265270c6c701eb3a7e25217', NULL, 1369078715, 'Janusz Jan');
INSERT INTO users VALUES (7, 'admin@admin.pl', 'admin', '586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6', NULL, 1370355515, 'Administrator');
INSERT INTO users VALUES (8, 'user@user.pl', 'user', '890d1ca8fcd713f2ebbcdaa090a7820cc0a00bbaf1e2ab4cebec935934207afa', NULL, 1370355518, 'Jan Kowalski');


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('users_id_seq', 9, true);


--
-- TOC entry 1973 (class 0 OID 17770)
-- Dependencies: 176 1975
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: iwm
--

INSERT INTO views VALUES (12, 7, 'PUBLIC', '[{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"","gridLeft":"","gridHeight":"200px","gridWidth":"200px","display":"","firstPlan":"0"},{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-190.3px","gridLeft":"-220px","gridHeight":"1884px","gridWidth":"2229.6px","display":"","firstPlan":"1"}]', 'Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)', 'Sat Apr 27 2013 19:35:41 GMT+0200 (CEST)');
INSERT INTO views VALUES (13, 7, 'PUBLIC', '[{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-1195px","gridLeft":"-2598px","gridHeight":"4688.4px","gridWidth":"5548.8px","display":"","firstPlan":"0"},{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"-690px","gridLeft":"-800px","gridHeight":"2144.4px","gridWidth":"2144.4px","display":"","firstPlan":"1"}]', 'Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)', 'Sat Apr 27 2013 19:36:32 GMT+0200 (CEST)');
INSERT INTO views VALUES (14, 7, 'PUBLIC', '[{"title":"xyz","photoId":"46","top":"-116px","left":"1172px","zoom":"1172px","gridTop":"1px","gridLeft":"51px","gridHeight":"900px","gridWidth":"601.2px","display":"","firstPlan":"0"},{"title":"Kate","photoId":"45","top":"88px","left":"323px","zoom":"323px","gridTop":"","gridLeft":"","gridHeight":"675px","gridWidth":"900px","display":"","firstPlan":"1"}]', 'Sat May 11 2013 15:41:25 GMT+0200', 'Sat May 11 2013 15:41:57 GMT+0200');


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iwm
--

SELECT pg_catalog.setval('views_id_seq', 14, true);


--
-- TOC entry 1927 (class 2606 OID 17787)
-- Dependencies: 161 161 1976
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1929 (class 2606 OID 17789)
-- Dependencies: 161 161 1976
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1933 (class 2606 OID 17791)
-- Dependencies: 165 165 1976
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1931 (class 2606 OID 17793)
-- Dependencies: 163 163 1976
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 17795)
-- Dependencies: 168 168 1976
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1937 (class 2606 OID 17797)
-- Dependencies: 169 169 169 1976
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1939 (class 2606 OID 17799)
-- Dependencies: 170 170 1976
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1941 (class 2606 OID 17801)
-- Dependencies: 170 170 1976
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 1943 (class 2606 OID 17803)
-- Dependencies: 172 172 1976
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 1945 (class 2606 OID 17805)
-- Dependencies: 174 174 1976
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 1947 (class 2606 OID 17807)
-- Dependencies: 174 174 1976
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1949 (class 2606 OID 17809)
-- Dependencies: 176 176 1976
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: iwm; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 1950 (class 2606 OID 17810)
-- Dependencies: 161 174 1946 1976
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- TOC entry 1951 (class 2606 OID 17815)
-- Dependencies: 161 1940 170 1976
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE;


--
-- TOC entry 1952 (class 2606 OID 17820)
-- Dependencies: 1928 163 161 1976
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE;


--
-- TOC entry 1953 (class 2606 OID 17825)
-- Dependencies: 165 1946 174 1976
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL;


--
-- TOC entry 1954 (class 2606 OID 17830)
-- Dependencies: 174 170 1946 1976
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL;


--
-- TOC entry 1955 (class 2606 OID 17835)
-- Dependencies: 174 1946 172 1976
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL;


--
-- TOC entry 1956 (class 2606 OID 17840)
-- Dependencies: 163 1930 172 1976
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;


--
-- TOC entry 1957 (class 2606 OID 17845)
-- Dependencies: 176 1946 174 1976
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: iwm
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL;


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-06-04 16:41:19 CEST

--
-- PostgreSQL database dump complete
--

