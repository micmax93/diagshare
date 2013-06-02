--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-05-21 16:08:21 CEST

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
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 178
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 190 (class 1255 OID 17276)
-- Dependencies: 6 541
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
-- TOC entry 161 (class 1259 OID 17277)
-- Dependencies: 1912 1913 6
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
-- TOC entry 162 (class 1259 OID 17285)
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
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE patients_id_seq OWNED BY patients.id;


--
-- TOC entry 163 (class 1259 OID 17287)
-- Dependencies: 1915 6
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
-- TOC entry 164 (class 1259 OID 17294)
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
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- TOC entry 165 (class 1259 OID 17296)
-- Dependencies: 1918 6
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
-- TOC entry 166 (class 1259 OID 17303)
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
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- TOC entry 167 (class 1259 OID 17305)
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
-- TOC entry 168 (class 1259 OID 17307)
-- Dependencies: 1919 6
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 17314)
-- Dependencies: 6
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 17317)
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
-- TOC entry 171 (class 1259 OID 17320)
-- Dependencies: 6 170
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
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- TOC entry 172 (class 1259 OID 17322)
-- Dependencies: 1921 1922 1923 6
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
-- TOC entry 173 (class 1259 OID 17328)
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
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 174 (class 1259 OID 17330)
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
-- TOC entry 175 (class 1259 OID 17336)
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
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 176 (class 1259 OID 17338)
-- Dependencies: 1926 6
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
-- TOC entry 177 (class 1259 OID 17345)
-- Dependencies: 176 6
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
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE views_id_seq OWNED BY views.id;


--
-- TOC entry 1914 (class 2604 OID 17347)
-- Dependencies: 162 161
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 17348)
-- Dependencies: 164 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 17349)
-- Dependencies: 166 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- TOC entry 1920 (class 2604 OID 17350)
-- Dependencies: 171 170
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- TOC entry 1924 (class 2604 OID 17351)
-- Dependencies: 173 172
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1925 (class 2604 OID 17352)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 1927 (class 2604 OID 17353)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);


--
-- TOC entry 1962 (class 0 OID 17277)
-- Dependencies: 161 1979
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY patients (id, name, date, status, description, room_id, owner_id) FROM stdin;
26	Jan Kowalski	2013-03-24	\N	\N	3	\N
27	Adam Nowak	2013-03-24	\N	\N	4	\N
28	Sławomir Wysoki	2013-03-24	\N	\N	4	\N
29	Ania Myszewska	2013-03-24	\N	\N	3	\N
\.


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 162
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patients_id_seq', 29, true);


--
-- TOC entry 1964 (class 0 OID 17287)
-- Dependencies: 163 1979
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY photos (id, patient_id, filename, title, x_count, y_count, width, height) FROM stdin;
51	26	image.jpg	Rentgen_płuc	2	2	540	430
52	26	ekg.jpg	EKG	4	1	948	523
53	27	mri-brain.jpg	CT	3	3	1014	963
54	27	cat_scan_1968.jpg	CT2	1	2	378	440
57	29	Microsoft-Research.jpg	Zestaw	4	3	944	738
58	29	url.jpg	USG	3	4	1149	836
59	28	url.png	Wizualizacja	5	3	1000	1143
61	28	scan530.jpg	Kręgosłup	1	1	295	340
\.


--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 164
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('photos_id_seq', 61, true);


--
-- TOC entry 1966 (class 0 OID 17296)
-- Dependencies: 165 1979
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY posts (id, patient_id, tag_id, owner_id, content) FROM stdin;
\.


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 166
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('posts_id_seq', 37, true);


--
-- TOC entry 1969 (class 0 OID 17307)
-- Dependencies: 168 1979
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, name, description) FROM stdin;
1	login	Podstawowa rola umożliwiająca logowanie
\.


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 167
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roles_id_seq', 3, true);


--
-- TOC entry 1970 (class 0 OID 17314)
-- Dependencies: 169 1979
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles_users (user_id, role_id) FROM stdin;
7	1
\.


--
-- TOC entry 1971 (class 0 OID 17317)
-- Dependencies: 170 1979
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rooms (id, name, owner_id) FROM stdin;
3	Oddział	7
4	Neurologia	7
\.


--
-- TOC entry 1998 (class 0 OID 0)
-- Dependencies: 171
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rooms_id_seq', 4, true);


--
-- TOC entry 1973 (class 0 OID 17322)
-- Dependencies: 172 1979
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, photo_id, owner_id, title, x, y) FROM stdin;
\.


--
-- TOC entry 1999 (class 0 OID 0)
-- Dependencies: 173
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 141, true);


--
-- TOC entry 1975 (class 0 OID 17330)
-- Dependencies: 174 1979
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, username, password, logins, last_login, full_name) FROM stdin;
7	admin@admin.pl	admin	586d47435ff7be82b8f4b0847ac23e79492a10e77103768ae626d8ad22c664c6	\N	1369145100	Administrator
\.


--
-- TOC entry 2000 (class 0 OID 0)
-- Dependencies: 175
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 9, true);


--
-- TOC entry 1977 (class 0 OID 17338)
-- Dependencies: 176 1979
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY views (id, owner_id, status, state, start, "end") FROM stdin;
12	7	PUBLIC	[{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"","gridLeft":"","gridHeight":"200px","gridWidth":"200px","display":"","firstPlan":"0"},{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-190.3px","gridLeft":"-220px","gridHeight":"1884px","gridWidth":"2229.6px","display":"","firstPlan":"1"}]	Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)	Sat Apr 27 2013 19:35:41 GMT+0200 (CEST)
13	7	PUBLIC	[{"title":"Katie_Grafika","photoId":"38","top":"27px","left":"548px","zoom":"548px","contrast":40,"gridTop":"-1195px","gridLeft":"-2598px","gridHeight":"4688.4px","gridWidth":"5548.8px","display":"","firstPlan":"0"},{"title":"Prześwietlenie","photoId":"1","top":"172px","left":"1166px","zoom":"1166px","gridTop":"-690px","gridLeft":"-800px","gridHeight":"2144.4px","gridWidth":"2144.4px","display":"","firstPlan":"1"}]	Sat Apr 27 2013 19:35:23 GMT+0200 (CEST)	Sat Apr 27 2013 19:36:32 GMT+0200 (CEST)
14	7	PUBLIC	[{"title":"xyz","photoId":"46","top":"-116px","left":"1172px","zoom":"1172px","gridTop":"1px","gridLeft":"51px","gridHeight":"900px","gridWidth":"601.2px","display":"","firstPlan":"0"},{"title":"Kate","photoId":"45","top":"88px","left":"323px","zoom":"323px","gridTop":"","gridLeft":"","gridHeight":"675px","gridWidth":"900px","display":"","firstPlan":"1"}]	Sat May 11 2013 15:41:25 GMT+0200	Sat May 11 2013 15:41:57 GMT+0200
15	7	PUBLIC	[{"title":"Prześwietlenie","photoId":"1","top":"39px","left":"435.2px","zoom":"3.631968551893185","gridTop":"-22.7736px","gridLeft":"-62.4136px","gridHeight":"718.4px","gridWidth":"718.4px","display":"","firstPlan":"38"},{"title":"xyz","photoId":"46","top":"40px","left":"","zoom":"1","contrast":40,"gridTop":"13px","gridLeft":"63px","gridHeight":"750px","gridWidth":"501px","display":"","firstPlan":"66"}]	Mon May 20 2013 15:46:54 GMT+0200 (CEST)	Mon May 20 2013 15:53:55 GMT+0200 (CEST)
\.


--
-- TOC entry 2001 (class 0 OID 0)
-- Dependencies: 177
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('views_id_seq', 15, true);


--
-- TOC entry 1929 (class 2606 OID 17355)
-- Dependencies: 161 161 1980
-- Name: patients_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);


--
-- TOC entry 1931 (class 2606 OID 17357)
-- Dependencies: 161 161 1980
-- Name: patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 17359)
-- Dependencies: 165 165 1980
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 1933 (class 2606 OID 17361)
-- Dependencies: 163 163 1980
-- Name: primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);


--
-- TOC entry 1937 (class 2606 OID 17363)
-- Dependencies: 168 168 1980
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- TOC entry 1939 (class 2606 OID 17365)
-- Dependencies: 169 169 169 1980
-- Name: roles_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);


--
-- TOC entry 1941 (class 2606 OID 17367)
-- Dependencies: 170 170 1980
-- Name: rooms_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);


--
-- TOC entry 1943 (class 2606 OID 17369)
-- Dependencies: 170 170 1980
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 1945 (class 2606 OID 17371)
-- Dependencies: 172 172 1980
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 17373)
-- Dependencies: 174 174 1980
-- Name: users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);


--
-- TOC entry 1949 (class 2606 OID 17375)
-- Dependencies: 174 174 1980
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1951 (class 2606 OID 17377)
-- Dependencies: 176 176 1980
-- Name: views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);


--
-- TOC entry 1952 (class 2606 OID 17378)
-- Dependencies: 174 1948 161 1980
-- Name: patients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1953 (class 2606 OID 17383)
-- Dependencies: 161 1942 170 1980
-- Name: patients_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);


--
-- TOC entry 1954 (class 2606 OID 17388)
-- Dependencies: 163 1930 161 1980
-- Name: photos_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1955 (class 2606 OID 17393)
-- Dependencies: 165 1948 174 1980
-- Name: posts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1956 (class 2606 OID 17398)
-- Dependencies: 165 161 1930 1980
-- Name: posts_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);


--
-- TOC entry 1957 (class 2606 OID 17403)
-- Dependencies: 165 1944 172 1980
-- Name: posts_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- TOC entry 1958 (class 2606 OID 17408)
-- Dependencies: 170 1948 174 1980
-- Name: rooms_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1959 (class 2606 OID 17413)
-- Dependencies: 172 1948 174 1980
-- Name: tags_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1960 (class 2606 OID 17418)
-- Dependencies: 163 172 1932 1980
-- Name: tags_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE;


--
-- TOC entry 1961 (class 2606 OID 17423)
-- Dependencies: 176 174 1948 1980
-- Name: views_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO iwm;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-05-21 16:08:22 CEST

--
-- PostgreSQL database dump complete
--

