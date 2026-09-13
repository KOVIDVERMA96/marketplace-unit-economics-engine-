--
-- PostgreSQL database dump
--

\restrict NZyKigCgJlpmI0LBpwZay4yUbIdHvbdR9oHqTi8vFBVKM1k5g3pvvEIphvmugF9

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-13 17:54:58

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
-- TOC entry 229 (class 1259 OID 16464)
-- Name: fct_monthly_actual_financials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fct_monthly_actual_financials (
    order_month date,
    total_orders bigint,
    total_units_sold numeric,
    units_per_order numeric,
    merchandise_gmv numeric,
    freight_gmv numeric,
    gross_order_value numeric,
    total_cash_collected numeric,
    reconciliation_gap numeric,
    gross_aov numeric,
    credit_card_pct numeric,
    boleto_pct numeric,
    voucher_pct numeric,
    debit_card_pct numeric
);


ALTER TABLE public.fct_monthly_actual_financials OWNER TO postgres;

--
-- TOC entry 5061 (class 0 OID 16464)
-- Dependencies: 229
-- Data for Name: fct_monthly_actual_financials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fct_monthly_actual_financials (order_month, total_orders, total_units_sold, units_per_order, merchandise_gmv, freight_gmv, gross_order_value, total_cash_collected, reconciliation_gap, gross_aov, credit_card_pct, boleto_pct, voucher_pct, debit_card_pct) FROM stdin;
2016-09-01	1	3	3.00	134.97	8.49	143.46	\N	\N	\N	\N	\N	\N	\N
2016-10-01	265	313	1.18	40325.11	6165.55	46490.66	46566.71	76.05	175.72	81.55	16.39	1.54	0.52
2016-12-01	1	1	1.00	10.90	8.72	19.62	19.62	0.00	19.62	100.00	0.00	0.00	0.00
2017-01-01	750	913	1.22	111798.36	15684.01	127482.37	127545.67	63.30	170.06	78.51	17.75	3.15	0.58
2017-02-01	1653	1858	1.12	234223.40	37015.92	271239.32	271298.65	59.33	164.13	77.54	20.00	1.90	0.56
2017-03-01	2546	2897	1.14	359198.85	55132.10	414330.95	414369.39	38.44	162.75	78.52	18.34	2.29	0.85
2017-04-01	2303	2569	1.12	340669.68	50142.72	390812.40	390952.18	139.78	169.76	78.38	18.21	2.73	0.68
2017-05-01	3546	4004	1.13	489338.25	77513.15	566851.40	567066.73	215.33	159.92	74.68	21.98	2.83	0.50
2017-06-01	3135	3489	1.11	421923.37	68127.00	490050.37	490225.60	175.23	156.37	75.48	21.46	2.57	0.49
2017-07-01	3872	4416	1.14	481604.52	84694.56	566299.08	566403.93	104.85	146.28	76.92	19.72	3.01	0.35
2017-08-01	4193	4797	1.14	554699.70	91132.66	645832.36	646000.61	168.25	154.07	77.57	19.74	2.21	0.47
2017-09-01	4150	4737	1.14	607399.67	93677.82	701077.49	701169.99	92.50	168.96	78.82	18.04	2.47	0.67
2017-10-01	4478	5214	1.16	648247.65	102869.36	751117.01	751140.27	23.26	167.74	78.87	17.95	2.42	0.76
2017-11-01	7289	8475	1.16	987765.37	165598.83	1153364.20	1153528.05	163.85	158.26	79.25	18.62	1.62	0.51
2017-12-01	5513	6187	1.12	726033.19	117045.10	843078.29	843199.17	120.88	152.95	77.61	19.07	2.51	0.82
2018-01-01	7069	8037	1.14	924645.00	153242.46	1077887.46	1078606.86	719.40	152.58	77.92	18.36	2.65	1.07
2018-02-01	6555	7518	1.15	826437.13	139731.28	966168.41	966510.88	342.47	147.45	78.48	18.50	2.25	0.77
2018-03-01	7003	8017	1.14	953356.25	167241.99	1120598.24	1120678.00	79.76	160.03	80.43	16.65	2.25	0.67
2018-04-01	6798	7827	1.15	973534.09	159344.84	1132878.93	1132933.95	55.02	166.66	80.35	16.82	1.91	0.92
2018-05-01	6749	7810	1.16	977544.69	151229.83	1128774.52	1128836.69	62.17	167.26	80.35	17.01	1.80	0.84
2018-06-01	6099	7010	1.15	856077.86	155900.43	1011978.29	1012090.68	112.39	165.94	79.17	15.02	2.29	3.52
2018-07-01	6159	6963	1.13	867953.46	159853.82	1027807.28	1027903.86	96.58	166.89	75.48	18.82	1.92	3.78
2018-08-01	6351	7142	1.12	838576.64	146915.00	985491.64	985414.28	-77.36	155.16	79.35	14.29	1.75	4.61
\.


-- Completed on 2026-09-13 17:54:58

--
-- PostgreSQL database dump complete
--

\unrestrict NZyKigCgJlpmI0LBpwZay4yUbIdHvbdR9oHqTi8vFBVKM1k5g3pvvEIphvmugF9

