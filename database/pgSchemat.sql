--
-- Struktura tabeli dla tabeli 'users'
--

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name varchar(255) UNIQUE NOT NULL,
  password varchar(255) NOT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'rooms'
--

CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  name varchar(255) UNIQUE NOT NULL,
  owner_id INTEGER REFERENCES users(id)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'patients'
--

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name varchar(255) UNIQUE NOT NULL,
  date date DEFAULT 'NOW()',
  status varchar(50) DEFAULT NULL,
  description text,
  room_id INTEGER REFERENCES rooms(id),
  owner_id INTEGER REFERENCES users(id)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'photos'
--

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  patient_id  INTEGER REFERENCES patients(id),
  filename varchar(255) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'views'
--

CREATE TABLE views (
  id SERIAL PRIMARY KEY,
  owner_id  INTEGER REFERENCES users(id),
  status varchar(50) DEFAULT NULL,
  photo_id  INTEGER REFERENCES photos(id),
  x INTEGER DEFAULT 0,
  y INTEGER DEFAULT 0,
  scale float DEFAULT 1,
  contrast float DEFAULT NULL,
  brightness float DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'tags'
--

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  photo_id  INTEGER REFERENCES photos(id),
  owner_id INTEGER REFERENCES users(id),
  title varchar(255) DEFAULT '',
  x INTEGER DEFAULT 0,
  y INTEGER DEFAULT 0
);

-- --------------------------------------------------------

--
-- Funkcja XOR
--

CREATE OR REPLACE FUNCTION XOR(arg1 boolean, arg2 boolean)
  RETURNS boolean AS
$BODY$BEGIN
RETURN ( arg1 and not arg2) or ( not arg1 and arg2);
END$BODY$
  LANGUAGE plpgsql VOLATILE;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli 'posts'
--

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  patient_id INTEGER REFERENCES patients(id) DEFAULT NULL,
  tag_id INTEGER REFERENCES tags(id) DEFAULT NULL,
  owner_id  INTEGER REFERENCES users(id),
  content text,
  CONSTRAINT THREAD_FK CHECK(xor(patient_id IS NULL, tag_id IS NULL))
);