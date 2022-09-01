--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
--SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

--CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

--COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: tsm_system_rows; Type: EXTENSION; Schema: -; Owner: -
--

--CREATE EXTENSION IF NOT EXISTS tsm_system_rows WITH SCHEMA public;


--
-- Name: EXTENSION tsm_system_rows; Type: COMMENT; Schema: -; Owner: 
--

--COMMENT ON EXTENSION tsm_system_rows IS 'TABLESAMPLE method which accepts number of rows as a limit';

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: casts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casts (
    movie_id bigint NOT NULL,
    person_id bigint NOT NULL,
    job_id bigint NOT NULL,
    role text NOT NULL
);


--ALTER TABLE public.casts OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id bigint NOT NULL,
    name text
);


--ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    name text
);


--ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: TABLE jobs; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.jobs IS 'English-only version of job_names';


--
-- Name: movie_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genres (
    movie_id bigint NOT NULL,
    genre_id bigint NOT NULL
);


--ALTER TABLE public.movie_genres OWNER TO postgres;

--
-- Name: movie_in_saga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_in_saga (
    movie_id bigint NOT NULL,
    saga_id bigint NOT NULL
);


--ALTER TABLE public.movie_in_saga OWNER TO postgres;

--
-- Name: movie_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_languages (
    movie_id bigint NOT NULL,
    language text NOT NULL
);


--ALTER TABLE public.movie_languages OWNER TO postgres;

--
-- Name: movie_references; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_references (
    reference_to bigint NOT NULL,
    referenced_by bigint NOT NULL,
    type text NOT NULL
);


--ALTER TABLE public.movie_references OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    id bigint NOT NULL,
    name text,
    date date,
    runtime integer,
    budget numeric,
    revenue numeric,
    homepage text,
    vote_average numeric
);


--ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: sagas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sagas (
    id bigint NOT NULL,
    name text,
    date date
);


--ALTER TABLE public.sagas OWNER TO postgres;

--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    id bigint NOT NULL,
    name text,
    birthdate date,
    deathdate date,
    gender integer
);


--ALTER TABLE public.people OWNER TO postgres;


