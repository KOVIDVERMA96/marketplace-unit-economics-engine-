--
-- PostgreSQL database dump
--

\restrict g9eKDWsz8dOLxpfRq538OXSIsY7YZieTjbaQ5xX1r5tAMfmoQ9rj14DZ7rJjD6b

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-13 17:55:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 233 (class 1259 OID 16496)
-- Name: fct_seller_concentration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fct_seller_concentration (
    seller_decile integer,
    sellers_in_decile bigint,
    decile_gmv numeric,
    gmv_share_pct numeric,
    cumulative_gmv_share_pct numeric
);


ALTER TABLE public.fct_seller_concentration OWNER TO postgres;

--
-- TOC entry 5061 (class 0 OID 16496)
-- Dependencies: 233
-- Data for Name: fct_seller_concentration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fct_seller_concentration (seller_decile, sellers_in_decile, decile_gmv, gmv_share_pct, cumulative_gmv_share_pct) FROM stdin;
1	297	8873076.37	67.11	67.11
2	297	2006583.27	15.18	82.29
3	297	1026473.27	7.76	90.05
4	297	549968.17	4.16	94.21
5	297	328102.28	2.48	96.69
6	297	202659.24	1.53	98.22
7	297	117831.52	0.89	99.11
8	297	67111.11	0.51	99.62
9	297	36305.84	0.27	99.89
10	297	13387.04	0.10	99.99
\.


-- Completed on 2026-09-13 17:55:24

--
-- PostgreSQL database dump complete
--

\unrestrict g9eKDWsz8dOLxpfRq538OXSIsY7YZieTjbaQ5xX1r5tAMfmoQ9rj14DZ7rJjD6b

