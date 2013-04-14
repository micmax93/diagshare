PGDMP     :                    q           iwm    9.1.9    9.1.9 P    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    16588    iwm    DATABASE     u   CREATE DATABASE iwm WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'pl_PL.UTF-8' LC_CTYPE = 'pl_PL.UTF-8';
    DROP DATABASE iwm;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6            �            3079    11645    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    178            �            1255    16589    xor(boolean, boolean)    FUNCTION     �   CREATE FUNCTION xor(arg1 boolean, arg2 boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN
RETURN ( arg1 and not arg2) or ( not arg1 and arg2);
END$$;
 6   DROP FUNCTION public.xor(arg1 boolean, arg2 boolean);
       public       postgres    false    540    6            �            1259    16590    patients    TABLE     
  CREATE TABLE patients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date date DEFAULT '2013-03-24'::date,
    status character varying(50) DEFAULT NULL::character varying,
    description text,
    room_id integer,
    owner_id integer
);
    DROP TABLE public.patients;
       public         postgres    false    1904    1905    6            �            1259    16598    patients_id_seq    SEQUENCE     q   CREATE SEQUENCE patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.patients_id_seq;
       public       postgres    false    6    161            �           0    0    patients_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE patients_id_seq OWNED BY patients.id;
            public       postgres    false    162            �            1259    16600    photos    TABLE       CREATE TABLE photos (
    id integer NOT NULL,
    patient_id integer,
    filename character varying(255) DEFAULT NULL::character varying,
    title character varying(255),
    x_count integer,
    y_count integer,
    width integer,
    height integer
);
    DROP TABLE public.photos;
       public         postgres    false    1907    6            �            1259    16607    photos_id_seq    SEQUENCE     o   CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.photos_id_seq;
       public       postgres    false    163    6            �           0    0    photos_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE photos_id_seq OWNED BY photos.id;
            public       postgres    false    164            �            1259    16609    posts    TABLE     �   CREATE TABLE posts (
    id integer NOT NULL,
    patient_id integer,
    tag_id integer,
    owner_id integer,
    content text,
    CONSTRAINT thread_fk CHECK (xor((patient_id IS NULL), (tag_id IS NULL)))
);
    DROP TABLE public.posts;
       public         postgres    false    1910    6            �            1259    16616    posts_id_seq    SEQUENCE     n   CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.posts_id_seq;
       public       postgres    false    6    165            �           0    0    posts_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE posts_id_seq OWNED BY posts.id;
            public       postgres    false    166            �            1259    16734    roles_id_seq    SEQUENCE     n   CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public       postgres    false    6            �            1259    16731    roles    TABLE     �   CREATE TABLE roles (
    id integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description character varying(1000)
);
    DROP TABLE public.roles;
       public         postgres    false    1922    6            �            1259    16743    roles_users    TABLE     Y   CREATE TABLE roles_users (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);
    DROP TABLE public.roles_users;
       public         postgres    false    6            �            1259    16618    rooms    TABLE     p   CREATE TABLE rooms (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    owner_id integer
);
    DROP TABLE public.rooms;
       public         postgres    false    6            �            1259    16621    rooms_id_seq    SEQUENCE     n   CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.rooms_id_seq;
       public       postgres    false    6    167            �           0    0    rooms_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;
            public       postgres    false    168            �            1259    16623    tags    TABLE     �   CREATE TABLE tags (
    id integer NOT NULL,
    photo_id integer,
    owner_id integer,
    title character varying(255) DEFAULT ''::character varying,
    x integer DEFAULT 0,
    y integer DEFAULT 0
);
    DROP TABLE public.tags;
       public         postgres    false    1912    1913    1914    6            �            1259    16629    tags_id_seq    SEQUENCE     m   CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.tags_id_seq;
       public       postgres    false    6    169            �           0    0    tags_id_seq    SEQUENCE OWNED BY     -   ALTER SEQUENCE tags_id_seq OWNED BY tags.id;
            public       postgres    false    170            �            1259    16631    users    TABLE        CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255),
    logins integer,
    last_login integer,
    full_name character varying(255)
);
    DROP TABLE public.users;
       public         postgres    false    6            �            1259    16637    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    171    6            �           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       postgres    false    172            �            1259    16639    views    TABLE     6  CREATE TABLE views (
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
    DROP TABLE public.views;
       public         postgres    false    1917    1918    1919    1920    6            �            1259    16646    views_id_seq    SEQUENCE     n   CREATE SEQUENCE views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.views_id_seq;
       public       postgres    false    6    173            �           0    0    views_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE views_id_seq OWNED BY views.id;
            public       postgres    false    174            r           2604    16648    id    DEFAULT     \   ALTER TABLE ONLY patients ALTER COLUMN id SET DEFAULT nextval('patients_id_seq'::regclass);
 :   ALTER TABLE public.patients ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    162    161            t           2604    16649    id    DEFAULT     X   ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);
 8   ALTER TABLE public.photos ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    164    163            u           2604    16650    id    DEFAULT     V   ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);
 7   ALTER TABLE public.posts ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    166    165            w           2604    16651    id    DEFAULT     V   ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);
 7   ALTER TABLE public.rooms ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    168    167            {           2604    16652    id    DEFAULT     T   ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);
 6   ALTER TABLE public.tags ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    170    169            |           2604    16653    id    DEFAULT     V   ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    172    171            �           2604    16654    id    DEFAULT     V   ALTER TABLE ONLY views ALTER COLUMN id SET DEFAULT nextval('views_id_seq'::regclass);
 7   ALTER TABLE public.views ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    174    173            �          0    16590    patients 
   TABLE DATA               S   COPY patients (id, name, date, status, description, room_id, owner_id) FROM stdin;
    public       postgres    false    161    1975   CU       �           0    0    patients_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('patients_id_seq', 1, true);
            public       postgres    false    162            �          0    16600    photos 
   TABLE DATA               [   COPY photos (id, patient_id, filename, title, x_count, y_count, width, height) FROM stdin;
    public       postgres    false    163    1975   �U       �           0    0    photos_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('photos_id_seq', 14, true);
            public       postgres    false    164            �          0    16609    posts 
   TABLE DATA               C   COPY posts (id, patient_id, tag_id, owner_id, content) FROM stdin;
    public       postgres    false    165    1975   �V       �           0    0    posts_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('posts_id_seq', 4, true);
            public       postgres    false    166            �          0    16731    roles 
   TABLE DATA               /   COPY roles (id, name, description) FROM stdin;
    public       postgres    false    175    1975   �V       �           0    0    roles_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('roles_id_seq', 3, true);
            public       postgres    false    176            �          0    16743    roles_users 
   TABLE DATA               0   COPY roles_users (user_id, role_id) FROM stdin;
    public       postgres    false    177    1975   8W       �          0    16618    rooms 
   TABLE DATA               ,   COPY rooms (id, name, owner_id) FROM stdin;
    public       postgres    false    167    1975   YW       �           0    0    rooms_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('rooms_id_seq', 1, true);
            public       postgres    false    168            �          0    16623    tags 
   TABLE DATA               <   COPY tags (id, photo_id, owner_id, title, x, y) FROM stdin;
    public       postgres    false    169    1975   W       �           0    0    tags_id_seq    SEQUENCE SET     2   SELECT pg_catalog.setval('tags_id_seq', 2, true);
            public       postgres    false    170            �          0    16631    users 
   TABLE DATA               V   COPY users (id, email, username, password, logins, last_login, full_name) FROM stdin;
    public       postgres    false    171    1975   �W       �           0    0    users_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('users_id_seq', 7, true);
            public       postgres    false    172            �          0    16639    views 
   TABLE DATA               [   COPY views (id, owner_id, status, photo_id, x, y, scale, contrast, brightness) FROM stdin;
    public       postgres    false    173    1975   TX       �           0    0    views_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('views_id_seq', 2, true);
            public       postgres    false    174            �           2606    16656    patients_name_key 
   CONSTRAINT     N   ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_name_key UNIQUE (name);
 D   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_name_key;
       public         postgres    false    161    161    1976            �           2606    16658    patients_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_pkey;
       public         postgres    false    161    161    1976            �           2606    16660 
   posts_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
       public         postgres    false    165    165    1976            �           2606    16662    primary_key 
   CONSTRAINT     I   ALTER TABLE ONLY photos
    ADD CONSTRAINT primary_key PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.photos DROP CONSTRAINT primary_key;
       public         postgres    false    163    163    1976            �           2606    16749    role_pk 
   CONSTRAINT     D   ALTER TABLE ONLY roles
    ADD CONSTRAINT role_pk PRIMARY KEY (id);
 7   ALTER TABLE ONLY public.roles DROP CONSTRAINT role_pk;
       public         postgres    false    175    175    1976            �           2606    16747    roles_users_pk 
   CONSTRAINT     _   ALTER TABLE ONLY roles_users
    ADD CONSTRAINT roles_users_pk PRIMARY KEY (user_id, role_id);
 D   ALTER TABLE ONLY public.roles_users DROP CONSTRAINT roles_users_pk;
       public         postgres    false    177    177    177    1976            �           2606    16664    rooms_name_key 
   CONSTRAINT     H   ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_name_key;
       public         postgres    false    167    167    1976            �           2606    16666 
   rooms_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public         postgres    false    167    167    1976            �           2606    16668 	   tags_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
       public         postgres    false    169    169    1976            �           2606    16670    users_name_key 
   CONSTRAINT     I   ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (email);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT users_name_key;
       public         postgres    false    171    171    1976            �           2606    16672 
   users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    171    171    1976            �           2606    16674 
   views_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY views
    ADD CONSTRAINT views_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.views DROP CONSTRAINT views_pkey;
       public         postgres    false    173    173    1976            �           2606    16675    patients_owner_id_fkey    FK CONSTRAINT     q   ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);
 I   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_owner_id_fkey;
       public       postgres    false    1939    161    171    1976            �           2606    16680    patients_room_id_fkey    FK CONSTRAINT     o   ALTER TABLE ONLY patients
    ADD CONSTRAINT patients_room_id_fkey FOREIGN KEY (room_id) REFERENCES rooms(id);
 H   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_room_id_fkey;
       public       postgres    false    1933    167    161    1976            �           2606    16685    photos_patient_id_fkey    FK CONSTRAINT     t   ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
 G   ALTER TABLE ONLY public.photos DROP CONSTRAINT photos_patient_id_fkey;
       public       postgres    false    163    161    1925    1976            �           2606    16690    posts_owner_id_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);
 C   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_owner_id_fkey;
       public       postgres    false    165    171    1939    1976            �           2606    16695    posts_patient_id_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
 E   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_patient_id_fkey;
       public       postgres    false    165    161    1925    1976            �           2606    16700    posts_tag_id_fkey    FK CONSTRAINT     f   ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(id);
 A   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_tag_id_fkey;
       public       postgres    false    165    169    1935    1976            �           2606    16705    rooms_owner_id_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);
 C   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_owner_id_fkey;
       public       postgres    false    1939    171    167    1976            �           2606    16710    tags_owner_id_fkey    FK CONSTRAINT     i   ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);
 A   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_owner_id_fkey;
       public       postgres    false    1939    169    171    1976            �           2606    16715    tags_photo_id_fkey    FK CONSTRAINT     j   ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);
 A   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_photo_id_fkey;
       public       postgres    false    163    169    1927    1976            �           2606    16720    views_owner_id_fkey    FK CONSTRAINT     k   ALTER TABLE ONLY views
    ADD CONSTRAINT views_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);
 C   ALTER TABLE ONLY public.views DROP CONSTRAINT views_owner_id_fkey;
       public       postgres    false    1939    171    173    1976            �           2606    16725    views_photo_id_fkey    FK CONSTRAINT     l   ALTER TABLE ONLY views
    ADD CONSTRAINT views_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES photos(id);
 C   ALTER TABLE ONLY public.views DROP CONSTRAINT views_photo_id_fkey;
       public       postgres    false    163    1927    173    1976            �   �   x��A
�0 �s��@K���"�����m���,����>A�/{�Z0(S�MQ5�٩��]�vT���q�Ѻ�w,��@��0���N자"1YbX҂�ݶ')dG�׷0��^��f�A�G�je���Z���2-      �   �   x�5�M
�0�ד�X2&��v)��!2��؆�b�U<��rp10���  ,#��{j�4����O�����Z�S�ő����8��{tZ/(�_(�D��RS\P��� ,q+�s7�����s��0gk��(��1��F����C��Ҷ3F]+����2�      �   Q   x�3�4���4�J�IMN�U(H,+�������2��sFeR�BI"P��&�����eQg�门P�Z������� ���      �   =   x�3���O����O).I,�/OT(��IT(��?�''�<31�Hkr�PP./3�+F��� M^j      �      x�3�4����� �$      �      x�3������4����� n[      �   -   x�3�4B��*NSN.# ۈ3$�835735��(`����� �?      �   �   x�U�[
�0E��Ŕf��L�t]AA&�BAki"�|iA��8F�R��Q˦��o����U�3�IR�o�r:ح��U�1;r�O��yr�gG��
.�������, !��{�X�����kۤ�7=vZ�7�2�      �   9   x�3�4�u��t2�А3����8�8�<�C\�b�`�gh�
̠�c���� '%g     