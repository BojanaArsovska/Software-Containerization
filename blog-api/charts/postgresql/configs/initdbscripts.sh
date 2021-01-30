#!/bin/bash
set -e

echo running initdb stuff

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
--CREATE USER docker;
--CREATE DATABASE docker;
--GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgresadmin
--

CREATE TABLE public.alembic_version ( version_num character varying(32) NOT NULL);


ALTER TABLE public.alembic_version OWNER TO postgresadmin;

--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.alembic_version ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- PostgreSQL database dump complete
--


-- users

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgresadmin
--

CREATE TABLE public.users ( id integer NOT NULL, name character varying(128) NOT NULL,
    email character varying(128) NOT NULL, password character varying(128) NOT NULL,
    created_at timestamp without time zone, modified_at timestamp without time zone);


ALTER TABLE public.users OWNER TO postgresadmin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgresadmin
--

CREATE SEQUENCE public.users_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgresadmin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgresadmin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgresadmin

--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.users ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.users ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


-- blogposts

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: blogposts; Type: TABLE; Schema: public; Owner: postgresadmin
--

CREATE TABLE public.blogposts ( id integer NOT NULL, title character varying(128) NOT NULL, contents text NOT NULL,
    owner_id integer NOT NULL, created_at timestamp without time zone, modified_at timestamp without time zone);


ALTER TABLE public.blogposts OWNER TO postgresadmin;

--
-- Name: blogposts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgresadmin
--

CREATE SEQUENCE public.blogposts_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;


ALTER TABLE public.blogposts_id_seq OWNER TO postgresadmin;

--
-- Name: blogposts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgresadmin
--

ALTER SEQUENCE public.blogposts_id_seq OWNED BY public.blogposts.id;



--
-- Name: blogposts id; Type: DEFAULT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.blogposts ALTER COLUMN id SET DEFAULT nextval('public.blogposts_id_seq'::regclass);


--
-- Name: blogposts blogposts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.blogposts ADD CONSTRAINT blogposts_pkey PRIMARY KEY (id);


--
-- Name: blogposts blogposts_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgresadmin
--

ALTER TABLE ONLY public.blogposts
    ADD CONSTRAINT blogposts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--


EOSQL

echo initdb completed
