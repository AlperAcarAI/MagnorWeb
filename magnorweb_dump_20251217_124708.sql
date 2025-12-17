--
-- PostgreSQL database dump
--

\restrict esZs5dmySXswn0gv0ZWrrjCdyozxZEReXL63yUiLRiKM9B4mRleo3JIBIvZlWrZ

-- Dumped from database version 16.11 (Homebrew)
-- Dumped by pg_dump version 16.11 (Homebrew)

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

--
-- Name: proficiency_level; Type: TYPE; Schema: public; Owner: acar
--

CREATE TYPE public.proficiency_level AS ENUM (
    'native',
    'fluent',
    'intermediate',
    'basic'
);


ALTER TYPE public.proficiency_level OWNER TO acar;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: acar
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'user',
    'viewer'
);


ALTER TYPE public.user_role OWNER TO acar;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agencies; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.agencies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    contact_name text,
    contact_email text,
    contact_phone text,
    commission_rate numeric(5,2),
    notes text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.agencies OWNER TO acar;

--
-- Name: brands; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.brands (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    logo text,
    color text DEFAULT 'bg-purple-500'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.brands OWNER TO acar;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    icon text,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.categories OWNER TO acar;

--
-- Name: kol_agencies; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kol_agencies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    kol_id uuid NOT NULL,
    agency_id uuid NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    is_active boolean DEFAULT true NOT NULL,
    contract_notes text
);


ALTER TABLE public.kol_agencies OWNER TO acar;

--
-- Name: kol_categories; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kol_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    kol_id uuid NOT NULL,
    category_id uuid NOT NULL,
    is_primary boolean DEFAULT false NOT NULL
);


ALTER TABLE public.kol_categories OWNER TO acar;

--
-- Name: kol_languages; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kol_languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    kol_id uuid NOT NULL,
    language_id uuid NOT NULL,
    proficiency_level public.proficiency_level
);


ALTER TABLE public.kol_languages OWNER TO acar;

--
-- Name: kol_pricing; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kol_pricing (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    kol_id uuid NOT NULL,
    service_name text NOT NULL,
    social_media_details jsonb,
    price numeric(10,2) NOT NULL,
    price_without_commission numeric(10,2),
    currency text DEFAULT 'USD'::text NOT NULL,
    notes text,
    contact_info text,
    is_active boolean DEFAULT true NOT NULL,
    valid_from timestamp without time zone,
    valid_until timestamp without time zone,
    created_by uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.kol_pricing OWNER TO acar;

--
-- Name: kol_social_media; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kol_social_media (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    kol_id uuid NOT NULL,
    social_media_id uuid NOT NULL,
    link text NOT NULL,
    follower_count integer,
    engagement_rate numeric(5,2),
    verified boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.kol_social_media OWNER TO acar;

--
-- Name: kols; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.kols (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    tier_score integer,
    telegram_address text,
    email text,
    phone text,
    notes text,
    is_active boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.kols OWNER TO acar;

--
-- Name: languages; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.languages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.languages OWNER TO acar;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    token text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sessions OWNER TO acar;

--
-- Name: social_media; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.social_media (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    icon text,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.social_media OWNER TO acar;

--
-- Name: users; Type: TABLE; Schema: public; Owner: acar
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username text NOT NULL,
    email text,
    password text NOT NULL,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    last_login timestamp without time zone
);


ALTER TABLE public.users OWNER TO acar;

--
-- Data for Name: agencies; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.agencies (id, name, contact_name, contact_email, contact_phone, commission_rate, notes, is_active, created_at, updated_at) FROM stdin;
2db608fc-a6c3-4fda-a846-7ea2987c03e0	Magnor	\N	\N	\N	\N	Magnor Agency - Premium Web3 Marketing	t	2025-12-10 16:48:54.48611	2025-12-10 16:48:54.48611
49147e32-d354-4366-82a7-48a1b3f109fd	Markchain	\N	\N	\N	\N	Markchain - Blockchain Marketing Agency	t	2025-12-10 16:48:54.48611	2025-12-10 16:48:54.48611
4341951f-6d16-4abd-84cc-204fd4721a00	Tiko	\N	\N	\N	\N	Tiko Agency	t	2025-12-10 16:48:54.48611	2025-12-10 16:48:54.48611
4c58fe08-8326-42e3-b426-f83565cd8dae	FainEra	\N	\N	\N	\N	FainEra - Digital Marketing	t	2025-12-10 16:48:54.48611	2025-12-10 16:48:54.48611
f50745d0-a04f-4631-ba98-d318a1d30f57	Cmedia	\N	\N	\N	\N	Cmedia - Content & Marketing Agency	t	2025-12-10 16:48:54.48611	2025-12-10 16:48:54.48611
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.brands (id, name, logo, color, created_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.categories (id, name, description, icon, is_active) FROM stdin;
a9b46f8c-e978-446f-8db4-e019843d17a0	Invesment	Investment opportunities and strategies	investment	t
0652bfda-1c8f-4057-89d1-695edac3c389	Trade	Trading and market activities	trade	t
3be7640b-781f-45e7-9010-6f12a56d579a	Volume	Volume generation campaigns	volume	t
7b6efad2-588b-456e-99c5-280469d7f0ac	AirDrop	Airdrop campaigns and distributions	airdrop	t
619da7e6-530a-4b03-97d9-ae83f6e121b8	Brand Awaraness	Brand awareness and visibility	brand	t
629f1b84-30e3-4091-ab03-1c348fb8ee8e	PreSale	Pre-sale and early access campaigns	presale	t
29e2746c-20eb-4067-897b-f5d26da835f1	News	News and announcements	news	t
1a2321e1-efb0-4f24-9c17-1c8b9093d140	Education	Educational content and tutorials	education	t
2917fb34-2404-4ac1-8474-439bb8e2b0d9	Gaming	Gaming and GameFi projects	gaming	t
f0b1b1f6-9334-4c67-b745-9e1a9e3803d8	Solona	Solana blockchain ecosystem	solana	t
\.


--
-- Data for Name: kol_agencies; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kol_agencies (id, kol_id, agency_id, start_date, end_date, is_active, contract_notes) FROM stdin;
a1361a46-f371-47f8-8bf5-2605c161a1bb	a08f7952-90d4-4354-b8b9-5c0a5e255d9e	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
22a35077-d1d5-4464-8d81-fe2b1b7a5645	92444995-2431-4c5f-a13c-7c2cc5ee7d30	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
cc476308-de8a-4c0f-9e8c-56d6d19df1b6	74e78d28-5150-484b-9db2-9446b75381d5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
8d271794-525b-4f95-b648-3fd5195c7c78	90cf70d3-9e96-408e-a2ba-36d6a28cef4a	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
50c4bf05-f545-4bf9-a3ce-3215df1dbc44	e03a2d3a-3282-4b79-a7cd-56b93fd3b598	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e127fa85-27a5-4bbb-b8d6-0f53fb826b9b	d54d1f0e-4025-4958-a212-cdfe52009005	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
ed88ecbb-6703-4d73-8bdf-8207fe41de1f	da40d652-d045-4bff-8a32-e8003411b36b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e6db4ca6-610d-40f6-9090-2b3db37e3eed	c40a0124-19fe-4651-a59a-28cf46fbd787	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c3398dac-612e-4f35-b95d-0d5f732a7cf1	a40312dd-0331-4a25-bed6-2b05e9152fbf	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
89edb8c9-3946-4062-8aa8-3b82dc6ee220	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c607beef-67fc-4beb-8bd5-686c4fba8151	f735e4c0-39c3-4c66-92ad-908f7461a84f	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
6ed34dbb-03a5-4dec-b752-953e0a14841f	c5055660-0373-4b7a-8842-b53c9d810bc9	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
928f109d-da2c-4efb-bc86-9e163b6d86e5	10a0228d-8083-41d2-a11f-7fe4a61bbc16	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e1e95dc5-81c8-4005-bad1-9a63e5aaf891	3a08982c-087b-47cf-8b8f-1a7afb5e4081	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f8c1d78a-f8cc-4b10-a943-4f4f89ec255c	afec6c13-3295-4055-abeb-9d3d7329bb4b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
a87127e5-58f1-41ac-8f42-ee5a0cbb6f9e	05676f72-39b2-41e3-9957-a3a5b8d3cf3b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
ae40f6b8-63da-49cb-b5ee-c77ed3ecd257	cd1b83c9-d393-4140-b9aa-a03c8ad0cf20	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
bd746a86-0dd4-4293-89f4-183beb0d9b55	eb46fe18-5c1f-4b32-9071-63daa3da0e28	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
bb41a278-71c9-404c-b1d1-c179c8ca781f	26de4eaa-09f2-4943-ab51-f32f20f48e25	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
114ac8c4-7c39-4db7-a579-71760b44906b	6cca21a7-d9b0-4c72-8743-d0c4d18861ae	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
771095ea-b3de-4e75-a10b-1ef5188f00f8	849504e9-4b12-4f8c-946e-21eca7000980	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
0838ebb9-038e-4064-bcaa-18521381b861	654a9fd7-e1fa-4ade-938c-dc90713e4f35	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
1ebf1d40-3a9c-48f2-ad03-9a99347f2b31	f3a3819e-212b-4aeb-a8fe-779243323abe	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
d0edcf2a-c8aa-4938-b1b0-1a37c19e4b00	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
fda7d78e-5c16-4402-a8b7-6d3e9f2a4341	40331030-31cb-4391-913b-acd387389679	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c7117b0e-3a23-4bc8-aeb8-8ed2dfec3327	9467920b-47ff-4786-ab2d-ba71bedb4520	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
9f44b89f-0baa-417b-97d4-515b2269e409	449eb148-3918-483d-ad31-078456bbfddc	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
cc34882f-c851-40c3-b3cf-a3d31869c28b	c432674b-3697-4c92-9698-61ef46eedbe7	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
30baf4a4-4f4a-4f57-81b6-cbf84f456c1e	a8e73e8b-e412-4d9b-971d-1bfb59309abb	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e42704ed-8524-4899-932a-8fc8174395e3	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
66c7ce5f-98c7-4fc2-8c22-126febd52e36	be5f976b-114d-4308-8242-52d14f4e9aa6	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f3e41a76-1d89-435f-84c3-61c2f098c978	ac955c91-0b4f-4e7b-97e3-6d29389cf196	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
7eb007f3-6a9d-463f-9330-6e4d4b57abbf	b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
2521156e-736f-4027-9abe-4ca8e8b49dc5	7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
435b0187-423c-4aff-810a-439be301d4c5	9272a0a5-0def-403f-8dad-475fa62fdc71	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
11a66824-5644-4937-bd66-55cd8da13fb4	8bb3e252-e66b-4477-a145-8b03c028805d	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
eb4f42ba-13c9-45a5-ad6d-3c643404d121	df663153-02e1-4bf6-8f3b-ac3efeefdb48	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c89467bb-7ee6-48af-9f24-6e882c41f682	54848923-af3c-4528-a36f-b86babd69225	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
9cf59619-dec8-44ff-9339-658538c1d995	b2e93254-185e-4547-a363-eb5a99078141	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
68bf0140-122e-42e5-b638-87d47050a608	47abda88-d904-4402-8257-1e88c0ff6ef5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
ccdca0f4-5354-4303-8c8e-b1d4b79d4773	508162b5-5cc2-4cbe-932c-cccc7c7c526f	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
cee95eb9-d99c-44b9-80b3-8d81e622b6cf	003b2d41-7de0-4eec-8fe2-17374ae91d58	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
d2f41b1a-d504-4d55-9bdb-6098326d5c81	e0f32a2f-a1b6-4bce-9a48-3407f24062a5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c53018cb-25d7-499d-a339-c35a7ea9c642	281f97e5-14e2-4a93-80af-80e0ed98bcff	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
3ed679ae-f566-4e83-bdd5-300d6f9b0ba8	f4b5744a-8dd0-4504-ba9c-be8992240fe3	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
888c3177-a06c-4e70-b31c-729971f3a2bc	186b1700-46b2-4e9f-b961-5f86f5efbfc1	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
0e97ecff-3358-4371-b0ee-7656b3e038f9	e6ef5e56-45a6-4c7c-a540-afc90b193143	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
5d76be13-52e7-48a5-8c96-5ebef16927b4	c6fb0205-1405-4198-940d-5c075949c13e	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
2903ecb0-fd6f-4800-a835-442fecb7dcf7	f09eb623-3bbd-4771-b853-aef41da517ed	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
38432e6d-0295-4582-b86b-eadcda13d05b	d8fd8b3f-5e45-4e37-8a50-85bcbf23efd4	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
244a92b2-c571-4da0-a17e-7e89dd89c82e	0a2f4d54-807c-4e33-866b-cfc22845d6e6	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
be80283e-80c6-4d52-ab66-d9c1a7596993	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
bba0d9f5-f23f-4dd3-bd49-e2c4fd697e13	8ea77d03-8233-49e8-b39b-262daada91aa	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
33748990-351b-4248-a4fa-2ac5c476b859	888cbfe3-9c4b-4456-9d33-f72e0d002456	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
24892b33-49e3-4817-9943-2e837fcf87a9	df953e7c-659b-401e-a906-7b25f29fca41	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e14ddd4c-bc34-406e-9258-317af002d32a	88615501-f3e3-434c-bbff-9d5178d9274c	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
12ee3d0e-2650-471a-8874-24c62394e80c	febfc4b3-6c2f-4353-9059-2639e24ffec6	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
b7b3abc0-24ad-42fe-8a70-f4899eab7661	e90ebec3-3bc2-49b1-8548-173d50dd8873	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
b9e9cbc3-6af0-4dc4-92f3-5f738a617e98	2f3b4d72-0a9a-49e2-8985-50c9d816da4c	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
23a76055-7f2d-4ae3-864b-1a31f32eb546	83c11014-e12b-466b-a09d-e5ae72fc71ba	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
991a1cd9-8e8e-453d-a042-0113c8318476	84e5e479-8261-4a7c-a14d-08ba739fda95	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
931a90ed-1549-4b15-ac3a-99c3aec3851b	43794457-3218-4378-8092-8391571c3ff3	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
08c5f023-5762-4b80-9c02-daab85ca33f9	1ce65635-3d69-4b87-897d-1b42d241b66e	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
cebea20f-8fe9-4bf4-b19a-b0005633bc60	38a50ecf-a0c9-4789-afff-10c9c04312fc	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
8a657cb8-4599-4de2-a61c-6ed38e4e5c3b	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
7dcab659-9359-4018-acb1-5bf85b3da25f	2c32254c-b0e3-4fe5-942c-70518f6be97b	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
7c3e719e-e468-41e8-8611-3331cdae67f2	ad10b365-44b2-4b4c-bd9b-6b15a885598c	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
fc847db4-3a27-4f51-a98f-d76808cae3c7	1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
6875dbae-7443-45cc-9395-b975f9f23139	f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c782a371-72e3-40d8-a5c8-94ec4b156f44	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f666519a-216d-4431-8d1d-555111a7bcc7	c54006c7-737c-494d-8d18-b9de72a4d867	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
7b69100a-3799-4a47-a69d-117c35c1cc5b	b6f673cd-c892-4a6b-80e4-e35d5047f905	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
86ddfe81-a4d0-4122-af6a-facf5e0434c5	a50e21e7-b8e2-4678-a731-2602f1dd2bdb	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
aa6c84ad-420c-4e7d-9bbc-8769c1f13c80	89184324-3bd9-4479-91d8-05dbb8704734	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
7965fccc-e72f-4776-9fc9-a2b252629083	ee52295a-a14a-438d-8e93-b42966b44f57	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
b8789935-45be-4613-8200-8edc7a7200b2	3a5c5674-5f0c-4d4f-83de-6557052c9cd6	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
490c7495-24f8-4e21-885c-c4ed53918284	bb789f23-6d06-4380-a752-b391c3380210	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
ca09443e-6880-4bdd-8149-179562f12335	820af3e2-669e-43fd-9a5a-12cb06e50d80	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
8de86254-1696-4fe5-9542-5a713cb890d6	66f3145c-53d4-4244-91b4-0b84fdc87097	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
275023ce-f2c9-4621-b529-70e20541f11e	10b7a7d7-e824-4296-a746-e88fc7511cd8	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
573ec0ad-aaef-42d3-9856-47042e8b48a6	02e32b42-7818-40fc-8014-22afc4e69092	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
0d4e7cd9-3a0a-4eeb-815b-7a47e0047c7a	ca768075-e597-4929-9a5c-d749932ee0a1	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
84e9f869-4fec-4d05-b271-100323b4ec12	fe9fc6f0-2e95-4434-b379-9cf7cf7487c7	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
39f83f95-e106-4440-ab7c-8858c0e7b721	20bdeac7-b480-41bb-8f7a-1099626e3249	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
b71b2aef-037c-4b2f-9f9c-710e727ddb88	f390519c-40ea-4450-a54f-1e466b920e90	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
6cc4534d-5691-4e00-942f-967f0b0faa5b	2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
79578b9b-a853-4476-95a6-a277b69e9a48	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
021d6218-4625-4d45-9fbf-54bbafa79463	6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
90b1fdd4-3f0b-4ef5-a4de-09082bfb4f37	4f7141d7-ac31-4e32-8776-b4660f5c296b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
38039750-158c-467b-a8e0-8f4fec129dd9	6018f5e5-eb1b-4335-aef1-18b0e410cc15	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
780b3b38-e4e6-4562-a6e0-4e27daa1ea0e	f0464a49-5b3a-477f-b898-579fbf10c159	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
d27b0b9e-5ceb-4cd0-be81-049ade9b2a2f	815b489f-3c8b-4439-b18d-79ac234d198e	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
5528994a-6d80-4a81-b029-377d24136051	952bbd57-f1c2-4aa8-8fac-ae689e19e0d8	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
e415ea5f-21f9-42ce-ba4b-fa09930b5583	b868509d-79d9-492e-b250-33a34d8cb0e8	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
1b8c32cf-60e5-4e47-aeae-9a78e526ad41	7f2823e2-582f-4120-90d9-fd7d02ece572	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
50532bf8-cc3b-4c71-971f-14a320dfd210	92610a49-08e0-4bc3-b61c-9bbf8adee414	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f549b6e0-d5d6-4ff5-bbda-fed053211ac2	0781049d-3f4f-4184-86be-abd5b52d47e3	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
4577ddab-9e60-4dab-940a-44af63f5d175	48cfe773-1b13-41b3-92cf-f48af45125cb	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
af9f130a-740d-4e2d-978a-f0a9dd65ed24	edaab8c7-830a-461a-8d12-026793c0ab63	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
b7808879-7960-4a63-b6c8-29dc4ef24dae	b1780c0f-40ae-427a-ad1c-bf6f160dd8ff	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
ff75c317-063f-4141-9461-1e3a115e8094	91b8f309-8a61-4967-b5e3-469a9e494ebf	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
b08dd8f1-1519-4edc-a9ce-088e426d8702	2dc7b740-47c4-4dad-8e93-b9bf036609b6	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
0eeee8d1-6082-43bd-abbd-b7e64f18e3ef	365c16ff-15dd-4cd9-bd00-5b56537423dc	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
bb753a5e-c609-4bb3-9906-3bf65a387856	c3fd460c-b148-4f5e-94ed-f906607510d5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
cc38445d-5c9d-4ed3-a4f1-e72205f62244	ef1ac0b2-e9b3-430c-9efb-8fc4f9989ff8	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
825f801f-b53f-446b-af99-b0c8e446c35d	886bfe98-a961-4e36-8e32-f34eff9db46a	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
710dae9b-a21a-46db-af0a-1d9196e75a02	cf66d5bd-490b-4b80-aba5-d04df1288fab	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
acebe381-ef79-460c-a47b-de8cd1b3b78b	2c7daabd-9713-4d6c-b44b-5295b1146e4b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e184465a-4ed3-493e-9579-4596dabd717d	30c617a3-6840-4150-9a78-e479cdaaa6a1	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
73cf8a61-2ba2-4f7b-b494-c874e479d5dc	d25cce7d-1b03-44ff-af78-c907300e06af	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
d98f442c-8730-49d9-a8ae-8b0d88306c43	31ccb5b9-3232-49bf-8121-b0d49784a072	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
7facc335-cf89-499b-972c-7b3b8e48161b	602788df-be32-4409-aa4a-331e1d3a3c12	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
d2bfa311-b6eb-440e-8dd1-a013086fd8b6	b4887d0c-2c72-4b6f-885f-530af72ea7aa	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
1bbb1efd-ac1a-4956-9ead-b3a6c2b77803	0be00181-1078-4960-958c-dad896f508cd	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
b880132c-2a46-4e86-bc91-358982b98f92	5205065e-4780-4bba-841b-2bf3bb2b4b2f	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
12244118-b554-486c-93a3-2ac0d645efa3	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
ecf01705-c228-4d42-957c-baa241f66626	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
c0dbdb46-0574-4c33-b9f2-d506b6901d2a	f129f037-4617-4f13-91b6-2f0846f15594	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f6669334-85ce-4a9c-92cd-ca05257cc3b2	bce6a1f6-efce-43e9-9e1f-556d8c35aa44	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
5a2932eb-8d80-4b38-bef9-1c161653b45d	f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f08e1b6a-118e-4660-b4c1-a3851fad770a	61f2cb13-4d3c-4ed9-b942-5d94de5b10c5	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
1bf6cf95-22d2-40a9-a8c7-b07fec06ec56	ea6c162c-6b68-45ba-a64c-5b80819411b1	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
e294e141-392c-4912-a408-e0df541dead5	d17b7538-0204-4b2f-aecf-83f8af1d266c	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
26eaa732-3f5d-4cfd-92ec-c58480978a49	22561ea9-e707-4082-afbf-0a706a3918d5	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
167d3f08-f476-4e2b-8eee-e4d52f5aaa02	28dafb56-4f38-4051-ae2b-67dabda4b1d5	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
4069a985-de22-4002-aa2c-354acc9e8b9b	e4477eab-179d-4400-aa9b-219169bf4111	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
a3563739-400b-4ebb-a993-6c69cd71b663	e9a26452-e262-4411-8e73-d99449360b66	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
228a86f4-43ee-416a-958e-bd1c303519ba	bd00f679-68f3-4b10-940d-4bce91e5918c	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
ea560c3f-45c8-476f-aace-e426fa5e67df	fac03169-f6bd-4c63-904f-614e89932b1b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
42fbcbed-e857-4c4a-870a-eb0796023743	eada85b3-3437-4c8f-ad80-94ec9a2ae738	4c58fe08-8326-42e3-b426-f83565cd8dae	\N	\N	t	\N
c104954f-a57f-4c29-a735-372d0c6e8b62	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
814ebfcd-f789-4d7c-9da9-c1dca45205a3	3375d125-c65b-4bbc-807c-d0e15580cc9b	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
386300ad-7a56-48de-9e9d-084c7eda3dff	cfd27e79-36d0-4646-af3d-3f66a790ca59	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
f2b09e12-a5d7-4dbc-9132-23846818a04f	6de1feb5-e286-467b-93fb-7cbf1dd12962	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
bc271f5c-b53b-4293-8b44-ba1f997b7e61	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
390a6bdf-c1d6-4d23-ba44-6bb5eb633879	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
50c654bb-5ea7-41a9-bfe1-9b4b2f5165a5	cf53fa17-a86a-4d2f-b72d-3232d84fdfdf	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
ce275763-c92c-4462-838f-1b75e0bfdf1b	c86137aa-11da-4736-a053-67db0a8d658d	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
325777ce-5d89-452b-a370-29758df07952	e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
b4cab43b-a825-4e38-91ad-3da839d5e0f1	3aecf454-6f25-40c9-b7f7-18cef6edcb32	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
2f682d82-ca33-4c8b-b654-4a2f3a132bb8	de43e928-54d8-424f-b164-c6f6cf7b8301	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
871b033d-0e33-4b53-9be8-9d95edb8a995	8ca620b9-34cc-4cb2-bde4-9e4e425fdf2c	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
6b009d49-81a5-40f3-9d34-2e0455d30681	7a267af5-6c9a-46e4-b7b6-b16612eba675	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
bb610782-b63f-49d1-bd3a-5f86222cca14	98c97607-b8f8-4115-8bbf-a389eefb9298	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
dbff8f88-1cd0-4a7e-8373-4ebfd88ec09c	81ea2a69-5998-4f99-9bef-ee4f79e2ed7d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d229a383-6d1f-4bd8-b811-d036e856a337	87d1c881-208d-42f3-9d46-76b2c427bae3	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
be9a6fee-b559-482a-ac19-14699380462a	34fd25ca-654a-4bed-b5e3-087641ff1da4	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
881347ce-502a-445e-9769-03c390fcca7e	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
de1559be-ecec-4cd0-b8d9-c1329d995c75	e94b1181-5944-4cc0-87ca-e7cb96294cde	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9f0b4524-0369-4ee4-9699-9a2986ca98b1	2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
da4a6bb7-45b2-4ee8-9136-604dd60ffef8	0534a13e-fd02-4cfb-8491-c59ac802ff56	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
21601c04-734d-4eb8-9a29-d7f3c36412d5	a63fdd89-7fdd-4a67-bd10-3ec3f948723d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
04442338-a78b-4fa8-842a-7fe3659b27b3	0c9a840d-5ae1-405f-97d8-b4620bd69836	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
156aece3-18be-4289-b1df-fe413edb7d9c	cfd6e494-2e99-4444-b0dd-cf0e39c35c3f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
99ff40b6-ce5e-4ef3-b109-49f4db862727	f8998b14-8d70-4926-9fb2-9254bd4ac494	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fc6d94d6-52f6-4399-8c4d-21aced288bf6	3673e128-01f7-48b5-83e1-f5d132e0b124	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
fbed724e-4738-4a70-a396-ed274e42d8b1	83c4db35-bc00-42ee-84a3-0c518581f849	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
2c08cd22-e348-482a-a9ef-220e87e1195f	3275128f-dcb6-4a98-9250-0c658c74b22d	f50745d0-a04f-4631-ba98-d318a1d30f57	\N	\N	t	\N
54ba634d-f841-4bb2-8bee-39032437defa	b5c1a526-3c0d-4769-adad-454977d5b169	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e9842d1b-e6f1-4446-b746-425c48c0e1db	31288d3a-60ff-4355-b0cc-22c27c795888	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a0027443-32ae-494c-93c7-11decde675b7	9d82b44c-4a01-4adc-a2b7-de0f341cb15b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b214cad4-8a39-42a3-b952-1d1ef382bd92	ed06996e-4ff3-4e67-ace1-49001541cd54	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
eca99370-bae0-4423-9146-2ee5e876241e	3c1350c6-7f72-4592-a6c7-8bf2953f02ad	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c3acb02f-3059-4756-834e-00e0fb3b46e1	13fe3906-7dbc-4eca-a595-90b86ce38b10	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d029053d-452a-4479-a488-ad37daa89b65	0a5197f5-c578-4532-b9ca-d826eda45631	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f60dca36-05a5-4238-86f2-f194e0ad3ef7	5261e50f-6740-406d-b27d-cbe14528d0f5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e49f6b4c-4177-4c8e-9083-7ae5ee1b8d62	a6e5af8d-b3ce-40f7-a650-659c2b733e3f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
414bf586-d589-42ea-ad2a-22f0b85d37ca	5b01d0aa-c26f-478e-835a-0d3560a3fc70	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fabff830-2f55-444d-a356-0e570a564cb7	25407bcd-ae8d-46c3-a4d8-dced7f78d279	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c6bc6ac9-454f-4fb6-8676-7202b293a6df	80e338f3-e4dc-4b08-bef3-ccfd3cecd922	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
cf55c729-2c73-4cab-9934-53eb3acafd81	53dc91bc-b3ca-4daa-8068-3bae75b63cd3	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2f00e536-8d9b-4961-b487-37447e2679db	7daebce3-f985-446e-892b-ce680f7811bb	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f7b517bb-1b86-44e8-8e07-238d9fb77eb5	3909bc10-7b63-4f58-b952-b07cb94f25fa	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f703eaad-7e07-423f-abb2-8c05e1edf914	2a44bd0d-60df-412f-b41b-0ee989031acc	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e6882ed6-713f-43b4-a000-c4c3dd060b4e	15e1cfe3-8c2d-4095-a1c0-84a959935c65	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
28a22d0a-fe41-498a-a476-0910155ee218	2950382c-f095-469b-9d0a-03b3a4cac477	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
4e3d63df-45a8-4cc8-a375-9a1fa81fd973	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
468e527a-42fb-4be6-ac53-b31dc5afceeb	2fb528eb-fc7e-4684-9dac-ebdc7108c66e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6f6f3e4b-e1b5-453e-9d8e-e6810d90d998	51d5f2ba-7110-46bc-8d63-14d0fa652a5d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
83e99e18-7162-4562-ace2-c6b69eb43ddf	9d98647e-0c3f-43ac-a41f-889f2306c64a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fe5faa34-9635-42a9-a268-a6094be653d0	c6322e44-f4a9-4aec-a2f6-850336b9ad9b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
16910d4b-ac25-468b-ac02-8ba56669eef2	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d0f66cb2-b2da-4741-809f-411174669050	98b58011-16fc-4ec7-b25e-a0a6dddd9fa2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
08a25360-7fd6-4be9-827f-f1c1586e6f2e	a3101525-7901-4a34-a80c-0fe955903e17	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b75dc0e7-fa10-4f95-ad0e-fca91138df7d	2f7314ea-dcf9-4ced-bbd0-12e235827ef6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2f919122-d6e7-4a52-9c5c-76675b6d6cd3	b1ce0761-75e7-4bfc-970c-39c63c15beae	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6480ea6d-57c0-40df-83ea-7ca07045862c	640ff371-f8ed-4280-b39e-636337db7a47	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
748b0092-990e-4c68-adce-26e95e72b02f	c1240f25-cd0b-4059-8226-f5838f72a21d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
bb304c29-870e-43b9-bb2e-0fe902056fc0	c34b6e61-7e47-42af-8d0f-7258a892df93	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
40abbd3b-ab6e-45fc-9fa3-7a10a8814ad1	be2c7d26-cd3c-42b7-8462-426a2f77ca55	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
745fb7b9-c47d-48bb-b63b-61da0e7b5ba1	5cc8dabb-2e93-4493-9b7e-5b2da6a992b9	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
66267aee-59f6-449f-8ce2-b0c15c45fd27	538264a7-212c-4f12-b5b9-eb01130c695e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
50f67af8-22e0-422c-985e-27775f040b32	44265096-ccf3-4de5-993b-57ca76e5936d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7d5af0a7-fd0c-4dc9-89d5-964fa840b560	fe992cec-9283-4d0e-b054-aac3273b2ea5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
8575084a-6123-4d68-b100-e0f23260274f	04141f93-b2e1-41e2-9850-837cc8afe2b8	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
ce3819b6-57d9-44d1-9f8c-55df048f9d61	ae226d98-be72-441a-b8ef-e7c0de5eaa98	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
cd326ede-ee48-43c0-98a9-0eb574d38581	b2a1c05d-9609-469f-a37f-a90299d9b43e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3edb85cc-55ac-4763-accc-0cdb8afdaa46	d2c44e4b-1f6e-487f-8c87-56b1287ccfe5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fcbee727-f58c-4225-9dbb-baca2ef32443	012dc821-4451-48e8-b9f6-0c62b69b6b84	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
43d5db72-0bb5-4197-a892-4e041e024a8a	4d7bc637-9284-4927-b0cd-7e2193d71a75	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
949e1768-66d1-4cb4-9ccc-305f09b12d87	12ac870c-c81a-4a4f-8739-7fbe33c891b7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c18ad105-a167-4203-8d11-12c3aea83a70	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
5ffb8ea4-ed51-4df1-9946-65615db57b49	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a53d0946-f07d-4678-b257-2fc4ccc12f98	80f0e661-7d4d-4afd-b5a0-688b93830483	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
acf1786c-b9e3-4240-a536-5ef4a20c297a	7b66d829-14ac-4e8e-bc45-c4d7a3d6b5c8	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b8865949-b21c-4dca-a235-f09f9b413583	8de3c4eb-cc3f-4c1f-ba06-001992e8fbd7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9a14d4b8-d7a8-4d65-b3a8-cd928bab88ec	8171aa82-e03c-419a-bd78-f8149d941ec5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
0ca7c7b2-617e-45e1-83f1-df225ebae15d	8e7bc0f8-e12d-4f86-8cc1-c2172e20bfcb	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
32162210-f951-40f7-82eb-0cbedb810fc7	a729039a-942d-415a-80bd-9c882ed4ad40	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f5fbd233-58f4-46c2-9775-414ef0950c00	90057bf7-6dfd-4f3c-acf1-e9f13ea5f207	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
0301972c-52a5-47f4-8164-c8219ac5a463	1399c0fe-80f8-48af-88cc-ae8b8bff6911	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
63abdc7a-3664-4872-8266-3dd75cc1451d	8ed05502-d9d4-4f16-b115-990845279625	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3cd7fb41-1a88-468b-8920-5d97822f517b	74cdb61f-4460-4d79-9311-70c7fbb866da	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a104b5af-5856-4208-8a2b-323dc2c62e8f	6d581354-2a55-4133-bdb6-58087f38dbe6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
817fd8e2-70b0-45cd-8660-cb6a9991b941	87362c41-8e3b-4de9-9b7b-c1c80ab5551d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1e4fbb04-a0aa-4b95-b15f-99c018f31ed0	bdae4eec-4bf0-4c0d-8e4a-bbf8e8ec525c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
52aee836-2264-453e-a3ee-3ddef885cb87	7a141736-4709-4f4d-9525-2fc61668753d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f17a78e4-9f5b-4216-97c2-6a9861b9e7c7	6c8989e0-27f3-4dea-9c9a-ea3d720bef74	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fd1cbc3c-1d4d-42a9-ab8e-b633cd80b148	e6ed116f-20ee-4e33-9e02-b94609a4b1d4	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9c5337b6-6654-4385-8655-c28578b29740	109a6ec0-be3d-4328-b64b-b9b00f24b358	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
939daedc-5900-4089-8d40-820112fe78f8	eb3aa25c-3533-4267-b913-8fc8361590c3	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
faac294b-dde7-4f2a-b397-5ed5a75d258d	b01467c1-c5ff-419c-a878-5a6f6692c4a1	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b01b53e5-3a9a-405a-b98a-43980569f8a3	918eab5e-48c2-4b12-b710-a5ed470bbbdf	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
87aabd48-6269-4c78-8a59-0f2c37e92d27	77004703-79c5-431a-b7b9-c61e9a5610e5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
ac8ad7b4-cc10-468c-8aa3-7d6cdeadf20f	8880a9b3-e726-44ba-b8fb-8d81c9ca4bb1	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
56593b4a-2579-455b-985b-ced5018b8ea5	493085c2-5cfd-4739-bac2-00d9532d4886	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
56e4ee71-4283-4702-b965-88a980db9cae	a7f4d186-7dbc-43ff-a6eb-071cb73bcd24	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fa0931ed-ab5d-420f-889c-9cacc8bff9f6	4a23b148-7768-4e61-8679-df0cd894ba5c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
22c87d3b-d928-4fb7-9836-97b4bc5ef40f	cedcd048-a84e-4c58-83dc-3e52a8dfac0b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
4667867e-5fb5-4fdc-a02d-5b192c5ff62c	af71200b-6946-49bc-a2aa-6ad36368b8cf	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
19bf2490-bc12-4389-b3bd-1f02aeba6dfd	e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
713e79c8-eb5f-4f37-858e-b29a0d891b68	822c81af-c1b5-4493-b0a8-55ff0fdbbfee	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
34426f4b-e7b3-4041-8062-fee13f57b46d	b40da33a-f72b-468b-9886-5aa16aea65d7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3eb6468d-40ac-4d73-aac3-67aa1f196267	19300d02-feb6-42b9-8cf9-0cd847a24821	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
8c13c75a-93e7-4c2d-82a9-7927472280d1	fd93a113-b0fe-4a7a-bd1b-262a688517c6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3922b44d-a4b2-4943-ba3f-f30b191da5ff	c18ae991-a8fb-42f9-8cd0-7047fe39d597	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
04185f8b-bc8b-4892-81c4-d80d9e239452	1812ef72-6275-4dd6-92d2-a91ed2871065	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
047ddfae-03d2-4dd6-b8ab-743b1d742185	d6167946-0ac9-431d-b151-1ef742b78f5d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
67bdb6db-c57b-4474-9730-fa6029fa75c2	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
43746758-e518-44d2-b7f4-aac600ffd808	f29618c2-ef58-4c56-a6d2-c11779262f12	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
8fee0c1c-eee2-48d7-a802-11aaec91eb2a	20901b9b-696f-41da-9b0a-56c2b8c2874d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
06a372b2-9661-4646-a8b5-b67b06f29d2c	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e585268b-4050-4752-a407-e620795070ed	a34840e0-3c85-4209-94b7-445658014577	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7eb71141-9168-4105-8720-b4ef3198ceed	718f59a6-8d16-4e31-84f0-61883efc83fe	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1489560a-a939-4057-98ba-b511e45c8b63	60a1caed-204b-423a-818a-476d229e4c56	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e143a826-ab77-45a5-8215-2bf3ac818e6b	86adf090-8560-4038-839a-caabbb105de3	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d74b6e8c-1609-480d-8b7d-675f2ef4e9ee	50b93517-656c-431d-b111-9fc40557712f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a4b80fe5-3928-4379-be18-76c1158161f0	18008409-4129-4af9-a114-f0ae6269ec2b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
92d7cdeb-3818-4495-8fe0-6bf8d222c74b	2cba013b-a76f-4d2a-bd8a-87605899cdd0	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
97ea532f-040f-4544-b764-0b0b4a9e0345	5eecf188-ac02-4b8e-87da-3ec22550adbc	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c82fcca5-4acc-4790-81bf-8f9ebed7c757	acdb7ded-63b9-4e74-a95c-96d584e05e85	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
66d832f1-4d25-4e65-8640-d431062bc1c9	51465645-99e4-411b-84bb-c35db8063c51	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3b8e7d69-ba1a-455c-b7d9-dbd46c9342c7	431f2005-da1f-4309-9b88-bc84e36a271f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
438ed4f7-96f3-467d-bcd0-3f79d8e65a40	6e27e554-7a48-45d4-878c-063a723e33c2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
bf9a666f-bfa4-451a-946d-be877a4bd2c1	eb01735c-541b-4bc9-b357-080cdea8f749	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
3e102372-a7b0-4a11-ab80-c8b0dc35ac20	66e31a78-d9ee-4475-8324-824f1d7a5e01	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
ba803d8b-7443-4a48-a840-232ffec8e3ad	afed05b8-7348-4604-949d-9e25de692f4e	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
3faef9f3-3b65-4111-8f21-9ef6655780ca	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
a1bafb9c-c92d-4dd5-af5b-2a78dbbb853c	78288a3c-91c0-4414-af3b-6fb308bdb9fe	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
45939544-abac-4f3a-818c-d074fc1a0c77	58b959a9-0137-4f52-b2a3-1388ccd167c2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c1bacbb1-d7a7-47a9-98fb-853a0986666d	6073dca8-6f3b-4a4c-bd89-51c4599d76a1	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
0ffbfa97-76e9-4e6e-ab7d-3a195678936d	6bdc05dd-b9aa-421b-810e-10ae2c309d74	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
cd4515f5-c2dc-4261-a18e-28f7097ea99f	37dcd61b-db39-4503-a4ee-d1bc37d4052a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
464875e3-4c80-4b08-94ea-ff6ab817c1bc	03a0a906-acb5-4276-af0e-56ffff01be45	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
ba36251d-c059-4031-bd47-2277ec68ada2	209afc83-5f38-41e7-afca-a46ff03f9f69	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1567cf5a-4dbf-47f8-900d-2164d044b84f	7d4d69a7-e764-479b-af12-259c90e4a56c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
946de515-d58c-4ae9-8784-fcadd8576349	58e8eed6-92e8-4555-bda2-4ef60f159516	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
5284c579-3e96-4d72-b397-923acc4887cc	c8aa5616-b8b6-488c-baea-d0ff1b42ad60	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7eb9eeb5-1ba6-4eb6-a417-f1e071d32f3e	f30fbc03-1379-4a3f-9cb0-4e53194f41d5	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
9d3f7fca-5b25-425c-9c92-680b3b488b66	136f2845-8bf7-4324-bd2e-2e7f84025cd3	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
f9f3bd6e-d2ab-48bf-8a0b-daf795d96c0f	56d2d5ce-e67a-4a46-97cb-8ef4fde0e960	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
b8360eee-7c47-45da-81cd-890be18be2af	db3a7a94-caa7-4a9f-899a-f25c24199e2a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a406cad9-7881-44c2-afee-fa8a8d296740	f8799383-8829-494d-b9ea-6d6acb56178e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
4caa5c0b-620d-4cbc-a8cd-a56f1e875384	a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1692e54e-ab94-4132-b6fd-5fb08cea0b97	d29938f5-3fb9-40c9-a64f-12dcaa311692	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
81489e15-0d4b-44d7-958a-61564a196baf	aeaafa1a-e889-432d-88f9-096455b63aeb	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
20a6bf7a-d30f-403f-81ce-dfe12de75c52	66a68c02-2321-453b-bd50-79ff47082a9c	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
4fe018ee-1f77-411e-a279-823de838f3f0	a3d597ea-4118-46ad-bd41-49950351a7f5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
65e76965-6f76-4e78-9207-1b687f5eaef6	78747028-16fc-42c1-ba68-ad630d5a5bda	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
a1596901-403f-45c5-a073-c72d941a36fd	1a75ba2a-e021-4c3e-b068-c55029a8a923	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
dd4b5844-4c6d-46a2-9057-3b96f2f90477	2472142d-690e-4406-b8af-eea74d1afa6f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7fa1ab5f-7d2f-49dc-a14d-030413276c10	b36c6d5b-3cfd-4b76-8af1-93d565960d54	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
631dc5df-0eda-4634-a834-82e25ef164f7	efae8184-423d-41e4-9557-7aa10924710b	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
05493843-952c-4583-88a3-aaf2b1711ad0	899cfad6-04d0-442d-bfd0-cb91e18ae0d0	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
b3431c51-7d83-4bef-b83f-dd7beae46152	6ffa6051-8a12-4c47-9b02-0eac4e5a3cb0	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
efbd24cf-fa36-4123-9ac2-b63b9a553778	30d9c8ad-0e04-428f-8fd2-576ca87228c8	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
c7d16e54-03e3-481c-b05a-d99bcd3644e9	c3bc5eaa-f1f4-4426-937c-d9b713c9fd16	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
de03e546-1472-4b4e-a331-bebb759f3e83	e9e3fb40-6e36-48d9-918a-25cb5975cf0b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
207dde5c-3ea4-4a36-9f21-83202cd52f8b	05d4763c-6190-4df5-b97f-e60500a9df99	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fe0d06b4-1052-4535-aa7f-2c6fbbcae860	0a540629-6aec-455d-9339-5f467913ff9d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
574bb2cf-1ea9-4432-842b-aa6bd99f4cc6	c5e25267-6809-4882-b749-9662946912c2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
56dfa2b0-042c-4cc1-9605-a3df81aef447	a8dd7f18-3436-471c-a958-69575f764986	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
73a83bb5-8b92-447c-93da-ca2c29dff240	d96d57cb-c038-4b44-b083-b324eeef60a9	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a093524d-4429-4dc3-b024-579221426c3f	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a473369f-2a88-4e6a-a2a5-05790ba928d2	c5942cef-4b45-44ae-bd78-d60f38a052b5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9017ff85-ac6d-40cb-83a5-64c85395e09d	5ef7275a-ff14-4948-aebb-fa5d6b6a0e9b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e00e738d-8950-40af-8881-03a2d7929d68	b462869e-5bc0-4ff4-ada6-6944092d9e59	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b8895342-f70c-4c20-a5cc-6b57127416a8	0909af86-2dc6-41b3-8787-53eb87b387bb	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
dd8974cd-eacf-44c3-b100-cddfc5027957	0bf4c131-d69b-4b4b-af65-b795960d06f7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e3a89f40-4ad5-45ee-9c84-75cf9aa4f1c5	449d6043-e4a5-4cb7-882d-6523c4fa5319	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
81b85be6-8b3d-493d-b307-6b9c298bd007	2a9688a8-1ddf-4b40-9b13-4eebdd046e59	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
5cb6fb13-da2c-4ec1-bb97-69cfb6dbb8f9	fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1b7a68a1-4976-40cf-841a-d8af078a159b	f0c334b2-8671-46e9-aafe-e3148ee23adf	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6c4213df-c694-4429-bb60-88b3184e534e	ba69463e-a9d1-4935-9596-b00294a5234a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
820db1b5-3f5e-409b-aa78-6f8e02603f23	3950674f-2bc5-4911-bf0a-53ae0ba48d8c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
4b7b70ac-51ac-4fe5-8b1b-a21de722c44c	d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
1368829e-14a7-409f-a745-98d544057316	7d370edc-909f-498d-ae21-6bc2ccfb00b1	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fc70d815-8876-41df-b7da-4e9d9c76a282	d923e4ba-e0d1-4fa1-9837-2755a8b33f04	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
746a1596-0c67-4d20-ba8a-511a52276ecf	23a054f8-f81e-414c-bb6a-eb295bc619a6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
5bdd84bc-81fb-4062-b7e0-2596e9f4404d	56bb5d62-6d41-462b-9f29-6f224d84763d	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b6d2fc3a-f61a-46b2-8619-eea6980409ef	d72e298a-d2f6-45c3-8b09-7e0294eabf5e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
29209895-390d-4d33-81a7-3eec27419f78	d266b55c-cef1-451f-a3ce-4b71e887543e	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
077ad960-e1bd-4fba-a053-971021c4ca77	8f9f112d-f597-4978-90fc-5906ccff773b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
02e7800d-3f62-409b-ab47-32b9b58b840c	bb3c65c7-9823-4df6-8c9e-051332a6cedb	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2a56b508-2a4f-4438-b6a3-7b2a8a21ac60	394ff94e-831c-49cb-a04b-896128421240	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
46a02606-22e4-41f7-8c1b-4fe987b9d22f	352bfcd2-9a94-4791-b9c1-1b7d43bc8db2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
005970fe-b64f-460a-b0d5-500f9791a81a	ce1e5343-b310-4e6f-94ef-5824a2c167a7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
15518558-1c63-4d54-b1c3-25fa8ca5c4bc	f9862fe3-43b4-4742-892e-713694464801	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2653b2ad-2564-42b8-8496-9e4194ef429a	ff53a665-8e8b-4311-971a-fe2b51985a00	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2e61b37e-c578-4097-b6c9-e00295724685	746d71ca-9353-48de-8ae8-dbfc0654538a	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
6456ec96-7003-42a8-ab3d-8c528cda726c	81d595eb-74a1-4698-b416-46c09ac155d9	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f72b4f9f-7dae-413e-9979-28e01682b4f5	ffc65822-d148-468b-ba2c-18d9b231b8e5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
67f15d9b-d7b9-4bb4-84b0-5e4c10d108fd	901eb416-3a46-4d7c-aa0c-93decf104d01	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f2eb8aa7-5856-4dad-9ddf-1db8c63a6e3f	e1b258fb-7611-4b39-a601-09d38c5d6dff	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2ce62e12-643a-4403-8938-fb481d399168	5920a748-45c1-4867-b792-8a6c7845a6fb	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6fbc4a54-16f5-4a54-a5b5-aec946b6a8ff	4d95ba58-5fcf-451c-9d78-6d8a02719d51	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
1e9f94fd-f6af-478f-ac16-e95d58809575	67e93fc8-55a3-412c-9740-0bb6d9141177	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
72b53818-6013-414d-930d-16dad22106b0	59df3d5e-434c-44cb-9361-a252d1e8dc78	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
ab32c950-6670-4df7-b651-dda46c8338a0	57d33458-6158-4457-a863-416a59f2bcd3	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f330d99f-02f5-4915-bf31-0f3d2f815315	7cbda437-88bb-47c1-b598-cb6eb72ea01a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6c16c609-c907-47fc-b948-bef4a716b6cd	4055d5a9-7d7f-451b-beb9-4dea063dfb23	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
8bbb13f9-28ca-4a6a-ac69-bfe8bfc4a2b9	01fa437e-dded-42ac-a1ab-795135b5c433	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
3aa1f0d9-54bd-4b32-97bd-4b1a28f7bbc1	cb476e55-39c3-4257-944f-3b1c93f8bc1a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2d3b140f-ba06-4a01-a9ce-d19384a9b29e	294b5801-e218-4601-81e8-cc59f67d38ea	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
2dc2a958-1422-48ff-86b7-0638bc31f68f	5e0d6233-37b7-429b-b437-7c9e80a88217	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9402b5ba-2837-414c-94a2-cecbd64c6aea	1d9ca24c-6c45-431b-9358-912bb0d7000b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d74f9108-7f8e-4cf9-a99c-edf569c93b25	d2b50556-4bc9-47d6-8a96-387edca98cde	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
9a68e02c-daf5-4f0b-b20b-9f98cb588af6	59982833-d4f4-433d-8718-0facedf7460c	2db608fc-a6c3-4fda-a846-7ea2987c03e0	\N	\N	t	\N
397a575e-1d7d-4780-8306-0ab069ee4618	05b24779-78c6-498a-a515-cfd2c1110ff4	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a9e017b2-c477-4569-b136-7f876ce8328f	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
46826693-0d07-4284-ab24-2df97c73acae	77069309-1d94-457d-ae04-8f41f99b61ba	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a5cf7a07-e500-4ce2-a36d-27ecff4077b1	2ffbb550-8ef7-4ee0-abbb-2bc8cc9b8626	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
416745d6-737a-41a0-acc0-f62808374b89	ce85846a-bdae-482d-9f88-5f846ff811fa	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6ff885d6-3315-4c3e-a70a-b8a87c31d0e9	794403fc-d937-456e-905d-ba1014f8ebdf	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
572e6d46-fdc8-443a-84ea-aed1b7e39025	cc3e9660-9e46-4ae1-8ac6-060ab08ad10b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7e89ec99-561f-4035-83d6-4d79c54d7ef2	0d2da959-8d4e-4bdb-9e13-9a5558102ef5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
036fe3cf-10b7-42e4-acb1-1f33483a4d84	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
cfceb256-155d-4471-b9f2-521996170256	6289c163-0a16-4bea-aac3-48248f825fd7	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
79f36353-444e-4b47-a862-c240c01fe44a	bdb16884-7662-42a2-b2ef-07ae7ff01a1a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e22c140c-d8f0-46ec-9ec8-abbc865a96d2	3b9e651e-7b05-4ef5-971c-23f80efa20ec	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d15aae4e-f8a1-4d6b-b3e9-987901210640	183a902d-4b06-4904-8d47-3379609ab004	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
58e4e36f-89b9-415d-822e-9afd88155808	400be1dd-a2a9-42f5-90d0-d84fe069f387	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
47771417-7f85-4d93-b80e-3ac8f9ea9c3f	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
a081cb06-d787-459a-8c88-a383776065aa	6a4abfcc-aef9-48c9-9ec2-c246cf7d11f2	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
318af084-29d5-4d57-bcc8-47267e3b568f	40888ff9-372f-473a-9aef-29d1ba5af6d8	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
94cbfc0b-ad5c-40aa-bb54-31b93a4fb6cf	a40d7c70-e895-4a15-b8be-62e233876780	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
97f08ac2-996a-42e1-a572-819f6012014f	1264f97e-0a23-4690-8272-23123de6547a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
092e951f-c92a-4ae4-8246-c9ef24ffd51a	cfc44cf7-59b1-4830-a8e4-9689467b0c4c	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
51c79bb1-5fce-4a7a-9763-3b5cfbb6e92c	168dd1ca-e812-4069-bf8d-25b4843e7973	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
288415df-3a99-43ff-a244-570e54604326	08a2e539-1261-4c96-8955-f115d42bf27f	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
4fb06303-1d3c-4239-ac05-f720b2ada7b0	69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
74d9d306-e0ec-440a-8c2c-cd2488d456cf	3de2647b-2c7e-4be4-a1ad-da663c52b49c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b31ee65b-c56d-47c4-ab3d-92c593a6d0aa	fe3a36d9-b571-4767-87a6-d16e5b653b13	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
944d4435-e0a5-4ba9-ba35-71b65658ff54	cc54cc90-5051-4d2e-8116-185ffd1d55f9	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
ccba4f24-2128-4f79-bbfb-d3324520af1e	74b2dfe4-603a-48cb-a0f4-2326194f571c	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
80513170-c5b8-4d9b-8f0f-a5229e904bb4	bd49d3d2-b6d9-435d-8e51-70b36eb92d79	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
b1e58214-724c-4616-9065-f67185b74402	7f14b79a-599d-4733-aa62-44518f5c617a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f9984537-1e0a-4537-89b8-a58144d77323	e484f6a3-69db-421b-983a-004a7555a023	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
bb6d684b-56d1-4056-8aed-264b9b7d54fd	277f9203-92c7-4a39-809d-e81eee5e5637	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
5dd92100-7554-4042-90c5-9520f97f9925	73054296-9cb6-4dc1-bb30-147fc0f14f47	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
6543ceb1-f52c-4856-9e2d-8a8464b4d077	8317df96-4c13-4514-87df-b8c65d9e08dc	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
fbb06df1-c2fa-4bff-b93d-44b02dcecfe0	b1ec569f-83ee-4a17-9d07-53d70bbee703	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
8bdc08c4-fbe3-4ce0-9a43-0834a77f2eff	fb8dd599-e3bc-43cb-996d-4e11c82aadd6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
421ff290-8f11-486f-9765-1ef177f5b5c7	6953adb3-42f6-4216-b602-14f8417c754a	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
f8192426-8dca-47fe-8e84-ecd366629c86	103659ba-e1f4-405d-b289-2fabf44ad1b8	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7f6101f6-68c5-4497-9cd7-11fa436fd551	0014cdbc-a111-4968-a413-828882e32e66	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
7085dc90-9b66-45ed-9e66-7557cf0f54f2	7c4c65ad-dec4-4abe-93bf-6c7011711ea5	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
786d2440-fca3-42e3-9551-f4d9ea91a6c5	aa54bc98-4f39-4229-9084-5e1c992c4b96	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
04cd81d2-894b-4eff-894f-0ee17cebeb9a	a116e420-674e-4867-b4b7-0bfdd644559b	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
64bb6842-ae54-44d8-8dcc-12729c048f7e	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
d000c71a-0fea-44d0-b4fa-1d803c4fbe62	50480996-392e-4fbd-bcd3-b2d67cbb25ae	49147e32-d354-4366-82a7-48a1b3f109fd	\N	\N	t	\N
e9316701-e81b-486f-9ca8-92ffdc2458b7	d242154c-41ac-4bea-b101-f4fe9eac41a2	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
b8e969b2-7a9b-4ed8-ae1e-5ceda90ab523	d137bd3f-41e4-43a8-820a-7addc94df4ea	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
63a01dae-c8a0-43e4-9d67-c71d3dc4f254	b824bf6a-408f-4ced-b623-4e8ac159c446	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
57feace5-c7ec-42ed-b201-8076a31ea66d	171a88d2-da6c-4fe1-960d-82b4f11998b2	4341951f-6d16-4abd-84cc-204fd4721a00	\N	\N	t	\N
\.


--
-- Data for Name: kol_categories; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kol_categories (id, kol_id, category_id, is_primary) FROM stdin;
86b13a87-5876-49d7-b9bd-90a7886076ed	a08f7952-90d4-4354-b8b9-5c0a5e255d9e	7b6efad2-588b-456e-99c5-280469d7f0ac	f
1b136960-7995-4ad9-8405-812a50da65be	92444995-2431-4c5f-a13c-7c2cc5ee7d30	7b6efad2-588b-456e-99c5-280469d7f0ac	f
4064cee8-7e16-4462-bcf4-702e26d8c1cb	74e78d28-5150-484b-9db2-9446b75381d5	7b6efad2-588b-456e-99c5-280469d7f0ac	f
d5cd00c1-e2a9-4830-9e62-2daac3c983a4	74e78d28-5150-484b-9db2-9446b75381d5	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
90e00390-b797-40d4-85ab-7ea7905e6ce0	90cf70d3-9e96-408e-a2ba-36d6a28cef4a	7b6efad2-588b-456e-99c5-280469d7f0ac	f
8a8d5887-1d14-46cd-aa3e-eeb00054aaa4	edf54653-87a6-4af9-918b-71e27114f074	7b6efad2-588b-456e-99c5-280469d7f0ac	f
5fe8478c-ea69-437a-9c3b-1e709d4135b9	a40312dd-0331-4a25-bed6-2b05e9152fbf	3be7640b-781f-45e7-9010-6f12a56d579a	f
df5de05e-9f86-44c4-b518-94fd28399f95	52494623-468b-4439-9818-d36645830dd0	7b6efad2-588b-456e-99c5-280469d7f0ac	f
0eebe55a-00ac-4667-a65c-3f51fdd69fb7	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	3be7640b-781f-45e7-9010-6f12a56d579a	f
82aa6d52-5012-4daf-88ab-ed67eeb9c5c2	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
0c5dd490-0e34-44fe-ae2f-73e8063c55f2	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	a9b46f8c-e978-446f-8db4-e019843d17a0	f
dc10ed4d-64c8-45c7-9896-fe72d9bf0a07	f735e4c0-39c3-4c66-92ad-908f7461a84f	0652bfda-1c8f-4057-89d1-695edac3c389	f
cf77a70c-ef47-4ae8-ac70-7014a37f4736	f735e4c0-39c3-4c66-92ad-908f7461a84f	a9b46f8c-e978-446f-8db4-e019843d17a0	f
d494562b-1ac1-4271-8c9f-ab87ad1e655d	f735e4c0-39c3-4c66-92ad-908f7461a84f	3be7640b-781f-45e7-9010-6f12a56d579a	f
3f3700ec-425d-4547-8c4e-26456115e0b7	10a0228d-8083-41d2-a11f-7fe4a61bbc16	7b6efad2-588b-456e-99c5-280469d7f0ac	f
434ff9e8-7592-4c4e-9b00-4694fc49e436	eb46fe18-5c1f-4b32-9071-63daa3da0e28	3be7640b-781f-45e7-9010-6f12a56d579a	f
fec51ab5-106d-454a-9b9f-3c8a165ceb0d	849504e9-4b12-4f8c-946e-21eca7000980	7b6efad2-588b-456e-99c5-280469d7f0ac	f
a75a1f67-f051-42a8-b419-6c20c596751d	654a9fd7-e1fa-4ade-938c-dc90713e4f35	7b6efad2-588b-456e-99c5-280469d7f0ac	f
b9505221-bea4-4fa0-a9ea-bf09ca20c861	f3a3819e-212b-4aeb-a8fe-779243323abe	3be7640b-781f-45e7-9010-6f12a56d579a	f
f45009f8-3d5a-4271-9cd1-f26d5a2b2895	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	3be7640b-781f-45e7-9010-6f12a56d579a	f
85091409-abb3-42b9-9e97-4e1b991a0038	40331030-31cb-4391-913b-acd387389679	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
8a1d24aa-cbbf-45be-8f63-056c7bb875ce	40331030-31cb-4391-913b-acd387389679	29e2746c-20eb-4067-897b-f5d26da835f1	f
6c1e0464-6fb4-49b0-9ff3-8f7974b80b6f	40331030-31cb-4391-913b-acd387389679	a9b46f8c-e978-446f-8db4-e019843d17a0	f
9f43acf8-a4ef-4412-841d-3c3609cf205d	c432674b-3697-4c92-9698-61ef46eedbe7	3be7640b-781f-45e7-9010-6f12a56d579a	f
5f0c7803-b9b8-45e6-9785-fdb48b059390	a8e73e8b-e412-4d9b-971d-1bfb59309abb	7b6efad2-588b-456e-99c5-280469d7f0ac	f
c7c789b6-6f16-476f-931b-c6bd078038c2	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
730fbaa2-9b27-43a2-867d-58f5ed176f2a	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
5b99060b-3006-4025-be7a-77b1d15d3779	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	29e2746c-20eb-4067-897b-f5d26da835f1	f
bd3074e8-e10d-4018-8441-6db31ce0a852	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	3be7640b-781f-45e7-9010-6f12a56d579a	f
ba87d958-80ee-4c7a-86cb-1731d153d9b6	be5f976b-114d-4308-8242-52d14f4e9aa6	3be7640b-781f-45e7-9010-6f12a56d579a	f
6e2b312f-7b69-48b0-9511-4c68ab3f8e14	be5f976b-114d-4308-8242-52d14f4e9aa6	7b6efad2-588b-456e-99c5-280469d7f0ac	f
713c07f7-94b9-4cd0-bf4f-6dba041513a7	be5f976b-114d-4308-8242-52d14f4e9aa6	0652bfda-1c8f-4057-89d1-695edac3c389	f
8ceced72-ddeb-4791-a5fe-505dc0a8ece8	ac955c91-0b4f-4e7b-97e3-6d29389cf196	3be7640b-781f-45e7-9010-6f12a56d579a	f
ec0768be-56a6-48aa-91d3-7c0711e9435f	8bb3e252-e66b-4477-a145-8b03c028805d	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
7e986839-7615-4cc0-8c04-0dc13e9e69e6	8bb3e252-e66b-4477-a145-8b03c028805d	29e2746c-20eb-4067-897b-f5d26da835f1	f
cd0cb142-7d74-48a6-89f3-2c5a8864946c	8bb3e252-e66b-4477-a145-8b03c028805d	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
31a884e1-b45a-4488-a40e-dbdbb33694e7	8bb3e252-e66b-4477-a145-8b03c028805d	0652bfda-1c8f-4057-89d1-695edac3c389	f
4682852f-447e-4b99-a5ab-59fcbebbe984	54848923-af3c-4528-a36f-b86babd69225	3be7640b-781f-45e7-9010-6f12a56d579a	f
0a0e8857-dd0a-49be-adf9-167901fcc6da	15520237-b54c-4912-abf0-f29c1499181d	7b6efad2-588b-456e-99c5-280469d7f0ac	f
3015e3bb-4673-41e8-863d-d6fa37241bb5	47abda88-d904-4402-8257-1e88c0ff6ef5	3be7640b-781f-45e7-9010-6f12a56d579a	f
026ce8ad-3dcc-4042-9ea3-5db8c153fff9	1fec272f-7562-488b-9ec9-eff4656dcabe	7b6efad2-588b-456e-99c5-280469d7f0ac	f
52396bd2-92be-41ab-aa71-2c67d6a546c4	003b2d41-7de0-4eec-8fe2-17374ae91d58	3be7640b-781f-45e7-9010-6f12a56d579a	f
78edff0b-08ad-476f-9280-3811e37a04ad	281f97e5-14e2-4a93-80af-80e0ed98bcff	3be7640b-781f-45e7-9010-6f12a56d579a	f
cf408239-94e2-4a42-be07-518bcb34c3bc	e6ef5e56-45a6-4c7c-a540-afc90b193143	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
6bb5b6a0-0da2-43a8-9198-0ee7c37af15b	e6ef5e56-45a6-4c7c-a540-afc90b193143	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
37d842e2-6a04-4b65-848e-b84887c64740	e6ef5e56-45a6-4c7c-a540-afc90b193143	29e2746c-20eb-4067-897b-f5d26da835f1	f
77ee09be-524c-4f72-933c-47367da81648	0a2f4d54-807c-4e33-866b-cfc22845d6e6	7b6efad2-588b-456e-99c5-280469d7f0ac	f
b783672c-3430-4e37-8968-a3970d925090	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	7b6efad2-588b-456e-99c5-280469d7f0ac	f
7e971cb8-bc60-4650-b1af-8e86c43654fd	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
d521108e-fa60-4913-a2a3-0f672c986bd7	888cbfe3-9c4b-4456-9d33-f72e0d002456	7b6efad2-588b-456e-99c5-280469d7f0ac	f
d787d56d-b090-406b-be75-278e05154b2e	888cbfe3-9c4b-4456-9d33-f72e0d002456	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
933279b5-828d-4ba0-98ab-874822acccc3	88615501-f3e3-434c-bbff-9d5178d9274c	3be7640b-781f-45e7-9010-6f12a56d579a	f
881a0237-1c53-4c13-8312-238899997090	43794457-3218-4378-8092-8391571c3ff3	7b6efad2-588b-456e-99c5-280469d7f0ac	f
94151014-de25-483a-9d48-01e9ab890def	43794457-3218-4378-8092-8391571c3ff3	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
95915ca2-7036-439d-8869-80315fb3ff82	1ce65635-3d69-4b87-897d-1b42d241b66e	3be7640b-781f-45e7-9010-6f12a56d579a	f
64e4e48d-19e5-480d-9f91-054c171a84cc	38a50ecf-a0c9-4789-afff-10c9c04312fc	7b6efad2-588b-456e-99c5-280469d7f0ac	f
d9bf61f7-2ae0-41bb-818a-537e9a4024b6	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	29e2746c-20eb-4067-897b-f5d26da835f1	f
1232d237-7300-408e-9093-51d263dc094a	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	7b6efad2-588b-456e-99c5-280469d7f0ac	f
17b0455e-bc47-4976-91b9-0c7f4e6dc67f	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
031b2ac5-d2e7-4a5a-bbf9-15a72bc4f5ab	ad10b365-44b2-4b4c-bd9b-6b15a885598c	3be7640b-781f-45e7-9010-6f12a56d579a	f
4953dfd8-3f01-4115-b2c6-cd365a03cfbe	f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	7b6efad2-588b-456e-99c5-280469d7f0ac	f
5ed4fdc1-5637-4a2b-859b-2df532e3a170	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
c881f11a-5042-41ef-aea2-2168e4d1b41f	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	29e2746c-20eb-4067-897b-f5d26da835f1	f
f58c3158-281b-4e6a-a11f-f5726c482a0f	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
d96c6c41-8f64-4aa2-ac59-35b54be26a08	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	3be7640b-781f-45e7-9010-6f12a56d579a	f
3c7e52fe-5742-42c7-a980-f5c170ee8ea5	66f3145c-53d4-4244-91b4-0b84fdc87097	3be7640b-781f-45e7-9010-6f12a56d579a	f
d52a8a34-ed6e-4331-9d2e-8290ec2cdb09	20bdeac7-b480-41bb-8f7a-1099626e3249	3be7640b-781f-45e7-9010-6f12a56d579a	f
cb783aa1-19ee-4fb6-85aa-2372e39a65cb	2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	3be7640b-781f-45e7-9010-6f12a56d579a	f
e2683234-c01d-4e07-8cf1-b47c2ca2184d	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	a9b46f8c-e978-446f-8db4-e019843d17a0	f
9e44a9b8-1f50-4f5f-95c8-24fbf3293f6e	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
3ea4f008-4251-4ae6-abb9-9f4d254fcaf0	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	0652bfda-1c8f-4057-89d1-695edac3c389	f
ddef45f2-32ed-44a1-a700-ff7029901b91	6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	7b6efad2-588b-456e-99c5-280469d7f0ac	f
0f7200d3-500f-4720-b294-921b9d05dbac	4f7141d7-ac31-4e32-8776-b4660f5c296b	3be7640b-781f-45e7-9010-6f12a56d579a	f
03bb6b15-f40c-4c3c-ae08-cc43470479ac	6d6ef876-21ca-47a0-9200-095074791c96	7b6efad2-588b-456e-99c5-280469d7f0ac	f
47b6f160-cfbb-424c-84e4-ae1a9f1b30ab	b868509d-79d9-492e-b250-33a34d8cb0e8	7b6efad2-588b-456e-99c5-280469d7f0ac	f
de4321a5-ab1e-42c1-b389-748029c4c354	b868509d-79d9-492e-b250-33a34d8cb0e8	29e2746c-20eb-4067-897b-f5d26da835f1	f
23a8d612-88d7-4d6f-a3a0-74378be7b500	b868509d-79d9-492e-b250-33a34d8cb0e8	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
c9da20ee-e68e-497e-9ff6-15f80a412e1a	b868509d-79d9-492e-b250-33a34d8cb0e8	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
5f9ed943-e6f8-4d09-9e5b-94f64abb8287	92610a49-08e0-4bc3-b61c-9bbf8adee414	7b6efad2-588b-456e-99c5-280469d7f0ac	f
d647b91c-d1eb-4601-9264-f8a13ff3a066	92610a49-08e0-4bc3-b61c-9bbf8adee414	3be7640b-781f-45e7-9010-6f12a56d579a	f
7fff3264-a2b7-489c-af89-a70348a11ec0	92610a49-08e0-4bc3-b61c-9bbf8adee414	29e2746c-20eb-4067-897b-f5d26da835f1	f
7c08d889-9473-4a6e-aa35-b331432fd7c2	7392cd69-e132-40c8-af99-dec18965f901	7b6efad2-588b-456e-99c5-280469d7f0ac	f
39993546-e45a-43a8-aa7f-3d12940f1710	c3fd460c-b148-4f5e-94ed-f906607510d5	7b6efad2-588b-456e-99c5-280469d7f0ac	f
abe6e666-451e-4084-b1bd-85de15676f97	c3fd460c-b148-4f5e-94ed-f906607510d5	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
aa8ef400-6938-4a00-8067-05e71c227bb8	c3fd460c-b148-4f5e-94ed-f906607510d5	29e2746c-20eb-4067-897b-f5d26da835f1	f
71c38dac-843d-4d31-82b1-351b01b8cabc	2c7daabd-9713-4d6c-b44b-5295b1146e4b	7b6efad2-588b-456e-99c5-280469d7f0ac	f
b181fae3-e4b0-4592-ab62-04d83b9931e9	d25cce7d-1b03-44ff-af78-c907300e06af	3be7640b-781f-45e7-9010-6f12a56d579a	f
d4d1d82b-9da6-4df1-8a3c-003b1e4a5868	9c5e0827-8042-4a8c-b133-6f02fe0d1661	7b6efad2-588b-456e-99c5-280469d7f0ac	f
8615b772-7e45-4ec7-bb48-8cda1f3b65a0	b4887d0c-2c72-4b6f-885f-530af72ea7aa	3be7640b-781f-45e7-9010-6f12a56d579a	f
6a807b3b-ea75-4f98-8eee-c565343ebb4c	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	3be7640b-781f-45e7-9010-6f12a56d579a	f
01cc2975-eb3d-4e19-8e64-b2b3e7c5a013	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
cb675814-a4ea-4ce5-9906-ebdde38e32df	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
676e003e-0606-4237-98e8-f0221da8f3b3	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
af6e0d64-18ea-47ba-868c-788ecaac5341	f129f037-4617-4f13-91b6-2f0846f15594	3be7640b-781f-45e7-9010-6f12a56d579a	f
8ca08ea3-5c69-49fb-b70e-c8767341ad13	f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	7b6efad2-588b-456e-99c5-280469d7f0ac	f
f47d2855-c9bb-4640-9868-21a6071e2aab	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	a9b46f8c-e978-446f-8db4-e019843d17a0	f
90100371-a391-4af1-8a48-3709922946b4	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
29e9f201-52ac-4918-9b16-3c94c19a47a4	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	1a2321e1-efb0-4f24-9c17-1c8b9093d140	f
d4f670d0-a274-472e-96e8-254c2b2e8a12	3375d125-c65b-4bbc-807c-d0e15580cc9b	3be7640b-781f-45e7-9010-6f12a56d579a	f
ef79e589-f2d8-455e-b87c-ab5d405f226a	cfd27e79-36d0-4646-af3d-3f66a790ca59	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
707964d2-cac9-4a0d-9bfb-38ab090e8b07	cfd27e79-36d0-4646-af3d-3f66a790ca59	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
be3ca854-ec87-4623-8fe9-916e179ec7a9	cfd27e79-36d0-4646-af3d-3f66a790ca59	29e2746c-20eb-4067-897b-f5d26da835f1	f
b43eaaf3-cb9f-46c7-88f8-9c82926ffd0d	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	629f1b84-30e3-4091-ab03-1c348fb8ee8e	f
d649f345-66ce-4b68-ace5-c11952599b02	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	3be7640b-781f-45e7-9010-6f12a56d579a	f
b127515a-d43f-43bd-a72b-6bdb2ac7cbe7	b9cd222b-c28c-4c28-8522-2206f37de8ef	7b6efad2-588b-456e-99c5-280469d7f0ac	f
d0eca1c5-6ad5-4129-97f8-e576133aa647	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	7b6efad2-588b-456e-99c5-280469d7f0ac	f
2159b298-f5d6-4602-8b65-6813b4587fc4	c86137aa-11da-4736-a053-67db0a8d658d	3be7640b-781f-45e7-9010-6f12a56d579a	f
7772bc9e-8780-4d9d-a05e-5a4556b9967f	e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	7b6efad2-588b-456e-99c5-280469d7f0ac	f
631ce954-ea2b-4766-b4fc-3de46702c521	3aecf454-6f25-40c9-b7f7-18cef6edcb32	7b6efad2-588b-456e-99c5-280469d7f0ac	f
accf7aae-62fd-446d-8b71-732419b3d17c	de43e928-54d8-424f-b164-c6f6cf7b8301	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
2aea8989-dda8-402b-904c-b5b63cafbb32	8ca620b9-34cc-4cb2-bde4-9e4e425fdf2c	7b6efad2-588b-456e-99c5-280469d7f0ac	f
80e66b9b-4f16-4256-a58d-f851bccf1bca	7a267af5-6c9a-46e4-b7b6-b16612eba675	7b6efad2-588b-456e-99c5-280469d7f0ac	f
bd1a4937-0ede-4037-9a6d-1dcfbf90da08	87d1c881-208d-42f3-9d46-76b2c427bae3	7b6efad2-588b-456e-99c5-280469d7f0ac	f
4eeafaec-0685-42ff-865d-30e051b939bd	34fd25ca-654a-4bed-b5e3-087641ff1da4	7b6efad2-588b-456e-99c5-280469d7f0ac	f
ad638876-74d5-42b9-a842-7eddb3968733	2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
8e4b78da-9bae-4c98-bf1f-790a5922c278	0534a13e-fd02-4cfb-8491-c59ac802ff56	7b6efad2-588b-456e-99c5-280469d7f0ac	f
2fa4f373-3b41-4bdd-a06a-175c8bc06e10	f8998b14-8d70-4926-9fb2-9254bd4ac494	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
a802ab69-f080-4969-a51a-f25149f47846	3673e128-01f7-48b5-83e1-f5d132e0b124	7b6efad2-588b-456e-99c5-280469d7f0ac	f
fac6aaa5-1cc6-4399-ad49-1861b2d274ad	83c4db35-bc00-42ee-84a3-0c518581f849	7b6efad2-588b-456e-99c5-280469d7f0ac	f
7f74cb6a-f168-4ade-9ce5-8f6fb16eab4e	3275128f-dcb6-4a98-9250-0c658c74b22d	7b6efad2-588b-456e-99c5-280469d7f0ac	f
7e0c3bef-7b10-4b9f-af86-849d19a039e0	31288d3a-60ff-4355-b0cc-22c27c795888	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
7fe5bd31-32f1-49b4-be95-efc3dcc2dd45	9d82b44c-4a01-4adc-a2b7-de0f341cb15b	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
859efd0c-6f5f-40ee-bd5f-31461e815a06	ed06996e-4ff3-4e67-ace1-49001541cd54	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
8ad897d9-5566-4c93-98ce-c1471e91d290	3c1350c6-7f72-4592-a6c7-8bf2953f02ad	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
9fbd9c1e-193a-4e0c-a905-85de29f9f41e	13fe3906-7dbc-4eca-a595-90b86ce38b10	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
35a0a925-828b-431b-8eb7-82244dbc61e6	0a5197f5-c578-4532-b9ca-d826eda45631	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
9e836ed4-7aa7-4c7a-b81d-77d6336033cf	5261e50f-6740-406d-b27d-cbe14528d0f5	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
0e657f3e-e160-4a1a-ab9f-949d14996454	9165be31-df7b-4b1b-a005-eddfd2b88020	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
397467fd-1a9a-4988-a66c-eceb4460d10d	d2c44e4b-1f6e-487f-8c87-56b1287ccfe5	3be7640b-781f-45e7-9010-6f12a56d579a	f
13e24d85-38f9-4fdc-b9bd-b4b5494b8782	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	3be7640b-781f-45e7-9010-6f12a56d579a	f
f9fe7627-f410-45e2-930d-12dad3db2f71	b40da33a-f72b-468b-9886-5aa16aea65d7	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
1b857bd2-9ebe-4b25-9edb-527c2d031b06	19300d02-feb6-42b9-8cf9-0cd847a24821	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
b5212e0c-12d8-45e9-9d3a-31b3debac500	fd93a113-b0fe-4a7a-bd1b-262a688517c6	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
347a9afb-ccce-4b86-9c21-8c2ae97918cb	d6167946-0ac9-431d-b151-1ef742b78f5d	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
6997d96d-5c24-4494-bf11-0e90fe1f54d7	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	a9b46f8c-e978-446f-8db4-e019843d17a0	f
42e64faa-1bb6-4d71-b9b3-388a8bfb337b	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	0652bfda-1c8f-4057-89d1-695edac3c389	f
712446f5-491e-4be8-ab86-03979d566af9	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	3be7640b-781f-45e7-9010-6f12a56d579a	f
4c335247-c5fa-45ec-8eb5-1f658a6dfd07	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
4dd4b83d-c4d5-4073-90ef-c0555bf4c947	f29618c2-ef58-4c56-a6d2-c11779262f12	a9b46f8c-e978-446f-8db4-e019843d17a0	f
8f6891e5-131e-4373-88ed-062574ac9541	f29618c2-ef58-4c56-a6d2-c11779262f12	0652bfda-1c8f-4057-89d1-695edac3c389	f
f30688e8-c1c8-476f-881f-194f8998d5dc	f29618c2-ef58-4c56-a6d2-c11779262f12	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
cdc2cfa8-2237-40ff-915b-dcbc2ac962b2	a34840e0-3c85-4209-94b7-445658014577	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
2421c878-5818-4ab8-aef9-c64cb21c33e7	86adf090-8560-4038-839a-caabbb105de3	3be7640b-781f-45e7-9010-6f12a56d579a	f
9a71d742-e526-4ad1-93ba-490183815eeb	50b93517-656c-431d-b111-9fc40557712f	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
ff89b562-daf3-47de-be84-91835da0cda0	2cba013b-a76f-4d2a-bd8a-87605899cdd0	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
501c5158-c2aa-417f-a516-086c7b0b0d3a	5eecf188-ac02-4b8e-87da-3ec22550adbc	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
8c5d3b5c-f8b3-44c9-8a52-f1a1d3ddfe35	431f2005-da1f-4309-9b88-bc84e36a271f	3be7640b-781f-45e7-9010-6f12a56d579a	f
fdd0c57f-d410-428f-9391-0405771c17e3	6e27e554-7a48-45d4-878c-063a723e33c2	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
b211f563-4ad1-42d1-ad19-eeba0d66e7e7	eb01735c-541b-4bc9-b357-080cdea8f749	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
f883d404-c8d9-4335-a820-fd1d8d6b2e85	afed05b8-7348-4604-949d-9e25de692f4e	3be7640b-781f-45e7-9010-6f12a56d579a	f
45b6d145-e17a-442f-b1a2-ffea9e6940ad	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	f0b1b1f6-9334-4c67-b745-9e1a9e3803d8	f
dbc1b24f-286f-4f80-8ffa-3f6cb3b5f54a	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	3be7640b-781f-45e7-9010-6f12a56d579a	f
48079970-bec5-44d1-9233-fe554c2c4ca5	58b959a9-0137-4f52-b2a3-1388ccd167c2	3be7640b-781f-45e7-9010-6f12a56d579a	f
7cc96081-adcb-4b4d-90ac-f46b655ddf4c	6073dca8-6f3b-4a4c-bd89-51c4599d76a1	3be7640b-781f-45e7-9010-6f12a56d579a	f
9c6188d3-6c45-495a-975e-cbbe488113fb	6bdc05dd-b9aa-421b-810e-10ae2c309d74	a9b46f8c-e978-446f-8db4-e019843d17a0	f
765d5deb-3edd-40a0-a192-6861ecd52747	6bdc05dd-b9aa-421b-810e-10ae2c309d74	0652bfda-1c8f-4057-89d1-695edac3c389	f
6f6b61d0-2d34-4915-b6b2-cb62e927d4ca	6bdc05dd-b9aa-421b-810e-10ae2c309d74	3be7640b-781f-45e7-9010-6f12a56d579a	f
a24a100b-692e-49c5-8b7d-1cf48d832df3	03a0a906-acb5-4276-af0e-56ffff01be45	3be7640b-781f-45e7-9010-6f12a56d579a	f
06c92320-e5e6-45d8-b9df-00904448c6fd	209afc83-5f38-41e7-afca-a46ff03f9f69	3be7640b-781f-45e7-9010-6f12a56d579a	f
7debccb5-9e0a-4960-a6be-ca248facadc5	7d4d69a7-e764-479b-af12-259c90e4a56c	a9b46f8c-e978-446f-8db4-e019843d17a0	f
563c868a-bd4a-4803-8775-06922e428753	7d4d69a7-e764-479b-af12-259c90e4a56c	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
7b2b0112-eb59-47a4-8d1d-b1754e260026	7d4d69a7-e764-479b-af12-259c90e4a56c	3be7640b-781f-45e7-9010-6f12a56d579a	f
f5491297-53ac-47f5-abf0-762c42194111	7d4d69a7-e764-479b-af12-259c90e4a56c	0652bfda-1c8f-4057-89d1-695edac3c389	f
574bef36-7cff-43de-ab3f-3f28ef052730	58e8eed6-92e8-4555-bda2-4ef60f159516	0652bfda-1c8f-4057-89d1-695edac3c389	f
37dceac0-f6a3-4c00-b41f-52095a084f12	58e8eed6-92e8-4555-bda2-4ef60f159516	3be7640b-781f-45e7-9010-6f12a56d579a	f
f86c7a2a-823a-4908-9a71-4cf4c8c58624	58e8eed6-92e8-4555-bda2-4ef60f159516	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
bc8ca263-6e7d-455c-b6b0-55c7f82603e0	58e8eed6-92e8-4555-bda2-4ef60f159516	a9b46f8c-e978-446f-8db4-e019843d17a0	f
20e623c6-7b8a-4d8f-b4d8-4916ee177169	c8aa5616-b8b6-488c-baea-d0ff1b42ad60	3be7640b-781f-45e7-9010-6f12a56d579a	f
a7a2d56c-ebdd-4549-9840-1526c94bb203	f30fbc03-1379-4a3f-9cb0-4e53194f41d5	3be7640b-781f-45e7-9010-6f12a56d579a	f
6fdfef37-343c-43de-aabd-ac313b3f04fe	136f2845-8bf7-4324-bd2e-2e7f84025cd3	3be7640b-781f-45e7-9010-6f12a56d579a	f
bf8ba9d4-364d-4ce8-af27-4d34004f2c6d	56d2d5ce-e67a-4a46-97cb-8ef4fde0e960	3be7640b-781f-45e7-9010-6f12a56d579a	f
85811eac-bd7f-40df-b5b6-d505d06055cb	a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	3be7640b-781f-45e7-9010-6f12a56d579a	f
ef91b300-65fb-4ac5-934b-970ef65f7b22	aeaafa1a-e889-432d-88f9-096455b63aeb	3be7640b-781f-45e7-9010-6f12a56d579a	f
ce96ec40-7ef1-4895-8318-77b9a8c1f21e	66a68c02-2321-453b-bd50-79ff47082a9c	3be7640b-781f-45e7-9010-6f12a56d579a	f
4308b787-86a5-41a8-9379-49c4f95c5024	78747028-16fc-42c1-ba68-ad630d5a5bda	3be7640b-781f-45e7-9010-6f12a56d579a	f
d6c946f1-4d2e-42fb-864b-b57b49d6fb36	2472142d-690e-4406-b8af-eea74d1afa6f	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
285dd99a-14fe-4092-adbb-8da87365eed6	efae8184-423d-41e4-9557-7aa10924710b	3be7640b-781f-45e7-9010-6f12a56d579a	f
f2ef10e7-a45c-45b0-921f-e40f376d91a8	899cfad6-04d0-442d-bfd0-cb91e18ae0d0	3be7640b-781f-45e7-9010-6f12a56d579a	f
03b0c067-ef69-4121-bb32-dbb6d80aceb1	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
6554e8db-e707-423e-b7a1-bd3eb4c1ff5f	0909af86-2dc6-41b3-8787-53eb87b387bb	3be7640b-781f-45e7-9010-6f12a56d579a	f
94b4a8b7-44e0-4ba5-95fd-bac371326e59	0bf4c131-d69b-4b4b-af65-b795960d06f7	3be7640b-781f-45e7-9010-6f12a56d579a	f
0cd29d24-268b-41c8-b3b5-e4063c56314f	fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	3be7640b-781f-45e7-9010-6f12a56d579a	f
6b53bec5-bd6d-4424-9e26-3709ae0b14a1	d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	3be7640b-781f-45e7-9010-6f12a56d579a	f
dbb555ea-93ce-4847-a5a5-2707ea14aea5	d923e4ba-e0d1-4fa1-9837-2755a8b33f04	f0b1b1f6-9334-4c67-b745-9e1a9e3803d8	f
067f43fa-056c-45d0-a68c-11379627f4ce	23a054f8-f81e-414c-bb6a-eb295bc619a6	3be7640b-781f-45e7-9010-6f12a56d579a	f
8858cfd8-05b2-4171-ac78-6e41d93f0121	56bb5d62-6d41-462b-9f29-6f224d84763d	3be7640b-781f-45e7-9010-6f12a56d579a	f
3a41a80b-021e-438f-b2a1-2d8a53ebdb47	d72e298a-d2f6-45c3-8b09-7e0294eabf5e	3be7640b-781f-45e7-9010-6f12a56d579a	f
a67bb6c0-98cc-4fec-8116-c5bed7f60aeb	d266b55c-cef1-451f-a3ce-4b71e887543e	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
4dc4df58-e3ec-494e-9065-b1e542df30f4	8f9f112d-f597-4978-90fc-5906ccff773b	3be7640b-781f-45e7-9010-6f12a56d579a	f
621e8616-e345-4a85-b203-cd38570371d4	f9862fe3-43b4-4742-892e-713694464801	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
8070b5f2-7a34-4890-be69-29e027191c0b	746d71ca-9353-48de-8ae8-dbfc0654538a	f0b1b1f6-9334-4c67-b745-9e1a9e3803d8	f
66d09114-55bc-4524-a355-bae4df6dd01a	e1b258fb-7611-4b39-a601-09d38c5d6dff	3be7640b-781f-45e7-9010-6f12a56d579a	f
a45658ca-bcf9-4330-9be3-ae829e373cf9	e1b258fb-7611-4b39-a601-09d38c5d6dff	0652bfda-1c8f-4057-89d1-695edac3c389	f
1018991a-ce07-45b2-81ec-6f7868bec5d5	e1b258fb-7611-4b39-a601-09d38c5d6dff	a9b46f8c-e978-446f-8db4-e019843d17a0	f
e3241480-58cd-4aba-b13a-aba239836594	4d95ba58-5fcf-451c-9d78-6d8a02719d51	3be7640b-781f-45e7-9010-6f12a56d579a	f
04fdf8e8-441c-472f-8bb6-b5930e2346c4	4055d5a9-7d7f-451b-beb9-4dea063dfb23	3be7640b-781f-45e7-9010-6f12a56d579a	f
ebf1f8ce-2315-458c-beab-e89355db4572	01fa437e-dded-42ac-a1ab-795135b5c433	3be7640b-781f-45e7-9010-6f12a56d579a	f
6eeab17e-c2ee-4b73-9c2c-39be7a2bcc42	d2b50556-4bc9-47d6-8a96-387edca98cde	0652bfda-1c8f-4057-89d1-695edac3c389	f
43b9ec12-885d-4c9c-96ab-b5bd00470d6f	d2b50556-4bc9-47d6-8a96-387edca98cde	619da7e6-530a-4b03-97d9-ae83f6e121b8	f
da969537-149d-417c-aba7-1f7a3ec3c76c	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	3be7640b-781f-45e7-9010-6f12a56d579a	f
408d5246-4024-4fdc-bdb8-afce8e469b54	ce85846a-bdae-482d-9f88-5f846ff811fa	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
b1ef0db4-60da-4549-abb6-ab56b6c3624c	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
2a756eb4-acd0-4ec2-be90-7e2c99b7c5a0	bdb16884-7662-42a2-b2ef-07ae7ff01a1a	3be7640b-781f-45e7-9010-6f12a56d579a	f
f0d34677-ff2c-418c-a975-46303ce905cd	08a2e539-1261-4c96-8955-f115d42bf27f	3be7640b-781f-45e7-9010-6f12a56d579a	f
fb52d5e7-13f9-4bdc-9a92-c4bc3f527c8d	69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	3be7640b-781f-45e7-9010-6f12a56d579a	f
385801ab-c2c1-40c1-ae57-e7389caa0157	bd49d3d2-b6d9-435d-8e51-70b36eb92d79	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
1604fa29-07ea-411b-9fdf-1cc7128bc06f	59df3d5e-434c-44cb-9361-a252d1e8dc78	3be7640b-781f-45e7-9010-6f12a56d579a	f
52a13fda-50bc-425f-9b26-c72a74a20b3a	01fa437e-dded-42ac-a1ab-795135b5c433	f0b1b1f6-9334-4c67-b745-9e1a9e3803d8	f
8260a796-b68a-477b-8e7a-4a8b4f880523	294b5801-e218-4601-81e8-cc59f67d38ea	3be7640b-781f-45e7-9010-6f12a56d579a	f
39f83fd8-ef68-4901-8e79-fb3a24c1ee1a	d2b50556-4bc9-47d6-8a96-387edca98cde	a9b46f8c-e978-446f-8db4-e019843d17a0	f
4e148ec3-1e37-4ca3-9620-2a92afb95c51	d2b50556-4bc9-47d6-8a96-387edca98cde	3be7640b-781f-45e7-9010-6f12a56d579a	f
b2329d1c-22ae-44b1-aa2b-f028438e64fb	6289c163-0a16-4bea-aac3-48248f825fd7	3be7640b-781f-45e7-9010-6f12a56d579a	f
926d1b36-1405-411f-98b4-ef63e5142127	40888ff9-372f-473a-9aef-29d1ba5af6d8	3be7640b-781f-45e7-9010-6f12a56d579a	f
61a385e5-b885-461a-ac19-1aa1be622570	a40d7c70-e895-4a15-b8be-62e233876780	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
b44714e8-2e7e-43ee-b702-1996025587c9	cfc44cf7-59b1-4830-a8e4-9689467b0c4c	3be7640b-781f-45e7-9010-6f12a56d579a	f
dfd70ef9-20f1-43c7-99fd-b3ce68e7cdfa	168dd1ca-e812-4069-bf8d-25b4843e7973	2917fb34-2404-4ac1-8474-439bb8e2b0d9	f
7c845cf1-c952-4c63-815f-19d9fbda7fb3	74b2dfe4-603a-48cb-a0f4-2326194f571c	3be7640b-781f-45e7-9010-6f12a56d579a	f
8f57ecd9-ad81-49bb-9147-cfdc2f6829c2	d242154c-41ac-4bea-b101-f4fe9eac41a2	3be7640b-781f-45e7-9010-6f12a56d579a	f
\.


--
-- Data for Name: kol_languages; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kol_languages (id, kol_id, language_id, proficiency_level) FROM stdin;
47365580-1f7f-44a6-963c-7577e14b8e2c	a08f7952-90d4-4354-b8b9-5c0a5e255d9e	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
12593f66-ef0a-443f-a392-6761c887c118	92444995-2431-4c5f-a13c-7c2cc5ee7d30	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
647f33aa-9394-42fa-8a70-bdf25dd93b17	74e78d28-5150-484b-9db2-9446b75381d5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
758f6a89-7835-4a5f-a907-c358e4c1bdf3	90cf70d3-9e96-408e-a2ba-36d6a28cef4a	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
03cdd1ad-35ab-4180-b7f3-d1d92def4b66	edf54653-87a6-4af9-918b-71e27114f074	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e533d596-8909-499a-a8a8-5103e8ed68be	e03a2d3a-3282-4b79-a7cd-56b93fd3b598	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
0f3621cc-db60-4a19-94e8-f81cb857ceac	d54d1f0e-4025-4958-a212-cdfe52009005	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3082d72e-d2f1-42f1-a04c-fb6cd3fc0def	da40d652-d045-4bff-8a32-e8003411b36b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9eeaabd5-0166-4a54-b753-9339424b4d15	c40a0124-19fe-4651-a59a-28cf46fbd787	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
ff76496b-b23d-49ca-8760-000551816310	a40312dd-0331-4a25-bed6-2b05e9152fbf	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
fda6c3b7-ee46-40df-a213-e4c3174a7c65	52494623-468b-4439-9818-d36645830dd0	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
425136d6-4b2e-4d6a-b024-8f21e4a8e1e1	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e98f36a4-149f-4ed0-b5a7-7874edbdb31d	f735e4c0-39c3-4c66-92ad-908f7461a84f	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f415f212-10d7-4d68-83ab-374bfcc6191f	c5055660-0373-4b7a-8842-b53c9d810bc9	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
6f9e6016-0f32-4da2-907e-c922db52e01a	10a0228d-8083-41d2-a11f-7fe4a61bbc16	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
1201018d-8a7a-4960-b2c5-def98013d1fc	3a08982c-087b-47cf-8b8f-1a7afb5e4081	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3957bb82-8cb9-46f4-9009-3459e513815d	afec6c13-3295-4055-abeb-9d3d7329bb4b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
5b409fac-2451-4fc2-8971-630d93add38c	05676f72-39b2-41e3-9957-a3a5b8d3cf3b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
44fb278b-5b38-4f29-9bde-2267fbc64682	cd1b83c9-d393-4140-b9aa-a03c8ad0cf20	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
66d071cf-3356-4c24-b29b-ee930da67a09	eb46fe18-5c1f-4b32-9071-63daa3da0e28	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8430ddcc-6f27-42d9-88aa-830e1832c8f2	26de4eaa-09f2-4943-ab51-f32f20f48e25	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a455fb17-f1bb-402d-b46f-b1b3d35b4736	6cca21a7-d9b0-4c72-8743-d0c4d18861ae	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8189f367-bf53-49dc-8073-b5e461b83116	849504e9-4b12-4f8c-946e-21eca7000980	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
de603afa-47b2-4cd1-9a74-0cd9dbac8f3f	654a9fd7-e1fa-4ade-938c-dc90713e4f35	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
12b1d010-b316-4216-955b-68a8dfdbe24b	f3a3819e-212b-4aeb-a8fe-779243323abe	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
78a8cac4-bc58-4e96-9d53-b06d3f24eb3e	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a7d65908-8736-4d2a-9fdc-a99098042248	40331030-31cb-4391-913b-acd387389679	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
cc918ed9-8889-4aa5-9c7d-fa9ca6ac1b0b	9467920b-47ff-4786-ab2d-ba71bedb4520	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
509d8236-2e5e-4290-ae40-1e14fc4f182f	449eb148-3918-483d-ad31-078456bbfddc	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
c984e2e7-6efe-4263-8ffb-b950bc1707da	c432674b-3697-4c92-9698-61ef46eedbe7	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
49620b3c-ac2f-4c3e-bd3c-3f80a7bcdb07	a8e73e8b-e412-4d9b-971d-1bfb59309abb	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
fbdb421f-77c1-450e-bf55-7ac78aaa6bef	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f635c172-0f30-43cd-99f4-4e835615a988	be5f976b-114d-4308-8242-52d14f4e9aa6	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
767755ca-c1ae-4ed7-b5ec-7efc7b0fb836	ac955c91-0b4f-4e7b-97e3-6d29389cf196	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
042b5000-2bdb-45e9-8c04-fcc55c5c4b3c	b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
6925b5ec-fe67-419b-b67e-0a7b0e54faea	7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
7bd54749-c041-46d2-9f50-2f5cfae9cecc	9272a0a5-0def-403f-8dad-475fa62fdc71	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
19c94987-bedd-463e-b9a7-9750a7d211a5	8bb3e252-e66b-4477-a145-8b03c028805d	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8b2df99b-6766-48b2-a458-af446585b8da	df663153-02e1-4bf6-8f3b-ac3efeefdb48	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
773f10a2-5f6a-488e-85f0-c28ed54ffd6f	54848923-af3c-4528-a36f-b86babd69225	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
dba9be45-fe04-4886-8894-eb6fb6491275	b2e93254-185e-4547-a363-eb5a99078141	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e2cb1a73-cc7c-4003-a190-dfce4ca296ac	15520237-b54c-4912-abf0-f29c1499181d	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e810f776-09db-449b-93cb-27bc4656dc90	47abda88-d904-4402-8257-1e88c0ff6ef5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
57b8c32a-6c11-40d0-a5cf-fef49a9bcac7	1fec272f-7562-488b-9ec9-eff4656dcabe	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
7e743d13-b1ec-4ef2-889d-a992d1716020	508162b5-5cc2-4cbe-932c-cccc7c7c526f	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
5e420fd1-e269-4aa6-b80b-a48aa68bfcab	003b2d41-7de0-4eec-8fe2-17374ae91d58	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
151f507b-ec54-460a-a703-a0e27e74aa1c	e0f32a2f-a1b6-4bce-9a48-3407f24062a5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a9f8ff3c-2d4c-41bc-a351-8cecd2cbe076	281f97e5-14e2-4a93-80af-80e0ed98bcff	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8fe359fa-1a64-40f2-9723-62b3bb65515d	f4b5744a-8dd0-4504-ba9c-be8992240fe3	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
cee24776-138c-4aac-8631-3cc452085b1f	186b1700-46b2-4e9f-b961-5f86f5efbfc1	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
1b8790e4-4ce3-40eb-9625-4aa9696beab9	e6ef5e56-45a6-4c7c-a540-afc90b193143	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9007f557-64e1-4798-b5fb-f15d22f9b9f1	c6fb0205-1405-4198-940d-5c075949c13e	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a6e6dfec-47df-4c49-83aa-d48c69412e8f	f09eb623-3bbd-4771-b853-aef41da517ed	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9eeb4c76-8030-4279-b8cc-092118588088	d8fd8b3f-5e45-4e37-8a50-85bcbf23efd4	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
14b0a70d-4f67-4505-a52f-e577ca393d72	0a2f4d54-807c-4e33-866b-cfc22845d6e6	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d3d258d2-7258-43f2-a809-a7d859056bf9	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
59ed80b5-b2b5-46c2-857c-8e65e9503e13	8ea77d03-8233-49e8-b39b-262daada91aa	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
83978ffb-6629-469f-9f28-adabae39df9f	888cbfe3-9c4b-4456-9d33-f72e0d002456	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3fd91b6e-36de-4c55-b710-09c29cf48d5a	df953e7c-659b-401e-a906-7b25f29fca41	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f6b1ca4a-f7c3-4af9-88a0-cc22b02e2e55	88615501-f3e3-434c-bbff-9d5178d9274c	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3223fa66-a4c2-4e76-ab6d-d74ddbb436df	febfc4b3-6c2f-4353-9059-2639e24ffec6	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
56c1ff9f-6f83-4618-bf95-533b3404732a	e90ebec3-3bc2-49b1-8548-173d50dd8873	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a0b09cdf-6d8b-4389-9d7a-164245911b17	2f3b4d72-0a9a-49e2-8985-50c9d816da4c	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4fbe776d-8a09-4558-813a-be6b8e3cdbbb	83c11014-e12b-466b-a09d-e5ae72fc71ba	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
7cb13794-9a0a-445d-b2d9-838207949738	84e5e479-8261-4a7c-a14d-08ba739fda95	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
10f81bb5-25a6-41dd-9029-5e350878230b	43794457-3218-4378-8092-8391571c3ff3	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
888e8045-0399-4098-8847-92481acf5088	1ce65635-3d69-4b87-897d-1b42d241b66e	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d23aeb0e-beff-4c93-bfc6-d9e4fc378726	38a50ecf-a0c9-4789-afff-10c9c04312fc	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d96af905-6349-466b-9590-6aacf03e6bae	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3d336c08-404c-49a6-86ee-f9b25b7fa9f3	2c32254c-b0e3-4fe5-942c-70518f6be97b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
775e9806-8628-4500-b70f-9f8c873edfba	ad10b365-44b2-4b4c-bd9b-6b15a885598c	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
98484701-eb95-4c9a-accc-144f06b8d7b0	1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
5742259f-c13a-4476-bbad-43007550bd22	f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
dba2a766-0019-4e4b-ab42-d0b2b243d85b	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
ed10e491-9235-4462-a701-e72fd7c1755c	c54006c7-737c-494d-8d18-b9de72a4d867	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f4819194-34b6-4a34-b683-94ce5b6ac6f3	b6f673cd-c892-4a6b-80e4-e35d5047f905	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4ddfeb0d-3e54-48ad-9603-f198ebb0efcc	a50e21e7-b8e2-4678-a731-2602f1dd2bdb	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
83e40104-4781-47c8-a399-e21535ba2e13	89184324-3bd9-4479-91d8-05dbb8704734	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8aa35747-ce72-4bcf-9da2-e531b98e16eb	ee52295a-a14a-438d-8e93-b42966b44f57	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
03508d1a-08e6-43ce-81ad-15d4fc026bb0	3a5c5674-5f0c-4d4f-83de-6557052c9cd6	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
66ff2d10-09f2-41ef-9330-bf1777063e78	bb789f23-6d06-4380-a752-b391c3380210	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
84aa87cd-8ba4-4f6b-be79-b390116358e4	820af3e2-669e-43fd-9a5a-12cb06e50d80	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
848fff84-13e7-4a13-b70b-77d88c6d7aa5	66f3145c-53d4-4244-91b4-0b84fdc87097	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d6bc5d81-41ae-4bf8-861b-2a14f0bf6921	10b7a7d7-e824-4296-a746-e88fc7511cd8	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
2e3de377-435b-4e09-aca7-b8537d44668e	02e32b42-7818-40fc-8014-22afc4e69092	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
c3754a16-b920-4bf4-b3b1-3171ca0490d7	ca768075-e597-4929-9a5c-d749932ee0a1	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9b0e1521-c14d-4525-9689-c65a39adb424	fe9fc6f0-2e95-4434-b379-9cf7cf7487c7	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
bbb5dc22-2191-45a9-9026-afe5bd6a21b8	20bdeac7-b480-41bb-8f7a-1099626e3249	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f7c44499-77de-489e-aa66-b366990b9c97	f390519c-40ea-4450-a54f-1e466b920e90	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
fab8c9ed-2ac5-4c74-8e6f-da7710954f56	2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
21dd5b9f-853a-4f0f-8027-18271e44d73b	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
48939b5e-e223-427a-8b76-24ea7cc6e454	6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
93daa591-5b14-43ab-8195-e4f426acbda8	4f7141d7-ac31-4e32-8776-b4660f5c296b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
98efb658-68c3-421c-87cb-92825bc55224	6018f5e5-eb1b-4335-aef1-18b0e410cc15	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e78af605-e321-4538-876f-77dcf8d426c0	f0464a49-5b3a-477f-b898-579fbf10c159	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
16ea446e-8fbc-46a9-bcaf-06940ad14eae	815b489f-3c8b-4439-b18d-79ac234d198e	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d8330002-9e66-47ec-a0ce-adec194c0945	6d6ef876-21ca-47a0-9200-095074791c96	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a62d7635-e4b8-44d5-b36d-92e17245fb26	952bbd57-f1c2-4aa8-8fac-ae689e19e0d8	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8bfe3b75-b5b3-4f23-acea-efd29f362703	b868509d-79d9-492e-b250-33a34d8cb0e8	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a72ca6de-fc70-4981-8557-832aeb64cf04	7f2823e2-582f-4120-90d9-fd7d02ece572	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f5b48f72-e3ae-42bc-aefc-8e45f9dc5ac3	92610a49-08e0-4bc3-b61c-9bbf8adee414	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
56bfbb92-ad60-44b6-a31a-a531aec58649	7392cd69-e132-40c8-af99-dec18965f901	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
ca4d65a1-5520-4771-b758-c7184ca5f7ea	0781049d-3f4f-4184-86be-abd5b52d47e3	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
1f9e4908-90ac-41ee-ad18-ea08e28707bd	48cfe773-1b13-41b3-92cf-f48af45125cb	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
02d793bc-4b58-4d1b-9e3d-e9f655c2953e	edaab8c7-830a-461a-8d12-026793c0ab63	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
138af918-8f6f-450a-bd1d-68a4b06330ec	b1780c0f-40ae-427a-ad1c-bf6f160dd8ff	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
65696457-9a08-4dfa-8f47-463456e2c105	91b8f309-8a61-4967-b5e3-469a9e494ebf	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d1874c68-e19a-4a06-8dee-99196b7c142d	2dc7b740-47c4-4dad-8e93-b9bf036609b6	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d9b02318-844b-43ae-9456-090045a3ad0a	365c16ff-15dd-4cd9-bd00-5b56537423dc	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
2cb3ebab-03bd-45a2-8490-5983b31725dc	c3fd460c-b148-4f5e-94ed-f906607510d5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8aed37c6-98cb-4c3f-be45-9aa50554577a	ef1ac0b2-e9b3-430c-9efb-8fc4f9989ff8	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
b83691db-87f6-4d0d-80ef-d1c00684199a	886bfe98-a961-4e36-8e32-f34eff9db46a	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a50b76ad-1f02-4ef4-be23-ae759d82dfa0	cf66d5bd-490b-4b80-aba5-d04df1288fab	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
ed25a9a1-a736-41b6-a680-8a040c8c0869	2c7daabd-9713-4d6c-b44b-5295b1146e4b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
66b68c3c-de01-41b0-abbf-34ba977bc933	30c617a3-6840-4150-9a78-e479cdaaa6a1	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
95df0f5a-abe6-4d1d-a804-421eaa485f76	d25cce7d-1b03-44ff-af78-c907300e06af	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
055ae382-e361-455a-bbc9-8fe2d322c39f	9c5e0827-8042-4a8c-b133-6f02fe0d1661	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
52b7e6a6-d34a-49f4-9030-4c985df9740a	31ccb5b9-3232-49bf-8121-b0d49784a072	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9200a03e-4602-432b-aa10-45d4de9e10b8	602788df-be32-4409-aa4a-331e1d3a3c12	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4496cbf1-d193-4ac0-a84e-3e166745c291	b4887d0c-2c72-4b6f-885f-530af72ea7aa	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
e094fbd3-9b4b-4222-8a0e-c804c0e20c16	0be00181-1078-4960-958c-dad896f508cd	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
bd7fa53f-ec66-4b7b-87a1-1f8aa82ecba9	5205065e-4780-4bba-841b-2bf3bb2b4b2f	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
95dd8b4e-d953-4a8f-9b49-c9d1fb4abaac	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4851a866-b0b5-4857-a53d-3403ac506bf3	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4b3927bf-1a7c-4daf-87be-6581a19ae473	f129f037-4617-4f13-91b6-2f0846f15594	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
8203abdc-f562-48ce-a2bb-b22605fe06a3	bce6a1f6-efce-43e9-9e1f-556d8c35aa44	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
16ab910e-1a19-451e-b258-47d6159f0b5c	f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
2480b6ff-c1ec-4ffa-9bdb-075f59deb213	61f2cb13-4d3c-4ed9-b942-5d94de5b10c5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
c456b7d3-0307-4cc9-821c-571d2e65b44e	ea6c162c-6b68-45ba-a64c-5b80819411b1	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
54d689ed-a89a-4ba1-bf91-a8000f9ad6ae	d17b7538-0204-4b2f-aecf-83f8af1d266c	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d363ee77-f29b-477b-ac27-76b2fca614ab	22561ea9-e707-4082-afbf-0a706a3918d5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
585e66ac-c68c-402d-a532-f2d099ec130d	28dafb56-4f38-4051-ae2b-67dabda4b1d5	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
48952942-6a22-445b-86a1-16d644c512bd	e4477eab-179d-4400-aa9b-219169bf4111	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
a7c52901-6e84-42aa-97cb-3d898a12c62b	e9a26452-e262-4411-8e73-d99449360b66	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
0fc51c1a-0f72-4f94-a5c2-41746484a6e0	bd00f679-68f3-4b10-940d-4bce91e5918c	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
f2d72f91-a96b-4c32-89d5-0ed5d8cf19fb	fac03169-f6bd-4c63-904f-614e89932b1b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
716f28fb-7587-45e7-971e-087cedeb5d3c	eada85b3-3437-4c8f-ad80-94ec9a2ae738	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
3ba8c876-995f-45f1-bdcf-139f5348de17	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
7efb2b15-e7af-48d5-99ee-c5eb280ca196	3375d125-c65b-4bbc-807c-d0e15580cc9b	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
bfbcd977-c969-4061-806c-190c056feb64	cfd27e79-36d0-4646-af3d-3f66a790ca59	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
ff0acaf6-c6c8-4b90-a0c2-3e6a6b460842	6de1feb5-e286-467b-93fb-7cbf1dd12962	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
9a055766-f767-4e69-9d32-92c71beefe44	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
d0ffcdf4-beda-4c79-9b72-d9a757dd5066	b9cd222b-c28c-4c28-8522-2206f37de8ef	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
472fc10a-1672-4f48-8a75-8f115c08b71d	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
4298ed04-d355-4605-8da4-577853177e08	cf53fa17-a86a-4d2f-b72d-3232d84fdfdf	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
0ecf348d-d945-471b-8f6b-a01f05dbac17	c86137aa-11da-4736-a053-67db0a8d658d	51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	\N
daf48d40-0a70-4307-a23c-81da4e3836ff	e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
e337ecd9-973b-44b7-a311-7a48617135af	3aecf454-6f25-40c9-b7f7-18cef6edcb32	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
cff9870e-172c-49c6-8516-baf90339c628	de43e928-54d8-424f-b164-c6f6cf7b8301	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
3f1e2147-dbbc-4ed8-84a0-db3b4b999082	8ca620b9-34cc-4cb2-bde4-9e4e425fdf2c	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
b768b44c-3407-4f73-8ee7-bb6b8547d402	7a267af5-6c9a-46e4-b7b6-b16612eba675	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
d3f1e8ed-8776-47ec-8414-d62a6b18d756	98c97607-b8f8-4115-8bbf-a389eefb9298	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
aa477e50-0e7e-4e51-ab89-7d459ce3e78d	81ea2a69-5998-4f99-9bef-ee4f79e2ed7d	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
cd494eb4-03f5-4be9-9a27-748a44c6b348	87d1c881-208d-42f3-9d46-76b2c427bae3	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
5d586e6c-745b-4374-919e-425c698e4f79	34fd25ca-654a-4bed-b5e3-087641ff1da4	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
e16bcb7d-6f5c-48e4-bac5-e7fbbc97822e	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
8bae05ec-cc58-4dff-ab55-68544c7dc59b	e94b1181-5944-4cc0-87ca-e7cb96294cde	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
1605f2cb-845b-4663-9d32-f7c565828b41	2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
6ada6e8e-43f0-4fcf-ad77-37c55eee0756	0534a13e-fd02-4cfb-8491-c59ac802ff56	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
b904c1da-a87d-4adc-8e92-f567689cd73c	a63fdd89-7fdd-4a67-bd10-3ec3f948723d	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
4c2bca15-a2b3-4326-b536-438ce69fedac	0c9a840d-5ae1-405f-97d8-b4620bd69836	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
e5fe6123-1ffc-49df-aa81-eb00a0b884f1	cfd6e494-2e99-4444-b0dd-cf0e39c35c3f	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
006407d7-0257-4edd-91fe-c4b76235c2b0	f8998b14-8d70-4926-9fb2-9254bd4ac494	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
5c1647f7-695c-4ebf-a72f-22ff82a783a7	3673e128-01f7-48b5-83e1-f5d132e0b124	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
74341192-c31d-460e-999e-c1e22ff61f82	83c4db35-bc00-42ee-84a3-0c518581f849	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
88871949-c1d9-4fab-9460-5ba7c216af53	3275128f-dcb6-4a98-9250-0c658c74b22d	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
5591ad3c-94aa-41db-b469-927363fcd8d7	b5c1a526-3c0d-4769-adad-454977d5b169	e05ba476-4d4f-43df-9cf3-78911ac7226a	\N
695675d1-3814-480d-8196-03e136ccbd54	2aef7c96-0171-4476-a1cc-b4f88b34e997	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
ac692623-8455-45d4-88b0-ec67fa1c9516	025435d6-5888-4fd6-8ea7-9920118431ca	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
cb8dc2d6-2334-4dfc-9377-20be66fa578a	3ac60df5-9ea5-4472-9504-061b503a0e98	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
482f73b3-1361-466a-8ce1-60db4b5bdf74	74cc7c04-8bd1-4dd4-84f8-5a0720a3244a	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
3f589f7a-7f4b-48c5-a199-77e80fc39254	31288d3a-60ff-4355-b0cc-22c27c795888	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
16dd7e0c-e796-4cc1-a8c4-770ea26b05d2	ea1ad626-2645-444d-ab29-4baedb9de705	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
87c53ee1-802b-4502-b9b8-10f6f6977ae1	5148040d-6f90-461f-a2f6-adeea2c0515d	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
7090a530-0f3e-420a-b98e-a21c97275a94	9d82b44c-4a01-4adc-a2b7-de0f341cb15b	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
5314e21d-e243-4173-a947-071ae16cdf38	5e24b43b-f14f-4683-96ff-4801f37d2bfa	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
8fa0bfe2-cb64-415c-b637-2ffbe65301c2	ed06996e-4ff3-4e67-ace1-49001541cd54	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
b1ea67fd-1f49-436a-bfe9-f60b6579d07a	6cd89218-572e-48b8-9073-39f9b8b25381	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
f4c6d7f6-94d1-4f63-88d1-0af5cc7ed9c3	7dcf839d-4ab8-4b3a-ac69-4c87f94b234a	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
9a3393c0-6a4f-416f-8e5a-3b70f1996b90	3c1350c6-7f72-4592-a6c7-8bf2953f02ad	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
6951cdf1-c3ae-4314-aa1b-b196dbb80d88	13fe3906-7dbc-4eca-a595-90b86ce38b10	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
9a351e30-0cd2-42bc-b9a5-62d6a9665e24	d26ca139-43ec-4a9e-8978-775e1e824d24	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
4b5d37f8-2ad3-4eba-93a2-f99fde65386f	1431f7e3-b5be-4c45-9499-2d38f736b916	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
816c9a77-9a4a-48c0-8f9a-0ea9a8c839ab	5251a6b3-70bb-4ab8-a580-9201fef78bcb	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
e062bd10-da2a-455e-9813-3a4a1f3d2275	9f8d74a6-0dec-40df-89b4-ce350f23ea20	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
fa7615f4-898e-468a-a68e-119de482f5a1	0a5197f5-c578-4532-b9ca-d826eda45631	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
7b64f906-02f6-4c52-82c5-9bcd7b664ccc	279d7e14-1a00-4448-847a-313a0bbae58a	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
4574dad6-c2ef-4a14-abc5-aa1de0eb13b4	38ea5178-eace-462d-8eec-4012d0850ed3	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
ad544550-78f7-4956-9224-515f715440ba	4563395a-81cd-427e-90b5-b22bef4ed6f7	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
2aa1633d-5d65-4935-a774-fbbc6c690916	6de7bcc9-5890-4201-92da-1d4a4b598bc6	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
de0b90f0-c72e-4673-b938-4235268d886b	b5c50956-be91-4641-87d2-4e3635864bc6	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
a1fafb22-2699-410f-870a-a198bde6711d	0285a773-0112-4881-81db-c2d3d1242270	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
d0e3ad6a-7b2d-41ba-b61f-82b13c578ecd	3638ba04-11a1-48f9-a594-2ae8703f0e3e	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
831dbd4f-64fb-46ac-8109-aba64f60889f	e08177fb-7fc4-4c64-8b7f-4d0560d08036	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
606a878d-a2c9-401a-b54f-863c85cb5a65	3d26bd02-5bca-4102-bf05-d7ec0fbdaca9	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
cc0f61d6-9843-43f1-99dc-5bb666825512	e06c1478-8030-4267-ac23-46cdf1cb76e2	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
30dcb694-9a6a-4dbf-966a-248edc3a0f74	8c1c9363-457e-40d1-905b-7dfd9a87b1a9	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
ff18cdc0-c252-491c-8b78-dcd781d2c9bc	52ba9901-cd9e-4c75-a28b-3c74f84b21e5	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
b9ea42c6-1ff6-4816-8345-61330ff1c17d	db0404d3-6d7c-4c35-87e8-14c991b6b894	ead6e18d-ebac-4263-9906-8fb7d0aba98a	\N
ed27e01e-b6eb-4af5-808a-ccb89cfe75ff	5261e50f-6740-406d-b27d-cbe14528d0f5	76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	\N
8dc0bd40-afd5-4665-8e54-1faeb0cb5b96	d3d42031-99ef-4704-b5cc-837a302fbc45	76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	\N
ee250ebd-95bb-4181-976e-d273aaa88a83	5d3bb457-c8ed-4cb4-aad0-962a8deb4e06	76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	\N
da5b922a-5180-41ec-b149-48261557e9a3	a6e5af8d-b3ce-40f7-a650-659c2b733e3f	76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	\N
d3f5b2a8-c0a7-4277-a6f5-e776201bec0c	5b01d0aa-c26f-478e-835a-0d3560a3fc70	76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	\N
ee22edfb-3ec4-4e42-bf39-13e9a6cbd35b	25407bcd-ae8d-46c3-a4d8-dced7f78d279	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
3054c6e3-aca2-408c-8173-2d2fcd069ed2	80e338f3-e4dc-4b08-bef3-ccfd3cecd922	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
adcaf1a2-364f-4009-989a-eb2d982ac54f	53dc91bc-b3ca-4daa-8068-3bae75b63cd3	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
44ff5646-c8d7-42a6-bb53-4c8fc5c32208	7daebce3-f985-446e-892b-ce680f7811bb	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
7b263196-fbb2-4d10-9c91-ae4516ffaf9c	3909bc10-7b63-4f58-b952-b07cb94f25fa	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
fddfd663-380f-46f3-bcd7-27daf6134a0f	2a44bd0d-60df-412f-b41b-0ee989031acc	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
dab43593-6836-4c72-a653-0020e0ad6de2	15e1cfe3-8c2d-4095-a1c0-84a959935c65	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
4a5287e4-2bcf-4a95-8905-18c628ca2b2f	2950382c-f095-469b-9d0a-03b3a4cac477	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
e2699c16-0547-4b7a-bf55-70055dafa504	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
b801f5b8-ab7c-406b-abc4-388cb594671f	2fb528eb-fc7e-4684-9dac-ebdc7108c66e	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
5d7afe50-29e8-4a1b-b944-fa10e495ea83	51d5f2ba-7110-46bc-8d63-14d0fa652a5d	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
ef21c1bd-c22f-4c3a-9fb1-8ba39b9b6cfd	9d98647e-0c3f-43ac-a41f-889f2306c64a	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
5dc29f7b-bd62-4c03-a1ce-7a14d005b76b	c6322e44-f4a9-4aec-a2f6-850336b9ad9b	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
20c428e4-d102-4a4e-8c36-f410128f4a9e	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
a514c494-9af3-4030-97d4-78ebe1ff4baa	98b58011-16fc-4ec7-b25e-a0a6dddd9fa2	f5064011-924d-4bcf-941f-2aeb1abbc11a	\N
50bfa023-7fee-492d-8258-271c24b5a533	a3101525-7901-4a34-a80c-0fe955903e17	9962c526-8c82-45c1-8f1c-747bde8e6817	\N
b12d6a57-96b1-4e49-a7d2-39689fdb73cd	2f7314ea-dcf9-4ced-bbd0-12e235827ef6	9962c526-8c82-45c1-8f1c-747bde8e6817	\N
631be7f4-fc11-4a4b-899d-27b7aac42df2	b1ce0761-75e7-4bfc-970c-39c63c15beae	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
fd39a03b-9476-4623-a1d3-68f50baeca31	640ff371-f8ed-4280-b39e-636337db7a47	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
86ef6ba5-0d10-4950-ab67-3f3aca81a00b	c1240f25-cd0b-4059-8226-f5838f72a21d	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
0a1a46e2-6495-4dbd-af80-130c61038771	c34b6e61-7e47-42af-8d0f-7258a892df93	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
2eafdf97-a8f9-42d3-9984-7fcfa8fac834	be2c7d26-cd3c-42b7-8462-426a2f77ca55	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
3688bad4-1dcb-484f-8318-89428a107c9b	5cc8dabb-2e93-4493-9b7e-5b2da6a992b9	79fefe98-1e8b-4bd1-b340-c6cccb136cd5	\N
d1d3ce87-91c4-4214-9fd1-c0b69858db59	103f24c5-dd68-4ef5-b98a-4f38b6268929	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
4c261da8-1b14-453a-9a37-d76c9a3d78c7	e1520e20-6b49-4942-a5bf-17db15a8b993	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
2a83cce4-08e5-4b67-8eb9-a5f0f8b6f835	a23d2de8-9182-49d0-8390-0892a0d120ac	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
d6381585-305f-4371-9051-2217af2815c5	a2cb2258-fdb6-4ece-a4e5-68d41668da04	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
285ff8f1-e788-4b91-925e-e6e30046c941	ae6b7c13-ad5d-44e9-9c9d-13fa1caba3af	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
e5208c9f-c6ed-43cf-ae76-646b6add788a	a4d26b54-bc04-4df1-8b3d-c01939ba12ac	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
660830e3-ccec-4be8-9328-1c0219c26bc7	78ff7e96-5a3d-47ee-89d4-ec56e551af4d	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
ed5b7369-d6b1-49c8-9484-d9f225556d79	b9aa29a7-3446-4a57-9227-f04b897053d0	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
065389d4-9f07-4af6-9674-b141750ac1ae	c9a7f368-d571-4f16-88b2-953fa413afce	0ebf082f-7e17-4d63-903f-3e09bd533183	\N
34650d52-e44c-46d9-bc42-4e4aeade4e51	2d783d0e-91d3-4232-b881-4c4f0e68b5ae	75b12421-5398-45b2-b773-8464d8bdc06c	\N
5c84860a-3473-42b8-8e06-3fe3d27ba552	c08d0109-01e2-4143-9b50-5c7ec6ac0755	75b12421-5398-45b2-b773-8464d8bdc06c	\N
370e4897-da85-49d7-9ae6-5a6cf6b5fefa	8e474aae-efe1-4e65-9592-ebb65cf96d1d	75b12421-5398-45b2-b773-8464d8bdc06c	\N
83abdbe7-0468-4830-8721-811f96774f33	94310160-1f29-4873-b341-4b3a7b37554f	75b12421-5398-45b2-b773-8464d8bdc06c	\N
72118351-8866-4c11-a098-e4c207ae91a7	d725e61f-ad5f-48e3-898f-c363c3346fc8	75b12421-5398-45b2-b773-8464d8bdc06c	\N
fc763cae-6e1f-4be1-b637-61c9b3fa4852	341117c1-b380-463f-a2e1-df27dc642128	75b12421-5398-45b2-b773-8464d8bdc06c	\N
b5e42663-9460-4f4a-b693-30692f3484b1	5747fab8-f04b-4ede-8a94-d17c74d00bfd	75b12421-5398-45b2-b773-8464d8bdc06c	\N
9da2a080-5c61-40c4-9d39-286a2b2a0f67	b91bc33b-adf3-462c-975e-4c9bc4dbef2a	75b12421-5398-45b2-b773-8464d8bdc06c	\N
4d552032-7606-4cb5-8632-56d2a6add45c	6fe10761-049b-40f7-abae-2fd5d58abb50	75b12421-5398-45b2-b773-8464d8bdc06c	\N
5e56fefe-97df-40be-8b23-6d623b7daf72	e9c3d54a-a260-442a-a346-7dff417300c0	75b12421-5398-45b2-b773-8464d8bdc06c	\N
67ab46a3-1f30-4c6b-8f19-f3019e176291	cfeb2b0f-270b-407f-a625-bd46c0b9b0e0	75b12421-5398-45b2-b773-8464d8bdc06c	\N
8c12e14e-dd3d-4ce4-a070-55624acf6975	67f81b56-5b58-4fc0-b955-31f44ccb0135	75b12421-5398-45b2-b773-8464d8bdc06c	\N
568aacf5-639e-48fc-aff8-d6019e8f0091	33991c64-7e13-4231-86c2-db7afbf10414	75b12421-5398-45b2-b773-8464d8bdc06c	\N
95c647be-766f-4969-b849-af963815f225	63b322f6-5f56-40d3-bf84-bbace6c2c8a5	75b12421-5398-45b2-b773-8464d8bdc06c	\N
ecde1866-4016-4e31-95c6-dce9a6008747	f65cc96b-2042-4141-93d9-5b96d83bf05b	75b12421-5398-45b2-b773-8464d8bdc06c	\N
06205d9a-77da-47b4-8f6e-7861e85b259a	e8e5e669-74a7-494e-b464-afbc843bb0bf	75b12421-5398-45b2-b773-8464d8bdc06c	\N
df99d4e7-ae14-4dc3-aac9-301599dd642c	80ff1ea3-3187-45a8-8abf-a065791af2aa	75b12421-5398-45b2-b773-8464d8bdc06c	\N
07ee8930-5e6c-4661-bddf-0332bf6dd269	6bdf87ef-ce76-411c-b0a9-3f2f7e312d18	75b12421-5398-45b2-b773-8464d8bdc06c	\N
7e56820f-2604-4bb0-b2ec-b60f62b01c28	a7c0391f-039f-4893-9fed-342636e2c31a	75b12421-5398-45b2-b773-8464d8bdc06c	\N
7611a1a8-c2d2-4b92-a7fa-2b0f6bac9d8c	564e6fa2-cbf8-48b7-ba16-8afeeeb36783	75b12421-5398-45b2-b773-8464d8bdc06c	\N
c3819ba0-b839-4d51-962f-ac225b78d6e8	711d739c-10ed-450c-80de-baace6f715fb	75b12421-5398-45b2-b773-8464d8bdc06c	\N
b4fd39bb-fff5-4239-b8fe-f6b603239ac5	391617a8-5422-4fa9-a00b-0a723927fda1	75b12421-5398-45b2-b773-8464d8bdc06c	\N
171c0a63-3c5f-4038-87e2-39bf44f3e482	d4704f1c-0bba-4dd0-b85f-d896be3c10c0	75b12421-5398-45b2-b773-8464d8bdc06c	\N
73b7feef-63b6-4d91-a79f-4d3f035af2c7	261855bb-6dd5-4966-8d34-1229e29e6def	75b12421-5398-45b2-b773-8464d8bdc06c	\N
0bec7b09-4c69-4ad4-a26d-d7b8144cce88	3d9705c4-60a6-43da-b2ae-e3694d363025	75b12421-5398-45b2-b773-8464d8bdc06c	\N
0e48879b-1d8b-4930-8a04-3c8019cb793e	485578d2-8745-4484-8692-b99c1113cd70	75b12421-5398-45b2-b773-8464d8bdc06c	\N
1be980e6-ae31-4e6b-8182-9bf135708109	c880e80b-e6e9-459b-b76c-613791b7b88d	75b12421-5398-45b2-b773-8464d8bdc06c	\N
56f48af0-a457-4de6-8fa5-35755f932005	402d4dcb-714d-4e15-95aa-94854f602c2f	75b12421-5398-45b2-b773-8464d8bdc06c	\N
85249214-7e24-4639-b6b9-109652c92bb8	e09bee44-10ce-4d87-94b2-3cfd7eccd5ff	75b12421-5398-45b2-b773-8464d8bdc06c	\N
1a435337-3ddc-4829-95a6-a449ccf134b1	e61fddef-5b5e-41df-8166-0013f41c935b	75b12421-5398-45b2-b773-8464d8bdc06c	\N
d1785ab8-5976-4734-8b56-67e2f46574fb	57e7e20a-72d6-40ff-9b6f-74f7fb46808a	75b12421-5398-45b2-b773-8464d8bdc06c	\N
88bda8e6-b918-4d60-ae95-04a0b7f7f7f8	81c829f0-c889-4ece-a1a2-d0ff22503cee	75b12421-5398-45b2-b773-8464d8bdc06c	\N
37474218-c138-44de-ba29-08a374c79d4d	997edef2-76fb-4731-bf0e-61711f5b4c3d	75b12421-5398-45b2-b773-8464d8bdc06c	\N
b31c28dc-7b46-42af-bad5-0dc0256c56e9	d275cf87-cacc-4301-a48c-e4ff974c7107	75b12421-5398-45b2-b773-8464d8bdc06c	\N
3cb6045e-8a5f-404f-b053-95d5c9b36cd6	7fa6f945-2af4-443f-ac9e-021942d58ffe	75b12421-5398-45b2-b773-8464d8bdc06c	\N
75ee5af9-2f4a-4349-a109-7e7c6bb85665	5510895e-1d4f-493b-bd7b-45c66d381b06	75b12421-5398-45b2-b773-8464d8bdc06c	\N
39e6d6a8-7b3a-444f-a7f0-fa592c17a277	107096f9-c4da-42a8-8b2e-bc08ff92a2c4	75b12421-5398-45b2-b773-8464d8bdc06c	\N
2e830e1c-1a8b-4511-8c36-afe8baaf3697	162986b6-6231-4b77-9305-f09c3662d29a	75b12421-5398-45b2-b773-8464d8bdc06c	\N
a02b7cfc-f156-438e-ae58-88dc5e125149	87991458-6510-4f9e-bcf8-59ccd6c2a424	75b12421-5398-45b2-b773-8464d8bdc06c	\N
30702254-25a7-4d49-b235-053e64be5d1b	fb1e01f9-e5b4-4e1e-ac03-c1bc596610b9	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
a35ded62-1e52-4659-902d-da534406de25	b20b59c3-0b66-410d-aeb6-6cf85d2cccf6	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
6de9aca0-0da5-43bc-a66e-48ca369bc047	ef37b1c3-a253-4086-89a2-5d9fcc9e40b5	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
75927e93-539b-40f9-a739-fe33d879e43d	4169437c-a5e3-43a4-9f74-91d4396c859b	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
24947c9b-7a78-44fa-b995-5e5ffa3e48c3	629cbe03-cc05-414c-a94f-5f89f9741208	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
3ca98825-75f0-44b8-bf9c-5d489a9ab896	7a1ad5c7-dd33-41d1-a520-d0e87bccb333	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
4a956fc6-f4e7-4392-be7c-047b00cd5030	137cf437-1b62-4fb4-98a3-48c1671ff617	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
27a93483-ec35-42b9-8b57-fd334851c56f	6bf62d19-ea8a-4efd-87cf-2e3f8b4c9ab1	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
f15c7418-67e3-4eca-89d4-fa71557d1e4a	79c46d87-380e-4919-b522-d6e9043525e9	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
2fd1a740-3c87-497c-a3b5-f22c064abe52	47d52f8a-0574-4733-aca8-ce5f86afae48	c042ca5c-43ad-4974-aac6-78aa92612acc	\N
85470857-ee8c-49b2-bc3f-f5a48b50793c	538264a7-212c-4f12-b5b9-eb01130c695e	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
6d2a9d8b-7797-4c27-bd10-6a8cbccde4d6	44265096-ccf3-4de5-993b-57ca76e5936d	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
f2132f8e-7820-4ad8-b914-78757e62bff7	fe992cec-9283-4d0e-b054-aac3273b2ea5	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
dfd2a3a9-0bea-4c76-b8db-a5c232a8a33a	04141f93-b2e1-41e2-9850-837cc8afe2b8	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
30c372dc-e567-46e5-bc42-957a889cbbe8	ae226d98-be72-441a-b8ef-e7c0de5eaa98	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
138dd4ef-11c9-4c4e-ae68-eebd5cbba0c1	b2a1c05d-9609-469f-a37f-a90299d9b43e	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
efa1f3c5-7d3e-4a9f-9461-bf83a1527378	9165be31-df7b-4b1b-a005-eddfd2b88020	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
8a9b0b04-54f4-44e3-962d-3a3ef7392113	d2c44e4b-1f6e-487f-8c87-56b1287ccfe5	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
db2301b2-55e4-4c37-a208-b3da87033d92	012dc821-4451-48e8-b9f6-0c62b69b6b84	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
5e7f66a8-667b-4b93-aa7b-0d016527c4a2	4d7bc637-9284-4927-b0cd-7e2193d71a75	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
db7f6c92-2432-418b-912b-48bff9f54686	12ac870c-c81a-4a4f-8739-7fbe33c891b7	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
1230ca29-7e5d-4738-a464-79082bcccf54	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
77a65947-1001-422e-8c00-08d2ae9e5996	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
206ee7bd-4ce7-4feb-9929-751ce3118b74	80f0e661-7d4d-4afd-b5a0-688b93830483	fff4700b-ceac-4ede-8374-8e45eaaa4708	\N
37bd3b6a-8045-4977-ae3c-5170c2d81ef4	7b66d829-14ac-4e8e-bc45-c4d7a3d6b5c8	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
451120e0-c7b6-474a-a032-c1858e53e15f	8de3c4eb-cc3f-4c1f-ba06-001992e8fbd7	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
c4947c90-74b6-4939-a9da-30b1a8413172	8171aa82-e03c-419a-bd78-f8149d941ec5	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
2de792ea-8620-4dd2-9f69-d2b2fd66603d	8e7bc0f8-e12d-4f86-8cc1-c2172e20bfcb	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
3553c099-9382-4794-8b52-a79d32cea0f8	a729039a-942d-415a-80bd-9c882ed4ad40	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
416ec79e-09f0-4466-8baa-0ea7d232cbf6	90057bf7-6dfd-4f3c-acf1-e9f13ea5f207	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
8c1b72d7-d11a-4347-b20e-cb80808838e0	1399c0fe-80f8-48af-88cc-ae8b8bff6911	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
675cbc0d-d9d5-4018-9550-f7f77bcc23a9	8ed05502-d9d4-4f16-b115-990845279625	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
9e8d70ab-901b-4877-8d0c-8c8c09e28484	74cdb61f-4460-4d79-9311-70c7fbb866da	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
d1fa17ef-2c4e-427d-bc78-eab9472f563e	6d581354-2a55-4133-bdb6-58087f38dbe6	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
fda4de36-1348-45b4-8ff3-e270b106bc12	87362c41-8e3b-4de9-9b7b-c1c80ab5551d	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
7c0a1e74-30d8-4493-af61-1dc1beb82eca	bdae4eec-4bf0-4c0d-8e4a-bbf8e8ec525c	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
4859e03f-faff-4f06-b0ad-e765c5cf65f6	7a141736-4709-4f4d-9525-2fc61668753d	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
5656c1bf-6e8e-4b35-8e51-6d6124291c47	6c8989e0-27f3-4dea-9c9a-ea3d720bef74	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
3b06a42d-c3b8-45bb-aca4-5d84c9815f55	e6ed116f-20ee-4e33-9e02-b94609a4b1d4	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
9f58540b-ed72-4a05-9c61-cbe390084781	109a6ec0-be3d-4328-b64b-b9b00f24b358	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
12c77176-8043-4574-b40b-a36db9269eb8	eb3aa25c-3533-4267-b913-8fc8361590c3	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
8fade54a-a08e-4acb-b5e4-41a90ae151ea	b01467c1-c5ff-419c-a878-5a6f6692c4a1	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
e6912410-03f3-45d7-bf44-e136a642ca57	918eab5e-48c2-4b12-b710-a5ed470bbbdf	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
45ad6bcf-dab2-4a72-99fa-b3ce5d1c7eb6	77004703-79c5-431a-b7b9-c61e9a5610e5	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
29fc86b6-ccf4-41ef-87b0-a4f5b20cee81	8880a9b3-e726-44ba-b8fb-8d81c9ca4bb1	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
9c41dc37-948d-4f94-9e18-fcd057e84b15	493085c2-5cfd-4739-bac2-00d9532d4886	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
2d4c922d-7f2d-45a3-b0bf-8af140997f92	a7f4d186-7dbc-43ff-a6eb-071cb73bcd24	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
416fc4e1-a7f6-4399-9d66-69a1a3165c17	4a23b148-7768-4e61-8679-df0cd894ba5c	75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	\N
f2aeef92-9361-4a6f-b7d5-bf4db4c210c3	cedcd048-a84e-4c58-83dc-3e52a8dfac0b	702d5b5d-69a2-49c6-b503-97fd568df444	\N
c9fb490f-825b-48a2-9678-1205ae413c5d	af71200b-6946-49bc-a2aa-6ad36368b8cf	702d5b5d-69a2-49c6-b503-97fd568df444	\N
77fbf808-fdf2-4d2b-983c-3e8974c1321c	e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	702d5b5d-69a2-49c6-b503-97fd568df444	\N
25b6642c-1938-4ef7-b0aa-ffa54f346ecf	822c81af-c1b5-4493-b0a8-55ff0fdbbfee	702d5b5d-69a2-49c6-b503-97fd568df444	\N
4498ce7a-4c41-4cd5-8ef9-a5a8a724f215	b40da33a-f72b-468b-9886-5aa16aea65d7	702d5b5d-69a2-49c6-b503-97fd568df444	\N
bc2233d0-eef8-4ce9-9bcf-98c6ec6a7541	19300d02-feb6-42b9-8cf9-0cd847a24821	702d5b5d-69a2-49c6-b503-97fd568df444	\N
d98308a3-305e-4f87-8076-2cd0dcfabc0c	fd93a113-b0fe-4a7a-bd1b-262a688517c6	702d5b5d-69a2-49c6-b503-97fd568df444	\N
b5853535-8474-47db-917d-82203a0707e7	c18ae991-a8fb-42f9-8cd0-7047fe39d597	702d5b5d-69a2-49c6-b503-97fd568df444	\N
2548fe68-9cf6-4725-bcf2-a324fb1a9531	1812ef72-6275-4dd6-92d2-a91ed2871065	702d5b5d-69a2-49c6-b503-97fd568df444	\N
1a4d1c02-c315-4664-84bc-79f1469256e0	d6167946-0ac9-431d-b151-1ef742b78f5d	702d5b5d-69a2-49c6-b503-97fd568df444	\N
04fe7cb3-f7fb-4feb-a605-db62ab537d26	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
5f8059fd-bc33-475c-8d66-eb94baced158	f29618c2-ef58-4c56-a6d2-c11779262f12	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
56b6db51-3474-4fe6-a9a4-7b7da126fe16	20901b9b-696f-41da-9b0a-56c2b8c2874d	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
030848e1-1044-426b-9988-29e2eef0290f	fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
94e7beb7-d8b8-483a-8928-bea30fce113f	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
0b710953-70cc-4824-952b-c4e67d3a0818	a34840e0-3c85-4209-94b7-445658014577	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
7f40e00e-464e-4735-baf6-62caa466bd6f	718f59a6-8d16-4e31-84f0-61883efc83fe	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
bcf35a8d-a2af-46c3-ab8c-ba389dbf3a58	87057b00-a0b9-436f-a9d3-fc7794a4acac	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
88850e2b-7c92-4d93-a379-3a062867de73	60a1caed-204b-423a-818a-476d229e4c56	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
07e10d68-d137-44df-8a6d-5fc9c5d46ce2	86adf090-8560-4038-839a-caabbb105de3	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
2afd8c45-c7d7-4a1c-8bc4-a9d80c7c7017	50b93517-656c-431d-b111-9fc40557712f	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
68344920-7145-469c-b498-5ec05ad10fd6	18008409-4129-4af9-a114-f0ae6269ec2b	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
1e96fe64-844c-438d-8306-4845acc96e53	2cba013b-a76f-4d2a-bd8a-87605899cdd0	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
d77e677b-cd7a-4a8c-87dc-5d797f2a6c76	4b43d6cc-7025-4896-be9f-9b30bf1fba98	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
29cabfa3-c886-4e03-830e-179b88953ba9	5eecf188-ac02-4b8e-87da-3ec22550adbc	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
ebe76f00-9f9b-4b94-8549-c56af21436be	acdb7ded-63b9-4e74-a95c-96d584e05e85	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
5dbe4aaf-c3b8-4c51-8723-6d42bb98fdd8	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
b36c2463-9933-402e-af7d-2a2f20d0bf93	51465645-99e4-411b-84bb-c35db8063c51	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
b65c4f4f-17c5-4a3f-991b-085d9adf5670	431f2005-da1f-4309-9b88-bc84e36a271f	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
7b373f90-b2df-41d3-9686-1d8712f11b33	6e27e554-7a48-45d4-878c-063a723e33c2	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
6fdd236c-200e-4d1f-85ff-974f8898f758	b4c91d20-b980-4a02-a0c7-65a824ea2358	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
37fcf948-61d6-4fd0-b3d7-4f2724630c50	eb01735c-541b-4bc9-b357-080cdea8f749	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
1c6512d0-842f-4a39-9a43-8d7dc8c1ead4	66e31a78-d9ee-4475-8324-824f1d7a5e01	e067e28c-a32a-485a-869c-57ea20a2b8a3	\N
9e08979d-14c8-4f23-b114-c5989573d6da	afed05b8-7348-4604-949d-9e25de692f4e	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
26323cbe-232b-4a4c-8f60-c780f223ba90	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
0c747c8f-9325-44ff-bdbe-126d526ecd18	78288a3c-91c0-4414-af3b-6fb308bdb9fe	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
453b9452-ff45-422f-850a-84c8bbe8f104	58b959a9-0137-4f52-b2a3-1388ccd167c2	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
ff7c0bfd-5b49-4829-8f24-d67fef015614	6073dca8-6f3b-4a4c-bd89-51c4599d76a1	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
a8ca8434-47ba-4bbd-abec-4e0d99df351d	6bdc05dd-b9aa-421b-810e-10ae2c309d74	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
e4c4419d-b45d-4056-9fdd-35fd37738ff7	37dcd61b-db39-4503-a4ee-d1bc37d4052a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
2afdf33b-db72-4512-a79b-6a41d7886d98	03a0a906-acb5-4276-af0e-56ffff01be45	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
94a1937d-fd6a-437d-b4dd-db67596a061c	209afc83-5f38-41e7-afca-a46ff03f9f69	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
243d0164-4b7a-4d3e-a778-d91e609362fc	7d4d69a7-e764-479b-af12-259c90e4a56c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
a5992899-8a2b-45a9-a81a-562a05dc4951	58e8eed6-92e8-4555-bda2-4ef60f159516	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
a82f2b5c-2eaf-47f6-b7a2-f45068b85769	c8aa5616-b8b6-488c-baea-d0ff1b42ad60	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7e39fb4d-c47b-45e7-a09a-9f11285c2bbd	f30fbc03-1379-4a3f-9cb0-4e53194f41d5	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
82b06280-97fd-4ef3-a8de-8dcdfe28a58c	136f2845-8bf7-4324-bd2e-2e7f84025cd3	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c4a7d167-d204-4f02-9bbe-44feca649d70	56d2d5ce-e67a-4a46-97cb-8ef4fde0e960	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
f8ca1e9a-8a8b-45ff-add0-3748206bd1b4	db3a7a94-caa7-4a9f-899a-f25c24199e2a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
2ecd6b8f-598d-4a5f-a024-d65439b4eacc	f8799383-8829-494d-b9ea-6d6acb56178e	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7b8cfead-1323-4216-b454-081b9c3314e5	a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
dbb256a4-baf2-4e03-92ad-cf9acc2b18c5	d29938f5-3fb9-40c9-a64f-12dcaa311692	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
afa0d0ce-aa68-412c-8c4a-9c682e82b881	aeaafa1a-e889-432d-88f9-096455b63aeb	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
57c778ca-e83a-447f-96f7-2f4325e908c2	66a68c02-2321-453b-bd50-79ff47082a9c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5bf469ca-b632-472e-b801-98eeab042d25	6c5a4dc5-d1d6-422f-bfc7-ee145ea2680a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d348a641-cc9c-4a28-8d2f-729f3a13c8e7	a3d597ea-4118-46ad-bd41-49950351a7f5	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
e2d26c13-7f6a-4230-927b-fb5dd64f571a	78747028-16fc-42c1-ba68-ad630d5a5bda	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
78885de4-a5f8-4cdf-a588-43fac6f6fffc	1a75ba2a-e021-4c3e-b068-c55029a8a923	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5fdcaa65-d241-441d-a403-55784b8fadaa	2472142d-690e-4406-b8af-eea74d1afa6f	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
25e14ec3-31f3-41c7-a8ab-fdfcf80419aa	b36c6d5b-3cfd-4b76-8af1-93d565960d54	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
75b5d00e-9319-47e1-993d-61f39f2e926a	efae8184-423d-41e4-9557-7aa10924710b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
1e19906e-cf62-451b-abe7-4d40136b818e	899cfad6-04d0-442d-bfd0-cb91e18ae0d0	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
9004779f-7a4b-4f0f-81f8-cc920072f3ae	6ffa6051-8a12-4c47-9b02-0eac4e5a3cb0	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
ef04b71e-df5a-4ff9-a8b6-52bc58dd8457	30d9c8ad-0e04-428f-8fd2-576ca87228c8	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
bd642f79-8c1a-4d02-b915-58811c4f0400	c3bc5eaa-f1f4-4426-937c-d9b713c9fd16	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
03dd421b-4dd3-448e-b738-5813dd5f72cf	e9e3fb40-6e36-48d9-918a-25cb5975cf0b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
92825d67-8484-44ec-9e59-583f25f41a58	05d4763c-6190-4df5-b97f-e60500a9df99	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
f97d75cb-90b7-4d3e-a008-7ee3c5b05cfa	0a540629-6aec-455d-9339-5f467913ff9d	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
ef369728-95cb-4c02-a093-46438b917764	c5e25267-6809-4882-b749-9662946912c2	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d46240dc-5737-46ff-9c98-cd42cf0be74c	3c0e3bbc-66d9-4333-ad39-961ae3d102b7	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
719f687c-0ce2-4993-89f7-258d48f0771c	a8dd7f18-3436-471c-a958-69575f764986	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
309c462a-276d-4d87-892a-034631b5c7f1	d96d57cb-c038-4b44-b083-b324eeef60a9	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c7a22b4c-d62d-471a-bf31-7b1296387624	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
fce386eb-3b48-4217-be91-9060e6ebeb4f	c5942cef-4b45-44ae-bd78-d60f38a052b5	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
0f2e78df-eb08-4878-a12f-d31756d27ceb	5ef7275a-ff14-4948-aebb-fa5d6b6a0e9b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
71b27af8-f72e-448c-a1a3-1c2ae4af9f50	4d33ea45-8f4e-4a4d-a09b-ba34b57ba3e9	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
cb73d058-62b0-4899-87d9-8b5ab0b433db	b462869e-5bc0-4ff4-ada6-6944092d9e59	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5ebfee49-ab0e-434b-866c-4e5a6662ac1c	0909af86-2dc6-41b3-8787-53eb87b387bb	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
61b43ab0-b63e-4e90-bb3e-89905bec12b2	0bf4c131-d69b-4b4b-af65-b795960d06f7	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
95864f69-1ea6-4126-9de2-3b52c116cbf2	449d6043-e4a5-4cb7-882d-6523c4fa5319	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
95666964-e5d4-478c-aee6-d19595b38a29	2a9688a8-1ddf-4b40-9b13-4eebdd046e59	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
17600eae-c560-42fe-abf1-2f7a8dbfd929	fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5bebf4c4-9f62-4299-8ebf-19fafab72601	9836277c-c853-4951-a303-f6bac411c107	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
3fb3bd7e-4842-4f83-b04c-d18de26b2a46	f0c334b2-8671-46e9-aafe-e3148ee23adf	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
38700c28-316f-4bad-9f42-2a8e5ca8610f	ba69463e-a9d1-4935-9596-b00294a5234a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
867f8c00-8b98-4077-8bac-07fc95fdd665	3950674f-2bc5-4911-bf0a-53ae0ba48d8c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7dbf1adf-94bf-49b9-b14b-ffb8542bb658	d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
b3e03314-b851-468b-8495-7f12edb40d30	7d370edc-909f-498d-ae21-6bc2ccfb00b1	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
51dd4f09-b23e-4e40-a47c-b434e6647be9	d923e4ba-e0d1-4fa1-9837-2755a8b33f04	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
9fd6e678-237c-494c-a9f4-871389879a3c	23a054f8-f81e-414c-bb6a-eb295bc619a6	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d055e8e7-5d3c-4447-8a31-8210660feb6f	56bb5d62-6d41-462b-9f29-6f224d84763d	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
6b8a8e6d-59a4-4af2-8a0b-0bec1c68b032	d72e298a-d2f6-45c3-8b09-7e0294eabf5e	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
a4c39009-9d73-4e6f-8ac6-dc579662cf8c	d266b55c-cef1-451f-a3ce-4b71e887543e	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
b20e2ce0-8526-4eed-9d5f-0192095649fa	8f9f112d-f597-4978-90fc-5906ccff773b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
64042570-9382-4c70-9339-f51f8450e6f9	bb3c65c7-9823-4df6-8c9e-051332a6cedb	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
050e7744-c234-40c6-8347-a662c4b1fbe6	394ff94e-831c-49cb-a04b-896128421240	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
fdaf6d7d-da46-4c53-9a9d-debf18785557	352bfcd2-9a94-4791-b9c1-1b7d43bc8db2	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
315b5959-fddc-4925-86b1-3d832985375c	ce1e5343-b310-4e6f-94ef-5824a2c167a7	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
e94b6b52-bfa3-4c32-bcee-5350b711733d	a1345f80-0740-403c-857a-c2a066e9c8c3	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7b7e9468-e53d-407d-bafd-7b8a4412594b	f9862fe3-43b4-4742-892e-713694464801	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
93dd1198-f472-4bd7-9799-8cf6430713a6	b5756577-7ac1-4ea5-8a7b-67d1d5712382	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
80d63140-044f-48cd-ab96-6c0a908d4243	ff53a665-8e8b-4311-971a-fe2b51985a00	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c3d5e115-283a-4434-a272-fbc20852cbc7	746d71ca-9353-48de-8ae8-dbfc0654538a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7c1944bd-845d-45d1-a6b2-1a1b4ef65da5	81d595eb-74a1-4698-b416-46c09ac155d9	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
95348ad9-21ce-4584-990b-ea9048b7b341	ffc65822-d148-468b-ba2c-18d9b231b8e5	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d7ce7a16-cb57-4b80-a1b1-aa91d9d18a7d	901eb416-3a46-4d7c-aa0c-93decf104d01	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
e8fa9799-0f80-414b-b619-b5e3734a806b	e1b258fb-7611-4b39-a601-09d38c5d6dff	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
47b7df3b-37c0-429d-a263-f5b672b19f94	67e93fc8-55a3-412c-9740-0bb6d9141177	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
29c7d034-845f-4265-bdef-0c271b251ccd	59df3d5e-434c-44cb-9361-a252d1e8dc78	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
478f332b-e153-4632-b3de-a5ce48cfcd08	950c1fce-9af9-489d-9057-23e42ebd5e2a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d5eb9b07-2bd7-4aa6-acbd-3d61ba0c8435	598acdcf-7247-4bb0-b980-91b71380899b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
4b0aeb21-a804-4cd9-96fd-d4caac432374	01fa437e-dded-42ac-a1ab-795135b5c433	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
48f25e80-3684-4dc1-8d4a-a16551a70d8a	294b5801-e218-4601-81e8-cc59f67d38ea	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
7c5ccf3a-638c-454c-9897-1a87a64b1c5c	1d9ca24c-6c45-431b-9358-912bb0d7000b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
f88522e6-a65b-4f40-aa81-742af3e4c4ac	d2b50556-4bc9-47d6-8a96-387edca98cde	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c2715e06-bcb1-44f4-8d46-5def97020da6	59982833-d4f4-433d-8718-0facedf7460c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
43aa7c1d-ce2d-402b-89fd-1298b8ce4931	05b24779-78c6-498a-a515-cfd2c1110ff4	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
233b8dd7-47fb-47a7-ae86-6db0eaa59f86	77069309-1d94-457d-ae04-8f41f99b61ba	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
14037a00-b91f-40d6-8bba-a91e34e4d678	2ffbb550-8ef7-4ee0-abbb-2bc8cc9b8626	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
590fbf37-8b3c-4bd9-ad07-b9a03c3af285	794403fc-d937-456e-905d-ba1014f8ebdf	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
697fe4f4-ce93-41a9-9b62-c0e9cc123ecb	64ce9410-1679-44f2-8c70-138792a1e087	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
88d43a60-9230-4dd1-bb71-8bed35ee93a4	0d2da959-8d4e-4bdb-9e13-9a5558102ef5	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
48a1289e-0409-4fe5-b1ad-aa47ecc9140c	6289c163-0a16-4bea-aac3-48248f825fd7	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
6c105e31-883b-44f5-b12e-5f230a7fb1f7	9696fc6a-d3c9-481e-904e-72454a56cfb0	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
1461ce4f-1025-4929-bfd4-7150cfe888ac	3b9e651e-7b05-4ef5-971c-23f80efa20ec	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
251c3f95-f7f3-4de3-a0bd-3d110ab4b780	183a902d-4b06-4904-8d47-3379609ab004	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
8edd7177-079d-4a4f-a595-7b4cea151c8e	400be1dd-a2a9-42f5-90d0-d84fe069f387	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
d3fb589e-f7e7-4c48-a1fd-1924f06343a2	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c82e9788-7d60-4f7a-922c-44e135cde1d6	6a4abfcc-aef9-48c9-9ec2-c246cf7d11f2	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5a1c23de-1322-4d25-ab92-19ce17fe7095	40888ff9-372f-473a-9aef-29d1ba5af6d8	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
b879599d-0c35-4fae-a61b-b4c52b6d6f32	a40d7c70-e895-4a15-b8be-62e233876780	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c1111637-2776-4f8a-b97d-07a322104161	70012215-6080-4feb-bd19-5a7da237d524	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
09f3a7a4-4ac7-4bef-be47-9b7d70adcc9a	cfc44cf7-59b1-4830-a8e4-9689467b0c4c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
4beb22c1-5a5e-4e0a-8ea1-ae93cf5cc617	168dd1ca-e812-4069-bf8d-25b4843e7973	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
f3e8b9bd-aff6-4577-bc12-e613a36f16b2	3de2647b-2c7e-4be4-a1ad-da663c52b49c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
df1381ff-2b5d-418b-b8b3-3210a82285ac	fe3a36d9-b571-4767-87a6-d16e5b653b13	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
1e84d899-bfe2-40ab-9b1b-31f13da39b18	cc54cc90-5051-4d2e-8116-185ffd1d55f9	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
ec71d330-e175-4e0d-a281-23566323212f	74b2dfe4-603a-48cb-a0f4-2326194f571c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
cce89536-750f-4c80-9151-9efbfc05c6b2	480c0dad-eb5a-4e45-b6c4-0d89a202aa18	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
656eca12-1d71-43ef-a60f-9f0012b10dbf	eca2971b-5e27-40bd-adec-2098a19fb964	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
1884095c-0cfb-4477-848b-b090cf7bd381	6f727607-1ad4-46cb-af3d-3a91fbb0eccf	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
1f9a9954-e378-4ab3-a707-7b022b6bc688	e8e64cd6-a80c-4e32-ac4a-c8d01273e444	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
9e159cc4-6933-4737-8c56-e1c20f9f01ea	6f3a5ab2-0286-4042-8629-37ee61bfb595	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
ab3715ce-987e-4bd1-a985-91254e2d2eb0	4848c5c6-a3c4-43ce-bcdf-48e979e85356	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
c8d33e5a-c943-4cc0-9755-45230fb68c8d	db208873-6fb7-4ba6-9488-7539dd1ba769	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
a559cbad-73c0-4bf2-bc85-2ee68587dcc2	ac23f99a-bacd-45e6-9d89-31e63a19d59f	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
07f37e78-b263-45ca-ad96-50be416626e8	1378b622-ffc4-47d0-9c06-60198b6b925c	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
07e658f5-a5e9-49bf-8697-6b7442739447	7128f876-3e36-4dcf-b53f-1d013c870dc5	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
1c6d1084-ef71-43df-ad19-3b37ee58e1d0	ac84bc3f-4964-438e-ae06-145366f680e6	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
42576173-f00d-4671-9450-97b1b38c87a2	28f63dbc-d59a-40ff-b38d-39ed1637e538	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
f5bd3eb0-14a6-4641-b800-18e90b2bc3e7	8dc919b6-d6dd-4bd3-b297-94c6023df030	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
5b1f8278-d04d-4216-8483-b147299b02b8	6dfea2f7-777a-45ee-8554-6ddcbb59b841	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
98170277-04d8-4677-814f-90e14712ba00	32929a16-977e-4700-9ef2-21ade7141aca	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
65c719cd-15bc-4d44-997d-0cc0e8fcfac3	903eb4a1-3be5-4187-a23d-440d1160d717	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
c8dcf751-6e8f-4d06-8c53-80968b50b65f	73054296-9cb6-4dc1-bb30-147fc0f14f47	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
a9348ef7-3f0a-4f42-b3b1-7f1d461118f1	8317df96-4c13-4514-87df-b8c65d9e08dc	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
b30c57c1-0435-49c9-be05-6fa44ffc9ff5	b1ec569f-83ee-4a17-9d07-53d70bbee703	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
c88ea513-4f1f-4931-9260-8217a9909e9d	fb8dd599-e3bc-43cb-996d-4e11c82aadd6	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
b1b03591-f70c-489d-9330-34613f2a18c3	6953adb3-42f6-4216-b602-14f8417c754a	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
9b2600f9-ac91-46e5-8806-e152e22140b4	103659ba-e1f4-405d-b289-2fabf44ad1b8	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
4295890d-f0be-4da8-8bcc-55a2887cb424	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	77f6770e-dd6f-4c20-ac36-835a6dd877fe	\N
c703b0a5-b702-455c-81f7-85fc81f5fd79	50480996-392e-4fbd-bcd3-b2d67cbb25ae	77f6770e-dd6f-4c20-ac36-835a6dd877fe	\N
baa909fe-f64e-407a-afb7-38b8b19ea57a	d242154c-41ac-4bea-b101-f4fe9eac41a2	f301d383-13a9-4e27-a871-4e8bcc7e48b1	\N
464f4f8f-8590-4775-a644-569a6b3a95c7	5920a748-45c1-4867-b792-8a6c7845a6fb	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
5cf59e9c-f892-46b5-bb90-a9efcf84b02a	4d95ba58-5fcf-451c-9d78-6d8a02719d51	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
94a6ee32-256a-4ce8-89aa-f3b0a7eb0ace	57d33458-6158-4457-a863-416a59f2bcd3	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
6b929c6e-de6f-4fc9-bb6f-fcb7e8eaaaf9	360939ba-f9a5-4122-860b-bf8f6a700d5b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
71d702ce-6770-480a-8898-7efbe8b3d647	7cbda437-88bb-47c1-b598-cb6eb72ea01a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c91e9d9c-44d8-4600-8091-3b71fabd0521	4055d5a9-7d7f-451b-beb9-4dea063dfb23	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
fafe69f5-1732-4500-9e0e-dea9aca2e7a1	cb476e55-39c3-4257-944f-3b1c93f8bc1a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
19ba8a33-8a62-4d40-b4f1-d0489925195e	14f0e2a6-31b7-4617-9bb7-9a70be9e185c	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
3516a4ca-69ec-4aaa-8a14-a23d63d77554	5e0d6233-37b7-429b-b437-7c9e80a88217	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
85ad8798-bc37-453c-b9b7-7b9c136e06d2	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
0fc0d3bc-af0f-414b-806a-a8b36897c99b	ce85846a-bdae-482d-9f88-5f846ff811fa	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
b09d88e6-0dc4-4aed-9e40-e96114a6d571	cc3e9660-9e46-4ae1-8ac6-060ab08ad10b	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
e5a20c59-1d07-449b-9bd5-e55bf7e120f0	4e528c7a-acc8-4f9a-a623-07a80b4d81a6	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
fca7f274-e0c9-42d7-929a-e1e2d1079bce	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
be7cab4a-e59a-4400-a05c-999b0c6bc9cd	bdb16884-7662-42a2-b2ef-07ae7ff01a1a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
b01f9830-995f-45a2-a508-8b3e23a2fa11	1264f97e-0a23-4690-8272-23123de6547a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
aeffd8da-a835-473e-9a27-6156d810b1a8	954bc336-4c17-4f7d-90be-16658e264c5a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
fd635f52-8a13-4207-92f9-004cb32c1563	72ac3de4-eeaa-49cf-932a-cb0d421745db	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
c5ae8726-0551-4356-a22e-f77945d532a8	08a2e539-1261-4c96-8955-f115d42bf27f	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
4e2d457e-af1f-4879-ab0d-20383e7fc188	69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
432fd0b8-fd82-4d3c-afbe-ee912b5d0cea	5fc1c616-8522-4ce7-aa55-4c2ed2009365	792bca6d-7eca-48b2-8995-b3bf9e33310d	\N
74b5198f-13be-4fa9-bcf7-7ee825cafa00	bd49d3d2-b6d9-435d-8e51-70b36eb92d79	58e932c2-ada0-4961-a156-ee1b84291133	\N
dc530815-e31f-4259-876f-7cdf0ea9235c	7f14b79a-599d-4733-aa62-44518f5c617a	4ff25d92-d264-4ca2-aebc-e29cb488835f	\N
bd1f9325-92cf-449e-b502-93e3cef9ac86	e484f6a3-69db-421b-983a-004a7555a023	4ff25d92-d264-4ca2-aebc-e29cb488835f	\N
561da8f2-4483-4298-8e80-039c2dc1ae1b	53ca5fed-83fb-483b-8828-fc44b82f2151	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
54ed19b6-c075-4d1e-b1cb-b406bf2075e4	f38f2d0e-222a-466c-94f6-a5ae59722d48	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
d9c71317-2a4b-4bbb-9d18-fa9e3a63d1e1	8bdb3443-0b3c-4c0e-af70-8d5445637c2d	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
c09b2d8d-79df-4486-b92c-8d82077171db	1bb1b2be-d8ea-455b-8548-7e3b2f26d998	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
dc3d312f-95bb-4de6-80d1-a2d247275cef	dbec632d-00a9-4f98-89f2-a03331e47f5e	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
ca9a42b8-d8d6-4420-81b6-92fb665c7b7e	3276768e-5aba-468c-892b-24adbfd7d455	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
6b6ffa3c-c885-4aad-8419-ffce34ca2bea	632ed109-9131-4e88-a37a-66627509d544	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
bcaa556e-3613-4e85-a1b8-5784fa04663e	f961b49d-105b-4814-84f2-0430331ed65a	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
3282f475-0753-433c-ba35-3f0407d2c1b4	1354a7ef-fa5e-4b15-864b-84711dda47c3	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
ec8aec9a-62c2-434a-9067-6f6b6ff2969c	2d2ccc2f-e903-4f5d-8438-451b39f6fe35	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
3a25ac58-299b-4eba-9328-9883180a7dfc	62c0ce66-d822-4ca7-9f0d-82f71e8f1b02	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
5c6a530d-7615-45c8-91c4-dc75bf01aec6	e2aa0ef9-010f-4ccf-aabc-6a7623e9fca0	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
7e0a8a33-9c2b-45ae-a3ad-022c3e018ff2	6c907c1f-121a-41ce-aff6-4977ab588fed	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
2f620292-8874-455b-8d17-4d25fdef6df6	c5d5f602-291e-4544-a901-332f8fda700c	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
f94496a0-5a1c-40da-9f35-aa6558dc9f08	435df992-7b96-4eae-8936-b9b36b91405c	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
6b6def35-f4e7-409a-81b6-486ebd6b041c	95fbb6fc-10f3-4dc6-8cbe-090094ba417a	9c6bb2e7-362e-4730-996c-343fcfdd5c5f	\N
9b6b4266-f984-453b-a341-dd6e6551f924	277f9203-92c7-4a39-809d-e81eee5e5637	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
7229e07c-ee27-4b3b-9338-52c0ba86da03	0014cdbc-a111-4968-a413-828882e32e66	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
db05f072-2b5b-4345-99a8-52251e39b945	7c4c65ad-dec4-4abe-93bf-6c7011711ea5	e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	\N
69b17cc7-d204-4610-97b4-42e4344eb539	aa54bc98-4f39-4229-9084-5e1c992c4b96	77f6770e-dd6f-4c20-ac36-835a6dd877fe	\N
c16607f9-c838-47eb-82cf-39bda49d8e8a	a116e420-674e-4867-b4b7-0bfdd644559b	77f6770e-dd6f-4c20-ac36-835a6dd877fe	\N
a8bcc86b-952f-4240-9a63-205c5d8fab0c	d137bd3f-41e4-43a8-820a-7addc94df4ea	f301d383-13a9-4e27-a871-4e8bcc7e48b1	\N
\.


--
-- Data for Name: kol_pricing; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kol_pricing (id, kol_id, service_name, social_media_details, price, price_without_commission, currency, notes, contact_info, is_active, valid_from, valid_until, created_by, created_at, updated_at) FROM stdin;
b86e4bc6-317a-406b-8981-7c1cb3e32665	e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	X	{"X": {"count": 1}}	590.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.215882	2025-12-10 18:30:51.215882
b482d8a7-5244-4b48-9988-2fe412ec291b	3aecf454-6f25-40c9-b7f7-18cef6edcb32	X	{"X": {"count": 1}}	885.00	800.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.223569	2025-12-10 18:30:51.223569
821ed417-b968-4d81-9336-74ad4addf515	a08f7952-90d4-4354-b8b9-5c0a5e255d9e	X	{"X": {"count": 1}}	575.00	500.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.224475	2025-12-10 18:30:51.224475
a6a18906-e481-4a84-9f8e-b6cb4b21a6c7	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	Buy signal, X	{"B": {"count": 1}, "X": {"count": 1}}	3200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.225129	2025-12-10 18:30:51.225129
ece16e49-9f12-46aa-8ec6-7752fbb7a296	92444995-2431-4c5f-a13c-7c2cc5ee7d30	X	{"X": {"count": 1}}	575.00	500.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.225916	2025-12-10 18:30:51.225916
457e17ce-f257-4c4f-885f-26a76dc1d27c	74e78d28-5150-484b-9db2-9446b75381d5	X	{"X": {"count": 1}}	700.00	650.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.226345	2025-12-10 18:30:51.226345
6a542132-7b41-4b2c-94b5-6a924ff4d76d	25407bcd-ae8d-46c3-a4d8-dced7f78d279	Youtube	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.226961	2025-12-10 18:30:51.226961
3e4c07b3-c2e1-4ec2-873b-0caa9ce6f81e	53ca5fed-83fb-483b-8828-fc44b82f2151	Youtube integration	{"Y": {"count": 1}}	5060.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.227731	2025-12-10 18:30:51.227731
a5f99eac-9e4b-411e-9426-e8e724544123	5261e50f-6740-406d-b27d-cbe14528d0f5	Youtube	{"Y": {"count": 1}}	3850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.228363	2025-12-10 18:30:51.228363
57c4262b-3fff-46c6-bfaa-b7b1e9afa3b3	58b959a9-0137-4f52-b2a3-1388ccd167c2	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	2450.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.229043	2025-12-10 18:30:51.229043
60c9495f-e4b3-49b6-bb64-960f514c8fa4	fb1e01f9-e5b4-4e1e-ac03-c1bc596610b9	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.229484	2025-12-10 18:30:51.229484
776ebd4a-42ba-476a-a669-8274e34ad61c	538264a7-212c-4f12-b5b9-eb01130c695e	Youtube	{"Y": {"count": 1}}	2700.00	2300.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.229946	2025-12-10 18:30:51.229946
ab32ab96-c37a-4ce8-9f76-bd475efbd2a3	538264a7-212c-4f12-b5b9-eb01130c695e	Youtube integration	{"Y": {"count": 1}}	2000.00	1700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.230286	2025-12-10 18:30:51.230286
c29fd8f7-5d52-422c-a561-cd31a4be4d70	90cf70d3-9e96-408e-a2ba-36d6a28cef4a	Telegram	{"T": {"count": 1}}	350.00	300.00	USD	Fiyat alındı, instagram sayfası da var onun ücreti 400$ bize verdikleri fiyat, kom ile birlikte 450$.	@Raiken35 @adtemre	t	\N	\N	\N	2025-12-10 18:30:51.230704	2025-12-10 18:30:51.230704
01d9b035-765d-4072-8f45-b54868a80f78	edf54653-87a6-4af9-918b-71e27114f074	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	360.00	\N	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.231001	2025-12-10 18:30:51.231001
4d0cfd06-88c0-4546-b773-e55aa593b582	2d783d0e-91d3-4232-b881-4c4f0e68b5ae	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.231517	2025-12-10 18:30:51.231517
197ee0cd-943e-41da-a04b-5cce300d8fc1	f29618c2-ef58-4c56-a6d2-c11779262f12	Youtube	{"Y": {"count": 1}}	5750.00	5500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.232052	2025-12-10 18:30:51.232052
611afbc4-afac-4b86-a9bb-1ae8ce25be5c	f29618c2-ef58-4c56-a6d2-c11779262f12	X	{"X": {"count": 1}}	3200.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.232526	2025-12-10 18:30:51.232526
be183078-d57b-4ddc-8351-c7d83ec6c554	2aef7c96-0171-4476-a1cc-b4f88b34e997	Telegram	{"T": {"count": 1}}	345.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.232991	2025-12-10 18:30:51.232991
b64c1df0-c79a-4e6f-b5c5-b4da416c27d5	6bdc05dd-b9aa-421b-810e-10ae2c309d74	X	{"X": {"count": 1}}	13200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.233461	2025-12-10 18:30:51.233461
b1809ff7-a548-437a-aa51-7978de981094	e03a2d3a-3282-4b79-a7cd-56b93fd3b598	X	{"X": {"count": 1}}	600.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.233919	2025-12-10 18:30:51.233919
af558631-9793-4526-863b-ad5a5ce0f9aa	37dcd61b-db39-4503-a4ee-d1bc37d4052a	IG Story	{"I": {"count": 1}}	825.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.234459	2025-12-10 18:30:51.234459
89386fde-5e42-4b3b-bbe1-0b6c626d8782	da40d652-d045-4bff-8a32-e8003411b36b	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1035.00	900.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak (eralp ile calıstıgımız soylenecek)	\N	t	\N	\N	\N	2025-12-10 18:30:51.234795	2025-12-10 18:30:51.234795
8cb985b8-2f26-41c9-8850-710c531ea34f	03a0a906-acb5-4276-af0e-56ffff01be45	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	7800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.235093	2025-12-10 18:30:51.235093
a381c9db-d7eb-4109-a82a-1d35106e09e5	de43e928-54d8-424f-b164-c6f6cf7b8301	Youtube	{"Y": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.235428	2025-12-10 18:30:51.235428
9ad25611-d352-4fef-a1ac-c676ce89251b	480c0dad-eb5a-4e45-b6c4-0d89a202aa18	Youtube	{"Y": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.235767	2025-12-10 18:30:51.235767
0678f4c5-ca85-4a1b-b52b-471377fc3e4f	7f14b79a-599d-4733-aa62-44518f5c617a	Youtube	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.236412	2025-12-10 18:30:51.236412
43b37824-3d36-4b98-a177-a03ceb312eab	7f14b79a-599d-4733-aa62-44518f5c617a	IG Reels	{"I": {"count": 1}}	3940.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.237068	2025-12-10 18:30:51.237068
eb3c9ca9-3319-404f-ae54-c8f298b42018	025435d6-5888-4fd6-8ea7-9920118431ca	Youtube integration	{"Y": {"count": 1}}	11500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.237529	2025-12-10 18:30:51.237529
7b9d00be-5115-4a48-bbee-8d5bc0eded0f	58e8eed6-92e8-4555-bda2-4ef60f159516	X	{"X": {"count": 1}}	4350.00	4000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.238045	2025-12-10 18:30:51.238045
46b9ab4c-f9cd-41fb-80ea-dd8a75179fdf	58e8eed6-92e8-4555-bda2-4ef60f159516	Telegram	{"T": {"count": 1}}	3320.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.238697	2025-12-10 18:30:51.238697
a9faf0d2-4f13-4f0c-8581-67b25a20524f	c08d0109-01e2-4143-9b50-5c7ec6ac0755	Telegram	{"T": {"count": 1}}	1015.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.239631	2025-12-10 18:30:51.239631
ded762e6-945c-42d7-b7f5-64b35053addc	103f24c5-dd68-4ef5-b98a-4f38b6268929	Youtube	{"Y": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.240334	2025-12-10 18:30:51.240334
ffec9d92-dbb0-463f-a731-593b967aeaf8	a729039a-942d-415a-80bd-9c882ed4ad40	Youtube integration	{"Y": {"count": 1}}	1150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.241119	2025-12-10 18:30:51.241119
32726c6b-c929-4578-b4b1-b908e5c87677	c40a0124-19fe-4651-a59a-28cf46fbd787	Youtube	{"Y": {"count": 1}}	1100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.241663	2025-12-10 18:30:51.241663
c42c3c4a-9b89-4ac8-8c79-8c5e25f934cd	a40312dd-0331-4a25-bed6-2b05e9152fbf	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	5200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.241992	2025-12-10 18:30:51.241992
03bb7b6b-408e-48e7-8d8a-82eebb511d30	b20b59c3-0b66-410d-aeb6-6cf85d2cccf6	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.242286	2025-12-10 18:30:51.242286
ec41f73e-ced7-4f6a-a00f-572ee852550f	52494623-468b-4439-9818-d36645830dd0	X	{"X": {"count": 1}}	250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.242818	2025-12-10 18:30:51.242818
ffd6104b-58d0-45b7-8f00-9ad9ed9b8704	f735e4c0-39c3-4c66-92ad-908f7461a84f	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	8900.00	8000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.243337	2025-12-10 18:30:51.243337
6386f1c2-1f11-4ea8-846c-a82176f69681	c5055660-0373-4b7a-8842-b53c9d810bc9	X	{"X": {"count": 1}}	1380.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.243832	2025-12-10 18:30:51.243832
721be77b-6a6a-4a95-8781-3c5360dab6e6	10a0228d-8083-41d2-a11f-7fe4a61bbc16	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.244297	2025-12-10 18:30:51.244297
07cbe43c-f3e2-43b9-b434-e2267529b5cf	3a08982c-087b-47cf-8b8f-1a7afb5e4081	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.244833	2025-12-10 18:30:51.244833
26b74dc9-4bc9-4a4c-81cf-fda6ea0f5276	ef37b1c3-a253-4086-89a2-5d9fcc9e40b5	AMA	{"A": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.245143	2025-12-10 18:30:51.245143
4bcc5e50-ca2b-4427-9b95-3ef695c3b0fc	afec6c13-3295-4055-abeb-9d3d7329bb4b	Youtube	{"Y": {"count": 1}}	460.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.246549	2025-12-10 18:30:51.246549
fc683e9a-180c-4708-a400-41ad2dcd7be9	3ac60df5-9ea5-4472-9504-061b503a0e98	Youtube	{"Y": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.247062	2025-12-10 18:30:51.247062
2019ff25-cfa3-434d-ab8f-35d98dd47944	136f2845-8bf7-4324-bd2e-2e7f84025cd3	Buy signal, X, Telegram	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	4300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.247562	2025-12-10 18:30:51.247562
63acc07d-b17d-4e08-a9a3-30de90c193fc	136f2845-8bf7-4324-bd2e-2e7f84025cd3	Buy signal, X, Telegram	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	18000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.249768	2025-12-10 18:30:51.249768
a6944c2d-58bf-48ca-9c8b-030cefcf14c3	1399c0fe-80f8-48af-88cc-ae8b8bff6911	Youtube	{"Y": {"count": 1}}	13500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.25018	2025-12-10 18:30:51.25018
cae0a949-ceb6-49fb-8f81-10899b20b829	1399c0fe-80f8-48af-88cc-ae8b8bff6911	Youtube integration	{"Y": {"count": 1}}	7300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.251685	2025-12-10 18:30:51.251685
96434949-2970-43e2-bdc2-edfbfa6ba9a8	cd1b83c9-d393-4140-b9aa-a03c8ad0cf20	X	{"X": {"count": 1}}	1700.00	1500.00	USD	magnor olarak fiyat alınacak,pınar hanımla calısmıs pınardan bahsedilecek	\N	t	\N	\N	\N	2025-12-10 18:30:51.25223	2025-12-10 18:30:51.25223
4adf3a41-017a-44c3-8e39-4967c60966f6	db3a7a94-caa7-4a9f-899a-f25c24199e2a	IG Post	{"I": {"count": 1}}	385.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.252702	2025-12-10 18:30:51.252702
dcd27e44-9a86-4e9b-9c75-83f45d334c41	cedcd048-a84e-4c58-83dc-3e52a8dfac0b	Youtube integration	{"Y": {"count": 1}}	6460.00	5500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.253168	2025-12-10 18:30:51.253168
5880fc8c-5fde-4bf5-b936-3cb2e8d26dba	f8799383-8829-494d-b9ea-6d6acb56178e	IG Story	{"I": {"count": 1}}	880.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.253638	2025-12-10 18:30:51.253638
43c535fd-d68b-45bc-8683-aee73cb53e9d	8e474aae-efe1-4e65-9592-ebb65cf96d1d	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.254085	2025-12-10 18:30:51.254085
ea150c06-fa39-485e-adde-2da19195afb4	a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	3700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.254599	2025-12-10 18:30:51.254599
680273a5-30dc-4e05-8706-8a45ba5258e3	d29938f5-3fb9-40c9-a64f-12dcaa311692	IG Story	{"I": {"count": 1}}	495.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.25491	2025-12-10 18:30:51.25491
6d927b30-94b1-4575-925f-d86c69f19454	94310160-1f29-4873-b341-4b3a7b37554f	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.255209	2025-12-10 18:30:51.255209
de89fd82-6778-4e00-8d57-7ca21442d143	eb46fe18-5c1f-4b32-9071-63daa3da0e28	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1725.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.255647	2025-12-10 18:30:51.255647
681baef6-107e-48e2-9315-1ba444619671	eb46fe18-5c1f-4b32-9071-63daa3da0e28	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	5500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.255978	2025-12-10 18:30:51.255978
9577f6ce-e34f-4302-9403-d91f2d4dd008	26de4eaa-09f2-4943-ab51-f32f20f48e25	X	{"X": {"count": 1}}	300.00	250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.256271	2025-12-10 18:30:51.256271
ffe47648-b270-4361-835f-97555a4e23b7	aeaafa1a-e889-432d-88f9-096455b63aeb	Buy signal	{"B": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.256542	2025-12-10 18:30:51.256542
f7e939ec-770b-4b91-8045-9f2d3e06cf52	6cca21a7-d9b0-4c72-8743-d0c4d18861ae	Youtube	{"Y": {"count": 1}}	520.00	450.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.256809	2025-12-10 18:30:51.256809
cca1daed-4f75-4b6b-ad1d-2720f5d91596	66a68c02-2321-453b-bd50-79ff47082a9c	Buy signal	{"B": {"count": 1}}	5625.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.257092	2025-12-10 18:30:51.257092
b8ad8755-7463-4d59-a258-5c6c8b8fc720	6c5a4dc5-d1d6-422f-bfc7-ee145ea2680a	Tiktok	{"T": {"count": 1}}	5500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.257541	2025-12-10 18:30:51.257541
584ee237-a817-4fe1-a811-8c960490ac51	849504e9-4b12-4f8c-946e-21eca7000980	X	{"X": {"count": 1}}	650.00	600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.257846	2025-12-10 18:30:51.257846
09c08d65-fb61-4c56-ba78-770635e4c8b3	eca2971b-5e27-40bd-adec-2098a19fb964	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.258199	2025-12-10 18:30:51.258199
f750a7f7-4c60-459b-9e29-8f42f27bfdf2	a3d597ea-4118-46ad-bd41-49950351a7f5	X	{"X": {"count": 1}}	19250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.258456	2025-12-10 18:30:51.258456
36d8a904-ef32-4ff4-98aa-6f26dd2ed845	a3d597ea-4118-46ad-bd41-49950351a7f5	Youtube integration	{"Y": {"count": 1}}	39375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.258781	2025-12-10 18:30:51.258781
9b0569e9-524b-4ccf-bbf4-9e3137005d1c	fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	IG Story	{"I": {"count": 1}}	6820.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.259056	2025-12-10 18:30:51.259056
97f4c639-e3d3-46ca-9493-8d196ee5699f	fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	Tiktok	{"T": {"count": 1}}	6820.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.259385	2025-12-10 18:30:51.259385
5c2393ed-7a3b-46ef-840f-0a022b6519f5	654a9fd7-e1fa-4ade-938c-dc90713e4f35	X	{"X": {"count": 1}}	600.00	550.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.259822	2025-12-10 18:30:51.259822
900aab74-4d63-447d-96ac-885bc7a86d75	74cc7c04-8bd1-4dd4-84f8-5a0720a3244a	Telegram	{"T": {"count": 1}}	805.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.260309	2025-12-10 18:30:51.260309
6c3a926d-9cf4-4900-b7ff-9ca5590058b9	f3a3819e-212b-4aeb-a8fe-779243323abe	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	7000.00	6500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.260759	2025-12-10 18:30:51.260759
7b4d8726-7d58-436a-8eb5-bd96044b4026	d725e61f-ad5f-48e3-898f-c363c3346fc8	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.261209	2025-12-10 18:30:51.261209
c52c4fc6-77b7-489f-b548-b495e9545d08	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	Youtube integration	{"Y": {"count": 1}}	15750.00	14000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.261672	2025-12-10 18:30:51.261672
1701b417-f28a-4b20-8313-36725eaa3ec8	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	Youtube integration	{"Y": {"count": 1}}	4700.00	4000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.262065	2025-12-10 18:30:51.262065
baaec213-70f6-47e0-b9c0-4b3f30abcfaf	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	Youtube	{"Y": {"count": 1}}	9400.00	8000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.262487	2025-12-10 18:30:51.262487
376f350b-9b6b-42ec-9682-d97b4f8466aa	31288d3a-60ff-4355-b0cc-22c27c795888	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.262894	2025-12-10 18:30:51.262894
249072f7-d1ef-454f-a12e-c85adedbfc2f	5747fab8-f04b-4ede-8a94-d17c74d00bfd	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.263311	2025-12-10 18:30:51.263311
6ecb2d8b-fbc9-43cd-bcf0-1250c3617e84	5747fab8-f04b-4ede-8a94-d17c74d00bfd	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.263736	2025-12-10 18:30:51.263736
6b0e75d3-0406-4b31-ab6f-169a414f9f70	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	3000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.264135	2025-12-10 18:30:51.264135
0c888cc1-76af-492e-91d7-efb1a553d555	40331030-31cb-4391-913b-acd387389679	X	{"X": {"count": 1}}	1760.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.264482	2025-12-10 18:30:51.264482
e173aadb-ce5a-41e4-86d7-3b6901cffd85	ea1ad626-2645-444d-ab29-4baedb9de705	Youtube	{"Y": {"count": 1}}	1725.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.264804	2025-12-10 18:30:51.264804
8ea3607a-ebd9-45c2-9f51-6425b046d142	9467920b-47ff-4786-ab2d-ba71bedb4520	X	{"X": {"count": 1}}	450.00	400.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.265068	2025-12-10 18:30:51.265068
1addd589-635e-474e-9f38-2c36cc9bf406	af71200b-6946-49bc-a2aa-6ad36368b8cf	Youtube integration	{"Y": {"count": 1}}	5875.00	5000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.265541	2025-12-10 18:30:51.265541
85703e6c-7e52-4e8e-8d19-32804949e730	b91bc33b-adf3-462c-975e-4c9bc4dbef2a	Telegram	{"T": {"count": 1}}	1015.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.265824	2025-12-10 18:30:51.265824
ad1534a6-6675-48d4-b58a-9f3ecc9279cf	1a75ba2a-e021-4c3e-b068-c55029a8a923	IG Story, IG Post	{"I": {"count": 1}}	990.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.266162	2025-12-10 18:30:51.266162
9015f4da-4b91-47d0-bc43-e9f63de661da	449eb148-3918-483d-ad31-078456bbfddc	Youtube	{"Y": {"count": 1}}	920.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.266469	2025-12-10 18:30:51.266469
4ed1612e-a7ad-456f-b599-1ba28de87ce1	5148040d-6f90-461f-a2f6-adeea2c0515d	Telegram	{"T": {"count": 1}}	2070.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.266774	2025-12-10 18:30:51.266774
94e178f5-2d57-4d06-a1d8-f943c11ff238	2472142d-690e-4406-b8af-eea74d1afa6f	X, Telegram, Youtube	{"T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	27500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.267034	2025-12-10 18:30:51.267034
fd071838-2cc1-4bb1-9bf0-cb8facda35b5	c432674b-3697-4c92-9698-61ef46eedbe7	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.267278	2025-12-10 18:30:51.267278
c2505126-d1c8-4219-9099-86e19b76dd60	c432674b-3697-4c92-9698-61ef46eedbe7	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	7700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.267525	2025-12-10 18:30:51.267525
230e1e58-7da2-4623-a1bf-4156cb9a8439	4169437c-a5e3-43a4-9f74-91d4396c859b	Youtube	{"Y": {"count": 1}}	11250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.26784	2025-12-10 18:30:51.26784
eefd20c4-28fa-4dc2-92c3-a63817a1d4bd	4169437c-a5e3-43a4-9f74-91d4396c859b	Youtube integration	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.268142	2025-12-10 18:30:51.268142
44ad03c0-363e-41cd-984b-3e9c0afe74ed	b36c6d5b-3cfd-4b76-8af1-93d565960d54	IG Story	{"I": {"count": 1}}	430.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.268439	2025-12-10 18:30:51.268439
de274a63-b58a-49b7-8bc1-34af5c35a790	6fe10761-049b-40f7-abae-2fd5d58abb50	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.268742	2025-12-10 18:30:51.268742
fcf2baa2-60f7-4f0b-a3c5-0a53b403f69d	a8e73e8b-e412-4d9b-971d-1bfb59309abb	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.269036	2025-12-10 18:30:51.269036
d5c97040-9223-47af-9040-f849f0b5ab91	efae8184-423d-41e4-9557-7aa10924710b	Buy signal, X	{"B": {"count": 1}, "X": {"count": 1}}	2900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.26947	2025-12-10 18:30:51.26947
95fa38dc-0631-4c6d-a3c3-7c78c0ecc641	8bdb3443-0b3c-4c0e-af70-8d5445637c2d	Youtube integration	{"Y": {"count": 1}}	6750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.269805	2025-12-10 18:30:51.269805
d1f95f3d-6bd3-4624-886c-8c2b9d71506f	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	X	{"X": {"count": 1}}	600.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.270144	2025-12-10 18:30:51.270144
1a1af82e-0daf-49e2-9255-d2aade77caba	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	1900.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.270488	2025-12-10 18:30:51.270488
c12cea69-3d1c-4e50-b581-6b9351e9101c	bd49d3d2-b6d9-435d-8e51-70b36eb92d79	Youtube, Youtube integration	{"Y": {"count": 1}}	14850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.270947	2025-12-10 18:30:51.270947
379ca7c0-2618-4f5e-89ee-149580d056c7	899cfad6-04d0-442d-bfd0-cb91e18ae0d0	Buy signal	{"B": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.271282	2025-12-10 18:30:51.271282
d0a4534a-06a2-4a46-a690-1de06db45a98	e1520e20-6b49-4942-a5bf-17db15a8b993	Youtube	{"Y": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.271627	2025-12-10 18:30:51.271627
1f231669-b22b-4308-ba52-2b924b78b72f	7a267af5-6c9a-46e4-b7b6-b16612eba675	Youtube	{"Y": {"count": 1}}	3600.00	3250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.271995	2025-12-10 18:30:51.271995
d188ee01-b9ac-44a3-8fe0-6ce80a6a815a	7a267af5-6c9a-46e4-b7b6-b16612eba675	Youtube	{"Y": {"count": 1}}	3500.00	3250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.272383	2025-12-10 18:30:51.272383
d4833ef2-79a1-4aa2-95ca-5910d193bc30	7a267af5-6c9a-46e4-b7b6-b16612eba675	Youtube	{"Y": {"count": 1}}	2890.00	2550.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.272736	2025-12-10 18:30:51.272736
64a907a1-d367-4ec1-a18d-6b767f84c271	6f727607-1ad4-46cb-af3d-3a91fbb0eccf	X	{"X": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.273055	2025-12-10 18:30:51.273055
ea01d62a-7980-4905-8674-0b587c5e6c19	be5f976b-114d-4308-8242-52d14f4e9aa6	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	690.00	550.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.273367	2025-12-10 18:30:51.273367
8dabb095-91cf-43c1-9aff-64a0d8117ab3	be5f976b-114d-4308-8242-52d14f4e9aa6	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	6000.00	5000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.273686	2025-12-10 18:30:51.273686
27dc4786-0757-4f9d-a921-dd731406e247	ac955c91-0b4f-4e7b-97e3-6d29389cf196	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	5200.00	4500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.27398	2025-12-10 18:30:51.27398
b63e1723-d9f4-4c61-a5b2-6f0406c9530b	6ffa6051-8a12-4c47-9b02-0eac4e5a3cb0	IG Story	{"I": {"count": 1}}	660.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.274262	2025-12-10 18:30:51.274262
3707a5d3-79a4-412f-9037-4927ba398235	b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	Youtube	{"Y": {"count": 1}}	1100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.274784	2025-12-10 18:30:51.274784
46f4512b-86d3-4571-a9ab-fd30d303a3f0	a34840e0-3c85-4209-94b7-445658014577	X	{"X": {"count": 1}}	4950.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.275143	2025-12-10 18:30:51.275143
ce07f250-3749-4116-91bd-616afa08a840	a34840e0-3c85-4209-94b7-445658014577	Youtube integration	{"Y": {"count": 1}}	7700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.275451	2025-12-10 18:30:51.275451
99cb0c12-8f89-44cf-98ce-cbda87453b45	a34840e0-3c85-4209-94b7-445658014577	Youtube	{"Y": {"count": 1}}	17300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.275756	2025-12-10 18:30:51.275756
26ea8c8c-c01f-43cd-9bd2-fd7d8cd6f357	aa54bc98-4f39-4229-9084-5e1c992c4b96	Youtube, X, Telegram	{"T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.276048	2025-12-10 18:30:51.276048
5e2146d8-ee1d-4217-9371-edba2ce9058a	e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	Youtube	{"Y": {"count": 1}}	29375.00	25000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.27635	2025-12-10 18:30:51.27635
cc96874f-8da2-461c-ad5a-1ab512699218	e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	Youtube integration	{"Y": {"count": 1}}	10105.00	8600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.276689	2025-12-10 18:30:51.276689
8efaef94-8006-4b48-9be7-cc7f108c7f0c	7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	Youtube	{"Y": {"count": 1}}	920.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.277233	2025-12-10 18:30:51.277233
8028e0d8-d622-49fb-b6eb-b9b3fba63c88	e9c3d54a-a260-442a-a346-7dff417300c0	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.277986	2025-12-10 18:30:51.277986
0446b267-d00c-4206-ac48-3a14a7219889	cfeb2b0f-270b-407f-a625-bd46c0b9b0e0	Telegram	{"T": {"count": 1}}	1015.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.2787	2025-12-10 18:30:51.2787
c94e2e45-b6bd-4c9d-8bfc-1f225cff6562	6d581354-2a55-4133-bdb6-58087f38dbe6	Youtube	{"Y": {"count": 1}}	3000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.278997	2025-12-10 18:30:51.278997
2cd24d41-02e2-4f4d-9684-50ded4e758f9	6d581354-2a55-4133-bdb6-58087f38dbe6	Youtube integration	{"Y": {"count": 1}}	6500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.279268	2025-12-10 18:30:51.279268
292c19f1-0f09-4d2a-a9a8-e4e631fbde18	67f81b56-5b58-4fc0-b955-31f44ccb0135	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.279607	2025-12-10 18:30:51.279607
1792d967-b2d9-43a0-af8b-9a8b43182b4a	9272a0a5-0def-403f-8dad-475fa62fdc71	Youtube	{"Y": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.279939	2025-12-10 18:30:51.279939
313bfd0e-4b19-4a1b-a842-521e55e18e32	30d9c8ad-0e04-428f-8fd2-576ca87228c8	IG Story	{"I": {"count": 1}}	11550.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.280235	2025-12-10 18:30:51.280235
23e2c354-ccaf-4bb3-91e7-716637c25c38	30d9c8ad-0e04-428f-8fd2-576ca87228c8	Tiktok, IG Reels	{"I": {"count": 1}, "T": {"count": 1}}	13200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.280526	2025-12-10 18:30:51.280526
632c2a91-71da-49e9-aaae-4f6aeede2231	8bb3e252-e66b-4477-a145-8b03c028805d	X	{"X": {"count": 1}}	680.00	600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.280836	2025-12-10 18:30:51.280836
2d0d99de-e510-46f3-a960-bba39b79d811	df663153-02e1-4bf6-8f3b-ac3efeefdb48	X	{"X": {"count": 1}}	800.00	800.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.281164	2025-12-10 18:30:51.281164
8f678251-f548-4968-b050-3eaa01fad334	c3bc5eaa-f1f4-4426-937c-d9b713c9fd16	IG Reels, IG Story	{"I": {"count": 1}}	825.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.281502	2025-12-10 18:30:51.281502
1bc55b93-8eaa-4d4c-9a49-d05094260b9c	e9e3fb40-6e36-48d9-918a-25cb5975cf0b	IG Story	{"I": {"count": 1}}	770.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.281888	2025-12-10 18:30:51.281888
d996053c-21fa-4044-a590-042412e69fa7	33991c64-7e13-4231-86c2-db7afbf10414	Telegram	{"T": {"count": 1}}	1015.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.282247	2025-12-10 18:30:51.282247
8da81f14-86aa-4bfa-9a8e-2c53003247c4	05d4763c-6190-4df5-b97f-e60500a9df99	Telegram, X, Youtube	{"T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	33000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.282543	2025-12-10 18:30:51.282543
82db24c7-148f-4e5d-a08d-daa4f73d1ee0	54848923-af3c-4528-a36f-b86babd69225	Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}}	1500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.282836	2025-12-10 18:30:51.282836
b44a0073-beca-467d-8ac1-d612bf7aecaa	b2e93254-185e-4547-a363-eb5a99078141	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	60000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.28315	2025-12-10 18:30:51.28315
c9e37bc2-5790-4568-a27e-4ba79a495813	822c81af-c1b5-4493-b0a8-55ff0fdbbfee	Youtube integration	{"Y": {"count": 1}}	2350.00	2000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.283429	2025-12-10 18:30:51.283429
790df4dd-3b3e-431c-ba42-7af454b7b6c0	15520237-b54c-4912-abf0-f29c1499181d	X	{"X": {"count": 1}}	300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.28371	2025-12-10 18:30:51.28371
047dc512-2102-4f88-8313-c0c9df21716d	47abda88-d904-4402-8257-1e88c0ff6ef5	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	7300.00	6500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.283987	2025-12-10 18:30:51.283987
f71fe9de-cd6e-43e8-b182-26b8e07a998d	3c0e3bbc-66d9-4333-ad39-961ae3d102b7	Tiktok	{"T": {"count": 1}}	3080.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.284279	2025-12-10 18:30:51.284279
19ea39ae-ec7e-44cc-8e38-9ef28f83936b	a8dd7f18-3436-471c-a958-69575f764986	IG Story, IG Post	{"I": {"count": 1}}	495.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.284744	2025-12-10 18:30:51.284744
36d9257d-8296-4f97-a311-3bed3b7db67b	1fec272f-7562-488b-9ec9-eff4656dcabe	X	{"X": {"count": 1}}	360.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.285026	2025-12-10 18:30:51.285026
221ef079-5fa4-4c4d-a55e-bdbe4d633008	e484f6a3-69db-421b-983a-004a7555a023	Youtube	{"Y": {"count": 1}}	1300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.285263	2025-12-10 18:30:51.285263
8cfa88e4-e327-42c7-8f2f-01efe8408bbe	d242154c-41ac-4bea-b101-f4fe9eac41a2	Buy signal	{"B": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.285562	2025-12-10 18:30:51.285562
ef5b616c-1ffa-471e-b315-17ccd28a2619	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	Youtube integration	{"Y": {"count": 1}}	4110.00	3500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.285821	2025-12-10 18:30:51.285821
be4755fb-e71d-4bee-a8fc-53fc6f8d743e	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	Youtube	{"Y": {"count": 1}}	8225.00	7000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.286107	2025-12-10 18:30:51.286107
be539ef0-793c-4dda-b1a5-291c56c61f62	277f9203-92c7-4a39-809d-e81eee5e5637	Youtube	{"Y": {"count": 1}}	35500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.286338	2025-12-10 18:30:51.286338
6cf2c5b3-bb45-4ffa-861a-888bcd6e17f4	277f9203-92c7-4a39-809d-e81eee5e5637	Youtube integration	{"Y": {"count": 1}}	10700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.286579	2025-12-10 18:30:51.286579
cb869d90-e076-455e-a0a4-a9f195808fe8	c5942cef-4b45-44ae-bd78-d60f38a052b5	Tiktok, Instagram	{"I": {"count": 1}, "T": {"count": 1}}	12650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.286835	2025-12-10 18:30:51.286835
3ab33577-9186-4180-8f23-e250e20200fc	9d82b44c-4a01-4adc-a2b7-de0f341cb15b	Telegram	{"T": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.287087	2025-12-10 18:30:51.287087
a1ffccbf-e93b-446c-8e62-9d0c9e6927cd	4d33ea45-8f4e-4a4d-a09b-ba34b57ba3e9	Tiktok	{"T": {"count": 1}}	1870.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.287343	2025-12-10 18:30:51.287343
a9148bd8-e7ae-436e-b3cf-f44d57b1eb4d	b462869e-5bc0-4ff4-ada6-6944092d9e59	Youtube integration, X	{"X": {"count": 1}, "Y": {"count": 1}}	21450.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.287677	2025-12-10 18:30:51.287677
361cc0c7-fc67-4ecf-a4e8-52b87c34d4a4	5e24b43b-f14f-4683-96ff-4801f37d2bfa	Telegram	{"T": {"count": 1}}	1035.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.287979	2025-12-10 18:30:51.287979
46b58338-3d64-4a8c-a169-2d18976d2c8a	ed06996e-4ff3-4e67-ace1-49001541cd54	Telegram	{"T": {"count": 1}}	1100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.288231	2025-12-10 18:30:51.288231
7cde8757-a977-46ac-8e87-e0ee4601f276	0bf4c131-d69b-4b4b-af65-b795960d06f7	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	5520.00	5250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.288498	2025-12-10 18:30:51.288498
2e94f0c8-8333-433a-89a0-3385771f428d	003b2d41-7de0-4eec-8fe2-17374ae91d58	X	{"X": {"count": 1}}	1100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.288807	2025-12-10 18:30:51.288807
71074e57-fceb-4946-8c6f-526e682928a6	003b2d41-7de0-4eec-8fe2-17374ae91d58	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	4200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.28908	2025-12-10 18:30:51.28908
bd000646-ac05-42dc-a799-a43cb3917051	6cd89218-572e-48b8-9073-39f9b8b25381	Telegram	{"T": {"count": 1}}	2600.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.289341	2025-12-10 18:30:51.289341
6cc4ebd9-0d6f-4d10-8268-f14d4717efbb	449d6043-e4a5-4cb7-882d-6523c4fa5319	X	{"X": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.289801	2025-12-10 18:30:51.289801
7136490f-2383-4dc5-9954-d2730151f0e0	449d6043-e4a5-4cb7-882d-6523c4fa5319	X	{"X": {"count": 1}}	33450.00	28500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.290432	2025-12-10 18:30:51.290432
1f020add-73b7-4ce7-a57c-0ad2709dfca9	80e338f3-e4dc-4b08-bef3-ccfd3cecd922	Youtube	{"Y": {"count": 1}}	620.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.291111	2025-12-10 18:30:51.291111
05728039-5f0d-4e9e-a7b4-46ad0ac77b9e	80e338f3-e4dc-4b08-bef3-ccfd3cecd922	Youtube integration	{"Y": {"count": 1}}	1000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.291553	2025-12-10 18:30:51.291553
99812223-ba27-4591-915e-e078d0a71ca1	e0f32a2f-a1b6-4bce-9a48-3407f24062a5	Youtube	{"Y": {"count": 1}}	345.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.291918	2025-12-10 18:30:51.291918
626906f1-7550-4c4d-8a4d-344e136733d8	2a9688a8-1ddf-4b40-9b13-4eebdd046e59	Youtube integration	{"Y": {"count": 1}}	19250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.292252	2025-12-10 18:30:51.292252
445510a8-5c14-4679-815f-6948cda3edf4	53dc91bc-b3ca-4daa-8068-3bae75b63cd3	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	6460.00	5500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.29253	2025-12-10 18:30:51.29253
dcfd612f-ebac-448a-82a3-a7ef31edcebd	a116e420-674e-4867-b4b7-0bfdd644559b	IG Reels	{"I": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.292822	2025-12-10 18:30:51.292822
7464dda8-e76a-4d50-8b4d-b018c0132381	fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	5700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.293098	2025-12-10 18:30:51.293098
53fb8bdf-bff8-4591-8ad8-73279aaacd6e	281f97e5-14e2-4a93-80af-80e0ed98bcff	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.293518	2025-12-10 18:30:51.293518
27dec446-0d7b-46d5-8bd2-877da7ac6112	281f97e5-14e2-4a93-80af-80e0ed98bcff	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	1800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.293854	2025-12-10 18:30:51.293854
43a482cb-06e7-4da4-a51b-cdd92a8e3957	63b322f6-5f56-40d3-bf84-bbace6c2c8a5	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.294094	2025-12-10 18:30:51.294094
fd249714-5b84-4f57-9308-a39a9cea0ef1	9836277c-c853-4951-a303-f6bac411c107	Tiktok	{"T": {"count": 1}}	1760.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.294411	2025-12-10 18:30:51.294411
1e4703db-c9c7-41a6-9259-29010f99a5fd	f65cc96b-2042-4141-93d9-5b96d83bf05b	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.294856	2025-12-10 18:30:51.294856
f26f615d-d220-4bf9-8d2d-123e400d1350	bdae4eec-4bf0-4c0d-8e4a-bbf8e8ec525c	Youtube	{"Y": {"count": 1}}	7000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.295109	2025-12-10 18:30:51.295109
f1504994-98cc-4dfd-a345-c16132d00d57	7dcf839d-4ab8-4b3a-ac69-4c87f94b234a	Telegram	{"T": {"count": 1}}	750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.295343	2025-12-10 18:30:51.295343
0f52e7de-c20a-475a-a5f9-0d0073b3813c	98c97607-b8f8-4115-8bbf-a389eefb9298	Youtube	{"Y": {"count": 1}}	3750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.295579	2025-12-10 18:30:51.295579
f0914d97-b4d2-48a8-bb55-44bd7d44eecc	98c97607-b8f8-4115-8bbf-a389eefb9298	Youtube integration	{"Y": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.295812	2025-12-10 18:30:51.295812
9416a7ec-4d2b-4ede-96a0-fffe9ae0e9e1	186b1700-46b2-4e9f-b961-5f86f5efbfc1	X	{"X": {"count": 1}}	8900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.296052	2025-12-10 18:30:51.296052
e7f88ad6-ca2e-4b7c-b2b8-eb3fb142baab	e6ef5e56-45a6-4c7c-a540-afc90b193143	X	{"X": {"count": 1}}	2750.00	1750.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.296287	2025-12-10 18:30:51.296287
a2e1458b-b570-4c87-873c-12c0e2709a47	c6fb0205-1405-4198-940d-5c075949c13e	X	{"X": {"count": 1}}	520.00	400.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak,emirle eskiden calısıldıgı ve emirin yeni sirketinin magnor oldugundan bahsedilecek	\N	t	\N	\N	\N	2025-12-10 18:30:51.296528	2025-12-10 18:30:51.296528
1d3a8f47-e225-4e2a-8db8-a057cca36c0a	e8e5e669-74a7-494e-b464-afbc843bb0bf	Telegram	{"T": {"count": 1}}	1575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.296769	2025-12-10 18:30:51.296769
43015293-9e69-49a5-9d40-b46c001a0b40	81ea2a69-5998-4f99-9bef-ee4f79e2ed7d	Youtube integration	{"Y": {"count": 1}}	3650.00	3250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.297005	2025-12-10 18:30:51.297005
040f99a0-0ccf-4ffa-90d6-fcb06fd100bb	ba69463e-a9d1-4935-9596-b00294a5234a	IG Story	{"I": {"count": 1}}	495.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.29725	2025-12-10 18:30:51.29725
29c2b068-0a58-49d8-9cac-a429b4eef067	3950674f-2bc5-4911-bf0a-53ae0ba48d8c	X	{"X": {"count": 1}}	5800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.297483	2025-12-10 18:30:51.297483
f93354f8-085a-40d8-948b-f2d251257dc0	f09eb623-3bbd-4771-b853-aef41da517ed	Youtube	{"Y": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.297726	2025-12-10 18:30:51.297726
1b7ab76a-6488-4e9a-8ff2-83afe3f532a2	d8fd8b3f-5e45-4e37-8a50-85bcbf23efd4	Youtube	{"Y": {"count": 1}}	3500.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.297977	2025-12-10 18:30:51.297977
60b8edc4-b7bd-469b-8cf1-968445fb6cb5	a23d2de8-9182-49d0-8390-0892a0d120ac	Youtube	{"Y": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.29822	2025-12-10 18:30:51.29822
f2e45c1b-96af-4c9f-b555-ebc0b908687e	d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	Buy signal	{"B": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.29847	2025-12-10 18:30:51.29847
412aef6b-438f-46d1-abaf-a7b67401a30e	3c1350c6-7f72-4592-a6c7-8bf2953f02ad	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.298761	2025-12-10 18:30:51.298761
b25cce33-ceac-4203-ba41-d11495a3af46	fe992cec-9283-4d0e-b054-aac3273b2ea5	Youtube	{"Y": {"count": 1}}	2940.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.299023	2025-12-10 18:30:51.299023
3fdac7fa-eaab-487b-8168-15aa0a03191e	fe992cec-9283-4d0e-b054-aac3273b2ea5	Youtube integration	{"Y": {"count": 1}}	1760.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.2993	2025-12-10 18:30:51.2993
0e637f0d-939b-423b-b70f-01a09cf1665c	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.29966	2025-12-10 18:30:51.29966
37cac4e0-0103-4fcb-888c-2d33419be582	b40da33a-f72b-468b-9886-5aa16aea65d7	Youtube integration	{"Y": {"count": 1}}	4400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.299922	2025-12-10 18:30:51.299922
59bff5d6-bd23-41ad-aaa6-d84907b8eb46	7d370edc-909f-498d-ae21-6bc2ccfb00b1	IG Story	{"I": {"count": 1}}	550.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.300197	2025-12-10 18:30:51.300197
27a5c9fd-870e-49b4-ae68-5b9c4bfbaee2	80ff1ea3-3187-45a8-8abf-a065791af2aa	Telegram	{"T": {"count": 1}}	1240.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.300519	2025-12-10 18:30:51.300519
3552cdb7-977b-4575-8d14-18abe2dd2067	8ea77d03-8233-49e8-b39b-262daada91aa	X	{"X": {"count": 1}}	400.00	350.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.300802	2025-12-10 18:30:51.300802
53ae95d4-2319-4e81-8e67-c138da312ace	888cbfe3-9c4b-4456-9d33-f72e0d002456	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.301113	2025-12-10 18:30:51.301113
be39c99b-f80f-4994-ad51-0299206628b9	87057b00-a0b9-436f-a9d3-fc7794a4acac	IG Story	{"I": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.301434	2025-12-10 18:30:51.301434
438cc789-f9b0-4760-9a31-ce5d23efd46e	87057b00-a0b9-436f-a9d3-fc7794a4acac	Tiktok	{"T": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.301805	2025-12-10 18:30:51.301805
087aa677-bbea-4e79-9f36-641dde934cbf	629cbe03-cc05-414c-a94f-5f89f9741208	Youtube	{"Y": {"count": 1}}	7875.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.301986	2025-12-10 18:30:51.301986
1cda486b-386c-45bd-b8a7-f1cfd9632efd	629cbe03-cc05-414c-a94f-5f89f9741208	Youtube integration	{"Y": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.302196	2025-12-10 18:30:51.302196
64024ef4-3960-4a9e-8872-0ca9a3cd41b1	7daebce3-f985-446e-892b-ce680f7811bb	Youtube	{"Y": {"count": 1}}	3715.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.302401	2025-12-10 18:30:51.302401
210acc63-2e83-4572-a062-b4da622e3f03	d3d42031-99ef-4704-b5cc-837a302fbc45	Tiktok	{"T": {"count": 1}}	3850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.302604	2025-12-10 18:30:51.302604
2b60e512-1f8b-4451-a389-a574cd524a72	b1ce0761-75e7-4bfc-970c-39c63c15beae	IG Reels	{"I": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.302784	2025-12-10 18:30:51.302784
7db45fe7-f7b7-468d-a837-5c543ad48a2b	23a054f8-f81e-414c-bb6a-eb295bc619a6	X	{"X": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.302944	2025-12-10 18:30:51.302944
f0310b53-17ac-41cc-9c9c-8d547aff367b	56bb5d62-6d41-462b-9f29-6f224d84763d	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	16000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303129	2025-12-10 18:30:51.303129
2ebe17ca-8af6-45fb-86fb-8026cf2a7039	d72e298a-d2f6-45c3-8b09-7e0294eabf5e	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	20000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303308	2025-12-10 18:30:51.303308
f4376bff-6f13-4a21-93e4-e92241b6dd1f	6bdf87ef-ce76-411c-b0a9-3f2f7e312d18	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303476	2025-12-10 18:30:51.303476
760f9dbb-d557-472e-bed6-6c76679a253e	df953e7c-659b-401e-a906-7b25f29fca41	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303644	2025-12-10 18:30:51.303644
375d33ed-bcc4-4f6a-bb2a-434e1fd20f81	a3101525-7901-4a34-a80c-0fe955903e17	IG Reels	{"I": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303807	2025-12-10 18:30:51.303807
94c24184-ca6c-4ddb-816a-97c2fee9a601	d266b55c-cef1-451f-a3ce-4b71e887543e	Youtube	{"Y": {"count": 1}}	15400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.303985	2025-12-10 18:30:51.303985
6f5eabb6-0210-4c96-a0d6-aed78509a391	88615501-f3e3-434c-bbff-9d5178d9274c	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1500.00	1250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.304147	2025-12-10 18:30:51.304147
20f1740e-730b-4b9f-a228-d591bd4c47ee	88615501-f3e3-434c-bbff-9d5178d9274c	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	6325.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.304321	2025-12-10 18:30:51.304321
5d8b7692-6b16-4aec-96f9-2000811697c2	6c8989e0-27f3-4dea-9c9a-ea3d720bef74	Youtube integration	{"Y": {"count": 1}}	3500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.304636	2025-12-10 18:30:51.304636
7604014e-1005-4e61-b0c2-df5185c30d28	6c8989e0-27f3-4dea-9c9a-ea3d720bef74	Youtube	{"Y": {"count": 1}}	5000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.304826	2025-12-10 18:30:51.304826
4d81e67c-0b92-4156-8bcb-0c105c037db2	60a1caed-204b-423a-818a-476d229e4c56	X Thread	{"X": {"count": 1}}	1760.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.305014	2025-12-10 18:30:51.305014
a83cc7ec-a5d8-419a-878d-648dfd1b56e2	60a1caed-204b-423a-818a-476d229e4c56	X	{"X": {"count": 1}}	760.00	650.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.305188	2025-12-10 18:30:51.305188
7b87a575-2ea4-4451-82f2-be10f387b9fc	60a1caed-204b-423a-818a-476d229e4c56	X	{"X": {"count": 1}}	470.00	400.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.305383	2025-12-10 18:30:51.305383
e3d437f2-a3aa-459b-973b-eee38043223c	13fe3906-7dbc-4eca-a595-90b86ce38b10	Youtube	{"Y": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.30555	2025-12-10 18:30:51.30555
e427c087-47c8-43a7-9ced-afce9356c12f	3909bc10-7b63-4f58-b952-b07cb94f25fa	Youtube integration	{"Y": {"count": 1}}	2925.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.30572	2025-12-10 18:30:51.30572
c3322c73-8f59-4e36-8236-6b72b987f1f7	3909bc10-7b63-4f58-b952-b07cb94f25fa	Youtube	{"Y": {"count": 1}}	5625.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.305885	2025-12-10 18:30:51.305885
aed3c165-0c81-473b-b5d7-9940e3a4fcdf	febfc4b3-6c2f-4353-9059-2639e24ffec6	X	{"X": {"count": 1}}	1270.00	1000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.306058	2025-12-10 18:30:51.306058
109b0bc1-c753-4007-aae3-2600c199e140	e90ebec3-3bc2-49b1-8548-173d50dd8873	X	{"X": {"count": 1}}	6325.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.30622	2025-12-10 18:30:51.30622
6ecd49c2-d909-44d5-bbaa-836d597d071c	87d1c881-208d-42f3-9d46-76b2c427bae3	Youtube	{"Y": {"count": 1}}	1170.00	1000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.306379	2025-12-10 18:30:51.306379
43b04639-9d84-46c2-9597-3952b99b01d6	87d1c881-208d-42f3-9d46-76b2c427bae3	Youtube	{"Y": {"count": 1}}	785.00	700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.306551	2025-12-10 18:30:51.306551
0f9cde56-de5d-4eb5-a3c3-dca0f1a7a646	a7c0391f-039f-4893-9fed-342636e2c31a	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.306721	2025-12-10 18:30:51.306721
d8ab0932-058a-4248-bf95-4b6f2860b033	2f3b4d72-0a9a-49e2-8985-50c9d816da4c	X	{"X": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.306881	2025-12-10 18:30:51.306881
18c43560-0108-433a-8680-addde3dfd9a2	8f9f112d-f597-4978-90fc-5906ccff773b	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	9900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307064	2025-12-10 18:30:51.307064
06656a5e-66d4-45f4-9a13-ef061d04b66d	34fd25ca-654a-4bed-b5e3-087641ff1da4	X	{"X": {"count": 1}}	800.00	700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307248	2025-12-10 18:30:51.307248
44d0157c-f6bf-4257-8583-98268e1f7deb	84e5e479-8261-4a7c-a14d-08ba739fda95	X	{"X": {"count": 1}}	1440.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307419	2025-12-10 18:30:51.307419
c8ce1244-f94c-4bc3-8ef3-d281ce39a2ef	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Youtube integration	{"Y": {"count": 1}}	6750.00	6000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307573	2025-12-10 18:30:51.307573
3583361b-b51d-4b7e-9c57-8fec877fdbe3	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Youtube integration	{"Y": {"count": 1}}	13000.00	11500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307741	2025-12-10 18:30:51.307741
98ca243e-d488-44e7-9057-01027190670f	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Youtube	{"Y": {"count": 1}}	19125.00	17000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.307914	2025-12-10 18:30:51.307914
d736417b-4584-4108-a2be-a601ca2a25eb	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	X	{"X": {"count": 1}}	1380.00	1200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.308095	2025-12-10 18:30:51.308095
3cc9d7ea-118e-41d5-90f2-acacbe68b849	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	X Quote	{"X": {"count": 1}}	1350.00	1200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.308267	2025-12-10 18:30:51.308267
6827b773-77c8-4119-a565-76ef5006d63d	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Giveaway	{"G": {"count": 1}}	2800.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.308451	2025-12-10 18:30:51.308451
43c9a930-8fb2-4ba4-a35c-4e5b3e1cb697	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Telegram	{"T": {"count": 1}}	2800.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.308842	2025-12-10 18:30:51.308842
bfadd325-9367-4c09-bf38-b416e48a2d91	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Youtube, Youtube integration, X	{"X": {"count": 1}, "Y": {"count": 1}}	22500.00	20000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.309022	2025-12-10 18:30:51.309022
cdbc2167-db54-4694-a5ef-e4836e42666d	43794457-3218-4378-8092-8391571c3ff3	X	{"X": {"count": 1}}	1800.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.309213	2025-12-10 18:30:51.309213
e4be9240-fa1b-4f80-969b-bb257801dd4e	564e6fa2-cbf8-48b7-ba16-8afeeeb36783	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.30943	2025-12-10 18:30:51.30943
aa14b113-6182-4811-b70b-3f1a1cf1c50b	1ce65635-3d69-4b87-897d-1b42d241b66e	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	27000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.309686	2025-12-10 18:30:51.309686
4987e823-6f39-45b0-be50-5a79dbdf8627	d26ca139-43ec-4a9e-8978-775e1e824d24	Youtube	{"Y": {"count": 1}}	2875.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.30987	2025-12-10 18:30:51.30987
b6391d9c-aec1-4723-860b-a1888eaf40d9	711d739c-10ed-450c-80de-baace6f715fb	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.310122	2025-12-10 18:30:51.310122
a85b3c0d-4599-430b-b5dc-e09d4d9f9467	38a50ecf-a0c9-4789-afff-10c9c04312fc	X	{"X": {"count": 1}}	775.00	700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.310363	2025-12-10 18:30:51.310363
d394d074-bb3d-49e6-a282-21cd016f341d	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	X	{"X": {"count": 1}}	490.00	400.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.310572	2025-12-10 18:30:51.310572
072e067f-cb67-467f-934c-66208ddd02b1	a2cb2258-fdb6-4ece-a4e5-68d41668da04	IG Story, IG Post	{"I": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.310779	2025-12-10 18:30:51.310779
69070218-df36-42f1-af20-3ce919872140	ae6b7c13-ad5d-44e9-9c9d-13fa1caba3af	Youtube	{"Y": {"count": 1}}	2475.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.310962	2025-12-10 18:30:51.310962
ecbb6289-8e52-411a-b639-065ea9313bd8	391617a8-5422-4fa9-a00b-0a723927fda1	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.311188	2025-12-10 18:30:51.311188
2ad118ea-05f2-4430-ba01-6078f20cd2e2	394ff94e-831c-49cb-a04b-896128421240	IG Story	{"I": {"count": 1}}	935.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.311382	2025-12-10 18:30:51.311382
bd87bb62-80cc-459b-92db-2fc85cc32c94	e94b1181-5944-4cc0-87ca-e7cb96294cde	Youtube	{"Y": {"count": 1}}	3880.00	3300.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.311674	2025-12-10 18:30:51.311674
ecdc0224-e8d4-4657-bd5f-6e3be79ead12	ae226d98-be72-441a-b8ef-e7c0de5eaa98	Youtube	{"Y": {"count": 1}}	1800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.311862	2025-12-10 18:30:51.311862
971dcf81-3888-46ac-96ba-2c36aa580592	ae226d98-be72-441a-b8ef-e7c0de5eaa98	Youtube integration	{"Y": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312077	2025-12-10 18:30:51.312077
cf89a714-a55b-4e1a-b872-a8ef118ecda0	ae226d98-be72-441a-b8ef-e7c0de5eaa98	Youtube, IG Story, IG Post	{"I": {"count": 1}, "Y": {"count": 1}}	1300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312261	2025-12-10 18:30:51.312261
9769107f-af40-4b65-ac0e-0f0d5c74c23f	73054296-9cb6-4dc1-bb30-147fc0f14f47	Instagram	{"I": {"count": 1}}	2800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312434	2025-12-10 18:30:51.312434
1e55c5a5-d89f-400c-b7d9-e14d87217664	8317df96-4c13-4514-87df-b8c65d9e08dc	Youtube	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312616	2025-12-10 18:30:51.312616
3557f8dd-f14f-4df2-9882-13757c8dbcb9	8317df96-4c13-4514-87df-b8c65d9e08dc	Youtube integration	{"Y": {"count": 1}}	2080.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312822	2025-12-10 18:30:51.312822
c60e68b9-6c4d-4190-a2ce-b6f8ea6c11bc	352bfcd2-9a94-4791-b9c1-1b7d43bc8db2	IG Story	{"I": {"count": 1}}	430.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.312998	2025-12-10 18:30:51.312998
46b693fb-6159-46df-bb78-d25de13fe36d	640ff371-f8ed-4280-b39e-636337db7a47	IG Reels	{"I": {"count": 1}}	1240.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.313167	2025-12-10 18:30:51.313167
9d3331f7-0940-4b7c-9c24-214ceab53e2a	ce1e5343-b310-4e6f-94ef-5824a2c167a7	X	{"X": {"count": 1}}	6000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.313323	2025-12-10 18:30:51.313323
ce765d43-d4b9-4552-bcce-697f665442c7	a1345f80-0740-403c-857a-c2a066e9c8c3	Tiktok	{"T": {"count": 1}}	5060.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31348	2025-12-10 18:30:51.31348
f639d9a6-7cbf-44ca-b14c-e5b45ec1e565	ad10b365-44b2-4b4c-bd9b-6b15a885598c	X	{"X": {"count": 1}}	1320.00	\N	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.313642	2025-12-10 18:30:51.313642
6046e353-7927-477f-ad34-450bfc381e4d	ad10b365-44b2-4b4c-bd9b-6b15a885598c	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	7000.00	\N	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.313803	2025-12-10 18:30:51.313803
c0412a8a-50a0-4933-bd05-9f157dfa12ff	50b93517-656c-431d-b111-9fc40557712f	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.313971	2025-12-10 18:30:51.313971
62d9311c-2b54-4cb6-97a0-8f176bd2a6bf	50b93517-656c-431d-b111-9fc40557712f	Youtube integration	{"Y": {"count": 1}}	1000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.314144	2025-12-10 18:30:51.314144
08e91e33-4f04-4fb6-b4a9-bda69349dade	5d3bb457-c8ed-4cb4-aad0-962a8deb4e06	Tiktok	{"T": {"count": 1}}	6050.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.314296	2025-12-10 18:30:51.314296
435ca074-03f8-4ded-a847-53db354c03a5	ba03bb82-201c-4b85-afd6-3fceeec703ef	IG Story	{"I": {"count": 1}}	7150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.314594	2025-12-10 18:30:51.314594
cb8c1935-c783-42f6-bca9-ac165eef02ed	ba03bb82-201c-4b85-afd6-3fceeec703ef	Tiktok	{"T": {"count": 1}}	9350.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.314782	2025-12-10 18:30:51.314782
a19746c5-71d8-46ca-bcf0-e319df1c8a59	2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	Youtube	{"Y": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.314962	2025-12-10 18:30:51.314962
85bda91c-540d-4dbc-afc5-4c1075a338a6	b5756577-7ac1-4ea5-8a7b-67d1d5712382	Tiktok	{"T": {"count": 1}}	5500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31513	2025-12-10 18:30:51.31513
88d82e03-df09-4bd8-b1da-0ba3d4d56d4c	2a44bd0d-60df-412f-b41b-0ee989031acc	Youtube	{"Y": {"count": 1}}	2940.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.315287	2025-12-10 18:30:51.315287
0690ea8f-2a2c-4df4-bc99-97a243662d4c	18008409-4129-4af9-a114-f0ae6269ec2b	Youtube integration	{"Y": {"count": 1}}	20400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31547	2025-12-10 18:30:51.31547
4b0f23b1-2daf-4adc-ab0f-eddfbda8897e	18008409-4129-4af9-a114-f0ae6269ec2b	Youtube	{"Y": {"count": 1}}	26400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.315632	2025-12-10 18:30:51.315632
500d6362-c340-4860-a7bb-341b6e55201f	18008409-4129-4af9-a114-f0ae6269ec2b	X	{"X": {"count": 1}}	3500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.315786	2025-12-10 18:30:51.315786
8183da65-a801-4351-9b47-3b87b77c9b88	18008409-4129-4af9-a114-f0ae6269ec2b	Instagram	{"I": {"count": 1}}	2900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31595	2025-12-10 18:30:51.31595
0b724e5b-858e-4bbc-aff1-0630221c9018	18008409-4129-4af9-a114-f0ae6269ec2b	Instagram	{"I": {"count": 1}}	5100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.316269	2025-12-10 18:30:51.316269
9958b7e1-7ec0-4b13-b60d-6f212aeae295	ff53a665-8e8b-4311-971a-fe2b51985a00	X	{"X": {"count": 1}}	1100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.316441	2025-12-10 18:30:51.316441
3b3e7e60-bad6-409f-8747-e0a16f2b06d9	1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	Youtube	{"Y": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.316606	2025-12-10 18:30:51.316606
47d236f2-b459-47b8-ab12-bf3feb9d6631	f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	X	{"X": {"count": 1}}	5175.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31677	2025-12-10 18:30:51.31677
74a4f5e8-0c3b-4e6c-b3a9-0a2d86ac74a1	0534a13e-fd02-4cfb-8491-c59ac802ff56	X	{"X": {"count": 1}}	885.00	800.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.316933	2025-12-10 18:30:51.316933
04acc22d-9538-411e-934b-ad1d97e12e02	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	X	{"X": {"count": 1}}	3300.00	2750.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31712	2025-12-10 18:30:51.31712
04873436-75a3-4dd4-b2c1-d57a411c9a36	7a1ad5c7-dd33-41d1-a520-d0e87bccb333	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.317281	2025-12-10 18:30:51.317281
194cb8b8-b4ef-436f-8383-188268e33aa1	d4704f1c-0bba-4dd0-b85f-d896be3c10c0	Telegram	{"T": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.317437	2025-12-10 18:30:51.317437
48d96e62-1817-4dcb-be2a-553ef788436f	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	Youtube integration	{"Y": {"count": 1}}	6100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.317583	2025-12-10 18:30:51.317583
148dcbfb-150f-42b2-872e-f9f9f2d22276	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	Youtube	{"Y": {"count": 1}}	9000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.317737	2025-12-10 18:30:51.317737
001b94c2-67a4-488f-b24a-799cb1635bec	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	X	{"X": {"count": 1}}	1700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.317931	2025-12-10 18:30:51.317931
425c8f31-8d53-42b9-b319-9f11f0c781ce	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	IG Reels	{"I": {"count": 1}}	5625.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.318121	2025-12-10 18:30:51.318121
bb2c4b0d-3993-471b-95b0-180795e23d8e	c54006c7-737c-494d-8d18-b9de72a4d867	X	{"X": {"count": 1}}	360.00	300.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.318283	2025-12-10 18:30:51.318283
dbdb640a-4b4d-4bdc-8239-34b4b4306637	c54006c7-737c-494d-8d18-b9de72a4d867	Youtube	{"Y": {"count": 1}}	600.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.318444	2025-12-10 18:30:51.318444
f8f93350-54bf-47da-b6b4-be1ec23f4ff4	261855bb-6dd5-4966-8d34-1229e29e6def	Telegram	{"T": {"count": 1}}	1015.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.318604	2025-12-10 18:30:51.318604
88e6c4e9-47c9-449f-8c94-3083b7a35ac0	89184324-3bd9-4479-91d8-05dbb8704734	Youtube	{"Y": {"count": 1}}	600.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.319285	2025-12-10 18:30:51.319285
3d04b36a-327e-4d6d-a93c-3d406cdec40e	89184324-3bd9-4479-91d8-05dbb8704734	X	{"X": {"count": 1}}	2000.00	2000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.319566	2025-12-10 18:30:51.319566
67d573ea-ae92-41cd-9621-b5c7aa490235	ee52295a-a14a-438d-8e93-b42966b44f57	X	{"X": {"count": 1}}	400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.31976	2025-12-10 18:30:51.31976
3860dad3-e05f-4124-b5cb-aca53b01ce4f	bb789f23-6d06-4380-a752-b391c3380210	Youtube	{"Y": {"count": 1}}	750.00	600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.319952	2025-12-10 18:30:51.319952
1a9cb154-a928-4521-a20d-c4cc1466c59c	820af3e2-669e-43fd-9a5a-12cb06e50d80	X	{"X": {"count": 1}}	600.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.320258	2025-12-10 18:30:51.320258
ee29f653-d524-48d4-80f7-cf733fb727dd	66f3145c-53d4-4244-91b4-0b84fdc87097	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	2500.00	1700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.320482	2025-12-10 18:30:51.320482
f2391cfb-488d-49e1-92f7-11e9d3333088	10b7a7d7-e824-4296-a746-e88fc7511cd8	Youtube	{"Y": {"count": 1}}	115.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.320642	2025-12-10 18:30:51.320642
ac61dcb4-4664-425a-8e2e-73ee291cd565	02e32b42-7818-40fc-8014-22afc4e69092	Youtube	{"Y": {"count": 1}}	1035.00	900.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.320797	2025-12-10 18:30:51.320797
92736d19-8a2d-4e7e-8ff5-fc971f43f72f	ca768075-e597-4929-9a5c-d749932ee0a1	Youtube	{"Y": {"count": 1}}	800.00	700.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.320963	2025-12-10 18:30:51.320963
9cf43515-6d7a-42b0-9d6a-1378e3b07063	ca768075-e597-4929-9a5c-d749932ee0a1	X	{"X": {"count": 1}}	3000.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.321153	2025-12-10 18:30:51.321153
271c10ce-89ff-4f78-a44f-1f4e71bdd45e	20bdeac7-b480-41bb-8f7a-1099626e3249	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	3900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.321306	2025-12-10 18:30:51.321306
c5d14973-8c97-4e2e-a3d6-44613eff28f9	f390519c-40ea-4450-a54f-1e466b920e90	X	{"X": {"count": 1}}	690.00	600.00	USD	atilla iletişime geçecek,magnor olarak sıfırdan fiyat alınacak	\N	t	\N	\N	\N	2025-12-10 18:30:51.321455	2025-12-10 18:30:51.321455
d7d85c96-0527-42f6-be18-5836633e1392	2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	1300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.321626	2025-12-10 18:30:51.321626
888bf2f7-132d-4c4a-bef9-942a8a8a0e44	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	X	{"X": {"count": 1}}	680.00	600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.321796	2025-12-10 18:30:51.321796
3f486206-399c-4286-be78-75f17aeb9f97	6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.32199	2025-12-10 18:30:51.32199
62cd14bf-68e1-4b58-8487-1eab74cd10b2	4f7141d7-ac31-4e32-8776-b4660f5c296b	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	3500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.322149	2025-12-10 18:30:51.322149
c0893756-1150-400d-b675-932a96caaeba	4f7141d7-ac31-4e32-8776-b4660f5c296b	X	{"X": {"count": 1}}	990.00	900.00	USD	\N	Toplu çalışmalarda ciddi indirim alabiliriz	t	\N	\N	\N	2025-12-10 18:30:51.322307	2025-12-10 18:30:51.322307
9405844d-7ced-42f9-a67c-7feee27a3ba5	6018f5e5-eb1b-4335-aef1-18b0e410cc15	X	{"X": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.322462	2025-12-10 18:30:51.322462
e9e8ee55-2d99-4b77-bab0-f9ee84fa26e7	815b489f-3c8b-4439-b18d-79ac234d198e	X	{"X": {"count": 1}}	460.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.322622	2025-12-10 18:30:51.322622
6da08b85-9262-400a-b52d-a5cac543bbf7	19300d02-feb6-42b9-8cf9-0cd847a24821	Youtube integration	{"Y": {"count": 1}}	6875.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.322782	2025-12-10 18:30:51.322782
0e8fa0a7-16db-48b6-925b-c45d8a3a122b	2950382c-f095-469b-9d0a-03b3a4cac477	X Thread, X, X Quote	{"X": {"count": 1}}	6200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.323128	2025-12-10 18:30:51.323128
24cdc309-7400-46b6-81af-cd03f991f231	2950382c-f095-469b-9d0a-03b3a4cac477	X Thread	{"X": {"count": 1}}	2750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.323279	2025-12-10 18:30:51.323279
4c84264e-7b2c-46a8-951b-62391c395ee7	2950382c-f095-469b-9d0a-03b3a4cac477	X	{"X": {"count": 1}}	1000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.323487	2025-12-10 18:30:51.323487
f8dbdbfc-fea3-4315-b713-0200bec91ac3	2950382c-f095-469b-9d0a-03b3a4cac477	X Quote	{"X": {"count": 1}}	620.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.323682	2025-12-10 18:30:51.323682
87adecdb-bd54-4f08-bb2d-e959d1d5b5ba	fd93a113-b0fe-4a7a-bd1b-262a688517c6	Youtube integration	{"Y": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.323856	2025-12-10 18:30:51.323856
47407408-ea1c-465e-826e-d49f23750830	6d6ef876-21ca-47a0-9200-095074791c96	X	{"X": {"count": 1}}	1250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.324027	2025-12-10 18:30:51.324027
6c11d959-8e39-4983-8aa9-b17889bac144	a63fdd89-7fdd-4a67-bd10-3ec3f948723d	Youtube	{"Y": {"count": 1}}	9560.00	8500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.32426	2025-12-10 18:30:51.32426
74e3e2db-83f3-40f7-8f28-d06193b7cbf8	a63fdd89-7fdd-4a67-bd10-3ec3f948723d	Youtube integration	{"Y": {"count": 1}}	7300.00	6500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.324477	2025-12-10 18:30:51.324477
773f3396-2d09-4220-a3bf-8a3612678af8	4848c5c6-a3c4-43ce-bcdf-48e979e85356	X	{"X": {"count": 1}}	1687.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.324911	2025-12-10 18:30:51.324911
0acb2e67-7460-401f-8d88-5fdb9d84b50b	81d595eb-74a1-4698-b416-46c09ac155d9	Youtube integration	{"Y": {"count": 1}}	7700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.325113	2025-12-10 18:30:51.325113
233b1c85-956d-4659-aaf8-2394ffa9621f	ffc65822-d148-468b-ba2c-18d9b231b8e5	Youtube	{"Y": {"count": 1}}	33000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.325283	2025-12-10 18:30:51.325283
4b63a772-84c1-4f5c-b58d-3c6e16cffbe5	901eb416-3a46-4d7c-aa0c-93decf104d01	X	{"X": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.325447	2025-12-10 18:30:51.325447
7ca0a2b0-ef59-49f3-9c1d-4506c6a5af8a	b868509d-79d9-492e-b250-33a34d8cb0e8	X	{"X": {"count": 1}}	650.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.325683	2025-12-10 18:30:51.325683
ce5ddf1c-cb94-4b7c-99bc-afa46782cc6e	b2a1c05d-9609-469f-a37f-a90299d9b43e	Youtube	{"Y": {"count": 1}}	3230.00	2750.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.326307	2025-12-10 18:30:51.326307
e8b61b7c-73fb-43f9-acd7-808aff037fe9	b2a1c05d-9609-469f-a37f-a90299d9b43e	Youtube integration	{"Y": {"count": 1}}	1760.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.326505	2025-12-10 18:30:51.326505
4b595de0-a57a-4dc5-96f9-45b0742979f2	2cba013b-a76f-4d2a-bd8a-87605899cdd0	Youtube integration	{"Y": {"count": 1}}	3500.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.326722	2025-12-10 18:30:51.326722
da55f273-7e07-42a0-9e6f-b82434a321a9	2cba013b-a76f-4d2a-bd8a-87605899cdd0	Youtube	{"Y": {"count": 1}}	4700.00	4000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.326917	2025-12-10 18:30:51.326917
d2904ba9-ba22-4561-9e5a-1a38b13c8ca9	e1b258fb-7611-4b39-a601-09d38c5d6dff	Youtube, X	{"X": {"count": 1}, "Y": {"count": 1}}	6100.00	5500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.327101	2025-12-10 18:30:51.327101
1da9d0ab-1272-442d-8a20-c69f10569ad2	3d9705c4-60a6-43da-b2ae-e3694d363025	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.327265	2025-12-10 18:30:51.327265
881aab68-55e7-4119-b0a0-d6c926874289	b1ec569f-83ee-4a17-9d07-53d70bbee703	Youtube	{"Y": {"count": 1}}	3800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.327541	2025-12-10 18:30:51.327541
6984cd1e-f87c-4524-94bf-cd1f44b4bb19	b1ec569f-83ee-4a17-9d07-53d70bbee703	Youtube integration	{"Y": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.327771	2025-12-10 18:30:51.327771
f25ffb35-83d6-499a-abd7-8329b81128d5	4d95ba58-5fcf-451c-9d78-6d8a02719d51	X	{"X": {"count": 1}}	67500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.327938	2025-12-10 18:30:51.327938
2c9ebb00-cd7f-4766-8947-d6f55b632a61	92610a49-08e0-4bc3-b61c-9bbf8adee414	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1500.00	1350.00	USD	Bu adam için önce Ömer ile görüşülüp fiyat alınacak herzaman	\N	t	\N	\N	\N	2025-12-10 18:30:51.328098	2025-12-10 18:30:51.328098
11473566-e4ec-4507-920a-1d514ffd1b75	7392cd69-e132-40c8-af99-dec18965f901	X	{"X": {"count": 1}}	400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.328268	2025-12-10 18:30:51.328268
910f2e5a-2556-4771-9056-f8b83aa19807	9165be31-df7b-4b1b-a005-eddfd2b88020	Tiktok	{"T": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.328476	2025-12-10 18:30:51.328476
ac8f8127-a0ae-432f-9d7b-f1b61dd7917f	fb8dd599-e3bc-43cb-996d-4e11c82aadd6	Youtube	{"Y": {"count": 1}}	3100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.3287	2025-12-10 18:30:51.3287
46554a2d-8739-4c82-a17a-03927f1e6b96	fb8dd599-e3bc-43cb-996d-4e11c82aadd6	Youtube integration	{"Y": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.328879	2025-12-10 18:30:51.328879
9ae78d8c-58a9-49a6-890b-60568434aefb	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	Youtube integration, X, Telegram	{"T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	29375.00	25000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.329304	2025-12-10 18:30:51.329304
c33002f8-b2cd-4853-91fd-f93e358d2eac	360939ba-f9a5-4122-860b-bf8f6a700d5b	Tiktok	{"T": {"count": 1}}	3685.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.329629	2025-12-10 18:30:51.329629
d4124ce5-fd11-42cd-bfa7-d77a60030bc5	6953adb3-42f6-4216-b602-14f8417c754a	Youtube	{"Y": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.329803	2025-12-10 18:30:51.329803
4aa2336f-842b-4546-9881-f01fcf969660	6953adb3-42f6-4216-b602-14f8417c754a	Youtube integration	{"Y": {"count": 1}}	1690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.329962	2025-12-10 18:30:51.329962
c7f04f06-7dc4-4a70-8972-18f8b609aa52	4b43d6cc-7025-4896-be9f-9b30bf1fba98	Tiktok	{"T": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.330129	2025-12-10 18:30:51.330129
181af7c8-6f3c-4aa2-afa8-4a6db4206114	485578d2-8745-4484-8692-b99c1113cd70	Telegram	{"T": {"count": 1}}	1350.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.330299	2025-12-10 18:30:51.330299
c7092a8c-1752-43c7-a13e-d71d2cedc019	598acdcf-7247-4bb0-b980-91b71380899b	Tiktok	{"T": {"count": 1}}	7150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.330549	2025-12-10 18:30:51.330549
1a13f14d-be1a-41d9-aeb4-5bf82baea87c	598acdcf-7247-4bb0-b980-91b71380899b	Tiktok, IG Reels	{"I": {"count": 1}, "T": {"count": 1}}	13200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.330748	2025-12-10 18:30:51.330748
12c6a4e3-769e-4bd1-9b7e-879325ddccdf	edaab8c7-830a-461a-8d12-026793c0ab63	X	{"X": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.330942	2025-12-10 18:30:51.330942
190c2934-37b9-47fc-8248-c2d429d941ef	7cbda437-88bb-47c1-b598-cb6eb72ea01a	IG Story, IG Post	{"I": {"count": 1}}	2420.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.331124	2025-12-10 18:30:51.331124
d3dbc8a1-d7e0-4ed9-b259-ae087d315269	4055d5a9-7d7f-451b-beb9-4dea063dfb23	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	5800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.331354	2025-12-10 18:30:51.331354
7c387af9-d9bd-4b9c-834a-c528c5eeb2fb	012dc821-4451-48e8-b9f6-0c62b69b6b84	Youtube	{"Y": {"count": 1}}	5100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.331546	2025-12-10 18:30:51.331546
d24578ac-2b5a-4850-a2b3-2eb55813ca49	012dc821-4451-48e8-b9f6-0c62b69b6b84	Youtube integration	{"Y": {"count": 1}}	4275.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.331713	2025-12-10 18:30:51.331713
b52c5648-3893-447b-a840-34adc5bea4c6	012dc821-4451-48e8-b9f6-0c62b69b6b84	IG Story	{"I": {"count": 1}}	1240.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.331963	2025-12-10 18:30:51.331963
d644951a-6b4f-42c3-a937-f424d2ce4c0c	012dc821-4451-48e8-b9f6-0c62b69b6b84	IG Story	{"I": {"count": 1}}	2150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.332207	2025-12-10 18:30:51.332207
0551966d-f8ed-4784-9fd5-77c032345ea8	012dc821-4451-48e8-b9f6-0c62b69b6b84	Tiktok	{"T": {"count": 1}}	2475.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.3324	2025-12-10 18:30:51.3324
f0798d1f-d769-4dbd-9f00-dac8d77862f3	012dc821-4451-48e8-b9f6-0c62b69b6b84	Telegram	{"T": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.33258	2025-12-10 18:30:51.33258
a36569a0-1a54-4121-819f-015805f98171	01fa437e-dded-42ac-a1ab-795135b5c433	Buy signal, X	{"B": {"count": 1}, "X": {"count": 1}}	2700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.332743	2025-12-10 18:30:51.332743
b72babd9-c87b-4693-95b5-9e96fb91f5ba	c1240f25-cd0b-4059-8226-f5838f72a21d	Youtube	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.332904	2025-12-10 18:30:51.332904
a22ef937-a59d-4f21-aa19-a21b904d7873	1431f7e3-b5be-4c45-9499-2d38f736b916	Youtube	{"Y": {"count": 1}}	9775.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333077	2025-12-10 18:30:51.333077
33b7f890-179b-4b07-87b1-6d002c4c2283	91b8f309-8a61-4967-b5e3-469a9e494ebf	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	3100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333249	2025-12-10 18:30:51.333249
22698dbc-bc3b-4bc4-ac7f-cd03491c7157	4d7bc637-9284-4927-b0cd-7e2193d71a75	Youtube integration	{"Y": {"count": 1}}	1760.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333416	2025-12-10 18:30:51.333416
2a1f9e93-9022-4fbd-996e-ed5d9f138356	4d7bc637-9284-4927-b0cd-7e2193d71a75	Youtube	{"Y": {"count": 1}}	3055.00	2600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333581	2025-12-10 18:30:51.333581
f2f8311b-c8d8-48d9-8a00-76e5e6efdb51	c18ae991-a8fb-42f9-8cd0-7047fe39d597	Youtube integration	{"Y": {"count": 1}}	6110.00	5200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333761	2025-12-10 18:30:51.333761
328ad665-7e6f-4f4c-8ac6-bfb3f6f0791c	c18ae991-a8fb-42f9-8cd0-7047fe39d597	Youtube	{"Y": {"count": 1}}	2650.00	2250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.333954	2025-12-10 18:30:51.333954
608c5608-e7f2-4d38-9dea-78b72a352ef3	1812ef72-6275-4dd6-92d2-a91ed2871065	Youtube	{"Y": {"count": 1}}	9400.00	8000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.334128	2025-12-10 18:30:51.334128
8b79dd20-07a1-4aea-9271-88fdd20cc4cc	14f0e2a6-31b7-4617-9bb7-9a70be9e185c	Tiktok	{"T": {"count": 1}}	5500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.334324	2025-12-10 18:30:51.334324
4832764c-fbc5-42cd-96ab-19564ca0e432	5251a6b3-70bb-4ab8-a580-9201fef78bcb	Youtube	{"Y": {"count": 1}}	1150.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.334764	2025-12-10 18:30:51.334764
6a5d3f0e-660a-44ec-a178-6c163d0c4197	365c16ff-15dd-4cd9-bd00-5b56537423dc	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.334944	2025-12-10 18:30:51.334944
c21ee4ee-7dd9-4af5-b6c1-d4be09578e1e	137cf437-1b62-4fb4-98a3-48c1671ff617	Youtube	{"Y": {"count": 1}}	6750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.335113	2025-12-10 18:30:51.335113
04e43a57-6fd8-48d9-a20d-f773b4798f5f	137cf437-1b62-4fb4-98a3-48c1671ff617	Youtube integration	{"Y": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.335291	2025-12-10 18:30:51.335291
75bbead5-6308-4274-9d97-5666351fb3c7	294b5801-e218-4601-81e8-cc59f67d38ea	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	7800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.335669	2025-12-10 18:30:51.335669
ad8002b0-9a5d-4820-8935-fff24707948b	c880e80b-e6e9-459b-b76c-613791b7b88d	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.335902	2025-12-10 18:30:51.335902
0a3f8d0e-b055-49de-a8ff-4a1db1150191	103659ba-e1f4-405d-b289-2fabf44ad1b8	Youtube	{"Y": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.336088	2025-12-10 18:30:51.336088
d09c38d6-48d1-4cfc-a24d-05a99d52ae72	103659ba-e1f4-405d-b289-2fabf44ad1b8	Youtube integration	{"Y": {"count": 1}}	1900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.336275	2025-12-10 18:30:51.336275
7adaee50-dd1f-47eb-a88b-c85d88195cb8	9f8d74a6-0dec-40df-89b4-ce350f23ea20	Telegram	{"T": {"count": 1}}	805.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.336456	2025-12-10 18:30:51.336456
537cb0ed-a3ac-4c07-93a7-d04c310b981b	0a5197f5-c578-4532-b9ca-d826eda45631	Telegram	{"T": {"count": 1}}	935.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.336629	2025-12-10 18:30:51.336629
86583743-02a6-4f31-944b-f65a58cfa02a	279d7e14-1a00-4448-847a-313a0bbae58a	Youtube	{"Y": {"count": 1}}	2185.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.33682	2025-12-10 18:30:51.33682
0ec69792-6415-4ebd-aa8e-74b30c398006	5e0d6233-37b7-429b-b437-7c9e80a88217	IG Story	{"I": {"count": 1}}	660.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.336992	2025-12-10 18:30:51.336992
46f14c51-2b47-4ab2-a9ac-dbfae2cbc043	0c9a840d-5ae1-405f-97d8-b4620bd69836	Youtube	{"Y": {"count": 1}}	12330.00	10500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.337171	2025-12-10 18:30:51.337171
edf71469-3272-4b58-8104-df2849463f3a	0c9a840d-5ae1-405f-97d8-b4620bd69836	Youtube integration	{"Y": {"count": 1}}	7900.00	6750.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.337345	2025-12-10 18:30:51.337345
fdcda1c2-d443-4cde-bada-50e2a1bbf25d	1d9ca24c-6c45-431b-9358-912bb0d7000b	Youtube	{"Y": {"count": 1}}	17500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.337566	2025-12-10 18:30:51.337566
d96ec1e2-b581-4ff2-bdab-093b6593ee21	d2b50556-4bc9-47d6-8a96-387edca98cde	X	{"X": {"count": 1}}	5780.00	5500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.337739	2025-12-10 18:30:51.337739
cc097b01-ad59-4e3b-8114-a6e234bcf7e7	402d4dcb-714d-4e15-95aa-94854f602c2f	Telegram	{"T": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.337929	2025-12-10 18:30:51.337929
8b226b2b-0384-42f7-8812-6c9ee679b0c5	38ea5178-eace-462d-8eec-4012d0850ed3	Youtube	{"Y": {"count": 1}}	14375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.338115	2025-12-10 18:30:51.338115
98e0b86e-a25b-44b2-97fd-c62cae9ce800	2c7daabd-9713-4d6c-b44b-5295b1146e4b	X	{"X": {"count": 1}}	600.00	550.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.338282	2025-12-10 18:30:51.338282
3a73bc26-f560-47d3-990e-ea2ba41bd1d5	e09bee44-10ce-4d87-94b2-3cfd7eccd5ff	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.33845	2025-12-10 18:30:51.33845
56f477fd-929f-47e8-bf7a-9b605f130074	eb3aa25c-3533-4267-b913-8fc8361590c3	Youtube	{"Y": {"count": 1}}	15500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.338613	2025-12-10 18:30:51.338613
18c5b7c9-e4fe-4c34-8cd8-8de17881d2d1	e61fddef-5b5e-41df-8166-0013f41c935b	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.338822	2025-12-10 18:30:51.338822
46b66fad-ecef-4427-883c-f6d03c1da2b5	5eecf188-ac02-4b8e-87da-3ec22550adbc	Youtube integration	{"Y": {"count": 1}}	4500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.339044	2025-12-10 18:30:51.339044
496b2523-997c-473a-9136-09a070b7327e	5eecf188-ac02-4b8e-87da-3ec22550adbc	Instagram	{"I": {"count": 1}}	1870.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.339216	2025-12-10 18:30:51.339216
15af6e3f-1f70-44c8-8bda-2f221d75a95a	30c617a3-6840-4150-9a78-e479cdaaa6a1	X	{"X": {"count": 1}}	690.00	600.00	USD	güncel fiyat alınacak,magnor olarak sıfırdan,nihanla calısılmıs daha once nihandan bahsedilecek	\N	t	\N	\N	\N	2025-12-10 18:30:51.339389	2025-12-10 18:30:51.339389
4000e701-57d0-40bb-b39a-febb65eb5239	6bf62d19-ea8a-4efd-87cf-2e3f8b4c9ab1	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.339729	2025-12-10 18:30:51.339729
afd6e604-8fec-46d9-9646-4e0bb983003d	79c46d87-380e-4919-b522-d6e9043525e9	AMA	{"A": {"count": 1}}	3375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.340227	2025-12-10 18:30:51.340227
c4a19c2b-8e60-4e29-8f0e-bdc1857a3536	a6e5af8d-b3ce-40f7-a650-659c2b733e3f	Youtube	{"Y": {"count": 1}}	3050.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.340429	2025-12-10 18:30:51.340429
632e7941-8250-443e-8181-1e1ee0df9e49	a6e5af8d-b3ce-40f7-a650-659c2b733e3f	Youtube integration	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.340593	2025-12-10 18:30:51.340593
8a9c586f-46dc-4a06-9d33-3b5eda03bc0a	d25cce7d-1b03-44ff-af78-c907300e06af	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	2100.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.340819	2025-12-10 18:30:51.340819
1151e036-d458-4e62-b005-b0e7202ef933	9c5e0827-8042-4a8c-b133-6f02fe0d1661	X	{"X": {"count": 1}}	115.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.340998	2025-12-10 18:30:51.340998
3c1b6aef-6f99-4a21-9a97-e3c55222a75d	31ccb5b9-3232-49bf-8121-b0d49784a072	X	{"X": {"count": 1}}	800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34121	2025-12-10 18:30:51.34121
501c3db8-c594-45a9-bbe1-d4bc2040dc11	50480996-392e-4fbd-bcd3-b2d67cbb25ae	IG Reels	{"I": {"count": 1}}	1125.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.341411	2025-12-10 18:30:51.341411
6e95e8af-8e04-4e33-b6ad-5516a615ba7e	602788df-be32-4409-aa4a-331e1d3a3c12	Youtube	{"Y": {"count": 1}}	2650.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.341727	2025-12-10 18:30:51.341727
a24711c4-3164-40ad-9ed9-a1390b9e39d7	b4887d0c-2c72-4b6f-885f-530af72ea7aa	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.342009	2025-12-10 18:30:51.342009
bec6accc-5cc6-4614-a111-53b710073cd7	a4d26b54-bc04-4df1-8b3d-c01939ba12ac	Youtube	{"Y": {"count": 1}}	2530.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.342205	2025-12-10 18:30:51.342205
f6d2827b-ebc1-4c03-aaaf-fe26ba118679	c34b6e61-7e47-42af-8d0f-7258a892df93	IG Reels	{"I": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34239	2025-12-10 18:30:51.34239
af62cac2-af76-482a-a9f7-e8e2b8b3201b	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	Buy signal	{"B": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.342658	2025-12-10 18:30:51.342658
e95c9d0b-f907-45be-8304-cff99c24101c	be2c7d26-cd3c-42b7-8462-426a2f77ca55	IG Reels	{"I": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.342895	2025-12-10 18:30:51.342895
357fb592-8df1-4e4b-8c9d-4d5e8ab6f445	2ffbb550-8ef7-4ee0-abbb-2bc8cc9b8626	X	{"X": {"count": 1}}	4200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.343116	2025-12-10 18:30:51.343116
6642b55d-5823-43e3-808b-c74576548e7d	cfd6e494-2e99-4444-b0dd-cf0e39c35c3f	Youtube integration	{"Y": {"count": 1}}	10125.00	9000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.343298	2025-12-10 18:30:51.343298
965fd61b-02b1-44ef-9a78-1c6c16a07a3b	5205065e-4780-4bba-841b-2bf3bb2b4b2f	X	{"X": {"count": 1}}	950.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.343648	2025-12-10 18:30:51.343648
4543566c-71c2-48e8-9654-ef2962218ea3	2f7314ea-dcf9-4ced-bbd0-12e235827ef6	Youtube	{"Y": {"count": 1}}	1400.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.343839	2025-12-10 18:30:51.343839
334d16ed-fef5-4bc1-a6c9-dfbc877660fe	ce85846a-bdae-482d-9f88-5f846ff811fa	X	{"X": {"count": 1}}	5650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.344107	2025-12-10 18:30:51.344107
d5ad7dbb-63d2-4eb5-b305-cb1a640bf661	64ce9410-1679-44f2-8c70-138792a1e087	IG Story	{"I": {"count": 1}}	440.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34433	2025-12-10 18:30:51.34433
1f703991-c728-4d41-8a45-4aa6ef8a94e0	64ce9410-1679-44f2-8c70-138792a1e087	Tiktok	{"T": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34459	2025-12-10 18:30:51.34459
d77bbfff-4b42-4279-aa4c-e06b31e24914	4563395a-81cd-427e-90b5-b22bef4ed6f7	Youtube, Telegram	{"T": {"count": 1}, "Y": {"count": 1}}	11500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.344824	2025-12-10 18:30:51.344824
be85fac4-dd2b-4ebb-8e92-991df3e7aeb1	b5c50956-be91-4641-87d2-4e3635864bc6	Youtube	{"Y": {"count": 1}}	3450.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.345062	2025-12-10 18:30:51.345062
f6be283b-45d7-4f7e-9fa0-c3eb800e0ca5	b5c50956-be91-4641-87d2-4e3635864bc6	Telegram	{"T": {"count": 1}}	750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.345261	2025-12-10 18:30:51.345261
d97002a1-26e0-408d-811d-6253ca40a704	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	IG Story	{"I": {"count": 1}}	2420.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34544	2025-12-10 18:30:51.34544
c9f702b4-47c6-48dc-891e-4ee8c6e8e397	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	Tiktok	{"T": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.345626	2025-12-10 18:30:51.345626
c0bb9b17-315b-4a56-8d13-65bfad0d22e1	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	Tiktok	{"T": {"count": 1}}	2420.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.345818	2025-12-10 18:30:51.345818
c21ce397-f350-4312-b0ac-6034bdcb1246	f8998b14-8d70-4926-9fb2-9254bd4ac494	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.346004	2025-12-10 18:30:51.346004
d45e47f1-fa5a-49f7-9307-6ac3faab5f0a	78ff7e96-5a3d-47ee-89d4-ec56e551af4d	Youtube	{"Y": {"count": 1}}	2250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.346202	2025-12-10 18:30:51.346202
94541479-c321-4307-9bb7-55f982aef1f8	cc3e9660-9e46-4ae1-8ac6-060ab08ad10b	Youtube	{"Y": {"count": 1}}	6600.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.346391	2025-12-10 18:30:51.346391
5cf5e813-2e7e-42d8-9367-cd446edcfd03	4e528c7a-acc8-4f9a-a623-07a80b4d81a6	Tiktok	{"T": {"count": 1}}	1485.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.346583	2025-12-10 18:30:51.346583
55616b8b-1d8d-46c8-82b9-2d3f2fdb683d	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	X, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	2300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34677	2025-12-10 18:30:51.34677
622920fd-9dac-4edd-b513-c83c077d154b	51465645-99e4-411b-84bb-c35db8063c51	Youtube integration	{"Y": {"count": 1}}	16450.00	14000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.346958	2025-12-10 18:30:51.346958
0ed237bf-7baa-4321-87fc-d28bfd779172	51465645-99e4-411b-84bb-c35db8063c51	Youtube	{"Y": {"count": 1}}	29375.00	25000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.347137	2025-12-10 18:30:51.347137
043f98a6-0dcd-42f1-bc78-6367923f4915	51465645-99e4-411b-84bb-c35db8063c51	Tiktok, Instagram	{"I": {"count": 1}, "T": {"count": 1}}	8225.00	7000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.347323	2025-12-10 18:30:51.347323
8c76632d-0387-4501-90ec-33a8d004655d	51465645-99e4-411b-84bb-c35db8063c51	Telegram	{"T": {"count": 1}}	5875.00	5000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.347509	2025-12-10 18:30:51.347509
5f24812d-56da-421b-bfb2-5fe6cdd9eec8	51465645-99e4-411b-84bb-c35db8063c51	Tiktok	{"T": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.347693	2025-12-10 18:30:51.347693
da9af20c-d22d-4c52-959c-6ea2e87644df	431f2005-da1f-4309-9b88-bc84e36a271f	Youtube integration, Telegram, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "Y": {"count": 1}}	23000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.347889	2025-12-10 18:30:51.347889
1490cb5a-705a-4be4-8565-ab9efdff8c7e	0d2da959-8d4e-4bdb-9e13-9a5558102ef5	X	{"X": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348066	2025-12-10 18:30:51.348066
d80c8746-875e-4b47-843d-ab893de88bf0	0d2da959-8d4e-4bdb-9e13-9a5558102ef5	X	{"X": {"count": 1}}	33000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348267	2025-12-10 18:30:51.348267
20342caa-795d-433e-80ea-085fa3165c73	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	X, Youtube integration	{"X": {"count": 1}, "Y": {"count": 1}}	13200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348442	2025-12-10 18:30:51.348442
b82112a5-f1b8-47e6-be5c-7ee59d882005	57e7e20a-72d6-40ff-9b6f-74f7fb46808a	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348623	2025-12-10 18:30:51.348623
9ee88e8b-5aee-445b-b0a8-2d2917b916dc	bdb16884-7662-42a2-b2ef-07ae7ff01a1a	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	5550.00	5250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348787	2025-12-10 18:30:51.348787
d3f838a7-b546-4a8d-8824-ee1c6f0170ea	5b01d0aa-c26f-478e-835a-0d3560a3fc70	Youtube	{"Y": {"count": 1}}	1630.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.348974	2025-12-10 18:30:51.348974
7d15bba9-8957-4ee1-b5da-05bde679fe34	5cc8dabb-2e93-4493-9b7e-5b2da6a992b9	IG Reels	{"I": {"count": 1}}	2000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.349148	2025-12-10 18:30:51.349148
518be076-a068-445c-81b9-6babaea74991	3673e128-01f7-48b5-83e1-f5d132e0b124	Youtube	{"Y": {"count": 1}}	3500.00	3200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.34932	2025-12-10 18:30:51.34932
b43df486-05dc-460a-8f3f-96be71cda3a3	3673e128-01f7-48b5-83e1-f5d132e0b124	Youtube	{"Y": {"count": 1}}	2830.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.349618	2025-12-10 18:30:51.349618
a4032965-d700-4400-b388-c66b28b6f3cd	0014cdbc-a111-4968-a413-828882e32e66	Youtube	{"Y": {"count": 1}}	3650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.349843	2025-12-10 18:30:51.349843
0e9cc508-07c1-4572-8f95-b26a5a6d559d	0014cdbc-a111-4968-a413-828882e32e66	Youtube integration	{"Y": {"count": 1}}	1690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.350059	2025-12-10 18:30:51.350059
ddbf1fa3-7a5e-4af5-908d-613421a54457	9696fc6a-d3c9-481e-904e-72454a56cfb0	Tiktok	{"T": {"count": 1}}	11000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.350257	2025-12-10 18:30:51.350257
1899e4dc-cedf-4481-a0d5-39d955cc80dc	3b9e651e-7b05-4ef5-971c-23f80efa20ec	Youtube integration	{"Y": {"count": 1}}	23400.00	20000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35044	2025-12-10 18:30:51.35044
e0eeaf16-0416-45fd-975c-817a1617bec1	3b9e651e-7b05-4ef5-971c-23f80efa20ec	Youtube	{"Y": {"count": 1}}	25000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.350611	2025-12-10 18:30:51.350611
715655e2-f199-4e95-994b-72a650885965	3b9e651e-7b05-4ef5-971c-23f80efa20ec	X	{"X": {"count": 1}}	3500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.350763	2025-12-10 18:30:51.350763
535e2881-e0a5-43d8-8907-944e2184278d	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	X	{"X": {"count": 1}}	460.00	400.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.350972	2025-12-10 18:30:51.350972
1f292f24-ab5d-4f82-9461-b5a36d55c42d	183a902d-4b06-4904-8d47-3379609ab004	Youtube integration	{"Y": {"count": 1}}	22000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.351319	2025-12-10 18:30:51.351319
0c1cd156-7441-4e77-af90-8e6a5a503621	83c4db35-bc00-42ee-84a3-0c518581f849	X	{"X": {"count": 1}}	1080.00	950.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.351506	2025-12-10 18:30:51.351506
c25d6c7f-62b8-419a-b99d-f7ed15375aa7	f129f037-4617-4f13-91b6-2f0846f15594	X, Youtube, Buy signal	{"B": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	90000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.351714	2025-12-10 18:30:51.351714
158b3b29-19f1-4f91-87df-7dd4015c8ee5	81c829f0-c889-4ece-a1a2-d0ff22503cee	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.351928	2025-12-10 18:30:51.351928
fe3cd380-f718-4cfc-9cc3-7a89430776bf	bce6a1f6-efce-43e9-9e1f-556d8c35aa44	X	{"X": {"count": 1}}	780.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.352113	2025-12-10 18:30:51.352113
49eaba02-4654-439b-a1d3-1436c082c494	bce6a1f6-efce-43e9-9e1f-556d8c35aa44	X	{"X": {"count": 1}}	1920.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.352357	2025-12-10 18:30:51.352357
8faa757b-1433-4262-bd4d-19e204f9f147	400be1dd-a2a9-42f5-90d0-d84fe069f387	IG Story	{"I": {"count": 1}}	660.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.352546	2025-12-10 18:30:51.352546
901d5be4-1b05-439b-8ef3-d02252986c7f	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	Youtube integration	{"Y": {"count": 1}}	44000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35273	2025-12-10 18:30:51.35273
8321b07c-61c1-422e-a437-eeec6d9baa51	3275128f-dcb6-4a98-9250-0c658c74b22d	Youtube	{"Y": {"count": 1}}	3500.00	3250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.352914	2025-12-10 18:30:51.352914
b0cef479-21b2-458c-8aa1-b81ded45f354	3275128f-dcb6-4a98-9250-0c658c74b22d	Youtube	{"Y": {"count": 1}}	2490.00	2200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.353102	2025-12-10 18:30:51.353102
f043b13e-8d9a-4a75-9213-7bf95b84ba3b	f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	X	{"X": {"count": 1}}	575.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.353289	2025-12-10 18:30:51.353289
9f4f4906-4db5-4997-901c-67c9765d7027	997edef2-76fb-4731-bf0e-61711f5b4c3d	Telegram	{"T": {"count": 1}}	1350.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.353484	2025-12-10 18:30:51.353484
326e1841-e8ea-445f-8b3b-1a3f5015035a	d275cf87-cacc-4301-a48c-e4ff974c7107	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.353675	2025-12-10 18:30:51.353675
b14d3fba-1c27-4315-b195-8c2bfcd22606	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	Youtube integration	{"Y": {"count": 1}}	12375.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.353861	2025-12-10 18:30:51.353861
c9df28ee-c2c8-4d77-a719-d7113f5dfce9	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	IG Reels	{"I": {"count": 1}}	9000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35405	2025-12-10 18:30:51.35405
0da90cb7-7619-41da-9780-dd353f18421d	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	IG Story	{"I": {"count": 1}}	6200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35423	2025-12-10 18:30:51.35423
0ce30b16-8f7c-499d-b917-9d9a40b7dd65	6a4abfcc-aef9-48c9-9ec2-c246cf7d11f2	IG Post	{"I": {"count": 1}}	1980.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.354454	2025-12-10 18:30:51.354454
5e36ef42-05b2-4379-babe-f2c3acd924e3	ea6c162c-6b68-45ba-a64c-5b80819411b1	X	{"X": {"count": 1}}	600.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.354694	2025-12-10 18:30:51.354694
038071ee-1aa9-4640-a379-f2d305c1777c	6e27e554-7a48-45d4-878c-063a723e33c2	X	{"X": {"count": 1}}	2300.00	2000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.354862	2025-12-10 18:30:51.354862
68253f4a-6a45-4a0d-a211-975150ad830d	6e27e554-7a48-45d4-878c-063a723e33c2	X Thread	{"X": {"count": 1}}	3400.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.355051	2025-12-10 18:30:51.355051
6eb353cc-933b-49cb-8ca0-b57321f7bec5	6e27e554-7a48-45d4-878c-063a723e33c2	Telegram	{"T": {"count": 1}}	1450.00	1250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.355234	2025-12-10 18:30:51.355234
6736892f-9b9b-45aa-9f76-9f098f48e2a1	6e27e554-7a48-45d4-878c-063a723e33c2	Youtube integration	{"Y": {"count": 1}}	2300.00	2000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.355403	2025-12-10 18:30:51.355403
5c81bcdc-69ed-4e21-863d-d9d9ac795b34	d17b7538-0204-4b2f-aecf-83f8af1d266c	Youtube	{"Y": {"count": 1}}	3150.00	3000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.355575	2025-12-10 18:30:51.355575
03f0fa40-9711-4b6a-93b3-66948dcc9983	22561ea9-e707-4082-afbf-0a706a3918d5	X	{"X": {"count": 1}}	6900.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35578	2025-12-10 18:30:51.35578
4164e6c3-80b7-4ff8-b618-a5825deefe62	b5c1a526-3c0d-4769-adad-454977d5b169	X	{"X": {"count": 1}}	2060.00	1750.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.356274	2025-12-10 18:30:51.356274
a05636b1-021e-45d2-be52-3ce111f46c90	b5c1a526-3c0d-4769-adad-454977d5b169	Youtube integration	{"Y": {"count": 1}}	2940.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.356499	2025-12-10 18:30:51.356499
69a92e9e-7c03-459f-89ff-09cb4d0dacba	40888ff9-372f-473a-9aef-29d1ba5af6d8	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	5700.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.357299	2025-12-10 18:30:51.357299
d1415b6a-6833-40a8-8328-29a333219577	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	Youtube integration	{"Y": {"count": 1}}	8810.00	7500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.3575	2025-12-10 18:30:51.3575
b03eee5a-03ae-4ddb-a59e-0d4f864070a5	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	Youtube integration	{"Y": {"count": 1}}	29375.00	25000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.357682	2025-12-10 18:30:51.357682
11c3ae45-21a7-4ec6-a562-be1646c20ac9	0285a773-0112-4881-81db-c2d3d1242270	Youtube	{"Y": {"count": 1}}	4025.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.3579	2025-12-10 18:30:51.3579
0c78d972-602e-4e2b-a9f7-10cb9a7495e0	a40d7c70-e895-4a15-b8be-62e233876780	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	4700.00	4000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.35809	2025-12-10 18:30:51.35809
a4253916-f0d9-4f88-a016-58a13ec5229c	a40d7c70-e895-4a15-b8be-62e233876780	Youtube integration	{"Y": {"count": 1}}	23500.00	20000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.358291	2025-12-10 18:30:51.358291
6ad15975-8402-4d40-af4b-4f43018a045b	a40d7c70-e895-4a15-b8be-62e233876780	Youtube (2nd channel)	{"Y": {"count": 1}}	14680.00	12500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.358561	2025-12-10 18:30:51.358561
dce0bed3-26bb-47c2-942d-a726da7d3071	a40d7c70-e895-4a15-b8be-62e233876780	Youtube integration (2nd channel)	{"Y": {"count": 1}}	7600.00	6500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.358737	2025-12-10 18:30:51.358737
d35dfdea-becf-4d50-9be9-3b0f985b41e0	a40d7c70-e895-4a15-b8be-62e233876780	X, Telegram, Youtube integration, Youtube (2nd channel)	{"T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	41125.00	35000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.358962	2025-12-10 18:30:51.358962
ebfc8e32-ec6e-4eaa-aa56-4deed6d9ba94	1264f97e-0a23-4690-8272-23123de6547a	Tiktok, IG Story	{"I": {"count": 1}, "T": {"count": 1}}	1265.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.359194	2025-12-10 18:30:51.359194
75f2848c-9a5d-4b70-8d2e-564abea4a41a	954bc336-4c17-4f7d-90be-16658e264c5a	Tiktok	{"T": {"count": 1}}	2200.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.359374	2025-12-10 18:30:51.359374
ad61bd0b-28cf-47cd-9175-e2033406521f	70012215-6080-4feb-bd19-5a7da237d524	Tiktok	{"T": {"count": 1}}	3960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.359969	2025-12-10 18:30:51.359969
bce50d7c-d8c5-4ec7-aecb-bf02afd255be	72ac3de4-eeaa-49cf-932a-cb0d421745db	Tiktok	{"T": {"count": 1}}	14850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.360153	2025-12-10 18:30:51.360153
329a67c4-461b-4ace-acfa-80bc73ea06a3	b9aa29a7-3446-4a57-9227-f04b897053d0	Youtube	{"Y": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.360369	2025-12-10 18:30:51.360369
a2025b0e-2575-437f-bf81-08c74b04de25	b4c91d20-b980-4a02-a0c7-65a824ea2358	Tiktok	{"T": {"count": 1}}	5280.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36059	2025-12-10 18:30:51.36059
80ec3594-d5ff-4c5c-8876-5e903bf324ce	80f0e661-7d4d-4afd-b5a0-688b93830483	Youtube integration	{"Y": {"count": 1}}	5875.00	5000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.360815	2025-12-10 18:30:51.360815
80d89d6b-9636-43f1-89ba-5176cb62c943	b01467c1-c5ff-419c-a878-5a6f6692c4a1	Youtube integration	{"Y": {"count": 1}}	5750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.360998	2025-12-10 18:30:51.360998
1b1285c5-1589-46bd-9ddf-a41fadefa503	b01467c1-c5ff-419c-a878-5a6f6692c4a1	Youtube	{"Y": {"count": 1}}	8000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.361206	2025-12-10 18:30:51.361206
97bf9c0f-23b2-4441-a8f4-19812a6a0acb	47d52f8a-0574-4733-aca8-ce5f86afae48	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.361423	2025-12-10 18:30:51.361423
6cb0be0d-1c53-4950-818c-a01cc88bb1cd	168dd1ca-e812-4069-bf8d-25b4843e7973	X	{"X": {"count": 1}}	3950.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.361626	2025-12-10 18:30:51.361626
c9e6de54-a502-4af8-b06d-21a46e0b163b	3638ba04-11a1-48f9-a594-2ae8703f0e3e	Youtube	{"Y": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.361807	2025-12-10 18:30:51.361807
17cc2e5b-7c3b-4bb6-b825-f8d261d0fe71	08a2e539-1261-4c96-8955-f115d42bf27f	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	5800.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.361996	2025-12-10 18:30:51.361996
c3a920e8-cd96-4d07-8a91-6a21a125be27	7c4c65ad-dec4-4abe-93bf-6c7011711ea5	Youtube integration	{"Y": {"count": 1}}	3850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.362177	2025-12-10 18:30:51.362177
1243c871-6057-4a46-b542-04a4f4962769	e4477eab-179d-4400-aa9b-219169bf4111	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	460.00	\N	USD	magnor olarak görüşülecek, @tufanoglu telegram kullanıcı adı, eralpten bahsedilecek	\N	t	\N	\N	\N	2025-12-10 18:30:51.362385	2025-12-10 18:30:51.362385
dda67718-99d3-4579-ac0e-ac735ed7f3f3	e9a26452-e262-4411-8e73-d99449360b66	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	1600.00	1200.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.362575	2025-12-10 18:30:51.362575
6523311b-3e8b-4267-af35-78f1e73496ab	fac03169-f6bd-4c63-904f-614e89932b1b	Youtube	{"Y": {"count": 1}}	1800.00	1500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36281	2025-12-10 18:30:51.36281
be01c2d9-19d1-444d-8b06-c6055c248bd1	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	X	{"X": {"count": 1}}	600.00	500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.362996	2025-12-10 18:30:51.362996
d0111e28-be99-4ad3-a488-40ad5eda419c	3375d125-c65b-4bbc-807c-d0e15580cc9b	Buy signal, X, Telegram	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}}	180000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.363178	2025-12-10 18:30:51.363178
ec4340a8-251c-4e49-ade2-5e4e9ecf6099	cfd27e79-36d0-4646-af3d-3f66a790ca59	X	{"X": {"count": 1}}	580.00	450.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36338	2025-12-10 18:30:51.36338
bcd55dad-9c6f-45cc-bd10-b72491c71c22	6de1feb5-e286-467b-93fb-7cbf1dd12962	X	{"X": {"count": 1}}	250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.363584	2025-12-10 18:30:51.363584
6072d61d-a1f8-48ea-a1a5-f3a5907a6ceb	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	X, Telegram	{"T": {"count": 1}, "X": {"count": 1}}	2750.00	2000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36376	2025-12-10 18:30:51.36376
060b3b4b-e2d3-4c9a-b4c8-3ec6d4d1cb81	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	Youtube	{"Y": {"count": 1}}	4000.00	3500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.363954	2025-12-10 18:30:51.363954
58de29d9-b7fd-49f3-8f49-4a457bb7bd15	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	X, Telegram, Youtube, Buy signal	{"B": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	12000.00	10000.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.364166	2025-12-10 18:30:51.364166
60ba21a9-4284-43a1-8851-4c0cc0f8eb65	b9cd222b-c28c-4c28-8522-2206f37de8ef	X	{"X": {"count": 1}}	360.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.364504	2025-12-10 18:30:51.364504
89dae466-a416-4064-a5e6-42de90950b0b	e08177fb-7fc4-4c64-8b7f-4d0560d08036	Telegram	{"T": {"count": 1}}	345.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36474	2025-12-10 18:30:51.36474
7cb098a7-c398-42b1-adba-d709d4c8716f	5fc1c616-8522-4ce7-aa55-4c2ed2009365	Youtube, Tiktok	{"T": {"count": 1}, "Y": {"count": 1}}	22000.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.364922	2025-12-10 18:30:51.364922
916a327a-0fbb-4dc8-9060-91b603b276e6	5fc1c616-8522-4ce7-aa55-4c2ed2009365	Tiktok	{"T": {"count": 1}}	3300.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.365113	2025-12-10 18:30:51.365113
33f6b2ce-b0df-4506-8cca-9fc4d279c77e	3de2647b-2c7e-4be4-a1ad-da663c52b49c	Youtube integration	{"Y": {"count": 1}}	3850.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.365289	2025-12-10 18:30:51.365289
5c729f5f-f18a-40a0-a92f-3d2503cc9a20	fe3a36d9-b571-4767-87a6-d16e5b653b13	X	{"X": {"count": 1}}	5500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.365534	2025-12-10 18:30:51.365534
ad2966b3-e1c1-4c00-ba48-ead0418e8248	c9a7f368-d571-4f16-88b2-953fa413afce	Youtube	{"Y": {"count": 1}}	2815.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.365727	2025-12-10 18:30:51.365727
c25be3a2-571f-4ea2-aa29-ccb501badb83	7fa6f945-2af4-443f-ac9e-021942d58ffe	Telegram	{"T": {"count": 1}}	1240.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.365925	2025-12-10 18:30:51.365925
53fed36d-f0be-428f-9328-eb51d90be6d8	cc54cc90-5051-4d2e-8116-185ffd1d55f9	IG Story	{"I": {"count": 1}}	1540.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36613	2025-12-10 18:30:51.36613
933740fb-a063-4bd1-a4f6-99ae4cf11c77	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	X	{"X": {"count": 1}}	460.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.366402	2025-12-10 18:30:51.366402
0b0bc550-a5a1-4fbc-a59e-0efdd769934e	77004703-79c5-431a-b7b9-c61e9a5610e5	Youtube, X, Telegram, IG Reels, IG Story, X Quote	{"I": {"count": 1}, "T": {"count": 1}, "X": {"count": 1}, "Y": {"count": 1}}	56250.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.366643	2025-12-10 18:30:51.366643
2545fba1-9d00-45ed-9254-0f9abfddbcc2	74b2dfe4-603a-48cb-a0f4-2326194f571c	X	{"X": {"count": 1}}	38500.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.366845	2025-12-10 18:30:51.366845
ce5fac83-04f1-4bca-bd48-38337ca6c626	d6167946-0ac9-431d-b151-1ef742b78f5d	Youtube integration	{"Y": {"count": 1}}	2750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.36704	2025-12-10 18:30:51.36704
e6450438-3f31-419f-9555-4fdcc246fec3	cf53fa17-a86a-4d2f-b72d-3232d84fdfdf	X	{"X": {"count": 1}}	290.00	250.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.367228	2025-12-10 18:30:51.367228
d6fd6e64-4fbd-430e-b424-45f7c906ab5a	eb01735c-541b-4bc9-b357-080cdea8f749	Youtube	{"Y": {"count": 1}}	1650.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.367403	2025-12-10 18:30:51.367403
df4accc3-88d5-49a9-ac58-e29565031700	5510895e-1d4f-493b-bd7b-45c66d381b06	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.367591	2025-12-10 18:30:51.367591
22c4eb77-6c3e-4bdd-ab9d-a587f15ee417	66e31a78-d9ee-4475-8324-824f1d7a5e01	X	{"X": {"count": 1}}	2900.00	2500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.367928	2025-12-10 18:30:51.367928
0b44654f-98de-4321-aaa3-94ac4e5fd2e7	66e31a78-d9ee-4475-8324-824f1d7a5e01	Youtube integration	{"Y": {"count": 1}}	7640.00	6500.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.368101	2025-12-10 18:30:51.368101
8b72785a-9149-4c8a-9a7e-1cdc34b96e73	66e31a78-d9ee-4475-8324-824f1d7a5e01	Youtube, X	{"X": {"count": 1}, "Y": {"count": 1}}	9560.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.368287	2025-12-10 18:30:51.368287
fa6a997f-acae-45f8-b549-1fa6c3d239b6	3d26bd02-5bca-4102-bf05-d7ec0fbdaca9	Youtube	{"Y": {"count": 1}}	1380.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.368486	2025-12-10 18:30:51.368486
a93f725e-15ed-403a-8cbd-da8c9c82928c	c86137aa-11da-4736-a053-67db0a8d658d	X	{"X": {"count": 1}}	700.00	600.00	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.368698	2025-12-10 18:30:51.368698
27fa3860-183d-4b32-8640-362ae930fc38	c86137aa-11da-4736-a053-67db0a8d658d	X, Buy signal	{"B": {"count": 1}, "X": {"count": 1}}	1725.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.368889	2025-12-10 18:30:51.368889
6ffe4996-2f8f-401c-b3f2-19cc137310ec	e06c1478-8030-4267-ac23-46cdf1cb76e2	Telegram	{"T": {"count": 1}}	345.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.369077	2025-12-10 18:30:51.369077
7f0f8ce6-c508-4e21-8a24-19b3bdde872a	8c1c9363-457e-40d1-905b-7dfd9a87b1a9	Telegram	{"T": {"count": 1}}	805.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.369242	2025-12-10 18:30:51.369242
ba581f0b-ff3f-4e5e-994a-5774d53990ff	52ba9901-cd9e-4c75-a28b-3c74f84b21e5	Telegram	{"T": {"count": 1}}	575.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.369408	2025-12-10 18:30:51.369408
c0eba215-19b4-41b0-a38d-e62a3c2a9f16	db0404d3-6d7c-4c35-87e8-14c991b6b894	Telegram	{"T": {"count": 1}}	750.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.369656	2025-12-10 18:30:51.369656
447356a6-3f2b-429d-ab9a-25afd24e1039	107096f9-c4da-42a8-8b2e-bc08ff92a2c4	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.369859	2025-12-10 18:30:51.369859
eebc3c78-d9ce-4be3-a692-4bbe72b9cc7c	162986b6-6231-4b77-9305-f09c3662d29a	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.37004	2025-12-10 18:30:51.37004
c418c49a-9098-4e99-a1da-57dcb31bae7d	87991458-6510-4f9e-bcf8-59ccd6c2a424	Telegram	{"T": {"count": 1}}	960.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.370217	2025-12-10 18:30:51.370217
a56625ae-14a8-4f7d-b5b6-28d1a96f4e0e	7128f876-3e36-4dcf-b53f-1d013c870dc5	Youtube integration	{"Y": {"count": 1}}	7875.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.3704	2025-12-10 18:30:51.3704
17ec3e87-fc4e-4149-8ca8-fbbe57843366	ac84bc3f-4964-438e-ae06-145366f680e6	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.370574	2025-12-10 18:30:51.370574
412dce91-08b5-44dd-a3b4-fbb51b2962c2	28f63dbc-d59a-40ff-b38d-39ed1637e538	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.370754	2025-12-10 18:30:51.370754
1115a7c2-3d0a-45f3-aece-5c3654c1258e	32929a16-977e-4700-9ef2-21ade7141aca	X	{"X": {"count": 1}}	10690.00	\N	USD	\N	\N	t	\N	\N	\N	2025-12-10 18:30:51.370949	2025-12-10 18:30:51.370949
\.


--
-- Data for Name: kol_social_media; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kol_social_media (id, kol_id, social_media_id, link, follower_count, engagement_rate, verified, created_at, updated_at) FROM stdin;
6d234b94-237f-4710-b1a5-fd531dd49089	a08f7952-90d4-4354-b8b9-5c0a5e255d9e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xilhm	\N	\N	f	2025-12-10 18:19:12.021849	2025-12-10 18:19:12.021849
9e815f62-793e-4ed1-b36b-83d2338c08aa	92444995-2431-4c5f-a13c-7c2cc5ee7d30	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xmrred	\N	\N	f	2025-12-10 18:19:12.030673	2025-12-10 18:19:12.030673
b93ba4d4-e9ce-4dbd-b993-b6322ac02244	74e78d28-5150-484b-9db2-9446b75381d5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xRemiss	\N	\N	f	2025-12-10 18:19:12.033398	2025-12-10 18:19:12.033398
82a324e5-b080-4294-b373-a0279362956b	90cf70d3-9e96-408e-a2ba-36d6a28cef4a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/AirdropTurkiyeDuyuru	\N	\N	f	2025-12-10 18:19:12.036923	2025-12-10 18:19:12.036923
8a2c71a6-4eac-43b8-8e26-c0ce9d0e0b52	edf54653-87a6-4af9-918b-71e27114f074	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Airdropakd/	\N	\N	f	2025-12-10 18:19:12.03987	2025-12-10 18:19:12.03987
4da7a2fb-211d-4521-b9cf-d78e6f8b1a3e	edf54653-87a6-4af9-918b-71e27114f074	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/AKDDuyuru	\N	\N	f	2025-12-10 18:19:12.04039	2025-12-10 18:19:12.04039
5552cbb4-8139-47ed-8439-b0ceba62055c	e03a2d3a-3282-4b79-a7cd-56b93fd3b598	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/alitekintr?s=21	\N	\N	f	2025-12-10 18:19:12.042504	2025-12-10 18:19:12.042504
f7374963-a8ed-4254-834e-fcf9b1e66329	d54d1f0e-4025-4958-a212-cdfe52009005	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/c_alphahost	\N	\N	f	2025-12-10 18:19:12.044354	2025-12-10 18:19:12.044354
89e07161-3484-4186-b039-5b7ecd272322	da40d652-d045-4bff-8a32-e8003411b36b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/altcoinrookie	\N	\N	f	2025-12-10 18:19:12.046388	2025-12-10 18:19:12.046388
b6f738e8-bbe0-4fcd-b3e3-836e632cd2f7	da40d652-d045-4bff-8a32-e8003411b36b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Rookiesohbet	\N	\N	f	2025-12-10 18:19:12.046967	2025-12-10 18:19:12.046967
5439a656-a0e0-4ce8-8e20-cf1fea34bb9f	c40a0124-19fe-4651-a59a-28cf46fbd787	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/atamertuysaler	\N	\N	f	2025-12-10 18:19:12.048536	2025-12-10 18:19:12.048536
d9759806-dca4-49cb-9711-f2af79625f04	c40a0124-19fe-4651-a59a-28cf46fbd787	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/Atamertuysaler	\N	\N	f	2025-12-10 18:19:12.048978	2025-12-10 18:19:12.048978
310603d4-276d-46d3-a4d0-ec3de774514a	a40312dd-0331-4a25-bed6-2b05e9152fbf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/BtBanaLiz	\N	\N	f	2025-12-10 18:19:12.050738	2025-12-10 18:19:12.050738
f18f96d4-2543-48bc-b9c4-ab4fb4f2ab87	a40312dd-0331-4a25-bed6-2b05e9152fbf	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/BtBanaliz	\N	\N	f	2025-12-10 18:19:12.051152	2025-12-10 18:19:12.051152
6851b64d-acfa-42ac-8eab-6456c3e96b10	52494623-468b-4439-9818-d36645830dd0	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/barbiecoinn?s=21	\N	\N	f	2025-12-10 18:19:12.052813	2025-12-10 18:19:12.052813
f9a19b5c-d0ae-4a66-8157-c915ff0d3b79	d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/barisbuyuktas	\N	\N	f	2025-12-10 18:19:12.054677	2025-12-10 18:19:12.054677
cac79add-c50d-4ab1-becc-3864b5cced00	f735e4c0-39c3-4c66-92ad-908f7461a84f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/ReturntoTrading	\N	\N	f	2025-12-10 18:19:12.057137	2025-12-10 18:19:12.057137
e6dc26cc-05ea-430d-adfd-8ac9950022bf	c5055660-0373-4b7a-8842-b53c9d810bc9	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KardesBaris	\N	\N	f	2025-12-10 18:19:12.059802	2025-12-10 18:19:12.059802
70a4c5e5-70a9-4f3a-a062-2f2013f2b3c9	10a0228d-8083-41d2-a11f-7fe4a61bbc16	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/batikaneth	\N	\N	f	2025-12-10 18:19:12.061584	2025-12-10 18:19:12.061584
9896ff2a-3971-44b5-a3bb-84ca9258ba23	3a08982c-087b-47cf-8b8f-1a7afb5e4081	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/nuhbatuhann	\N	\N	f	2025-12-10 18:19:12.063127	2025-12-10 18:19:12.063127
bb1d866e-f75c-411c-b9fb-28344291cc0f	afec6c13-3295-4055-abeb-9d3d7329bb4b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@BerkayBerksun/videos	\N	\N	f	2025-12-10 18:19:12.064488	2025-12-10 18:19:12.064488
4d9d9c7e-4366-489c-9172-773354502e8d	afec6c13-3295-4055-abeb-9d3d7329bb4b	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/BBTRD	\N	\N	f	2025-12-10 18:19:12.064861	2025-12-10 18:19:12.064861
31243024-4d57-440c-9223-15d2d1c2d493	05676f72-39b2-41e3-9957-a3a5b8d3cf3b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Bitcoinmeraklsi	\N	\N	f	2025-12-10 18:19:12.06615	2025-12-10 18:19:12.06615
7836d261-ba28-4b4e-a947-81cc24eb3a9a	cd1b83c9-d393-4140-b9aa-a03c8ad0cf20	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Bitcoinmeraklsi?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor	\N	\N	f	2025-12-10 18:19:12.067324	2025-12-10 18:19:12.067324
bbaf5ed9-38d7-4dc0-a3cc-a1669b16c39c	eb46fe18-5c1f-4b32-9071-63daa3da0e28	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/borsaressami	\N	\N	f	2025-12-10 18:19:12.06884	2025-12-10 18:19:12.06884
41849478-2e5a-47c5-8195-b91e53ea2c67	eb46fe18-5c1f-4b32-9071-63daa3da0e28	77386a88-6ca3-44af-916f-807a0558671d	https://web.telegram.org/k/#@borsaressamitelegram	\N	\N	f	2025-12-10 18:19:12.069231	2025-12-10 18:19:12.069231
e07dc1d4-0d45-419c-847c-9b9e25d47586	26de4eaa-09f2-4943-ab51-f32f20f48e25	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Braatuu	\N	\N	f	2025-12-10 18:19:12.070996	2025-12-10 18:19:12.070996
e120a8a5-8851-472e-9fae-7e3e7e51685b	6cca21a7-d9b0-4c72-8743-d0c4d18861ae	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@bucoinedir	\N	\N	f	2025-12-10 18:19:12.072016	2025-12-10 18:19:12.072016
418dd6af-d38b-4a71-ad98-31158c4dcc0e	6cca21a7-d9b0-4c72-8743-d0c4d18861ae	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/bucoinedirr	\N	\N	f	2025-12-10 18:19:12.072399	2025-12-10 18:19:12.072399
db22fcfa-208e-4934-9898-562069fdc78f	849504e9-4b12-4f8c-946e-21eca7000980	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CaglahanEth	\N	\N	f	2025-12-10 18:19:12.073326	2025-12-10 18:19:12.073326
44ee8e8a-0da2-4877-8819-4136f2107a60	654a9fd7-e1fa-4ade-938c-dc90713e4f35	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CasanovaWeb3	\N	\N	f	2025-12-10 18:19:12.074473	2025-12-10 18:19:12.074473
5716c125-9f17-4dfd-b5a9-7123d08cb6d7	f3a3819e-212b-4aeb-a8fe-779243323abe	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CemalTheMM	\N	\N	f	2025-12-10 18:19:12.075598	2025-12-10 18:19:12.075598
abf65783-ace9-425b-ba6b-d4ab55a354e2	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cihan0xeth	\N	\N	f	2025-12-10 18:19:12.076645	2025-12-10 18:19:12.076645
3a99157a-d441-49d1-8ec2-3a1b6eb4675d	8db1d0c5-9103-4cc7-aab4-8653349d2cd4	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/KaspaTr	\N	\N	f	2025-12-10 18:19:12.07755	2025-12-10 18:19:12.07755
4fb4f546-b336-44e7-87b9-53388bc59fd9	40331030-31cb-4391-913b-acd387389679	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/cihan0xeth	\N	\N	f	2025-12-10 18:19:12.079415	2025-12-10 18:19:12.079415
711e25e7-4624-4cee-ab0f-564cce10f0be	9467920b-47ff-4786-ab2d-ba71bedb4520	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/coinagend	\N	\N	f	2025-12-10 18:19:12.081211	2025-12-10 18:19:12.081211
b2d31722-a5c1-4e18-9c22-8ee488b791b2	449eb148-3918-483d-ad31-078456bbfddc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CoinHuntersTR/videos	\N	\N	f	2025-12-10 18:19:12.082473	2025-12-10 18:19:12.082473
4a1501ea-86b5-4d46-ad11-2e12d82b165a	449eb148-3918-483d-ad31-078456bbfddc	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/coinhunterstr	\N	\N	f	2025-12-10 18:19:12.082826	2025-12-10 18:19:12.082826
2afcf37f-77c4-45f5-a110-e0c48e4d4e3d	c432674b-3697-4c92-9698-61ef46eedbe7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/coinuzmann	\N	\N	f	2025-12-10 18:19:12.083827	2025-12-10 18:19:12.083827
c05eedd4-9bba-4906-831a-e1728b20a47e	c432674b-3697-4c92-9698-61ef46eedbe7	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/coinuzmann	\N	\N	f	2025-12-10 18:19:12.084053	2025-12-10 18:19:12.084053
2935dcd3-cbe8-4d33-8d2c-febbafff7de1	a8e73e8b-e412-4d9b-971d-1bfb59309abb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/coinkritik	\N	\N	f	2025-12-10 18:19:12.085245	2025-12-10 18:19:12.085245
65efe4ff-a25d-4d52-a212-1be55750e389	8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xCoolPanda	\N	\N	f	2025-12-10 18:19:12.087084	2025-12-10 18:19:12.087084
01a9b090-6908-4d80-aebd-5103942c04f8	be5f976b-114d-4308-8242-52d14f4e9aa6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KriptoChef	\N	\N	f	2025-12-10 18:19:12.089824	2025-12-10 18:19:12.089824
d4271707-5190-45dd-addf-ec0360a586e6	be5f976b-114d-4308-8242-52d14f4e9aa6	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+C1KnLM_PEz04Zjg0	\N	\N	f	2025-12-10 18:19:12.090103	2025-12-10 18:19:12.090103
42493493-e0e2-4cf5-8790-ae72e802c2a1	ac955c91-0b4f-4e7b-97e3-6d29389cf196	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoCNR	\N	\N	f	2025-12-10 18:19:12.091844	2025-12-10 18:19:12.091844
534031a3-810d-4dc0-a11b-337c54abf265	ac955c91-0b4f-4e7b-97e3-6d29389cf196	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/CNRtrade	\N	\N	f	2025-12-10 18:19:12.092146	2025-12-10 18:19:12.092146
8bef2b5b-1b82-4d8e-815f-4802e409fc49	b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@cryptoepoch/videos	\N	\N	f	2025-12-10 18:19:12.093881	2025-12-10 18:19:12.093881
d044dedd-9676-435b-b68f-bd48c9e3a724	b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/cryptoepochchannell	\N	\N	f	2025-12-10 18:19:12.094155	2025-12-10 18:19:12.094155
5d1983d6-6b95-4e21-8d0e-4ca108570495	7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoHocam/videos	\N	\N	f	2025-12-10 18:19:12.09519	2025-12-10 18:19:12.09519
028c969b-d666-455a-8b02-68253ea390c8	7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/CRYPTOHOCAM1	\N	\N	f	2025-12-10 18:19:12.095426	2025-12-10 18:19:12.095426
237de065-d825-4968-b616-d93106a84844	9272a0a5-0def-403f-8dad-475fa62fdc71	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@makercrypto/videos	\N	\N	f	2025-12-10 18:19:12.096395	2025-12-10 18:19:12.096395
7038d58e-c738-4d64-85a3-ede12d498ac8	8bb3e252-e66b-4477-a145-8b03c028805d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoNeoo	\N	\N	f	2025-12-10 18:19:12.098491	2025-12-10 18:19:12.098491
0f8fa34e-4373-4e45-977b-2c08d1ac38b2	df663153-02e1-4bf6-8f3b-ac3efeefdb48	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptOguuz	\N	\N	f	2025-12-10 18:19:12.100719	2025-12-10 18:19:12.100719
e85355f6-ff72-4c97-aeca-44513f1de7c1	54848923-af3c-4528-a36f-b86babd69225	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/ByScarFacee	\N	\N	f	2025-12-10 18:19:12.101694	2025-12-10 18:19:12.101694
c852ebb2-120b-4503-aad7-79b9d8f1b4b9	b2e93254-185e-4547-a363-eb5a99078141	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoTroia	\N	\N	f	2025-12-10 18:19:12.102854	2025-12-10 18:19:12.102854
eeb646fd-2621-4ced-9dce-4b260f177a3c	b2e93254-185e-4547-a363-eb5a99078141	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptotroia	\N	\N	f	2025-12-10 18:19:12.10326	2025-12-10 18:19:12.10326
53cdcb41-cdc5-402e-838c-2558fe39694a	15520237-b54c-4912-abf0-f29c1499181d	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptoaty	\N	\N	f	2025-12-10 18:19:12.104394	2025-12-10 18:19:12.104394
a7d064ee-e232-4073-9b62-124d7b8b9241	15520237-b54c-4912-abf0-f29c1499181d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/cryptoaty	\N	\N	f	2025-12-10 18:19:12.104652	2025-12-10 18:19:12.104652
a0a7cfea-48c6-4f27-9218-eededbf3edc4	47abda88-d904-4402-8257-1e88c0ff6ef5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptObjektiff	\N	\N	f	2025-12-10 18:19:12.10561	2025-12-10 18:19:12.10561
8e755e04-8f2f-4380-94c2-380d72231061	1fec272f-7562-488b-9ec9-eff4656dcabe	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CRYTPOIDO/featured	\N	\N	f	2025-12-10 18:19:12.107756	2025-12-10 18:19:12.107756
aa68f2d3-f181-465b-af82-e51929cb973a	1fec272f-7562-488b-9ec9-eff4656dcabe	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptoid0	\N	\N	f	2025-12-10 18:19:12.108102	2025-12-10 18:19:12.108102
8ccca78e-f04d-4d98-bbfb-e620737b6a35	508162b5-5cc2-4cbe-932c-cccc7c7c526f	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptolft	\N	\N	f	2025-12-10 18:19:12.109123	2025-12-10 18:19:12.109123
b8c686a3-6951-4203-b39a-295b14315e16	003b2d41-7de0-4eec-8fe2-17374ae91d58	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptotrfacts	\N	\N	f	2025-12-10 18:19:12.109744	2025-12-10 18:19:12.109744
3a597506-f76a-4907-aa18-8e1c6c84cf85	003b2d41-7de0-4eec-8fe2-17374ae91d58	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptotrfacts	\N	\N	f	2025-12-10 18:19:12.109877	2025-12-10 18:19:12.109877
9df9e4de-dc38-469f-89a5-c1fdcb1d9bf7	e0f32a2f-a1b6-4bce-9a48-3407f24062a5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/caylakkriptocu?app=desktop	\N	\N	f	2025-12-10 18:19:12.110666	2025-12-10 18:19:12.110666
176c5edf-3bb8-475d-8df2-52ffb463c25b	e0f32a2f-a1b6-4bce-9a48-3407f24062a5	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/caylakkriptocu	\N	\N	f	2025-12-10 18:19:12.11081	2025-12-10 18:19:12.11081
557f3ef1-029d-4a01-95a0-5d4d0004726b	281f97e5-14e2-4a93-80af-80e0ed98bcff	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/coindoktorunuz	\N	\N	f	2025-12-10 18:19:12.11142	2025-12-10 18:19:12.11142
0b413294-9512-405d-9339-0c38d3c517b5	281f97e5-14e2-4a93-80af-80e0ed98bcff	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/coindoktorunuzresmi	\N	\N	f	2025-12-10 18:19:12.111557	2025-12-10 18:19:12.111557
96491379-80ab-4a72-bec8-ba5e1b1fb0cc	f4b5744a-8dd0-4504-ba9c-be8992240fe3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoEliif	\N	\N	f	2025-12-10 18:19:12.112505	2025-12-10 18:19:12.112505
6cbb7bea-2fde-45a2-978b-1cce2a1a9618	186b1700-46b2-4e9f-b961-5f86f5efbfc1	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@ElitTurk/videos	\N	\N	f	2025-12-10 18:19:12.113177	2025-12-10 18:19:12.113177
22c6fc02-0f2d-488f-9588-cb25248b8a9a	186b1700-46b2-4e9f-b961-5f86f5efbfc1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/TurkElit	\N	\N	f	2025-12-10 18:19:12.113432	2025-12-10 18:19:12.113432
4b963883-292c-4e1a-bf3d-25b41d458fb4	e6ef5e56-45a6-4c7c-a540-afc90b193143	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/locksmithcrypto	\N	\N	f	2025-12-10 18:19:12.113941	2025-12-10 18:19:12.113941
0a4b7fec-54d9-4d2e-8bb8-ed3b4515f9b5	c6fb0205-1405-4198-940d-5c075949c13e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/engineer_trader?s=21	\N	\N	f	2025-12-10 18:19:12.114757	2025-12-10 18:19:12.114757
9c099f2e-a2bb-44a9-9bc4-4908426e8820	f09eb623-3bbd-4771-b853-aef41da517ed	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@ExpertKripto/videos	\N	\N	f	2025-12-10 18:19:12.115286	2025-12-10 18:19:12.115286
5449029a-0ff8-4fb0-a7a8-729536a0361b	f09eb623-3bbd-4771-b853-aef41da517ed	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/expertkriptotelegram	\N	\N	f	2025-12-10 18:19:12.115411	2025-12-10 18:19:12.115411
e356a745-7e30-4726-85ef-6d9450922cb4	d8fd8b3f-5e45-4e37-8a50-85bcbf23efd4	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@ExpertPara	\N	\N	f	2025-12-10 18:19:12.115933	2025-12-10 18:19:12.115933
c7843676-7298-4581-893d-b9bec9cc2fbc	0a2f4d54-807c-4e33-866b-cfc22845d6e6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptofati	\N	\N	f	2025-12-10 18:19:12.116438	2025-12-10 18:19:12.116438
74e947dd-712c-4d8e-a540-37750b80566b	fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xfersah	\N	\N	f	2025-12-10 18:19:12.117124	2025-12-10 18:19:12.117124
3e633011-dc11-4e43-abaf-552cbf9156c6	8ea77d03-8233-49e8-b39b-262daada91aa	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Mkar34	\N	\N	f	2025-12-10 18:19:12.118236	2025-12-10 18:19:12.118236
5587ff8f-d132-4a36-8ecd-1ad60b904dc7	8ea77d03-8233-49e8-b39b-262daada91aa	77386a88-6ca3-44af-916f-807a0558671d	https://web.telegram.org/k/#@fitmiyiz	\N	\N	f	2025-12-10 18:19:12.118403	2025-12-10 18:19:12.118403
0cc687eb-bb37-492c-8289-0b8796df6519	888cbfe3-9c4b-4456-9d33-f72e0d002456	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Foxyyeth	\N	\N	f	2025-12-10 18:19:12.119076	2025-12-10 18:19:12.119076
44b80d30-32e5-44a9-af79-725448fcb5d0	df953e7c-659b-401e-a906-7b25f29fca41	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/genelpatron01	\N	\N	f	2025-12-10 18:19:12.12002	2025-12-10 18:19:12.12002
17ae84b1-f1c9-4a32-a9c8-671f5f93e633	df953e7c-659b-401e-a906-7b25f29fca41	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/genelpatron	\N	\N	f	2025-12-10 18:19:12.120196	2025-12-10 18:19:12.120196
b1b01b89-9bec-4054-bbe4-e7453f6d4032	88615501-f3e3-434c-bbff-9d5178d9274c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/CryptoGenzo	\N	\N	f	2025-12-10 18:19:12.120848	2025-12-10 18:19:12.120848
0dcf29a8-a392-49a4-8c58-d4c5a1f3f91b	88615501-f3e3-434c-bbff-9d5178d9274c	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/CoinGenzo	\N	\N	f	2025-12-10 18:19:12.12109	2025-12-10 18:19:12.12109
9f2d6c93-c808-4d4e-9270-21488cf64ade	febfc4b3-6c2f-4353-9059-2639e24ffec6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/mgokhanduman	\N	\N	f	2025-12-10 18:19:12.122466	2025-12-10 18:19:12.122466
22d632a9-c1e1-477d-9600-d79bcfa7aede	e90ebec3-3bc2-49b1-8548-173d50dd8873	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/GokhanGark	\N	\N	f	2025-12-10 18:19:12.123355	2025-12-10 18:19:12.123355
da1c7cda-d21a-4f25-a29f-2c9b2b285e1a	2f3b4d72-0a9a-49e2-8985-50c9d816da4c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/hanturksc	\N	\N	f	2025-12-10 18:19:12.123999	2025-12-10 18:19:12.123999
2467626b-7e2e-4e0d-b4c5-71da0a5c36b2	2f3b4d72-0a9a-49e2-8985-50c9d816da4c	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Kriptohantr	\N	\N	f	2025-12-10 18:19:12.124165	2025-12-10 18:19:12.124165
f2f5fb16-15b5-4531-b32e-8ceeea01515d	83c11014-e12b-466b-a09d-e5ae72fc71ba	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/hasanankatr	\N	\N	f	2025-12-10 18:19:12.124907	2025-12-10 18:19:12.124907
c2c8e1d8-4409-4609-9148-5744cfd4abb7	84e5e479-8261-4a7c-a14d-08ba739fda95	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/HASOsyalmedya	\N	\N	f	2025-12-10 18:19:12.125534	2025-12-10 18:19:12.125534
622a10a2-313a-41be-855e-f78cf24dc8e1	43794457-3218-4378-8092-8391571c3ff3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/HeathleyETH	\N	\N	f	2025-12-10 18:19:12.12614	2025-12-10 18:19:12.12614
7399360f-873b-4f59-9c32-6a2bf71f6862	1ce65635-3d69-4b87-897d-1b42d241b66e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/hirozaki2020	\N	\N	f	2025-12-10 18:19:12.127071	2025-12-10 18:19:12.127071
f062af62-2b3c-4847-b0c5-38a495d1b1b5	38a50ecf-a0c9-4789-afff-10c9c04312fc	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/howtousecrypto	\N	\N	f	2025-12-10 18:19:12.12779	2025-12-10 18:19:12.12779
35517c50-dd19-49e8-9071-072ba52b5e38	f88e97b1-176a-4468-8fc8-f2c5c7c272e5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/doruk1st	\N	\N	f	2025-12-10 18:19:12.128759	2025-12-10 18:19:12.128759
2f21a0f5-61df-4098-a1ef-5f5258814b22	2c32254c-b0e3-4fe5-942c-70518f6be97b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/xbtirfan	\N	\N	f	2025-12-10 18:19:12.129926	2025-12-10 18:19:12.129926
eb018d5a-6ac7-4c77-9822-bcff75c993a1	ad10b365-44b2-4b4c-bd9b-6b15a885598c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/jesscoin	\N	\N	f	2025-12-10 18:19:12.130541	2025-12-10 18:19:12.130541
1ef2274e-09c9-480d-b256-c201f8fd2d68	1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KadirSquirrel	\N	\N	f	2025-12-10 18:19:12.131278	2025-12-10 18:19:12.131278
85c0e65b-f6eb-4336-b1fe-330d7f2de43e	1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/kadirsquirrel	\N	\N	f	2025-12-10 18:19:12.131428	2025-12-10 18:19:12.131428
73ac1c24-c53f-4293-9575-f6eb3ee6265a	f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptokahin	\N	\N	f	2025-12-10 18:19:12.132055	2025-12-10 18:19:12.132055
50055e55-e5dc-4edd-a619-32ea3be794c2	8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kerimcalender	\N	\N	f	2025-12-10 18:19:12.13282	2025-12-10 18:19:12.13282
dfc6e8df-9541-4585-81f5-747516aeb47c	c54006c7-737c-494d-8d18-b9de72a4d867	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KoinSaati?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor	\N	\N	f	2025-12-10 18:19:12.135333	2025-12-10 18:19:12.135333
8893fc06-bf88-4d58-9cf9-6771e5104cc6	c54006c7-737c-494d-8d18-b9de72a4d867	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/koinsaati	\N	\N	f	2025-12-10 18:19:12.135503	2025-12-10 18:19:12.135503
5bc4da04-0e40-43e5-b383-7c324ecdbf8f	c54006c7-737c-494d-8d18-b9de72a4d867	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KoinSaati	\N	\N	f	2025-12-10 18:19:12.135691	2025-12-10 18:19:12.135691
5e8e3665-7d0a-4a6e-9fe8-336d71e01ad3	b6f673cd-c892-4a6b-80e4-e35d5047f905	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kripto_cem	\N	\N	f	2025-12-10 18:19:12.136708	2025-12-10 18:19:12.136708
d9e8650c-c6da-4565-a3df-9ef6cc7f4101	a50e21e7-b8e2-4678-a731-2602f1dd2bdb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KriptoEfsanesi	\N	\N	f	2025-12-10 18:19:12.137815	2025-12-10 18:19:12.137815
12febda8-1245-4329-b6cb-b58f243e4f7e	89184324-3bd9-4479-91d8-05dbb8704734	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/user/iakgun28101993	\N	\N	f	2025-12-10 18:19:12.138915	2025-12-10 18:19:12.138915
a29d6979-5850-405e-afc0-fa07fac099e1	89184324-3bd9-4479-91d8-05dbb8704734	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/kriptogelisim	\N	\N	f	2025-12-10 18:19:12.139111	2025-12-10 18:19:12.139111
072e9eea-6995-46a5-9c83-027e188f2527	89184324-3bd9-4479-91d8-05dbb8704734	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptogelisim	\N	\N	f	2025-12-10 18:19:12.139281	2025-12-10 18:19:12.139281
71726720-ab8d-44cb-9d95-ddcfd4f04d73	ee52295a-a14a-438d-8e93-b42966b44f57	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Kripto_HaYalet	\N	\N	f	2025-12-10 18:19:12.140535	2025-12-10 18:19:12.140535
b3f4e449-e7e5-47ca-a1c2-f5cf1530a6a0	3a5c5674-5f0c-4d4f-83de-6557052c9cd6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptoholder	\N	\N	f	2025-12-10 18:19:12.141294	2025-12-10 18:19:12.141294
b74b19ad-13e2-4afe-b9dc-424668e34829	bb789f23-6d06-4380-a752-b391c3380210	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KriptoKafalar	\N	\N	f	2025-12-10 18:19:12.141995	2025-12-10 18:19:12.141995
ebdbe79d-0b20-40d7-94e9-c032529c3766	bb789f23-6d06-4380-a752-b391c3380210	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/addlist/IYwGmiNn6Ng1NGJk	\N	\N	f	2025-12-10 18:19:12.14215	2025-12-10 18:19:12.14215
4d679a8f-534d-4275-8554-1b8249e48479	820af3e2-669e-43fd-9a5a-12cb06e50d80	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kahincryptocu	\N	\N	f	2025-12-10 18:19:12.142779	2025-12-10 18:19:12.142779
befc8b21-e431-451d-99b3-1223a47b4fd8	66f3145c-53d4-4244-91b4-0b84fdc87097	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptokraliyeni	\N	\N	f	2025-12-10 18:19:12.143792	2025-12-10 18:19:12.143792
aebc6005-d150-44b3-b421-4f3107f2370d	66f3145c-53d4-4244-91b4-0b84fdc87097	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+0-PP8sP3XkJlOTI0	\N	\N	f	2025-12-10 18:19:12.143961	2025-12-10 18:19:12.143961
0f7758f4-52ea-4b9c-82df-214e90f22a8b	10b7a7d7-e824-4296-a746-e88fc7511cd8	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KriptoNedir/featured	\N	\N	f	2025-12-10 18:19:12.144771	2025-12-10 18:19:12.144771
17a7e40a-014e-41f2-9049-fbd1626c9f0b	10b7a7d7-e824-4296-a746-e88fc7511cd8	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/Cryptolkm	\N	\N	f	2025-12-10 18:19:12.144938	2025-12-10 18:19:12.144938
10cb89d1-9a36-43e6-9fac-6d3f4943227a	02e32b42-7818-40fc-8014-22afc4e69092	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@kriptoofis	\N	\N	f	2025-12-10 18:19:12.1456	2025-12-10 18:19:12.1456
669a9cae-3458-4109-8938-9910ac32af65	02e32b42-7818-40fc-8014-22afc4e69092	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/kriptoofisresmi	\N	\N	f	2025-12-10 18:19:12.145744	2025-12-10 18:19:12.145744
2e726270-662c-4bfa-ab25-68b432719b76	ca768075-e597-4929-9a5c-d749932ee0a1	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KriptoSozluk	\N	\N	f	2025-12-10 18:19:12.146367	2025-12-10 18:19:12.146367
48192b78-7e48-4792-b1d0-a468476cca67	ca768075-e597-4929-9a5c-d749932ee0a1	a833496d-d109-42f7-a01f-be2a3180e5df	tiktok.com/@kriptosozluk	\N	\N	f	2025-12-10 18:19:12.146544	2025-12-10 18:19:12.146544
0b896ac4-1ff3-4e80-92b0-3f88e2992762	ca768075-e597-4929-9a5c-d749932ee0a1	77386a88-6ca3-44af-916f-807a0558671d	t.me/KriptoSozlukTVPiyasaMuhabbeti	\N	\N	f	2025-12-10 18:19:12.146695	2025-12-10 18:19:12.146695
5e947af6-a6be-4a06-b917-435792aa6acb	ca768075-e597-4929-9a5c-d749932ee0a1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	twitter.com/KriptoSozlukTV	\N	\N	f	2025-12-10 18:19:12.146843	2025-12-10 18:19:12.146843
b2e05e31-e85d-4ab6-ae12-d8a354574409	fe9fc6f0-2e95-4434-b379-9cf7cf7487c7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptowarrior	\N	\N	f	2025-12-10 18:19:12.147655	2025-12-10 18:19:12.147655
67b01389-b45e-46f0-82cc-57ae661e11d2	20bdeac7-b480-41bb-8f7a-1099626e3249	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptozenciii	\N	\N	f	2025-12-10 18:19:12.148403	2025-12-10 18:19:12.148403
d723afd6-6dec-4e00-b699-ab27efe58f84	20bdeac7-b480-41bb-8f7a-1099626e3249	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+8heC9mqk7y00ODI0	\N	\N	f	2025-12-10 18:19:12.148559	2025-12-10 18:19:12.148559
50e35f58-2038-4a00-93a3-fa36bc72e86f	f390519c-40ea-4450-a54f-1e466b920e90	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptobi	\N	\N	f	2025-12-10 18:19:12.149358	2025-12-10 18:19:12.149358
6d251a00-b06a-426c-9847-33ab5565478e	f390519c-40ea-4450-a54f-1e466b920e90	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kriptobiduyuru	\N	\N	f	2025-12-10 18:19:12.149503	2025-12-10 18:19:12.149503
c5b735e1-2c6c-435c-87b8-427bb009c41e	2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lKriptoBluel	\N	\N	f	2025-12-10 18:19:12.150127	2025-12-10 18:19:12.150127
0a903870-d272-4848-ba22-da70ca0a379b	6a0a2d6f-4e55-4a9f-85db-5a653c93d682	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptokrat5	\N	\N	f	2025-12-10 18:19:12.150941	2025-12-10 18:19:12.150941
eb526919-1cc0-4c4b-b758-f4641d253644	6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KriptoliaTR	\N	\N	f	2025-12-10 18:19:12.152101	2025-12-10 18:19:12.152101
276c284b-a2d5-4d6a-a651-1565ba2169bb	4f7141d7-ac31-4e32-8776-b4660f5c296b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/theKriptolik	\N	\N	f	2025-12-10 18:19:12.15309	2025-12-10 18:19:12.15309
88cd0bb9-4142-4aa0-a8f4-2d1f15e830e6	4f7141d7-ac31-4e32-8776-b4660f5c296b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/theKriptolik	\N	\N	f	2025-12-10 18:19:12.15385	2025-12-10 18:19:12.15385
0af9e44c-3e0c-4d64-b78a-1add9153dde8	6018f5e5-eb1b-4335-aef1-18b0e410cc15	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KriptoLisa	\N	\N	f	2025-12-10 18:19:12.154883	2025-12-10 18:19:12.154883
ba17f542-78d4-463f-afe8-4620020d80fa	f0464a49-5b3a-477f-b898-579fbf10c159	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptoloki/status/1962579658211230189	\N	\N	f	2025-12-10 18:19:12.155586	2025-12-10 18:19:12.155586
64ca6c48-769b-4fae-8de0-cd4016927956	815b489f-3c8b-4439-b18d-79ac234d198e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptoman0	\N	\N	f	2025-12-10 18:19:12.156209	2025-12-10 18:19:12.156209
ed52f32d-2de5-4b9d-80bd-e52f75a26a88	6d6ef876-21ca-47a0-9200-095074791c96	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/islakwcterlii	\N	\N	f	2025-12-10 18:19:12.157279	2025-12-10 18:19:12.157279
b3ca8248-02ba-4ea4-930c-78b77a09d0fb	6d6ef876-21ca-47a0-9200-095074791c96	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kuzeydurdenduyuru	\N	\N	f	2025-12-10 18:19:12.157521	2025-12-10 18:19:12.157521
4f22915f-9021-47a4-83f1-0bd55649955f	6d6ef876-21ca-47a0-9200-095074791c96	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@kuzeydurden	\N	\N	f	2025-12-10 18:19:12.157737	2025-12-10 18:19:12.157737
63c53bb4-f0f8-462c-88bd-1d0edcf18268	952bbd57-f1c2-4aa8-8fac-ae689e19e0d8	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptolacasa	\N	\N	f	2025-12-10 18:19:12.158525	2025-12-10 18:19:12.158525
18fba88a-23a4-46c7-ab3e-2192c13c5c26	b868509d-79d9-492e-b250-33a34d8cb0e8	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoLego0311	\N	\N	f	2025-12-10 18:19:12.159489	2025-12-10 18:19:12.159489
41bffd14-aecf-43e3-8ab1-9b0d8519b0b5	7f2823e2-582f-4120-90d9-fd7d02ece572	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lord_of_crypto_	\N	\N	f	2025-12-10 18:19:12.161221	2025-12-10 18:19:12.161221
3aac40f0-448a-41d4-be9e-54846616fec2	92610a49-08e0-4bc3-b61c-9bbf8adee414	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/btcoinmag	\N	\N	f	2025-12-10 18:19:12.162003	2025-12-10 18:19:12.162003
3290502d-d8a2-41aa-9f4e-82bad544d794	92610a49-08e0-4bc3-b61c-9bbf8adee414	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/crpyomag	\N	\N	f	2025-12-10 18:19:12.162207	2025-12-10 18:19:12.162207
e0a288c2-04d3-4b3e-a354-d41c2c6c092b	7392cd69-e132-40c8-af99-dec18965f901	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/mamiicrypto	\N	\N	f	2025-12-10 18:19:12.163493	2025-12-10 18:19:12.163493
7f2004bd-35dc-4e91-a6bd-5841733697ed	7392cd69-e132-40c8-af99-dec18965f901	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/MAM_crypto	\N	\N	f	2025-12-10 18:19:12.163678	2025-12-10 18:19:12.163678
130ed3ff-8c44-43fb-b923-97b374385a6c	0781049d-3f4f-4184-86be-abd5b52d47e3	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@melikbersah	\N	\N	f	2025-12-10 18:19:12.164469	2025-12-10 18:19:12.164469
15a5c42d-dad1-4da3-85cb-7d5e7ede5aa5	0781049d-3f4f-4184-86be-abd5b52d47e3	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/melikbersah	\N	\N	f	2025-12-10 18:19:12.164641	2025-12-10 18:19:12.164641
1db091cd-fc49-4def-ba3f-b88d4546f411	48cfe773-1b13-41b3-92cf-f48af45125cb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/mericfi	\N	\N	f	2025-12-10 18:19:12.165392	2025-12-10 18:19:12.165392
a4a971bd-196c-4024-951c-321745d7f7e6	edaab8c7-830a-461a-8d12-026793c0ab63	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/mesgo_	\N	\N	f	2025-12-10 18:19:12.166213	2025-12-10 18:19:12.166213
c396f17c-d99f-4ae0-9169-32157eb178a1	b1780c0f-40ae-427a-ad1c-bf6f160dd8ff	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kriptomete_	\N	\N	f	2025-12-10 18:19:12.166922	2025-12-10 18:19:12.166922
c5f69177-7f31-4b75-84a2-890b5257e9f9	91b8f309-8a61-4967-b5e3-469a9e494ebf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/milyonerzihin	\N	\N	f	2025-12-10 18:19:12.168261	2025-12-10 18:19:12.168261
afad1e7c-fedd-4db7-8e9e-6c160696db93	91b8f309-8a61-4967-b5e3-469a9e494ebf	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptohakantg	\N	\N	f	2025-12-10 18:19:12.168431	2025-12-10 18:19:12.168431
78c2aba2-931d-47d9-82bc-cdff1c3bc7b9	2dc7b740-47c4-4dad-8e93-b9bf036609b6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/muratmmturk	\N	\N	f	2025-12-10 18:19:12.169194	2025-12-10 18:19:12.169194
b441d34a-c684-4b58-a59b-2b934f31df08	365c16ff-15dd-4cd9-bd00-5b56537423dc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MonteKriptoKontu	\N	\N	f	2025-12-10 18:19:12.16995	2025-12-10 18:19:12.16995
3ebe4995-0f7a-4738-aed2-1198e7e16989	365c16ff-15dd-4cd9-bd00-5b56537423dc	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/MonteKriptoKontuDuyuru	\N	\N	f	2025-12-10 18:19:12.170122	2025-12-10 18:19:12.170122
0f166186-61ed-4ade-a7dc-976c4817b117	c3fd460c-b148-4f5e-94ed-f906607510d5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/nftmufettisi	\N	\N	f	2025-12-10 18:19:12.170821	2025-12-10 18:19:12.170821
039664f1-2527-41e2-aa0b-a888d831355e	ef1ac0b2-e9b3-430c-9efb-8fc4f9989ff8	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/NikkiSixx_7	\N	\N	f	2025-12-10 18:19:12.171965	2025-12-10 18:19:12.171965
4dda8090-1871-4170-ac29-368a8f168797	886bfe98-a961-4e36-8e32-f34eff9db46a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/oguzhantaskran	\N	\N	f	2025-12-10 18:19:12.172639	2025-12-10 18:19:12.172639
a07bf002-96ca-4bea-80c3-9386bec43e3d	cf66d5bd-490b-4b80-aba5-d04df1288fab	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/godofgem	\N	\N	f	2025-12-10 18:19:12.173313	2025-12-10 18:19:12.173313
00597575-beeb-48fc-a06a-22a15f675bb1	2c7daabd-9713-4d6c-b44b-5295b1146e4b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/onderyazici	\N	\N	f	2025-12-10 18:19:12.174294	2025-12-10 18:19:12.174294
43ec5e9a-7bf1-43f3-9a14-157c85fe0e95	30c617a3-6840-4150-9a78-e479cdaaa6a1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/OrtegasCrypto	\N	\N	f	2025-12-10 18:19:12.17525	2025-12-10 18:19:12.17525
b700e960-5f56-428a-80df-5134be2f69bd	d25cce7d-1b03-44ff-af78-c907300e06af	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xOziK	\N	\N	f	2025-12-10 18:19:12.175983	2025-12-10 18:19:12.175983
de8cae89-736c-4b78-9889-0a345e995970	d25cce7d-1b03-44ff-af78-c907300e06af	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/Ozithe0xkanali	\N	\N	f	2025-12-10 18:19:12.176162	2025-12-10 18:19:12.176162
4f754c87-2791-4cfc-aaf0-52a4c554370b	9c5e0827-8042-4a8c-b133-6f02fe0d1661	8564cdb8-9a90-4b0d-8bf9-c477c83814df	http://x.com/0xpandasol	\N	\N	f	2025-12-10 18:19:12.17701	2025-12-10 18:19:12.17701
9be8b8a0-85ec-4fd0-bd95-26853a0d3b87	31ccb5b9-3232-49bf-8121-b0d49784a072	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/PabloXbtc?t=xlwuBsH0c16RleceUik2Jg&s=09	\N	\N	f	2025-12-10 18:19:12.177632	2025-12-10 18:19:12.177632
0b5cbe13-2385-467e-b50d-4b78bf95d0cc	602788df-be32-4409-aa4a-331e1d3a3c12	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@para_hub	\N	\N	f	2025-12-10 18:19:12.178286	2025-12-10 18:19:12.178286
9878e105-c068-4dcb-aef9-785309bbb454	b4887d0c-2c72-4b6f-885f-530af72ea7aa	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/by_paradoks	\N	\N	f	2025-12-10 18:19:12.178957	2025-12-10 18:19:12.178957
78dcaf66-d846-4f34-9a04-245e598b1692	b4887d0c-2c72-4b6f-885f-530af72ea7aa	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/westanaliztg	\N	\N	f	2025-12-10 18:19:12.17926	2025-12-10 18:19:12.17926
8409b98a-f0d4-4520-bd3d-de5c6beed263	0be00181-1078-4960-958c-dad896f508cd	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/eness_turann	\N	\N	f	2025-12-10 18:19:12.180344	2025-12-10 18:19:12.180344
0600f870-412f-441a-a49c-21bde7e2e49c	5205065e-4780-4bba-841b-2bf3bb2b4b2f	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/cryptododo7	\N	\N	f	2025-12-10 18:19:12.18146	2025-12-10 18:19:12.18146
8041a5e4-22cd-44fa-aa5f-3661a53c5a3e	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/rockerfellerxau	\N	\N	f	2025-12-10 18:19:12.182157	2025-12-10 18:19:12.182157
36a0342d-f64a-4126-afe5-9dcafedbfcac	e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/alsatsinyalrock	\N	\N	f	2025-12-10 18:19:12.182343	2025-12-10 18:19:12.182343
9cb39064-5b41-434a-8132-5287c168d10c	2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kuzisatoshinin	\N	\N	f	2025-12-10 18:19:12.183216	2025-12-10 18:19:12.183216
3925f22d-be9b-4e57-afd7-93f8bf0c1cce	f129f037-4617-4f13-91b6-2f0846f15594	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Selcoin	\N	\N	f	2025-12-10 18:19:12.184481	2025-12-10 18:19:12.184481
dab99a59-abd0-4b48-9930-1192bb2abbae	f129f037-4617-4f13-91b6-2f0846f15594	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Selcoin	\N	\N	f	2025-12-10 18:19:12.184647	2025-12-10 18:19:12.184647
088d8729-706a-4672-808f-7d227791abba	bce6a1f6-efce-43e9-9e1f-556d8c35aa44	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Kriptomaniaca?t=wrDpjIGY8dLZkd2S4_9zxw&s=09	\N	\N	f	2025-12-10 18:19:12.185545	2025-12-10 18:19:12.185545
bf3c9256-60aa-4d05-95c8-db0ea41894d7	f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/sinavkk	\N	\N	f	2025-12-10 18:19:12.186661	2025-12-10 18:19:12.186661
113ca0c2-1ad7-4cc4-a284-69bbae3445d6	61f2cb13-4d3c-4ed9-b942-5d94de5b10c5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptooSeneR	\N	\N	f	2025-12-10 18:19:12.187815	2025-12-10 18:19:12.187815
4cac3a79-c5d0-4320-93a7-caf2583a3421	ea6c162c-6b68-45ba-a64c-5b80819411b1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/traderseyma	\N	\N	f	2025-12-10 18:19:12.188528	2025-12-10 18:19:12.188528
7ad6e403-2447-4f08-8933-12444d168444	d17b7538-0204-4b2f-aecf-83f8af1d266c	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@tarikbilenn	\N	\N	f	2025-12-10 18:19:12.189382	2025-12-10 18:19:12.189382
bf5efe38-d518-4180-ae35-b7344ccb0fba	d17b7538-0204-4b2f-aecf-83f8af1d266c	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/tarikbln	\N	\N	f	2025-12-10 18:19:12.18957	2025-12-10 18:19:12.18957
406d810a-f583-4f3e-b83c-d49edc078416	22561ea9-e707-4082-afbf-0a706a3918d5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/profesorishere	\N	\N	f	2025-12-10 18:19:12.190295	2025-12-10 18:19:12.190295
5c4f9a44-5d3a-490c-9f6c-27a33750ffdf	28dafb56-4f38-4051-ae2b-67dabda4b1d5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/teknikcihoca	\N	\N	f	2025-12-10 18:19:12.191022	2025-12-10 18:19:12.191022
52216a16-b4c7-4835-9d3a-0eac7d001a99	e4477eab-179d-4400-aa9b-219169bf4111	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Tufanoglu_	\N	\N	f	2025-12-10 18:19:12.191761	2025-12-10 18:19:12.191761
3da65ce9-5e27-426c-8a41-f8681fc19772	e9a26452-e262-4411-8e73-d99449360b66	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/tugsangokgoz	\N	\N	f	2025-12-10 18:19:12.192475	2025-12-10 18:19:12.192475
8f38705e-103d-4f94-845b-18de17982c33	e9a26452-e262-4411-8e73-d99449360b66	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptojordanofficial	\N	\N	f	2025-12-10 18:19:12.192655	2025-12-10 18:19:12.192655
7173a5ed-2b2a-4796-82e0-038bebcdfb57	bd00f679-68f3-4b10-940d-4bce91e5918c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/profesorturkmen	\N	\N	f	2025-12-10 18:19:12.193505	2025-12-10 18:19:12.193505
3c8ee2a3-40c0-45d8-b1bc-61f4be677e3f	fac03169-f6bd-4c63-904f-614e89932b1b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@UmutAktuKripto	\N	\N	f	2025-12-10 18:19:12.194229	2025-12-10 18:19:12.194229
7a6efae8-2d97-4995-b615-9199f30381a1	fac03169-f6bd-4c63-904f-614e89932b1b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/UmutAktu	\N	\N	f	2025-12-10 18:19:12.194399	2025-12-10 18:19:12.194399
17fa7d79-1ed1-4788-a298-3fe3151f7d9f	fac03169-f6bd-4c63-904f-614e89932b1b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/UmutAktu?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor	\N	\N	f	2025-12-10 18:19:12.194576	2025-12-10 18:19:12.194576
e1b4d69e-2b30-4388-88ae-a6248ef604f4	eada85b3-3437-4c8f-ad80-94ec9a2ae738	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/umutak47shawty	\N	\N	f	2025-12-10 18:19:12.195268	2025-12-10 18:19:12.195268
f93961a8-2ef4-4997-99fc-970d4b56fd69	964f2ba0-aaa4-4d3f-92b5-72ad4db28001	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/ustadsplinter34	\N	\N	f	2025-12-10 18:19:12.195946	2025-12-10 18:19:12.195946
9fc9a7df-7a72-459e-bf26-b42b20b8ef8d	3375d125-c65b-4bbc-807c-d0e15580cc9b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Vforrkripto	\N	\N	f	2025-12-10 18:19:12.197171	2025-12-10 18:19:12.197171
cda9ffd0-5124-4af1-82c9-05e6afde67a3	cfd27e79-36d0-4646-af3d-3f66a790ca59	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/cryptovalle0	\N	\N	f	2025-12-10 18:19:12.198015	2025-12-10 18:19:12.198015
b819d120-db95-4859-a6ea-711b60bb1392	6de1feb5-e286-467b-93fb-7cbf1dd12962	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/velanorETH	\N	\N	f	2025-12-10 18:19:12.199359	2025-12-10 18:19:12.199359
952f6f0d-5e98-4cd1-942d-cbe9bdcb4b9c	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/vemutlu	\N	\N	f	2025-12-10 18:19:12.200064	2025-12-10 18:19:12.200064
3f063c53-bd67-4c84-b05f-9f67ce430546	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/VMPreSale	\N	\N	f	2025-12-10 18:19:12.200241	2025-12-10 18:19:12.200241
8c4c2f14-e3dc-4b77-b696-3f0cfc1ebb67	9c3deaef-c8ce-4788-b304-e79ce2cc92b7	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@VeliMutluOfficial	\N	\N	f	2025-12-10 18:19:12.200419	2025-12-10 18:19:12.200419
eeb0a1b9-41aa-4f9c-aaa9-7ce0302531fb	b9cd222b-c28c-4c28-8522-2206f37de8ef	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/via__trader?s=21	\N	\N	f	2025-12-10 18:19:12.201448	2025-12-10 18:19:12.201448
7d7f11c5-bc7a-4264-90ce-654ab085c174	b9cd222b-c28c-4c28-8522-2206f37de8ef	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/CoachCommunityy	\N	\N	f	2025-12-10 18:19:12.20161	2025-12-10 18:19:12.20161
b0629d47-12bc-41cb-af34-c0450b229ff5	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Wind_Crypto	\N	\N	f	2025-12-10 18:19:12.202279	2025-12-10 18:19:12.202279
b4ce60fb-55a9-442a-a171-4cac6a676811	06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/WindCrypto	\N	\N	f	2025-12-10 18:19:12.20244	2025-12-10 18:19:12.20244
dc93bea9-d2b5-48e9-9aa8-f1f46872340d	cf53fa17-a86a-4d2f-b72d-3232d84fdfdf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/YsnAnaliz	\N	\N	f	2025-12-10 18:19:12.203291	2025-12-10 18:19:12.203291
730b2eb8-030a-4580-9e15-32f8a6dbe626	c86137aa-11da-4736-a053-67db0a8d658d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xRoronoaZoro	\N	\N	f	2025-12-10 18:19:12.204083	2025-12-10 18:19:12.204083
f06659ee-3f73-46bd-9aae-d18e59c04abb	e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lexmorenoweb3	\N	\N	f	2025-12-10 18:19:12.205198	2025-12-10 18:19:12.205198
c2069793-465d-4052-83da-653f61db06f9	3aecf454-6f25-40c9-b7f7-18cef6edcb32	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/pastanagacrypto	\N	\N	f	2025-12-10 18:19:12.205936	2025-12-10 18:19:12.205936
4351d52e-5e02-4c85-9d27-1d85d1697f3e	de43e928-54d8-424f-b164-c6f6cf7b8301	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@alvarburn	\N	\N	f	2025-12-10 18:19:12.206661	2025-12-10 18:19:12.206661
8efadae0-0de5-447a-8616-a1fd0154bbd3	8ca620b9-34cc-4cb2-bde4-9e4e425fdf2c	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CriptoMindYT	\N	\N	f	2025-12-10 18:19:12.207524	2025-12-10 18:19:12.207524
ab2ec19e-7ff2-4549-ace4-d226b8a95151	7a267af5-6c9a-46e4-b7b6-b16612eba675	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CriptoMindYT	\N	\N	f	2025-12-10 18:19:12.208535	2025-12-10 18:19:12.208535
ebb770ea-6fd1-4512-9b8f-1e638481d2ab	98c97607-b8f8-4115-8bbf-a389eefb9298	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@eduheras	\N	\N	f	2025-12-10 18:19:12.209475	2025-12-10 18:19:12.209475
d3f14cfa-d277-4391-b0db-011325ad6dab	81ea2a69-5998-4f99-9bef-ee4f79e2ed7d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@erikaespinal/videos	\N	\N	f	2025-12-10 18:19:12.210216	2025-12-10 18:19:12.210216
9b766543-6333-4290-ac51-55db5cec6004	87d1c881-208d-42f3-9d46-76b2c427bae3	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@itsguillemferrer/videos	\N	\N	f	2025-12-10 18:19:12.210951	2025-12-10 18:19:12.210951
c99e48bc-a4c0-4517-b62d-1ff481b66a79	34fd25ca-654a-4bed-b5e3-087641ff1da4	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Haskell_Gz	\N	\N	f	2025-12-10 18:19:12.211985	2025-12-10 18:19:12.211985
580f58e5-8bb8-4ab3-996f-92c7329fed3e	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/Healthypockets	\N	\N	f	2025-12-10 18:19:12.212857	2025-12-10 18:19:12.212857
f7fde927-66ad-4203-8e36-ee05f1a7e4ef	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/healthy_pockets	\N	\N	f	2025-12-10 18:19:12.213036	2025-12-10 18:19:12.213036
50d52d93-b71f-45d5-aa3e-2760091f056e	e625fed5-89b6-49a7-a2c4-94ed259ab0e6	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/elclubdelasojeras	\N	\N	f	2025-12-10 18:19:12.213199	2025-12-10 18:19:12.213199
d598bc15-bec4-41cb-920f-fa87f7a57105	e94b1181-5944-4cc0-87ca-e7cb96294cde	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@inverarg/videos	\N	\N	f	2025-12-10 18:19:12.21388	2025-12-10 18:19:12.21388
e05aed3a-f1d8-4772-bda8-ca625d944c79	2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Jonycabesa	\N	\N	f	2025-12-10 18:19:12.214628	2025-12-10 18:19:12.214628
7e8fbf7c-3aa1-44c4-beab-235c1c241733	0534a13e-fd02-4cfb-8491-c59ac802ff56	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptokakarot	\N	\N	f	2025-12-10 18:19:12.215422	2025-12-10 18:19:12.215422
edc3a57f-d4c7-4010-aac7-b6b3bc95e3cd	a63fdd89-7fdd-4a67-bd10-3ec3f948723d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/LaMejorEstrategiaCriptomonedas/about	\N	\N	f	2025-12-10 18:19:12.215978	2025-12-10 18:19:12.215978
81b24d51-916e-46e2-ad8c-b1b165e589df	0c9a840d-5ae1-405f-97d8-b4620bd69836	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@nicocabrera	\N	\N	f	2025-12-10 18:19:12.216682	2025-12-10 18:19:12.216682
e3b000ed-c7fe-4a4f-ba86-03ebdc9fecae	cfd6e494-2e99-4444-b0dd-cf0e39c35c3f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/%EE%82%87PlanBTC/videos	\N	\N	f	2025-12-10 18:19:12.217241	2025-12-10 18:19:12.217241
ad10f0e6-ed76-40e0-9427-fd04e61c00e0	f8998b14-8d70-4926-9fb2-9254bd4ac494	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@RAGERNFT	\N	\N	f	2025-12-10 18:19:12.217841	2025-12-10 18:19:12.217841
b17f5af4-24d5-4cd1-b4a5-fdcc2c5abf50	3673e128-01f7-48b5-83e1-f5d132e0b124	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@salvilla8622	\N	\N	f	2025-12-10 18:19:12.219569	2025-12-10 18:19:12.219569
e28e8657-b653-4f3b-adc5-058d5635c3ce	83c4db35-bc00-42ee-84a3-0c518581f849	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/secretodefi	\N	\N	f	2025-12-10 18:19:12.22089	2025-12-10 18:19:12.22089
d8e9e98a-ed9f-4192-ae6d-23b686ce2ff2	3275128f-dcb6-4a98-9250-0c658c74b22d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@ShooterinoYT	\N	\N	f	2025-12-10 18:19:12.222195	2025-12-10 18:19:12.222195
0d98db97-337e-4abf-a386-a28c5a39db1d	b5c1a526-3c0d-4769-adad-454977d5b169	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCW6cn54Y-qcS5Mk9Oj0nTTw	\N	\N	f	2025-12-10 18:19:12.223204	2025-12-10 18:19:12.223204
9edc5ecd-ec9d-48bb-863d-3ad71b2de7ff	b5c1a526-3c0d-4769-adad-454977d5b169	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Techconcatalina	\N	\N	f	2025-12-10 18:19:12.223381	2025-12-10 18:19:12.223381
45f8989d-f65e-49ec-ae59-2c606d2a5a6c	2aef7c96-0171-4476-a1cc-b4f88b34e997	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Alex_Invest01	\N	\N	f	2025-12-10 18:19:12.224172	2025-12-10 18:19:12.224172
278f8ed1-a59b-4261-9e95-b2b9d2c53702	025435d6-5888-4fd6-8ea7-9920118431ca	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@anufrievnikita	\N	\N	f	2025-12-10 18:19:12.224656	2025-12-10 18:19:12.224656
58753281-337a-42b6-a1b2-5fd26ace68df	3ac60df5-9ea5-4472-9504-061b503a0e98	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCN80Z1Ijz-5Pz22An2W0Yaw	\N	\N	f	2025-12-10 18:19:12.225127	2025-12-10 18:19:12.225127
90b8db9a-6b05-42c8-bf81-815e6ffc05bb	74cc7c04-8bd1-4dd4-84f8-5a0720a3244a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+e9zd8Tt6Tuk2MzI6	\N	\N	f	2025-12-10 18:19:12.225601	2025-12-10 18:19:12.225601
ed15780b-f991-4592-abe1-5987837476a5	31288d3a-60ff-4355-b0cc-22c27c795888	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://m.youtube.com/@CryptoCherry	\N	\N	f	2025-12-10 18:19:12.226062	2025-12-10 18:19:12.226062
9417dd70-f1c6-4da2-9614-beb190f2bca7	ea1ad626-2645-444d-ab29-4baedb9de705	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@cloudgeo?si=lG3D9WCT5IKM3NC5	\N	\N	f	2025-12-10 18:19:12.226852	2025-12-10 18:19:12.226852
d59a8935-eec7-4f7f-93f4-a85c60886d9c	5148040d-6f90-461f-a2f6-adeea2c0515d	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/CoinMetrika	\N	\N	f	2025-12-10 18:19:12.227565	2025-12-10 18:19:12.227565
5facd177-80ca-44ed-bfcc-4d21b5330ca7	9d82b44c-4a01-4adc-a2b7-de0f341cb15b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+aRtmSjlBGlhiNzgy	\N	\N	f	2025-12-10 18:19:12.228059	2025-12-10 18:19:12.228059
3273baa6-0919-4e54-a75f-52598a45c0d7	5e24b43b-f14f-4683-96ff-4801f37d2bfa	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Cryptos_Education	\N	\N	f	2025-12-10 18:19:12.22894	2025-12-10 18:19:12.22894
7ab0e7b3-c3f2-440a-ab99-5844e046bb1a	ed06996e-4ff3-4e67-ace1-49001541cd54	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+L0hbUKJwUREyYTNi	\N	\N	f	2025-12-10 18:19:12.229713	2025-12-10 18:19:12.229713
835b1c5e-e65d-4944-bcc8-8bf412b7bc1b	6cd89218-572e-48b8-9073-39f9b8b25381	77386a88-6ca3-44af-916f-807a0558671d	http://Telegram (47.5k)	\N	\N	f	2025-12-10 18:19:12.230496	2025-12-10 18:19:12.230496
0348a58e-2ac3-45e1-ace1-0b741b1bbf1c	7dcf839d-4ab8-4b3a-ac69-4c87f94b234a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/eazyscalping	\N	\N	f	2025-12-10 18:19:12.230982	2025-12-10 18:19:12.230982
211069e9-e60f-45f9-a173-27ad60d5a406	3c1350c6-7f72-4592-a6c7-8bf2953f02ad	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@cryptofateev?si=1CFVD-SHOPYdQNMs	\N	\N	f	2025-12-10 18:19:12.231433	2025-12-10 18:19:12.231433
b70b946c-1e72-4f65-919d-e3aab048bca1	13fe3906-7dbc-4eca-a595-90b86ce38b10	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://m.youtube.com/@Golodniuk_Kyryl/videos	\N	\N	f	2025-12-10 18:19:12.232158	2025-12-10 18:19:12.232158
3ebbd6bf-a636-4857-9a8e-70df4a084f84	d26ca139-43ec-4a9e-8978-775e1e824d24	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@alexhodl?si=yqQQ7JfXGJaOPOM8	\N	\N	f	2025-12-10 18:19:12.233082	2025-12-10 18:19:12.233082
7e80b098-004b-464d-9d0d-c31e01bdd497	1431f7e3-b5be-4c45-9499-2d38f736b916	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCUP66dHwZxisqlIYUXpDZQg	\N	\N	f	2025-12-10 18:19:12.233589	2025-12-10 18:19:12.233589
6300d714-0ebb-48b7-972b-8f4536db80a7	9f8d74a6-0dec-40df-89b4-ce350f23ea20	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+HSke8SWo8ZZiZjdi	\N	\N	f	2025-12-10 18:19:12.234486	2025-12-10 18:19:12.234486
6fdac5ec-fd54-43d0-b52b-90ed432277f2	0a5197f5-c578-4532-b9ca-d826eda45631	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+gJT_3gz6rTBiMWJi	\N	\N	f	2025-12-10 18:19:12.234964	2025-12-10 18:19:12.234964
fb323b06-63c8-488d-b2be-e82e71ccbc2a	279d7e14-1a00-4448-847a-313a0bbae58a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://m.youtube.com/@Ne_Nablydatel/videos	\N	\N	f	2025-12-10 18:19:12.235787	2025-12-10 18:19:12.235787
d5b0ce0f-628b-4132-a7c4-816841da0e2e	38ea5178-eace-462d-8eec-4012d0850ed3	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@olegapriori	\N	\N	f	2025-12-10 18:19:12.236253	2025-12-10 18:19:12.236253
389d16d4-1518-4637-9c52-94b2194764d0	4563395a-81cd-427e-90b5-b22bef4ed6f7	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@problockchain	\N	\N	f	2025-12-10 18:19:12.236701	2025-12-10 18:19:12.236701
b7495110-9705-4703-9c34-b445f6097362	4563395a-81cd-427e-90b5-b22bef4ed6f7	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Pro_Blockchain	\N	\N	f	2025-12-10 18:19:12.236836	2025-12-10 18:19:12.236836
406967d4-7b92-43bd-b3a2-01c15f6012f9	6de7bcc9-5890-4201-92da-1d4a4b598bc6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://m.youtube.com/@ProBoyScalp	\N	\N	f	2025-12-10 18:19:12.237299	2025-12-10 18:19:12.237299
17ca38b8-07d0-42f3-9ae0-29b58de7f017	b5c50956-be91-4641-87d2-4e3635864bc6	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/proboyscalp	\N	\N	f	2025-12-10 18:19:12.237756	2025-12-10 18:19:12.237756
0d320cd5-c827-4753-bec4-fbd13a2aa71a	0285a773-0112-4881-81db-c2d3d1242270	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@ccrypts?si=B_95VI-UyRX3gtQE	\N	\N	f	2025-12-10 18:19:12.238374	2025-12-10 18:19:12.238374
f771e5ce-e182-4c11-8d98-18379f5f9a5a	3638ba04-11a1-48f9-a594-2ae8703f0e3e	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://m.youtube.com/@TRADERSLIFEBIT	\N	\N	f	2025-12-10 18:19:12.238881	2025-12-10 18:19:12.238881
35648ca5-8f54-46eb-a17e-de30f06fda9f	e08177fb-7fc4-4c64-8b7f-4d0560d08036	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/victorbavur	\N	\N	f	2025-12-10 18:19:12.239655	2025-12-10 18:19:12.239655
f9c88b59-a3b7-4092-97be-df73d483e15c	3d26bd02-5bca-4102-bf05-d7ec0fbdaca9	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@zhukovtrade?si=JCK1-7ZqHQH_LFzw	\N	\N	f	2025-12-10 18:19:12.240162	2025-12-10 18:19:12.240162
21ff117f-b7bc-4ee8-96a6-1eb2de5aa849	e06c1478-8030-4267-ac23-46cdf1cb76e2	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+V-XZ3Sw_szRw3Po6	\N	\N	f	2025-12-10 18:19:12.24062	2025-12-10 18:19:12.24062
c8f2097c-c1fc-4988-8270-c1ab702eadb7	8c1c9363-457e-40d1-905b-7dfd9a87b1a9	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/zarabotaemmv	\N	\N	f	2025-12-10 18:19:12.241067	2025-12-10 18:19:12.241067
424e7b96-9b21-476d-8956-becea68db43f	52ba9901-cd9e-4c75-a28b-3c74f84b21e5	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/dumaydeystvuy	\N	\N	f	2025-12-10 18:19:12.241533	2025-12-10 18:19:12.241533
a2ea0324-7e8c-4fd9-a53d-8a104ec4345a	db0404d3-6d7c-4c35-87e8-14c991b6b894	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/KRIPTOFERMA	\N	\N	f	2025-12-10 18:19:12.242063	2025-12-10 18:19:12.242063
0adf3d1f-2ad0-4b89-b43f-3ab3bd93fcfb	5261e50f-6740-406d-b27d-cbe14528d0f5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@AcademiaCripto	\N	\N	f	2025-12-10 18:19:12.242648	2025-12-10 18:19:12.242648
a3e0d2ab-7845-4233-a64a-45f54b6ba2b9	d3d42031-99ef-4704-b5cc-837a302fbc45	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@gabrielquadrs	\N	\N	f	2025-12-10 18:19:12.243459	2025-12-10 18:19:12.243459
dfe9a022-670a-4afd-a2ce-e2f1acb3a17e	5d3bb457-c8ed-4cb4-aad0-962a8deb4e06	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@cryptojimmy01	\N	\N	f	2025-12-10 18:19:12.244205	2025-12-10 18:19:12.244205
4c87c500-5de1-40f3-a0a4-a06397a6dabd	a6e5af8d-b3ce-40f7-a650-659c2b733e3f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@OuluH/videos	\N	\N	f	2025-12-10 18:19:12.244751	2025-12-10 18:19:12.244751
4b0575eb-13a0-48c8-9dc9-b87b1a7ffcd6	5b01d0aa-c26f-478e-835a-0d3560a3fc70	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@SalleSRJnaWeb3/videos	\N	\N	f	2025-12-10 18:19:12.245447	2025-12-10 18:19:12.245447
64c49464-8236-4f68-8a54-68a259b01b13	25407bcd-ae8d-46c3-a4d8-dced7f78d279	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/321Crypto	\N	\N	f	2025-12-10 18:19:12.246064	2025-12-10 18:19:12.246064
1be67af7-1560-4429-b140-44bfc32f589a	25407bcd-ae8d-46c3-a4d8-dced7f78d279	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Powiadomienia_321Crypto	\N	\N	f	2025-12-10 18:19:12.246224	2025-12-10 18:19:12.246224
e5049bdb-9a52-4ee3-9b15-acdc4f2653f2	25407bcd-ae8d-46c3-a4d8-dced7f78d279	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@321Crypto	\N	\N	f	2025-12-10 18:19:12.246426	2025-12-10 18:19:12.246426
fb5ffe15-c051-418e-9efb-deb3134ab948	80e338f3-e4dc-4b08-bef3-ccfd3cecd922	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CzasToPieniadz/videos	\N	\N	f	2025-12-10 18:19:12.247021	2025-12-10 18:19:12.247021
ecd5c9f1-93d6-4e95-9ea1-64176ad6fadb	53dc91bc-b3ca-4daa-8068-3bae75b63cd3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/DEXLaboratory4	\N	\N	f	2025-12-10 18:19:12.247506	2025-12-10 18:19:12.247506
018b6eb6-dce0-4181-80e5-3fab26fb54a9	7daebce3-f985-446e-892b-ce680f7811bb	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@FxMag	\N	\N	f	2025-12-10 18:19:12.248443	2025-12-10 18:19:12.248443
895bdc45-f870-484e-b0ea-b5f16c610f14	3909bc10-7b63-4f58-b952-b07cb94f25fa	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@GotowynaKrypto/videos	\N	\N	f	2025-12-10 18:19:12.24904	2025-12-10 18:19:12.24904
952c3825-1eba-49e4-8ffb-3a57e2d4cf55	2a44bd0d-60df-412f-b41b-0ee989031acc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@JulianCrypto/videos	\N	\N	f	2025-12-10 18:19:12.249516	2025-12-10 18:19:12.249516
9d1351f4-e89f-4bc1-85d6-7a8dcc386752	15e1cfe3-8c2d-4095-a1c0-84a959935c65	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KoszaryTradingu	\N	\N	f	2025-12-10 18:19:12.249997	2025-12-10 18:19:12.249997
cabfe1ab-1fc9-4406-a1d2-34eddbc9e523	2950382c-f095-469b-9d0a-03b3a4cac477	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoAlexand	\N	\N	f	2025-12-10 18:19:12.250475	2025-12-10 18:19:12.250475
be6297fd-4e5a-4073-86ec-016f63558dcd	2950382c-f095-469b-9d0a-03b3a4cac477	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kryptolfg	\N	\N	f	2025-12-10 18:19:12.250591	2025-12-10 18:19:12.250591
65f3f5d6-df50-4534-bc16-702668dbfd5d	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@kryptoblogger1227	\N	\N	f	2025-12-10 18:19:12.251239	2025-12-10 18:19:12.251239
ccb5276c-96df-4a58-a387-17686def23c2	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/blogger_krypto	\N	\N	f	2025-12-10 18:19:12.251428	2025-12-10 18:19:12.251428
62823cca-6a31-4f78-b365-853de5874f68	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+w6y5lRUkc84wOTk0	\N	\N	f	2025-12-10 18:19:12.251573	2025-12-10 18:19:12.251573
3fb5dd32-221a-41e5-bb31-9d8874bfd9fd	e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@kryptoblogger?ug_source=op.auth&ug_term=Linktr.ee&utm_source=awyc6vc625ejxp86&utm_campaign=tt4d_profile_link&_r=1	\N	\N	f	2025-12-10 18:19:12.251711	2025-12-10 18:19:12.251711
aea20f1d-b0ec-4042-9495-eadaa2a811fa	2fb528eb-fc7e-4684-9dac-ebdc7108c66e	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/KryptowalutydlaPocz%C4%85tkuj%C4%85cych/videos	\N	\N	f	2025-12-10 18:19:12.25257	2025-12-10 18:19:12.25257
1fb3509e-8f04-45fb-b9dd-1391c143af09	51d5f2ba-7110-46bc-8d63-14d0fa652a5d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kyudo_krypto	\N	\N	f	2025-12-10 18:19:12.253928	2025-12-10 18:19:12.253928
5083759f-b86b-48ba-a7a4-9094fb9f7486	51d5f2ba-7110-46bc-8d63-14d0fa652a5d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@kyudokrypto	\N	\N	f	2025-12-10 18:19:12.254254	2025-12-10 18:19:12.254254
8cbf6578-4faf-4d9c-9fd1-da749d6ba01d	9d98647e-0c3f-43ac-a41f-889f2306c64a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@BibliaKryptowalut	\N	\N	f	2025-12-10 18:19:12.255115	2025-12-10 18:19:12.255115
577ee60c-37c2-4f26-95d1-9b19961b01a2	9d98647e-0c3f-43ac-a41f-889f2306c64a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lucas_michalek	\N	\N	f	2025-12-10 18:19:12.255297	2025-12-10 18:19:12.255297
9b8f82cf-c072-43fb-b82a-d7e9b10f36a0	c6322e44-f4a9-4aec-a2f6-850336b9ad9b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MaciejTomczyk3	\N	\N	f	2025-12-10 18:19:12.255949	2025-12-10 18:19:12.255949
cd05d23c-5233-4eec-920a-b9f0a1f72c70	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@kryptowalutydlapoczatkujacych	\N	\N	f	2025-12-10 18:19:12.256643	2025-12-10 18:19:12.256643
63eb5f2d-c504-44d2-9aab-2290f56d4bbc	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kdpwiadomosci	\N	\N	f	2025-12-10 18:19:12.256814	2025-12-10 18:19:12.256814
3a4c9760-adbf-41b9-8122-4f93e5c931d5	20e4f5d9-9e02-4aa0-bba7-87626ebe280a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MarekStiller	\N	\N	f	2025-12-10 18:19:12.256979	2025-12-10 18:19:12.256979
ef42751a-97fb-4f09-9180-7c267efc9796	98b58011-16fc-4ec7-b25e-a0a6dddd9fa2	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/SwiatKrypto	\N	\N	f	2025-12-10 18:19:12.257639	2025-12-10 18:19:12.257639
b4a655f6-c245-44ab-81f4-0f7c60f984d0	a3101525-7901-4a34-a80c-0fe955903e17	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@GeneraTuSueldo/videos	\N	\N	f	2025-12-10 18:19:12.258412	2025-12-10 18:19:12.258412
bb03a0a3-7971-489f-8473-7bfcaab71f82	a3101525-7901-4a34-a80c-0fe955903e17	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/generatusueldooficial/	\N	\N	f	2025-12-10 18:19:12.258579	2025-12-10 18:19:12.258579
2037d52d-be1f-4a61-9092-86d380c0572b	2f7314ea-dcf9-4ced-bbd0-12e235827ef6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@PolacoFinanzas	\N	\N	f	2025-12-10 18:19:12.25941	2025-12-10 18:19:12.25941
994b08b3-6a54-462a-8e3d-75c3cbde3a04	b1ce0761-75e7-4bfc-970c-39c63c15beae	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/gabrielressan/	\N	\N	f	2025-12-10 18:19:12.260052	2025-12-10 18:19:12.260052
74fa9922-370a-4f43-9e42-39ed63e1685d	640ff371-f8ed-4280-b39e-636337db7a47	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/isracrypto.eth?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw%3D%3D	\N	\N	f	2025-12-10 18:19:12.26079	2025-12-10 18:19:12.26079
b6df160a-59b6-4ecf-ac20-d1bf4000b347	c1240f25-cd0b-4059-8226-f5838f72a21d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@7INGRESOS	\N	\N	f	2025-12-10 18:19:12.261861	2025-12-10 18:19:12.261861
17cb4905-6d69-46c4-b4e5-c8741836745b	c34b6e61-7e47-42af-8d0f-7258a892df93	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/patomadrazo_?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw%3D%3D	\N	\N	f	2025-12-10 18:19:12.262497	2025-12-10 18:19:12.262497
b79aadd9-a2fc-46ec-8365-46f3c685b913	be2c7d26-cd3c-42b7-8462-426a2f77ca55	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/perecrypto/	\N	\N	f	2025-12-10 18:19:12.263117	2025-12-10 18:19:12.263117
77d8f851-6ea0-4597-8b6c-1c3480cd0642	5cc8dabb-2e93-4493-9b7e-5b2da6a992b9	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/salvatoregiuseppee/	\N	\N	f	2025-12-10 18:19:12.263734	2025-12-10 18:19:12.263734
744e3847-02f2-4cd9-8ac9-0c37601887f8	103f24c5-dd68-4ef5-b98a-4f38b6268929	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@arturguimaraesp	\N	\N	f	2025-12-10 18:19:12.264405	2025-12-10 18:19:12.264405
beeb811e-2e29-4454-9df2-955b63f595c2	e1520e20-6b49-4942-a5bf-17db15a8b993	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CriptoExplosiva	\N	\N	f	2025-12-10 18:19:12.265074	2025-12-10 18:19:12.265074
f7b48d85-034c-4737-9973-5a7874bf631e	a23d2de8-9182-49d0-8390-0892a0d120ac	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@fabiocatalao_	\N	\N	f	2025-12-10 18:19:12.265563	2025-12-10 18:19:12.265563
58dfa707-fe8e-4a18-8097-1225b4bee8ee	a2cb2258-fdb6-4ece-a4e5-68d41668da04	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/igorfreitasm/	\N	\N	f	2025-12-10 18:19:12.266058	2025-12-10 18:19:12.266058
470f1451-066f-40e0-9c93-fe84f7231fab	ae6b7c13-ad5d-44e9-9c9d-13fa1caba3af	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Insalubrescripto	\N	\N	f	2025-12-10 18:19:12.266594	2025-12-10 18:19:12.266594
0c7af013-2250-4cc9-9cba-0dcf5f5d1320	a4d26b54-bc04-4df1-8b3d-c01939ba12ac	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@patocrypto	\N	\N	f	2025-12-10 18:19:12.267114	2025-12-10 18:19:12.267114
ab61d269-287d-4974-9afb-67f5691bf98c	78ff7e96-5a3d-47ee-89d4-ec56e551af4d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Ramon_Cunha	\N	\N	f	2025-12-10 18:19:12.267609	2025-12-10 18:19:12.267609
f155c4e9-31d3-4da8-b5c7-3f1f01d559a5	b9aa29a7-3446-4a57-9227-f04b897053d0	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CriptoExplosiva	\N	\N	f	2025-12-10 18:19:12.268082	2025-12-10 18:19:12.268082
0b6e200e-4695-445d-9361-5c71e195c36b	b9aa29a7-3446-4a57-9227-f04b897053d0	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/othiago_moura	\N	\N	f	2025-12-10 18:19:12.268233	2025-12-10 18:19:12.268233
7a2e71a6-c40b-48f0-abe2-06b43f8bc6b9	c9a7f368-d571-4f16-88b2-953fa413afce	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CriptoComFe	\N	\N	f	2025-12-10 18:19:12.268698	2025-12-10 18:19:12.268698
c13e7980-5aa2-4e0e-a1c4-f85a8da75947	2d783d0e-91d3-4232-b881-4c4f0e68b5ae	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/bounty_atm	\N	\N	f	2025-12-10 18:19:12.269255	2025-12-10 18:19:12.269255
9fd2fac7-cd77-4dc8-9bf4-ca94666b535e	c08d0109-01e2-4143-9b50-5c7ec6ac0755	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Board_the_Ark	\N	\N	f	2025-12-10 18:19:12.269745	2025-12-10 18:19:12.269745
33eb5420-5ee8-40d6-ba20-fd87d932df87	8e474aae-efe1-4e65-9592-ebb65cf96d1d	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/bitmansour	\N	\N	f	2025-12-10 18:19:12.270213	2025-12-10 18:19:12.270213
221c9817-bd2d-4e3c-993c-d8c126c7c18c	94310160-1f29-4873-b341-4b3a7b37554f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/boojaANN	\N	\N	f	2025-12-10 18:19:12.270828	2025-12-10 18:19:12.270828
0e284d76-66b4-451f-9c4a-d6483079e6e6	d725e61f-ad5f-48e3-898f-c363c3346fc8	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/centurywhale	\N	\N	f	2025-12-10 18:19:12.271301	2025-12-10 18:19:12.271301
8c4e3d64-cf5e-4a2a-a5a0-edf18b451cef	341117c1-b380-463f-a2e1-df27dc642128	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/churin0329	\N	\N	f	2025-12-10 18:19:12.271786	2025-12-10 18:19:12.271786
c2f53fda-5206-404c-a985-040895ff054c	5747fab8-f04b-4ede-8a94-d17c74d00bfd	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/churin0329	\N	\N	f	2025-12-10 18:19:12.272235	2025-12-10 18:19:12.272235
2eb3d9e2-d874-4ce3-8d06-50ecc39b123a	b91bc33b-adf3-462c-975e-4c9bc4dbef2a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/dogeland01	\N	\N	f	2025-12-10 18:19:12.272702	2025-12-10 18:19:12.272702
02233120-25b3-4083-acc0-7f679d27077e	6fe10761-049b-40f7-abae-2fd5d58abb50	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Coin_AirdropKing	\N	\N	f	2025-12-10 18:19:12.273221	2025-12-10 18:19:12.273221
7b3d760e-0c2c-43d1-8941-933fd44a5dc3	e9c3d54a-a260-442a-a346-7dff417300c0	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Crypto_jailbreak_Korea	\N	\N	f	2025-12-10 18:19:12.273689	2025-12-10 18:19:12.273689
6c7bb7eb-e8e4-4360-9c9f-35b4e2877abf	cfeb2b0f-270b-407f-a625-bd46c0b9b0e0	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/lovejudylee	\N	\N	f	2025-12-10 18:19:12.274297	2025-12-10 18:19:12.274297
517256e5-22aa-43a0-9fc5-dc862cbb242f	67f81b56-5b58-4fc0-b955-31f44ccb0135	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptomacase	\N	\N	f	2025-12-10 18:19:12.274798	2025-12-10 18:19:12.274798
5da25733-bdb1-4519-bdf9-0e2137fa9c90	33991c64-7e13-4231-86c2-db7afbf10414	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptopandann	\N	\N	f	2025-12-10 18:19:12.275282	2025-12-10 18:19:12.275282
8dff592f-5a99-4854-84da-ec92dc96ec8b	63b322f6-5f56-40d3-bf84-bbace6c2c8a5	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/dolgommagic	\N	\N	f	2025-12-10 18:19:12.275891	2025-12-10 18:19:12.275891
fee92f09-4d20-439c-89c8-5847f988d65c	f65cc96b-2042-4141-93d9-5b96d83bf05b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Dynastylabs	\N	\N	f	2025-12-10 18:19:12.276364	2025-12-10 18:19:12.276364
e611dc9f-bc40-4320-a001-45766c5e43c0	e8e5e669-74a7-494e-b464-afbc843bb0bf	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/enjoymyhobby	\N	\N	f	2025-12-10 18:19:12.27683	2025-12-10 18:19:12.27683
a05485c4-c78a-4551-a14a-0a00958418a4	80ff1ea3-3187-45a8-8abf-a065791af2aa	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/fireantcrypto	\N	\N	f	2025-12-10 18:19:12.277287	2025-12-10 18:19:12.277287
507e8e0b-acec-4b44-b920-24bebe754adc	6bdf87ef-ce76-411c-b0a9-3f2f7e312d18	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/GemHiveDAOchannel	\N	\N	f	2025-12-10 18:19:12.277869	2025-12-10 18:19:12.277869
3377bd75-a748-4355-976e-0e66440c8477	a7c0391f-039f-4893-9fed-342636e2c31a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/engtokor	\N	\N	f	2025-12-10 18:19:12.27835	2025-12-10 18:19:12.27835
0f887a69-ac99-46a5-9e4a-86f9ec208fd1	564e6fa2-cbf8-48b7-ba16-8afeeeb36783	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/heedan22	\N	\N	f	2025-12-10 18:19:12.278824	2025-12-10 18:19:12.278824
6b394265-af12-4980-bc92-926a277d53ce	711d739c-10ed-450c-80de-baace6f715fb	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/honeymouse1003	\N	\N	f	2025-12-10 18:19:12.279371	2025-12-10 18:19:12.279371
2fa26fcc-ac6f-4010-848d-7a0781f07fd7	391617a8-5422-4fa9-a00b-0a723927fda1	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/lnsanecoin	\N	\N	f	2025-12-10 18:19:12.279865	2025-12-10 18:19:12.279865
aa34e0b4-ee75-4da4-862e-e1981bde264e	d4704f1c-0bba-4dd0-b85f-d896be3c10c0	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kkeongsmemo	\N	\N	f	2025-12-10 18:19:12.280584	2025-12-10 18:19:12.280584
5f88acd4-ffc5-47d7-9b3a-bbc2c15a4dbc	261855bb-6dd5-4966-8d34-1229e29e6def	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/kookookoob	\N	\N	f	2025-12-10 18:19:12.281035	2025-12-10 18:19:12.281035
ed8111d7-fd8b-4681-a229-fd066bf0ae8e	3d9705c4-60a6-43da-b2ae-e3694d363025	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/liambitcoin	\N	\N	f	2025-12-10 18:19:12.281498	2025-12-10 18:19:12.281498
8c7ac2e8-7ceb-4375-aa6f-ab115062ab8d	485578d2-8745-4484-8692-b99c1113cd70	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/MBMweb3	\N	\N	f	2025-12-10 18:19:12.281988	2025-12-10 18:19:12.281988
36d96c30-a778-44e4-bb2c-d363e878689d	c880e80b-e6e9-459b-b76c-613791b7b88d	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/mujammin123	\N	\N	f	2025-12-10 18:19:12.282461	2025-12-10 18:19:12.282461
072951fc-254f-4e60-a890-5bc51ee2f481	402d4dcb-714d-4e15-95aa-94854f602c2f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/officialunivercityofcrypto	\N	\N	f	2025-12-10 18:19:12.282929	2025-12-10 18:19:12.282929
21a42102-4724-4e3a-b7b2-2679937434f5	e09bee44-10ce-4d87-94b2-3cfd7eccd5ff	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/OngsalYee	\N	\N	f	2025-12-10 18:19:12.283387	2025-12-10 18:19:12.283387
b5b9cb75-f311-49a4-ae95-bf775844eb16	e61fddef-5b5e-41df-8166-0013f41c935b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/organic_IDO_KR	\N	\N	f	2025-12-10 18:19:12.283858	2025-12-10 18:19:12.283858
becd04b6-7de5-46b7-9cdf-08b5ec37d9c5	57e7e20a-72d6-40ff-9b6f-74f7fb46808a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Rowna999	\N	\N	f	2025-12-10 18:19:12.284375	2025-12-10 18:19:12.284375
27b3ef53-5d49-4312-882a-ac095ecea638	81c829f0-c889-4ece-a1a2-d0ff22503cee	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/ResearchSena	\N	\N	f	2025-12-10 18:19:12.28489	2025-12-10 18:19:12.28489
e11212ea-ac0d-4a27-849b-8d45e3cb5d4f	997edef2-76fb-4731-bf0e-61711f5b4c3d	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/sipangE	\N	\N	f	2025-12-10 18:19:12.285714	2025-12-10 18:19:12.285714
0c76ef21-3328-463c-b20a-2465dae13b75	d275cf87-cacc-4301-a48c-e4ff974c7107	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/officialskygoma	\N	\N	f	2025-12-10 18:19:12.286603	2025-12-10 18:19:12.286603
806c255f-721c-4167-860a-ae02fe151860	7fa6f945-2af4-443f-ac9e-021942d58ffe	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/WeCryptoTogether	\N	\N	f	2025-12-10 18:19:12.287247	2025-12-10 18:19:12.287247
018fbc76-aab2-4e74-8698-801edc9244a0	5510895e-1d4f-493b-bd7b-45c66d381b06	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/yobeullyANN	\N	\N	f	2025-12-10 18:19:12.28788	2025-12-10 18:19:12.28788
1e2ac2c2-dda9-4403-acb9-2485604812bd	107096f9-c4da-42a8-8b2e-bc08ff92a2c4	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/tlsrltnf	\N	\N	f	2025-12-10 18:19:12.288454	2025-12-10 18:19:12.288454
8f321b2b-f0c6-46fe-92b8-c8187978edeb	162986b6-6231-4b77-9305-f09c3662d29a	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/chavoonnam	\N	\N	f	2025-12-10 18:19:12.289078	2025-12-10 18:19:12.289078
4afd6b30-6eb8-4d99-8582-4cf099b91bf0	87991458-6510-4f9e-bcf8-59ccd6c2a424	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/vc_21m	\N	\N	f	2025-12-10 18:19:12.289559	2025-12-10 18:19:12.289559
b46c250c-69bb-4945-9e49-e3bf85f069e1	fb1e01f9-e5b4-4e1e-ac03-c1bc596610b9	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/admen_vc_2	\N	\N	f	2025-12-10 18:19:12.290073	2025-12-10 18:19:12.290073
6c6a8872-be9b-43b5-bafc-2371ce39ea8a	b20b59c3-0b66-410d-aeb6-6cf85d2cccf6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/BankeraDao	\N	\N	f	2025-12-10 18:19:12.290562	2025-12-10 18:19:12.290562
c0cfd0b8-7d31-4350-a65a-1c1187c5a546	ef37b1c3-a253-4086-89a2-5d9fcc9e40b5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/bb_jpdao	\N	\N	f	2025-12-10 18:19:12.291052	2025-12-10 18:19:12.291052
e29bd270-3430-4361-a91f-5f6b584371e5	4169437c-a5e3-43a4-9f74-91d4396c859b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CoinClubJapan	\N	\N	f	2025-12-10 18:19:12.291539	2025-12-10 18:19:12.291539
fcea59e7-b070-475f-8eaa-077d568a7b33	629cbe03-cc05-414c-a94f-5f89f9741208	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@fujimana	\N	\N	f	2025-12-10 18:19:12.292014	2025-12-10 18:19:12.292014
389232d3-3b3b-45f4-be72-faa0d6c19187	7a1ad5c7-dd33-41d1-a520-d0e87bccb333	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lskraise	\N	\N	f	2025-12-10 18:19:12.292722	2025-12-10 18:19:12.292722
e3ac0861-349d-42af-9a80-c98bb458ee34	137cf437-1b62-4fb4-98a3-48c1671ff617	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@fujimana	\N	\N	f	2025-12-10 18:19:12.293194	2025-12-10 18:19:12.293194
1953155c-7baf-4c12-b1c0-948887b2da0c	6bf62d19-ea8a-4efd-87cf-2e3f8b4c9ab1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/osa3210	\N	\N	f	2025-12-10 18:19:12.293662	2025-12-10 18:19:12.293662
94a3991f-94ba-4233-a53f-12cfbe6c51de	79c46d87-380e-4919-b522-d6e9043525e9	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/OtakuLabs_xyz	\N	\N	f	2025-12-10 18:19:12.294214	2025-12-10 18:19:12.294214
5e2d8e6a-8a27-41ad-95ed-1c7e03cf3426	47d52f8a-0574-4733-aca8-ce5f86afae48	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/TokenEconomist	\N	\N	f	2025-12-10 18:19:12.294737	2025-12-10 18:19:12.294737
e1e5654e-7638-4f36-a420-96a068fc3429	538264a7-212c-4f12-b5b9-eb01130c695e	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/AfterSideCrypto/videos	\N	\N	f	2025-12-10 18:19:12.295278	2025-12-10 18:19:12.295278
919629a3-3cf3-47d8-8a07-76c99d0c860c	44265096-ccf3-4de5-993b-57ca76e5936d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@AnggaAndinata	\N	\N	f	2025-12-10 18:19:12.296008	2025-12-10 18:19:12.296008
8b970644-4185-405b-afcc-e27922013b15	44265096-ccf3-4de5-993b-57ca76e5936d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/anggaandinata	\N	\N	f	2025-12-10 18:19:12.296179	2025-12-10 18:19:12.296179
7152b428-cf1a-495f-b708-b1602a614813	fe992cec-9283-4d0e-b054-aac3273b2ea5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@FedericoRonzoni/videos	\N	\N	f	2025-12-10 18:19:12.297051	2025-12-10 18:19:12.297051
2ce42e5a-35a0-4549-ab6f-c82b39a7120f	04141f93-b2e1-41e2-9850-837cc8afe2b8	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@FrancescoCarrino/videos	\N	\N	f	2025-12-10 18:19:12.297732	2025-12-10 18:19:12.297732
a9dbb465-1a8b-4802-993e-6bbd24066304	ae226d98-be72-441a-b8ef-e7c0de5eaa98	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCfURz82StG4JIjf581b195Q/featured	\N	\N	f	2025-12-10 18:19:12.298416	2025-12-10 18:19:12.298416
ad0337ec-7f50-47f1-b0a1-7d62b0e9129e	b2a1c05d-9609-469f-a37f-a90299d9b43e	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/LeonardoVecchio/videos	\N	\N	f	2025-12-10 18:19:12.299585	2025-12-10 18:19:12.299585
efb7fd46-ea02-4836-903f-f8a8b2d178a2	9165be31-df7b-4b1b-a005-eddfd2b88020	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@marcnieto.official	\N	\N	f	2025-12-10 18:19:12.300334	2025-12-10 18:19:12.300334
ca3afc65-fb07-49b8-bdf4-10f0b1bbe25b	d2c44e4b-1f6e-487f-8c87-56b1287ccfe5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MauroCaimi	\N	\N	f	2025-12-10 18:19:12.301169	2025-12-10 18:19:12.301169
ca815262-ee2e-4438-8ece-d37ecee270bd	012dc821-4451-48e8-b9f6-0c62b69b6b84	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MichaelPino/videos	\N	\N	f	2025-12-10 18:19:12.302018	2025-12-10 18:19:12.302018
efa09e54-f3c8-4aee-8e9b-87eba5306589	012dc821-4451-48e8-b9f6-0c62b69b6b84	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/_michaelpino_/	\N	\N	f	2025-12-10 18:19:12.302726	2025-12-10 18:19:12.302726
53de69a8-a64d-4a38-94af-f96831fd06e6	012dc821-4451-48e8-b9f6-0c62b69b6b84	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@michael_pino?lang=fr	\N	\N	f	2025-12-10 18:19:12.302947	2025-12-10 18:19:12.302947
89c50a26-5b90-42ea-9544-fec0ceb995c4	4d7bc637-9284-4927-b0cd-7e2193d71a75	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UChkzwqfPPTPnuSef26idqcg	\N	\N	f	2025-12-10 18:19:12.303709	2025-12-10 18:19:12.303709
815bec76-ad1b-43b2-9b68-c45a71db342c	12ac870c-c81a-4a4f-8739-7fbe33c891b7	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@RiccardoZanetti/videos	\N	\N	f	2025-12-10 18:19:12.304512	2025-12-10 18:19:12.304512
5c85076a-317e-4a14-9b09-eb240a8bec19	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@StartingFinance/videos	\N	\N	f	2025-12-10 18:19:12.305303	2025-12-10 18:19:12.305303
e75959e0-293b-4656-999b-26cfdf30f930	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/startingfinance/	\N	\N	f	2025-12-10 18:19:12.305459	2025-12-10 18:19:12.305459
eb3e1e0c-483b-4d61-8e9f-87856ff9b62b	f27c16ab-f3c3-466d-930b-bf1d3f3ee406	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@startingfinance	\N	\N	f	2025-12-10 18:19:12.305613	2025-12-10 18:19:12.305613
2aff1ec4-9cee-4e11-86a6-69ebe0fabd56	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@thecryptogateway/videos	\N	\N	f	2025-12-10 18:19:12.306306	2025-12-10 18:19:12.306306
03897f7b-e7de-43f9-adfc-3edad20c2be1	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/crypto_gateway	\N	\N	f	2025-12-10 18:19:12.306509	2025-12-10 18:19:12.306509
181549a9-d77e-4a47-953b-2d965a3038cd	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/TheCryptoGateway	\N	\N	f	2025-12-10 18:19:12.306687	2025-12-10 18:19:12.306687
34dae71f-43a9-4da0-948e-ccb4290505f8	1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/thecryptogateway/	\N	\N	f	2025-12-10 18:19:12.306845	2025-12-10 18:19:12.306845
41824173-81d9-49ed-8bfd-22dbdab10e93	80f0e661-7d4d-4afd-b5a0-688b93830483	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@TizianoTridico/videos	\N	\N	f	2025-12-10 18:19:12.307753	2025-12-10 18:19:12.307753
bf9c4075-ed91-4543-8a63-bd09eea0c612	7b66d829-14ac-4e8e-bc45-c4d7a3d6b5c8	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/AnalisaCrypto	\N	\N	f	2025-12-10 18:19:12.308628	2025-12-10 18:19:12.308628
af3a7742-b017-478c-8635-5b99a01966fd	8de3c4eb-cc3f-4c1f-ba06-001992e8fbd7	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/AndreRizky/featured	\N	\N	f	2025-12-10 18:19:12.309387	2025-12-10 18:19:12.309387
6dfa61fc-c785-4b53-8098-b3ad4ea7c85c	8171aa82-e03c-419a-bd78-f8149d941ec5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/andreasrtobing_	\N	\N	f	2025-12-10 18:19:12.31012	2025-12-10 18:19:12.31012
3e1b8d26-74a5-4816-9a86-02ec4bc3fd0b	8e7bc0f8-e12d-4f86-8cc1-c2172e20bfcb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/kyojindee	\N	\N	f	2025-12-10 18:19:12.310857	2025-12-10 18:19:12.310857
96b34bb4-42b9-4ebc-86c6-ba80a01b6fd7	a729039a-942d-415a-80bd-9c882ed4ad40	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@arzanocrypto	\N	\N	f	2025-12-10 18:19:12.311551	2025-12-10 18:19:12.311551
e9279095-6736-404a-9ae4-80e559ddf287	90057bf7-6dfd-4f3c-acf1-e9f13ea5f207	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/BTannadi	\N	\N	f	2025-12-10 18:19:12.312236	2025-12-10 18:19:12.312236
04940fcc-b9e4-46b4-a6e0-6a785753ebc5	1399c0fe-80f8-48af-88cc-ae8b8bff6911	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/bitcoinexpertindiaa	\N	\N	f	2025-12-10 18:19:12.312919	2025-12-10 18:19:12.312919
6530a3a4-67f4-409a-972f-e734cd5a9a29	8ed05502-d9d4-4f16-b115-990845279625	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/AlwaysBeenChoze	\N	\N	f	2025-12-10 18:19:12.313606	2025-12-10 18:19:12.313606
416e6af6-65d3-442f-892f-cd18282f9241	74cdb61f-4460-4d79-9311-70c7fbb866da	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Crypto_Jargon	\N	\N	f	2025-12-10 18:19:12.314496	2025-12-10 18:19:12.314496
83537feb-eb1e-4988-b183-bca555598d05	74cdb61f-4460-4d79-9311-70c7fbb866da	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptojargon69	\N	\N	f	2025-12-10 18:19:12.314671	2025-12-10 18:19:12.314671
bbd2a826-46f3-4d0f-9f25-7afa2eafe3c2	6d581354-2a55-4133-bdb6-58087f38dbe6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/cryptokingkeyur	\N	\N	f	2025-12-10 18:19:12.315347	2025-12-10 18:19:12.315347
693375e8-a7ad-4b8e-b21a-34c7d542492d	87362c41-8e3b-4de9-9b7b-c1c80ab5551d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoYug/videos	\N	\N	f	2025-12-10 18:19:12.31602	2025-12-10 18:19:12.31602
c369848b-dab7-4af1-8f7b-df9d2c86b127	bdae4eec-4bf0-4c0d-8e4a-bbf8e8ec525c	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@EarnWithSapna	\N	\N	f	2025-12-10 18:19:12.316725	2025-12-10 18:19:12.316725
66c021f5-5976-4e2f-826b-3cab77c11483	7a141736-4709-4f4d-9525-2fc61668753d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/GuarEmperor	\N	\N	f	2025-12-10 18:19:12.317398	2025-12-10 18:19:12.317398
c8add89d-35e9-4707-b82a-02964588cef9	6c8989e0-27f3-4dea-9c9a-ea3d720bef74	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@GlobalRashid/videos	\N	\N	f	2025-12-10 18:19:12.318096	2025-12-10 18:19:12.318096
363c103f-bf16-4f28-92f7-7a3edd64eea2	e6ed116f-20ee-4e33-9e02-b94609a4b1d4	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/ihsanAgaz/featured	\N	\N	f	2025-12-10 18:19:12.318968	2025-12-10 18:19:12.318968
adc691dc-1d5f-4728-9812-ad6a736eb3a5	109a6ec0-be3d-4328-b64b-b9b00f24b358	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/KenalKripto	\N	\N	f	2025-12-10 18:19:12.320229	2025-12-10 18:19:12.320229
cbc2e8a6-535c-4a59-aa44-7ad541f88215	eb3aa25c-3533-4267-b913-8fc8361590c3	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/c/Open4Profit	\N	\N	f	2025-12-10 18:19:12.321057	2025-12-10 18:19:12.321057
4b3fd471-817b-4d1f-a6ac-e90909aace7c	b01467c1-c5ff-419c-a878-5a6f6692c4a1	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/c/TODAYCRYPTO	\N	\N	f	2025-12-10 18:19:12.321809	2025-12-10 18:19:12.321809
50720728-bc32-4c8a-8a0b-7f4d86c45942	918eab5e-48c2-4b12-b710-a5ed470bbbdf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/TomketLovers	\N	\N	f	2025-12-10 18:19:12.322492	2025-12-10 18:19:12.322492
b3146bde-7366-42c5-8855-e879b23983a6	77004703-79c5-431a-b7b9-c61e9a5610e5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@WISEADVICEE/videos	\N	\N	f	2025-12-10 18:19:12.323185	2025-12-10 18:19:12.323185
6cbf2679-eec2-4be2-b597-3efc9378b477	8880a9b3-e726-44ba-b8fb-8d81c9ca4bb1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/yanzero_	\N	\N	f	2025-12-10 18:19:12.323859	2025-12-10 18:19:12.323859
e8a7c6e1-9493-45ee-b7df-7be420731005	493085c2-5cfd-4739-bac2-00d9532d4886	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/yonathandinata	\N	\N	f	2025-12-10 18:19:12.324767	2025-12-10 18:19:12.324767
44a1a385-00f2-4d03-a16f-9414a2f508fc	a7f4d186-7dbc-43ff-a6eb-071cb73bcd24	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@yunepto	\N	\N	f	2025-12-10 18:19:12.325492	2025-12-10 18:19:12.325492
e4daa5d3-d273-44e2-ac93-6e30f1169125	a7f4d186-7dbc-43ff-a6eb-071cb73bcd24	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/yunepto	\N	\N	f	2025-12-10 18:19:12.32568	2025-12-10 18:19:12.32568
e912a3a5-edf9-4dee-95ed-672317568053	4a23b148-7768-4e61-8679-df0cd894ba5c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/zksrzkshmr	\N	\N	f	2025-12-10 18:19:12.326419	2025-12-10 18:19:12.326419
e43d9578-3079-4d9c-af26-e363231625f0	cedcd048-a84e-4c58-83dc-3e52a8dfac0b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Bitcoin2Go	\N	\N	f	2025-12-10 18:19:12.32717	2025-12-10 18:19:12.32717
0685e1b7-34de-4f6a-be35-58dbbaaf408d	cedcd048-a84e-4c58-83dc-3e52a8dfac0b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/bitcoin2go	\N	\N	f	2025-12-10 18:19:12.327349	2025-12-10 18:19:12.327349
3d326e05-190e-45a4-8db3-3b3b8ae495c8	af71200b-6946-49bc-a2aa-6ad36368b8cf	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CoinCheckTV	\N	\N	f	2025-12-10 18:19:12.328238	2025-12-10 18:19:12.328238
5cd9f668-f986-41c1-a225-7ec2d7778dde	af71200b-6946-49bc-a2aa-6ad36368b8cf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/FurkanCCTV	\N	\N	f	2025-12-10 18:19:12.328412	2025-12-10 18:19:12.328412
a906f9c3-c218-4751-9ee3-3490118a71b5	e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoHeroesYT/videos	\N	\N	f	2025-12-10 18:19:12.32918	2025-12-10 18:19:12.32918
b3ca51e5-095d-477b-8aa1-eeebe457a8cd	822c81af-c1b5-4493-b0a8-55ff0fdbbfee	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/CryptoTuts/videos	\N	\N	f	2025-12-10 18:19:12.32984	2025-12-10 18:19:12.32984
5cdb1e4e-0ba7-4f77-87c0-02065115f79f	b40da33a-f72b-468b-9886-5aa16aea65d7	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@FFDK589/videos	\N	\N	f	2025-12-10 18:19:12.330543	2025-12-10 18:19:12.330543
9521cc8f-70a8-4bed-8b88-f350299d4d24	19300d02-feb6-42b9-8cf9-0cd847a24821	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@KryptoFaint/videos	\N	\N	f	2025-12-10 18:19:12.331419	2025-12-10 18:19:12.331419
fbecbe58-7fd8-4a48-a09a-b15688c212c9	fd93a113-b0fe-4a7a-bd1b-262a688517c6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Krypto_Nightowl/videos	\N	\N	f	2025-12-10 18:19:12.332382	2025-12-10 18:19:12.332382
b5e9d5fb-3b85-482f-9a32-8bc71862acac	c18ae991-a8fb-42f9-8cd0-7047fe39d597	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MissCryptoGer/videos	\N	\N	f	2025-12-10 18:19:12.333446	2025-12-10 18:19:12.333446
01a1a04b-5f97-47ba-92c2-2a36111f5189	1812ef72-6275-4dd6-92d2-a91ed2871065	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MonetenDave/videos	\N	\N	f	2025-12-10 18:19:12.334222	2025-12-10 18:19:12.334222
882dfacc-0173-4f4e-8efb-d472eb87b837	1812ef72-6275-4dd6-92d2-a91ed2871065	8564cdb8-9a90-4b0d-8bf9-c477c83814df	http://twitter.com/DaveMoneten	\N	\N	f	2025-12-10 18:19:12.334393	2025-12-10 18:19:12.334393
a5d2dcfb-3dd7-4244-a90b-9f4151776485	1812ef72-6275-4dd6-92d2-a91ed2871065	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/monetendave/	\N	\N	f	2025-12-10 18:19:12.334567	2025-12-10 18:19:12.334567
78398269-c168-44fc-8a78-46369f7d0f60	d6167946-0ac9-431d-b151-1ef742b78f5d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/watch?v=n0uSGBbD57U	\N	\N	f	2025-12-10 18:19:12.335244	2025-12-10 18:19:12.335244
c089c610-6252-4413-b4ed-80d6ddc6c09e	ac3d5f2e-1d2e-4646-a8d5-87ede6865999	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@AlanTradingYT/videos%60	\N	\N	f	2025-12-10 18:19:12.336102	2025-12-10 18:19:12.336102
089a8b36-0950-43e2-af4d-f734c1748c6c	f29618c2-ef58-4c56-a6d2-c11779262f12	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/AlanTradingYT	\N	\N	f	2025-12-10 18:19:12.337399	2025-12-10 18:19:12.337399
5a8d6955-8304-4338-a01d-8308b970d1d8	20901b9b-696f-41da-9b0a-56c2b8c2874d	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/caroline_jurado_/	\N	\N	f	2025-12-10 18:19:12.338719	2025-12-10 18:19:12.338719
cc17b89b-ed00-4e74-8f11-e14df707513a	fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@carolinejurado	\N	\N	f	2025-12-10 18:19:12.33947	2025-12-10 18:19:12.33947
3ba2b304-b45b-4be1-803e-68b48f13592c	fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/caroline_jurado_/	\N	\N	f	2025-12-10 18:19:12.339632	2025-12-10 18:19:12.339632
d44a44c9-3f95-4916-a132-c05f41174b8b	e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CharlieSeddine	\N	\N	f	2025-12-10 18:19:12.34022	2025-12-10 18:19:12.34022
52b8a3ae-d28a-4611-a58f-ae6c6976b76a	a34840e0-3c85-4209-94b7-445658014577	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/CryptoFutur/featured	\N	\N	f	2025-12-10 18:19:12.340946	2025-12-10 18:19:12.340946
2403ad5d-8be4-4363-a2aa-66b3d5d91d67	a34840e0-3c85-4209-94b7-445658014577	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/crypto_futur	\N	\N	f	2025-12-10 18:19:12.341128	2025-12-10 18:19:12.341128
1a320ab2-17f0-49fc-98e3-b84fb30decbc	718f59a6-8d16-4e31-84f0-61883efc83fe	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/frenchstartupper/	\N	\N	f	2025-12-10 18:19:12.341986	2025-12-10 18:19:12.341986
c728b6a1-1bf7-43a6-af78-53f1902ef387	87057b00-a0b9-436f-a9d3-fc7794a4acac	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@frenchstartupper	\N	\N	f	2025-12-10 18:19:12.342687	2025-12-10 18:19:12.342687
ed536efd-b699-40cc-9bf0-322712948202	87057b00-a0b9-436f-a9d3-fc7794a4acac	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/frenchstartupper/	\N	\N	f	2025-12-10 18:19:12.342866	2025-12-10 18:19:12.342866
a6bb3662-6606-4157-ac95-f82665106ee8	60a1caed-204b-423a-818a-476d229e4c56	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Crypto__Goku	\N	\N	f	2025-12-10 18:19:12.34354	2025-12-10 18:19:12.34354
2301d7c4-5137-49fa-a10b-0db70435adba	60a1caed-204b-423a-818a-476d229e4c56	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/GokuCryptoNews	\N	\N	f	2025-12-10 18:19:12.343718	2025-12-10 18:19:12.343718
ef6f0f59-7b09-41ff-8ff3-99ebd59e11e6	86adf090-8560-4038-839a-caabbb105de3	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Hasheur	\N	\N	f	2025-12-10 18:19:12.34503	2025-12-10 18:19:12.34503
038736b3-c4fc-4ed2-baa3-73fcddb098d9	50b93517-656c-431d-b111-9fc40557712f	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Jeuxcryptofr	\N	\N	f	2025-12-10 18:19:12.345847	2025-12-10 18:19:12.345847
9dee76e0-adab-49c7-9f05-741d56198755	50b93517-656c-431d-b111-9fc40557712f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@jeuxcryptofr/videos	\N	\N	f	2025-12-10 18:19:12.34602	2025-12-10 18:19:12.34602
090e5cdc-d0dd-4784-83f6-4478102efc8b	18008409-4129-4af9-a114-f0ae6269ec2b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/JulienRoman	\N	\N	f	2025-12-10 18:19:12.346914	2025-12-10 18:19:12.346914
366c27b5-10b4-4576-aac4-ae702aef3ae4	18008409-4129-4af9-a114-f0ae6269ec2b	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/julienromantelegram	\N	\N	f	2025-12-10 18:19:12.347085	2025-12-10 18:19:12.347085
e88d0f7a-8b0d-41ad-8286-c326fbe657fa	18008409-4129-4af9-a114-f0ae6269ec2b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/JulienROMAN13	\N	\N	f	2025-12-10 18:19:12.347258	2025-12-10 18:19:12.347258
c0ce68e6-6be9-4fc6-9711-e4448b65c858	18008409-4129-4af9-a114-f0ae6269ec2b	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/jromanyoutube/#	\N	\N	f	2025-12-10 18:19:12.347425	2025-12-10 18:19:12.347425
c94dd770-ea97-448d-9512-8d53a7dc35bc	18008409-4129-4af9-a114-f0ae6269ec2b	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@julienromanyoutube	\N	\N	f	2025-12-10 18:19:12.347593	2025-12-10 18:19:12.347593
76ac7a59-1479-4354-8515-f90c688ac7f9	2cba013b-a76f-4d2a-bd8a-87605899cdd0	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@lesroisdubitcoin	\N	\N	f	2025-12-10 18:19:12.348313	2025-12-10 18:19:12.348313
a175294e-f95c-48c4-8917-193e0b547ec2	2cba013b-a76f-4d2a-bd8a-87605899cdd0	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Rois_Hermes	\N	\N	f	2025-12-10 18:19:12.348483	2025-12-10 18:19:12.348483
3a2ba7c0-9eeb-4791-803e-6e1ae021140b	4b43d6cc-7025-4896-be9f-9b30bf1fba98	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/search?q=Maxime%20Painchaud&t=1658412297459	\N	\N	f	2025-12-10 18:19:12.349511	2025-12-10 18:19:12.349511
96b6f5d7-92f6-4c42-a507-57aadc2ea1ac	4b43d6cc-7025-4896-be9f-9b30bf1fba98	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/maxime.astuces/	\N	\N	f	2025-12-10 18:19:12.349695	2025-12-10 18:19:12.349695
5582925a-f91d-4381-b78e-55eb46cddbb1	4b43d6cc-7025-4896-be9f-9b30bf1fba98	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@maximeastuces	\N	\N	f	2025-12-10 18:19:12.349866	2025-12-10 18:19:12.349866
dd1d999e-e603-4934-987e-a92dd5c2ef09	5eecf188-ac02-4b8e-87da-3ec22550adbc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/OrianMessa%C3%AF/videos	\N	\N	f	2025-12-10 18:19:12.350419	2025-12-10 18:19:12.350419
220558c7-46de-4cec-ba29-638eec7697d6	5eecf188-ac02-4b8e-87da-3ec22550adbc	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/orian.messai/	\N	\N	f	2025-12-10 18:19:12.350591	2025-12-10 18:19:12.350591
a1d2ab48-cffe-417e-8be8-d5fa114d50c1	acdb7ded-63b9-4e74-a95c-96d584e05e85	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/frenchstartupper/	\N	\N	f	2025-12-10 18:19:12.35149	2025-12-10 18:19:12.35149
b1e4695d-4e0c-43af-8847-4a87eb1bb81d	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@quarter.elh?lang=en	\N	\N	f	2025-12-10 18:19:12.352492	2025-12-10 18:19:12.352492
c90d5bb0-1f3d-402b-a557-ba815a63bf6c	78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/quarter.elh/	\N	\N	f	2025-12-10 18:19:12.352682	2025-12-10 18:19:12.352682
ad6f7363-e705-4673-a85e-22359d2ccdcb	51465645-99e4-411b-84bb-c35db8063c51	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@rorovevo/videos	\N	\N	f	2025-12-10 18:19:12.353275	2025-12-10 18:19:12.353275
23046994-3591-41fc-b77c-db2cf40f89ec	51465645-99e4-411b-84bb-c35db8063c51	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@roroelguapo	\N	\N	f	2025-12-10 18:19:12.353511	2025-12-10 18:19:12.353511
c3924e4d-783a-4231-a8ba-d80db855b914	51465645-99e4-411b-84bb-c35db8063c51	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+SD94FN8paAJ4HcEG	\N	\N	f	2025-12-10 18:19:12.353714	2025-12-10 18:19:12.353714
2dde7065-5eb9-4155-9633-772d383aa92d	431f2005-da1f-4309-9b88-bc84e36a271f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@rorovevo	\N	\N	f	2025-12-10 18:19:12.354607	2025-12-10 18:19:12.354607
360a739f-9c24-46ec-a1fe-dadb6861c8a1	431f2005-da1f-4309-9b88-bc84e36a271f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/roroivx	\N	\N	f	2025-12-10 18:19:12.35478	2025-12-10 18:19:12.35478
96343c18-2322-481b-88d7-c157444de9d1	431f2005-da1f-4309-9b88-bc84e36a271f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+SD94FN8paAJ4HcEG	\N	\N	f	2025-12-10 18:19:12.354965	2025-12-10 18:19:12.354965
9bb10ccb-f149-4f90-b320-5452d77dd560	6e27e554-7a48-45d4-878c-063a723e33c2	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/TagadoBTC/	\N	\N	f	2025-12-10 18:19:12.356485	2025-12-10 18:19:12.356485
6e9e26fc-a4ce-479a-abee-f3ef426b46d7	6e27e554-7a48-45d4-878c-063a723e33c2	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/TagadoBitcoin	\N	\N	f	2025-12-10 18:19:12.356678	2025-12-10 18:19:12.356678
603404cd-97b1-4452-810e-89d81c9d2d85	6e27e554-7a48-45d4-878c-063a723e33c2	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/TagadoCrypto	\N	\N	f	2025-12-10 18:19:12.356863	2025-12-10 18:19:12.356863
61a75c40-30e8-4b16-a714-ecfcd843e0f7	b4c91d20-b980-4a02-a0c7-65a824ea2358	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@tib.talks?lang=fr	\N	\N	f	2025-12-10 18:19:12.357755	2025-12-10 18:19:12.357755
88122c9f-a9f8-49f5-bbda-f0958c221bc4	b4c91d20-b980-4a02-a0c7-65a824ea2358	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@TIBTalks/videos	\N	\N	f	2025-12-10 18:19:12.357932	2025-12-10 18:19:12.357932
e1ef0952-8d66-4014-8ba6-69cd6e4f33cd	b4c91d20-b980-4a02-a0c7-65a824ea2358	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/TIBTalks	\N	\N	f	2025-12-10 18:19:12.358135	2025-12-10 18:19:12.358135
94b30295-69b5-4bc2-bf20-a922e761362c	eb01735c-541b-4bc9-b357-080cdea8f749	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/YoanAxie	\N	\N	f	2025-12-10 18:19:12.358711	2025-12-10 18:19:12.358711
aeb1a821-60a4-4255-9f68-29a5eb5b3154	eb01735c-541b-4bc9-b357-080cdea8f749	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Yoan_GJ	\N	\N	f	2025-12-10 18:19:12.358886	2025-12-10 18:19:12.358886
b1f42244-056d-45fd-ad28-be710aab6a31	66e31a78-d9ee-4475-8324-824f1d7a5e01	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@yrile/videos	\N	\N	f	2025-12-10 18:19:12.359763	2025-12-10 18:19:12.359763
79beacd0-9289-4940-8a98-d03de7a2b1c8	66e31a78-d9ee-4475-8324-824f1d7a5e01	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/YrileC	\N	\N	f	2025-12-10 18:19:12.359946	2025-12-10 18:19:12.359946
45b8686c-a176-446c-af2a-702c248d38ee	afed05b8-7348-4604-949d-9e25de692f4e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xmistblade	\N	\N	f	2025-12-10 18:19:12.360689	2025-12-10 18:19:12.360689
c70b2d4c-e13c-4b33-a689-a34ccc3d8740	9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xmistblade	\N	\N	f	2025-12-10 18:19:12.36158	2025-12-10 18:19:12.36158
e583cdef-a1ac-4052-b66c-2cb34ef04739	78288a3c-91c0-4414-af3b-6fb308bdb9fe	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/0xSweep	\N	\N	f	2025-12-10 18:19:12.36279	2025-12-10 18:19:12.36279
ca04ef25-324b-4aca-80b5-a09a9eeba0a4	58b959a9-0137-4f52-b2a3-1388ccd167c2	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/ACXtrades	\N	\N	f	2025-12-10 18:19:12.363494	2025-12-10 18:19:12.363494
c4d61c78-029f-4f2f-8efe-27384efe42ce	6073dca8-6f3b-4a4c-bd89-51c4599d76a1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/ZssBecker	\N	\N	f	2025-12-10 18:19:12.364365	2025-12-10 18:19:12.364365
d89fa3af-e863-4436-a563-aba9a4f9b6df	6bdc05dd-b9aa-421b-810e-10ae2c309d74	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/wacy_time1	\N	\N	f	2025-12-10 18:19:12.365245	2025-12-10 18:19:12.365245
f3e5c546-b348-4583-85cb-a22575e355d3	37dcd61b-db39-4503-a4ee-d1bc37d4052a	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/altcoindaily/	\N	\N	f	2025-12-10 18:19:12.366658	2025-12-10 18:19:12.366658
4454dd9d-4ca3-49a6-8bbf-d9da49c50f14	03a0a906-acb5-4276-af0e-56ffff01be45	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Altsteinn	\N	\N	f	2025-12-10 18:19:12.36737	2025-12-10 18:19:12.36737
825f1b7c-9687-4c86-9520-0bc42fc9c52e	209afc83-5f38-41e7-afca-a46ff03f9f69	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/blknoiz06	\N	\N	f	2025-12-10 18:19:12.3682	2025-12-10 18:19:12.3682
c6eb625b-d325-4dcb-91ec-1b1754726dff	7d4d69a7-e764-479b-af12-259c90e4a56c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/ardizor	\N	\N	f	2025-12-10 18:19:12.369093	2025-12-10 18:19:12.369093
b0a7eb31-6d84-4255-949a-68e83a87c50c	58e8eed6-92e8-4555-bda2-4ef60f159516	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+bVPhgNX5MWRmNDBi	\N	\N	f	2025-12-10 18:19:12.370402	2025-12-10 18:19:12.370402
00e9ceaa-9df1-4520-9746-1076a91c0842	c8aa5616-b8b6-488c-baea-d0ff1b42ad60	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Ashcryptoreal	\N	\N	f	2025-12-10 18:19:12.371759	2025-12-10 18:19:12.371759
5847050c-e8bc-406e-80df-d483a5f8bc99	f30fbc03-1379-4a3f-9cb0-4e53194f41d5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/BagCalls	\N	\N	f	2025-12-10 18:19:12.372799	2025-12-10 18:19:12.372799
594a05b9-860d-4141-8777-c61f6d9b59e9	136f2845-8bf7-4324-bd2e-2e7f84025cd3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	http://x.com/wisdommatic	\N	\N	f	2025-12-10 18:19:12.373681	2025-12-10 18:19:12.373681
8494d34d-8d1e-4215-943a-9af7d3a5c93e	136f2845-8bf7-4324-bd2e-2e7f84025cd3	77386a88-6ca3-44af-916f-807a0558671d	http://t.me/cryptocoachpro	\N	\N	f	2025-12-10 18:19:12.373863	2025-12-10 18:19:12.373863
b8c08e41-ea74-45de-b20d-cfd1d1f475e6	56d2d5ce-e67a-4a46-97cb-8ef4fde0e960	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/_BillionAireSon	\N	\N	f	2025-12-10 18:19:12.374726	2025-12-10 18:19:12.374726
1d935f50-a47b-43e3-85a1-c16fa9c0352e	db3a7a94-caa7-4a9f-899a-f25c24199e2a	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/bitcoin.page/	\N	\N	f	2025-12-10 18:19:12.375612	2025-12-10 18:19:12.375612
e06c2b54-07af-49ff-9a02-ff37e99011e8	f8799383-8829-494d-b9ea-6d6acb56178e	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/bitcoinpricedaily/	\N	\N	f	2025-12-10 18:19:12.376323	2025-12-10 18:19:12.376323
10474039-5e5d-45e5-ba98-b42890e873a5	a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/blockchainbob	\N	\N	f	2025-12-10 18:19:12.377026	2025-12-10 18:19:12.377026
fafeb270-a81b-4721-8df8-b28152587bbd	d29938f5-3fb9-40c9-a64f-12dcaa311692	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/blocklantis/	\N	\N	f	2025-12-10 18:19:12.377855	2025-12-10 18:19:12.377855
49e357af-373c-4d13-bf8b-c8021c58d485	aeaafa1a-e889-432d-88f9-096455b63aeb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/brommmyy	\N	\N	f	2025-12-10 18:19:12.378691	2025-12-10 18:19:12.378691
0ca575f7-f47f-485e-bb16-f425e928e9f8	aeaafa1a-e889-432d-88f9-096455b63aeb	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/brommysbags	\N	\N	f	2025-12-10 18:19:12.378871	2025-12-10 18:19:12.378871
5cc82750-68c0-4acd-9b2b-ea27edc79311	66a68c02-2321-453b-bd50-79ff47082a9c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/bull_bnb	\N	\N	f	2025-12-10 18:19:12.379746	2025-12-10 18:19:12.379746
3fbe23d8-6501-4af5-a6ae-fc9d0c6ff9b0	6c5a4dc5-d1d6-422f-bfc7-ee145ea2680a	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@businesswithnoah	\N	\N	f	2025-12-10 18:19:12.380607	2025-12-10 18:19:12.380607
c2d04576-5727-40b8-a96e-abe56f93ed3e	a3d597ea-4118-46ad-bd41-49950351a7f5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/themooncarl	\N	\N	f	2025-12-10 18:19:12.381142	2025-12-10 18:19:12.381142
0b222350-58e1-4c3b-975b-67ea2d3e51e8	a3d597ea-4118-46ad-bd41-49950351a7f5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@themoon	\N	\N	f	2025-12-10 18:19:12.381314	2025-12-10 18:19:12.381314
4f620851-8ce7-4b0c-82e5-42e5c62a7f25	78747028-16fc-42c1-ba68-ad630d5a5bda	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cryptocevo?s=21&t=AGOxdb9ccwSmcY2XtRjloA	\N	\N	f	2025-12-10 18:19:12.382038	2025-12-10 18:19:12.382038
7a36a820-7aca-4714-bb6a-595605dbecb2	1a75ba2a-e021-4c3e-b068-c55029a8a923	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/coingape/	\N	\N	f	2025-12-10 18:19:12.38287	2025-12-10 18:19:12.38287
e8df229b-18f4-4161-b517-97b3aa6174a5	2472142d-690e-4406-b8af-eea74d1afa6f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCdSa35z0ZFiQQnhD1bFzgXQ	\N	\N	f	2025-12-10 18:19:12.383834	2025-12-10 18:19:12.383834
f9e3a187-ecef-4db3-9b19-0d95948bf3db	2472142d-690e-4406-b8af-eea74d1afa6f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@coinpostpro5320	\N	\N	f	2025-12-10 18:19:12.384068	2025-12-10 18:19:12.384068
0ea5826e-a7ed-434d-8b9c-db2605929cb0	2472142d-690e-4406-b8af-eea74d1afa6f	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCUP66dHwZxisqlIYUXpDZQg	\N	\N	f	2025-12-10 18:19:12.38423	2025-12-10 18:19:12.38423
537b15ac-d02b-4f31-b77d-f5281a818688	2472142d-690e-4406-b8af-eea74d1afa6f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/Coin_Post	\N	\N	f	2025-12-10 18:19:12.384432	2025-12-10 18:19:12.384432
c83d9416-0b63-4e21-853d-cefacc6b08de	2472142d-690e-4406-b8af-eea74d1afa6f	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/cryptodaily	\N	\N	f	2025-12-10 18:19:12.384611	2025-12-10 18:19:12.384611
582efcca-d4c6-48c9-ab32-039e33c22890	b36c6d5b-3cfd-4b76-8af1-93d565960d54	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/coingrams/	\N	\N	f	2025-12-10 18:19:12.385726	2025-12-10 18:19:12.385726
6031c726-fb39-4dfa-abf4-5ed739957143	efae8184-423d-41e4-9557-7aa10924710b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/cometcalls	\N	\N	f	2025-12-10 18:19:12.386548	2025-12-10 18:19:12.386548
c52d0e57-d4c4-464d-9fd7-7a1d75c6ed0d	899cfad6-04d0-442d-bfd0-cb91e18ae0d0	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/CraftyGems	\N	\N	f	2025-12-10 18:19:12.387476	2025-12-10 18:19:12.387476
ebfe1b5d-c06d-4eab-9aa9-e0d3c1c5c036	6ffa6051-8a12-4c47-9b02-0eac4e5a3cb0	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptoding/	\N	\N	f	2025-12-10 18:19:12.388334	2025-12-10 18:19:12.388334
5500478d-1c38-432f-b7f9-898e69fc9c3d	30d9c8ad-0e04-428f-8fd2-576ca87228c8	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/masonversluis/	\N	\N	f	2025-12-10 18:19:12.389235	2025-12-10 18:19:12.389235
12a54478-9dfe-49aa-8862-a9803858daf1	30d9c8ad-0e04-428f-8fd2-576ca87228c8	a833496d-d109-42f7-a01f-be2a3180e5df	https://tiktok.com/@cryptomasun	\N	\N	f	2025-12-10 18:19:12.389447	2025-12-10 18:19:12.389447
f219d946-c1c9-4aa7-a742-2302468cee03	c3bc5eaa-f1f4-4426-937c-d9b713c9fd16	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/official_cryptopablo/	\N	\N	f	2025-12-10 18:19:12.390401	2025-12-10 18:19:12.390401
94311eb2-b438-4e4a-962a-ecac46104f36	e9e3fb40-6e36-48d9-918a-25cb5975cf0b	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/crypto.pages/	\N	\N	f	2025-12-10 18:19:12.391557	2025-12-10 18:19:12.391557
8bfc9737-10ee-450a-b52d-4c44ff7c8bf3	05d4763c-6190-4df5-b97f-e60500a9df99	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/crypto_rand	\N	\N	f	2025-12-10 18:19:12.392286	2025-12-10 18:19:12.392286
bcda0712-2918-4475-902b-0d9069310f4e	0a540629-6aec-455d-9339-5f467913ff9d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoCapo_	\N	\N	f	2025-12-10 18:19:12.392991	2025-12-10 18:19:12.392991
2a8c078a-1a6c-4276-927f-f3305d3da670	c5e25267-6809-4882-b749-9662946912c2	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptocita/	\N	\N	f	2025-12-10 18:19:12.393703	2025-12-10 18:19:12.393703
6ace0978-c23b-4822-b01a-412607738e71	3c0e3bbc-66d9-4333-ad39-961ae3d102b7	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@cryptocita	\N	\N	f	2025-12-10 18:19:12.394445	2025-12-10 18:19:12.394445
c506ebda-13ff-42b4-b3fb-ecbb80c9488e	3c0e3bbc-66d9-4333-ad39-961ae3d102b7	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptocita/	\N	\N	f	2025-12-10 18:19:12.394625	2025-12-10 18:19:12.394625
f61e1add-4ac5-4604-8f08-368b328c06d0	a8dd7f18-3436-471c-a958-69575f764986	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptoworld2020/	\N	\N	f	2025-12-10 18:19:12.39518	2025-12-10 18:19:12.39518
43235117-e041-4264-9c21-f4f8d9bdfd1d	d96d57cb-c038-4b44-b083-b324eeef60a9	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoGodJohn	\N	\N	f	2025-12-10 18:19:12.396256	2025-12-10 18:19:12.396256
312893e1-24f4-40bc-920d-69ac73aca6e9	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/Cryptolyze/videos	\N	\N	f	2025-12-10 18:19:12.396978	2025-12-10 18:19:12.396978
ee9d8acd-f323-46dd-8c91-0ca6a65e13cc	dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Cryptolyze_tek	\N	\N	f	2025-12-10 18:19:12.397157	2025-12-10 18:19:12.397157
8079fd4e-156c-49df-ad0c-7ee7a887c222	c5942cef-4b45-44ae-bd78-d60f38a052b5	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@cryptomasun	\N	\N	f	2025-12-10 18:19:12.398021	2025-12-10 18:19:12.398021
709f7053-5398-47e8-bb39-52f4fa9ddec6	c5942cef-4b45-44ae-bd78-d60f38a052b5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/masonversluis	\N	\N	f	2025-12-10 18:19:12.398189	2025-12-10 18:19:12.398189
3f5c8f5f-fa67-4f5b-9262-991fd791f3bd	5ef7275a-ff14-4948-aebb-fa5d6b6a0e9b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoMichNL	\N	\N	f	2025-12-10 18:19:12.39886	2025-12-10 18:19:12.39886
bceadf11-06e5-4b5f-be77-94131be94994	5ef7275a-ff14-4948-aebb-fa5d6b6a0e9b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@cryptomichnl	\N	\N	f	2025-12-10 18:19:12.399092	2025-12-10 18:19:12.399092
af59b189-8755-4142-88aa-b9f152bf6010	4d33ea45-8f4e-4a4d-a09b-ba34b57ba3e9	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@cryptopizzagirl	\N	\N	f	2025-12-10 18:19:12.399758	2025-12-10 18:19:12.399758
6856fe54-129c-41ce-96f9-44ca98733f88	b462869e-5bc0-4ff4-ada6-6944092d9e59	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/CryptosRUs/videos	\N	\N	f	2025-12-10 18:19:12.400298	2025-12-10 18:19:12.400298
8ca078c1-aa2f-48a4-9f24-b6db652ca4ff	b462869e-5bc0-4ff4-ada6-6944092d9e59	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptosR_Us	\N	\N	f	2025-12-10 18:19:12.400481	2025-12-10 18:19:12.400481
c9da8b4c-2dc4-40a1-ab5d-1cb9c744f27a	0909af86-2dc6-41b3-8787-53eb87b387bb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/CryptoThannos	\N	\N	f	2025-12-10 18:19:12.401189	2025-12-10 18:19:12.401189
ef062d31-01d7-4cb2-9bff-279af43d2c2e	0bf4c131-d69b-4b4b-af65-b795960d06f7	77386a88-6ca3-44af-916f-807a0558671d	t.me/thanos_mind	\N	\N	f	2025-12-10 18:19:12.402204	2025-12-10 18:19:12.402204
1e27839e-fc04-49b0-853b-fd02631e27b7	449d6043-e4a5-4cb7-882d-6523c4fa5319	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/nobrainflip	\N	\N	f	2025-12-10 18:19:12.403061	2025-12-10 18:19:12.403061
e51574b8-1b14-457e-8b80-4cd223e1bff0	449d6043-e4a5-4cb7-882d-6523c4fa5319	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+uh1Ubbla3Us2MmRi	\N	\N	f	2025-12-10 18:19:12.403231	2025-12-10 18:19:12.403231
24d3afff-1c90-4f3b-b7a6-3b34004ca0a3	2a9688a8-1ddf-4b40-9b13-4eebdd046e59	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@davincij15	\N	\N	f	2025-12-10 18:19:12.403924	2025-12-10 18:19:12.403924
eb0e0d31-e957-4b00-8a56-c568d5ca9e5e	2a9688a8-1ddf-4b40-9b13-4eebdd046e59	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/davincij15	\N	\N	f	2025-12-10 18:19:12.404148	2025-12-10 18:19:12.404148
11d719ac-30d2-4ec3-811a-82d22a574767	fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/dippy_eth	\N	\N	f	2025-12-10 18:19:12.404881	2025-12-10 18:19:12.404881
8e90e2bf-5b0f-4db5-aa1e-3bfd0d8af895	9836277c-c853-4951-a303-f6bac411c107	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/DustyBC/videos	\N	\N	f	2025-12-10 18:19:12.405752	2025-12-10 18:19:12.405752
bf0f0ce7-24c7-4e4f-8002-df53a989304f	9836277c-c853-4951-a303-f6bac411c107	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/TheDustyBC	\N	\N	f	2025-12-10 18:19:12.405926	2025-12-10 18:19:12.405926
cf5663cb-316b-41e1-800f-b449a9f06e83	9836277c-c853-4951-a303-f6bac411c107	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@dustybc	\N	\N	f	2025-12-10 18:19:12.4061	2025-12-10 18:19:12.4061
83148ea7-f6df-444c-97d7-9e0fe5e592f1	f0c334b2-8671-46e9-aafe-e3148ee23adf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/ericcryptoman	\N	\N	f	2025-12-10 18:19:12.406636	2025-12-10 18:19:12.406636
91ab0ea6-1bfe-4103-8622-4ebad08d12ed	ba69463e-a9d1-4935-9596-b00294a5234a	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/ethereum_updates/	\N	\N	f	2025-12-10 18:19:12.407305	2025-12-10 18:19:12.407305
ca4c47ce-8b5b-43a9-843d-67d729a71264	3950674f-2bc5-4911-bf0a-53ae0ba48d8c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Eunicedwong	\N	\N	f	2025-12-10 18:19:12.408132	2025-12-10 18:19:12.408132
f1a472ce-b8c8-49c3-b344-d715be60481b	d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	8564cdb8-9a90-4b0d-8bf9-c477c83814df	http://x.com/farmercist_eth	\N	\N	f	2025-12-10 18:19:12.408789	2025-12-10 18:19:12.408789
6b07bedc-90bc-4cee-abd4-4d50a6f629dc	7d370edc-909f-498d-ae21-6bc2ccfb00b1	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/thefinancialwolf/	\N	\N	f	2025-12-10 18:19:12.409717	2025-12-10 18:19:12.409717
fc5ad6f8-0afe-433e-95b9-873854b50954	d923e4ba-e0d1-4fa1-9837-2755a8b33f04	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/fuelzebagsss	\N	\N	f	2025-12-10 18:19:12.410379	2025-12-10 18:19:12.410379
ad6126ff-4218-4bd9-b951-ff25610b6eb7	23a054f8-f81e-414c-bb6a-eb295bc619a6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/gainzy222	\N	\N	f	2025-12-10 18:19:12.411311	2025-12-10 18:19:12.411311
6cf86724-3f49-4f3e-9f30-fe337b3d80de	56bb5d62-6d41-462b-9f29-6f224d84763d	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/gem_detecter	\N	\N	f	2025-12-10 18:19:12.412134	2025-12-10 18:19:12.412134
f6d0c4c7-49ec-4d61-ac0c-079e8d6575dc	d72e298a-d2f6-45c3-8b09-7e0294eabf5e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/gem_insider	\N	\N	f	2025-12-10 18:19:12.413014	2025-12-10 18:19:12.413014
225f1acb-9cca-434c-adc5-4bc632562a70	d266b55c-cef1-451f-a3ce-4b71e887543e	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@gennadym	\N	\N	f	2025-12-10 18:19:12.414139	2025-12-10 18:19:12.414139
12324d30-2f65-4a99-9993-58bfecf86bfc	8f9f112d-f597-4978-90fc-5906ccff773b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/degen_hardy	\N	\N	f	2025-12-10 18:19:12.414945	2025-12-10 18:19:12.414945
6de68192-0bc9-402f-9a35-ef54312d9275	bb3c65c7-9823-4df6-8c9e-051332a6cedb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/DefiIgnas	\N	\N	f	2025-12-10 18:19:12.415811	2025-12-10 18:19:12.415811
38709e44-f6e3-41b5-9050-496c0f0e576c	394ff94e-831c-49cb-a04b-896128421240	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/intelligentcryptocurrency/	\N	\N	f	2025-12-10 18:19:12.416512	2025-12-10 18:19:12.416512
5dc7bc30-8b9c-467c-8cca-11bd24b1eaa2	352bfcd2-9a94-4791-b9c1-1b7d43bc8db2	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/investingmentors/	\N	\N	f	2025-12-10 18:19:12.417203	2025-12-10 18:19:12.417203
0b83dd0c-1933-4a7f-801a-b8af6a288ed3	ce1e5343-b310-4e6f-94ef-5824a2c167a7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/icedknife	\N	\N	f	2025-12-10 18:19:12.417974	2025-12-10 18:19:12.417974
25489eee-0edc-46d1-86f0-5e5f03d1e491	a1345f80-0740-403c-857a-c2a066e9c8c3	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@inspiredanalyst	\N	\N	f	2025-12-10 18:19:12.41937	2025-12-10 18:19:12.41937
b9bcfbc1-75d0-4cb8-9140-f153af8b1916	ba03bb82-201c-4b85-afd6-3fceeec703ef	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@JoeParysCrypto/videos	\N	\N	f	2025-12-10 18:19:12.4208	2025-12-10 18:19:12.4208
283b1d79-b0b6-4b00-80b3-7afd20fce403	ba03bb82-201c-4b85-afd6-3fceeec703ef	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/JoeParys	\N	\N	f	2025-12-10 18:19:12.420977	2025-12-10 18:19:12.420977
d46b1482-cea1-44aa-9f41-da63814b53d1	ba03bb82-201c-4b85-afd6-3fceeec703ef	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@joeparys	\N	\N	f	2025-12-10 18:19:12.421143	2025-12-10 18:19:12.421143
b50ac16c-1b0b-4fb9-81f4-f7b6d56786fd	ba03bb82-201c-4b85-afd6-3fceeec703ef	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/joeparys	\N	\N	f	2025-12-10 18:19:12.42131	2025-12-10 18:19:12.42131
128814f5-acda-44d8-aae4-310efd4061ea	b5756577-7ac1-4ea5-8a7b-67d1d5712382	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@jollygreeninvestor	\N	\N	f	2025-12-10 18:19:12.427478	2025-12-10 18:19:12.427478
ad34861c-ef28-4b13-bbb4-db930b31eb02	ff53a665-8e8b-4311-971a-fe2b51985a00	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/hackapreneur	\N	\N	f	2025-12-10 18:19:12.428344	2025-12-10 18:19:12.428344
045fbced-dd4e-4090-a46e-c323de540d40	746d71ca-9353-48de-8ae8-dbfc0654538a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/teddi_speaks	\N	\N	f	2025-12-10 18:19:12.429402	2025-12-10 18:19:12.429402
fb5d244b-218d-40ec-8a99-d51be5a671db	81d595eb-74a1-4698-b416-46c09ac155d9	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@LadyOfCrypto/videos	\N	\N	f	2025-12-10 18:19:12.430526	2025-12-10 18:19:12.430526
86e3e7d6-e01d-4688-87e5-00b2c1cdfa95	81d595eb-74a1-4698-b416-46c09ac155d9	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/LadyofCrypto1	\N	\N	f	2025-12-10 18:19:12.430697	2025-12-10 18:19:12.430697
83d1130a-8bd7-4ff7-b9de-a1bed81a102a	ffc65822-d148-468b-ba2c-18d9b231b8e5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@TheCryptoLark	\N	\N	f	2025-12-10 18:19:12.431541	2025-12-10 18:19:12.431541
2f6daeb1-57cb-47bb-acff-d2fd75902579	ffc65822-d148-468b-ba2c-18d9b231b8e5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/TheCryptoLark	\N	\N	f	2025-12-10 18:19:12.431716	2025-12-10 18:19:12.431716
b0d22bba-3609-4a7b-aaba-5be99f841c66	901eb416-3a46-4d7c-aa0c-93decf104d01	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@LayahHeilpern/videos	\N	\N	f	2025-12-10 18:19:12.432556	2025-12-10 18:19:12.432556
2d3a5c3f-763a-42da-97f9-511552a6755d	901eb416-3a46-4d7c-aa0c-93decf104d01	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/LayahHeilpern	\N	\N	f	2025-12-10 18:19:12.432726	2025-12-10 18:19:12.432726
6252ff5d-7572-4965-98dc-d69fff7af51f	901eb416-3a46-4d7c-aa0c-93decf104d01	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+Pzl_0PTVlI5hYmRk	\N	\N	f	2025-12-10 18:19:12.432935	2025-12-10 18:19:12.432935
8a8e0d7d-3dfe-4a7a-82b2-6ab39b173435	e1b258fb-7611-4b39-a601-09d38c5d6dff	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://www.youtube.com/c/CryptoKingg/videos   https://twitter.com/LeviRietveld	\N	\N	f	2025-12-10 18:19:12.433694	2025-12-10 18:19:12.433694
f8d86a7b-38ba-423d-8c43-5d10342f2ef7	5920a748-45c1-4867-b792-8a6c7845a6fb	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/lukebelmar	\N	\N	f	2025-12-10 18:19:12.435023	2025-12-10 18:19:12.435023
0baab96c-34ab-425b-a2e7-f8ed81d16277	4d95ba58-5fcf-451c-9d78-6d8a02719d51	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MacnBTC	\N	\N	f	2025-12-10 18:19:12.435928	2025-12-10 18:19:12.435928
c6adf089-4f97-4368-97c7-27026e56c6e1	67e93fc8-55a3-412c-9740-0bb6d9141177	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/mad_apes_call	\N	\N	f	2025-12-10 18:19:12.436775	2025-12-10 18:19:12.436775
92fb9e5c-b4e4-49d1-a4f2-a51cd384eb3d	59df3d5e-434c-44cb-9361-a252d1e8dc78	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/ManLyNFT	\N	\N	f	2025-12-10 18:19:12.438011	2025-12-10 18:19:12.438011
644700fa-fe5f-4aa6-aa8f-58484ece2b18	57d33458-6158-4457-a863-416a59f2bcd3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MarioNawfal	\N	\N	f	2025-12-10 18:19:12.438978	2025-12-10 18:19:12.438978
40a65c60-cabd-4ce7-a703-9d95347c8a3a	360939ba-f9a5-4122-860b-bf8f6a700d5b	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@marvinfavisofficial?lang=fr	\N	\N	f	2025-12-10 18:19:12.439722	2025-12-10 18:19:12.439722
f033bebb-585e-4f3f-9238-6c4063890184	950c1fce-9af9-489d-9057-23e42ebd5e2a	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@megbzk	\N	\N	f	2025-12-10 18:19:12.440363	2025-12-10 18:19:12.440363
b880007f-9b06-479f-b917-5450067d206f	950c1fce-9af9-489d-9057-23e42ebd5e2a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@megbzk/videos	\N	\N	f	2025-12-10 18:19:12.440528	2025-12-10 18:19:12.440528
ac3d62e1-0928-4a4d-8831-19fd4e85c1c4	950c1fce-9af9-489d-9057-23e42ebd5e2a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/megbzk	\N	\N	f	2025-12-10 18:19:12.440687	2025-12-10 18:19:12.440687
b53212a2-681f-4890-a0d3-b147e8064516	598acdcf-7247-4bb0-b980-91b71380899b	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@megbzk	\N	\N	f	2025-12-10 18:19:12.441191	2025-12-10 18:19:12.441191
5f49f486-0a20-4c89-8c3b-1b3b94e9fa84	598acdcf-7247-4bb0-b980-91b71380899b	12ebc106-4857-49c8-9528-263dc3b96f85	https://instagram.com/megbzk	\N	\N	f	2025-12-10 18:19:12.441345	2025-12-10 18:19:12.441345
92cf361f-c27a-468d-b408-237caa8e5313	7cbda437-88bb-47c1-b598-cb6eb72ea01a	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/metaculture/	\N	\N	f	2025-12-10 18:19:12.442446	2025-12-10 18:19:12.442446
e52fa1ed-4af7-4575-8c33-d62413a15c2e	4055d5a9-7d7f-451b-beb9-4dea063dfb23	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MetaGorgonite	\N	\N	f	2025-12-10 18:19:12.443206	2025-12-10 18:19:12.443206
dc3ea226-8ab3-4b32-8ee7-593071abeeee	01fa437e-dded-42ac-a1ab-795135b5c433	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/MichaelSixgods	\N	\N	f	2025-12-10 18:19:12.444002	2025-12-10 18:19:12.444002
2322e543-1d59-4a0c-8a8d-757799383124	cb476e55-39c3-4257-944f-3b1c93f8bc1a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/milesdeutscher	\N	\N	f	2025-12-10 18:19:12.444979	2025-12-10 18:19:12.444979
a23d6575-4103-4bf8-8860-13f8c8f875fa	cb476e55-39c3-4257-944f-3b1c93f8bc1a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@milesdeutscher1357/videos	\N	\N	f	2025-12-10 18:19:12.445167	2025-12-10 18:19:12.445167
d5729f54-78e8-420e-bdac-6c3bfb71e790	14f0e2a6-31b7-4617-9bb7-9a70be9e185c	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@moneycoachvince	\N	\N	f	2025-12-10 18:19:12.445833	2025-12-10 18:19:12.445833
139b1e00-9476-4328-816d-49d5bfb960ba	294b5801-e218-4601-81e8-cc59f67d38ea	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/deg_ape	\N	\N	f	2025-12-10 18:19:12.446446	2025-12-10 18:19:12.446446
7dd28cf1-e5b7-41eb-992a-5fc84d982227	5e0d6233-37b7-429b-b437-7c9e80a88217	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/nft.globally/	\N	\N	f	2025-12-10 18:19:12.44731	2025-12-10 18:19:12.44731
6becb57a-875e-4bd2-92b4-e21f7c83dc0b	1d9ca24c-6c45-431b-9358-912bb0d7000b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@NoBsCryptoOfficial	\N	\N	f	2025-12-10 18:19:12.447995	2025-12-10 18:19:12.447995
fa3104d0-eb17-4842-9515-716748e6873d	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/fuelzebagsss	\N	\N	f	2025-12-10 18:19:12.451505	2025-12-10 18:19:12.451505
9be2aa10-9f49-4ee7-9975-1539a3af56aa	ce85846a-bdae-482d-9f88-5f846ff811fa	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@JoeParysCrypto/videos	\N	\N	f	2025-12-10 18:19:12.455798	2025-12-10 18:19:12.455798
129cd91d-4473-46cb-8c02-af110dfd4e0f	64ce9410-1679-44f2-8c70-138792a1e087	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptokang/	\N	\N	f	2025-12-10 18:19:12.457582	2025-12-10 18:19:12.457582
909a5e5e-8d5a-469c-9a27-c55f7453ca27	cc3e9660-9e46-4ae1-8ac6-060ab08ad10b	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@ramyzaycmanyt	\N	\N	f	2025-12-10 18:19:12.45834	2025-12-10 18:19:12.45834
e9ac8018-b26e-4190-93ab-ebc68da944fb	4e528c7a-acc8-4f9a-a623-07a80b4d81a6	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@real_doomed_crypto	\N	\N	f	2025-12-10 18:19:12.458926	2025-12-10 18:19:12.458926
3ff9066c-f828-4096-8731-c4183791829a	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoRover	\N	\N	f	2025-12-10 18:19:12.460067	2025-12-10 18:19:12.460067
cbe71691-1e55-48f0-b766-f0c720a441d4	bdb16884-7662-42a2-b2ef-07ae7ff01a1a	77386a88-6ca3-44af-916f-807a0558671d	t.me/rutradebtc	\N	\N	f	2025-12-10 18:19:12.4617	2025-12-10 18:19:12.4617
727e0290-6397-4f44-9332-4d7d51de191b	3b9e651e-7b05-4ef5-971c-23f80efa20ec	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/StackerSatoshi	\N	\N	f	2025-12-10 18:19:12.463323	2025-12-10 18:19:12.463323
229d43cb-d9f6-4ad4-b977-05ca85000a7f	3b9e651e-7b05-4ef5-971c-23f80efa20ec	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@satoshistackerfr4041/videos	\N	\N	f	2025-12-10 18:19:12.463802	2025-12-10 18:19:12.463802
7c988ada-7d5b-4db4-b476-2a97ccca36ec	3b9e651e-7b05-4ef5-971c-23f80efa20ec	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@satoshistackerespanol8644/videos	\N	\N	f	2025-12-10 18:19:12.464151	2025-12-10 18:19:12.464151
55ea4b41-3cd4-4427-8f64-52028f0adabb	183a902d-4b06-4904-8d47-3379609ab004	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/scottmelker	\N	\N	f	2025-12-10 18:19:12.465295	2025-12-10 18:19:12.465295
3af5c661-ddbc-4362-a71d-7b287442a5ec	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/scottmelker	\N	\N	f	2025-12-10 18:19:12.467121	2025-12-10 18:19:12.467121
92e7b878-09fc-45fe-ada0-9e33345528a2	a40d7c70-e895-4a15-b8be-62e233876780	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@TheHouseOfCrypto/videos	\N	\N	f	2025-12-10 18:19:12.469607	2025-12-10 18:19:12.469607
2433f1e5-da88-4214-aef1-2802a636038a	a40d7c70-e895-4a15-b8be-62e233876780	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Peter_thoc	\N	\N	f	2025-12-10 18:19:12.469953	2025-12-10 18:19:12.469953
6c098501-1483-403d-9790-750d828a1832	1264f97e-0a23-4690-8272-23123de6547a	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@thewolfofbitcoins	\N	\N	f	2025-12-10 18:19:12.47094	2025-12-10 18:19:12.47094
8e17ce29-ec3c-4d0e-be87-34cfbba5a1d5	954bc336-4c17-4f7d-90be-16658e264c5a	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@thecryptohippie	\N	\N	f	2025-12-10 18:19:12.471609	2025-12-10 18:19:12.471609
b9510bbf-546b-48ef-b92c-1b2f7d2cd030	72ac3de4-eeaa-49cf-932a-cb0d421745db	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@therealmelaninking	\N	\N	f	2025-12-10 18:19:12.472786	2025-12-10 18:19:12.472786
3ed33394-476e-46c8-a31f-47e3e7ced6b5	168dd1ca-e812-4069-bf8d-25b4843e7973	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/defitracer	\N	\N	f	2025-12-10 18:19:12.474065	2025-12-10 18:19:12.474065
2d50f0c4-ce4c-463b-a1ba-76a4068481c9	08a2e539-1261-4c96-8955-f115d42bf27f	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Tradinator33	\N	\N	f	2025-12-10 18:19:12.475136	2025-12-10 18:19:12.475136
9219e16a-84c3-4e77-944e-36990e6a5ee0	69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@virtualbacon	\N	\N	f	2025-12-10 18:19:12.476481	2025-12-10 18:19:12.476481
ecbdf344-d836-4545-9814-0b58ad688f59	5fc1c616-8522-4ce7-aa55-4c2ed2009365	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@VirtualBacon/videos	\N	\N	f	2025-12-10 18:19:12.477553	2025-12-10 18:19:12.477553
18fea29d-db07-4d87-b97a-43f3fce46c57	bd49d3d2-b6d9-435d-8e51-70b36eb92d79	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@cornemarchand	\N	\N	f	2025-12-10 18:19:12.480971	2025-12-10 18:19:12.480971
28aa9af7-9ee2-4e4e-96de-5819e4547739	7f14b79a-599d-4733-aa62-44518f5c617a	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/thonyalvarez_/	\N	\N	f	2025-12-10 18:19:12.481889	2025-12-10 18:19:12.481889
33579f78-2b3c-486e-9a87-cfafbde83114	e484f6a3-69db-421b-983a-004a7555a023	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoJams	\N	\N	f	2025-12-10 18:19:12.482599	2025-12-10 18:19:12.482599
e50ea6cc-c0a9-45e5-9de8-1a61ccd3227b	53ca5fed-83fb-483b-8828-fc44b82f2151	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCYID-1RNw63kbCV3iAShmog/featured	\N	\N	f	2025-12-10 18:19:12.483228	2025-12-10 18:19:12.483228
871787d5-4b9e-4718-8dc4-2c1a28434e30	f38f2d0e-222a-466c-94f6-a5ae59722d48	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/CalmanBTC	\N	\N	f	2025-12-10 18:19:12.48442	2025-12-10 18:19:12.48442
f554927e-6eed-454a-a452-3b9aa26af6ce	8bdb3443-0b3c-4c0e-af70-8d5445637c2d	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/Coocolab/videos	\N	\N	f	2025-12-10 18:19:12.486278	2025-12-10 18:19:12.486278
c0b8ebe9-693d-42f9-adb3-361f7b09091b	1bb1b2be-d8ea-455b-8548-7e3b2f26d998	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/cryptowilson_?t=HGbOSqJTBCe1ay51WZyhzA&s=09	\N	\N	f	2025-12-10 18:19:12.48801	2025-12-10 18:19:12.48801
f81b7037-245e-401c-a155-e2a3d2b5abe5	dbec632d-00a9-4f98-89f2-a03331e47f5e	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/nft_hu	\N	\N	f	2025-12-10 18:19:12.489078	2025-12-10 18:19:12.489078
ed001c89-7066-46cd-a3c6-8b5c66f2c679	3276768e-5aba-468c-892b-24adbfd7d455	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Paris13Jeanne	\N	\N	f	2025-12-10 18:19:12.490118	2025-12-10 18:19:12.490118
0ecc3697-9823-4353-8710-8ace134e0b16	632ed109-9131-4e88-a37a-66627509d544	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/nancy_c813	\N	\N	f	2025-12-10 18:19:12.491261	2025-12-10 18:19:12.491261
f3e80226-b1cb-42d7-a9f2-9ec32c66d7e4	f961b49d-105b-4814-84f2-0430331ed65a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/victalk_eth	\N	\N	f	2025-12-10 18:19:12.492306	2025-12-10 18:19:12.492306
b27b78f6-900f-462f-b2c0-7ebfcfac30ac	1354a7ef-fa5e-4b15-864b-84711dda47c3	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/GuaTianGuaTian	\N	\N	f	2025-12-10 18:19:12.493305	2025-12-10 18:19:12.493305
7c4cffa1-4a74-464b-a76c-b5f8766a641d	2d2ccc2f-e903-4f5d-8438-451b39f6fe35	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/11dizhu	\N	\N	f	2025-12-10 18:19:12.494354	2025-12-10 18:19:12.494354
6a3e22d9-1f8d-41b4-a537-6179ff67b5b3	62c0ce66-d822-4ca7-9f0d-82f71e8f1b02	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/NintendoDoomed	\N	\N	f	2025-12-10 18:19:12.495425	2025-12-10 18:19:12.495425
8c3f1483-dc8b-4fcd-afe6-8d6408f3d50d	e2aa0ef9-010f-4ccf-aabc-6a7623e9fca0	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/yuyue_chris	\N	\N	f	2025-12-10 18:19:12.496451	2025-12-10 18:19:12.496451
c72c7919-36f9-441c-af55-a8671328964a	6c907c1f-121a-41ce-aff6-4977ab588fed	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xKillTheWolf	\N	\N	f	2025-12-10 18:19:12.49772	2025-12-10 18:19:12.49772
cbb1e980-5990-4168-9736-998841e9aa9e	c5d5f602-291e-4544-a901-332f8fda700c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/TokenMore	\N	\N	f	2025-12-10 18:19:12.499012	2025-12-10 18:19:12.499012
d95150ba-5390-446d-b3d4-33ea4ed06abd	435df992-7b96-4eae-8936-b9b36b91405c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/iamyourchaos	\N	\N	f	2025-12-10 18:19:12.500018	2025-12-10 18:19:12.500018
400979e8-7a74-4444-9b40-cc54b1a3c9ac	95fbb6fc-10f3-4dc6-8cbe-090094ba417a	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xSleepinRain	\N	\N	f	2025-12-10 18:19:12.500996	2025-12-10 18:19:12.500996
1cd1142b-16c5-4c9a-a469-9f28f7489c03	277f9203-92c7-4a39-809d-e81eee5e5637	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/CRIPTOMANIACOS/videos	\N	\N	f	2025-12-10 18:19:12.502214	2025-12-10 18:19:12.502214
e324f4d0-a44c-484b-91ca-7dd04aee5a1e	73054296-9cb6-4dc1-bb30-147fc0f14f47	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UC8oofAsuieQv3imZGvaUDOQ/featured	\N	\N	f	2025-12-10 18:19:12.50287	2025-12-10 18:19:12.50287
808462df-fed1-487e-ab43-c8b4c8b2a66f	0014cdbc-a111-4968-a413-828882e32e66	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/sandrocabrales	\N	\N	f	2025-12-10 18:19:12.507295	2025-12-10 18:19:12.507295
a9d553cb-a965-4c12-aa74-394237465bfb	7c4c65ad-dec4-4abe-93bf-6c7011711ea5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/TUBAR%C3%83ODABOLSA	\N	\N	f	2025-12-10 18:19:12.507994	2025-12-10 18:19:12.507994
1eb23398-8a9b-41ea-b7bc-ffa788f3c86b	aa54bc98-4f39-4229-9084-5e1c992c4b96	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/CryptoFuturo	\N	\N	f	2025-12-10 18:19:12.50866	2025-12-10 18:19:12.50866
54042285-a8bc-443a-85ac-2f1fba216189	aa54bc98-4f39-4229-9084-5e1c992c4b96	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/CryptoFuturoGrupo	\N	\N	f	2025-12-10 18:19:12.508979	2025-12-10 18:19:12.508979
a526dc60-a159-4bc9-a902-62fc3fe3154f	a116e420-674e-4867-b4b7-0bfdd644559b	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/diegoseib	\N	\N	f	2025-12-10 18:19:12.509602	2025-12-10 18:19:12.509602
959cefa6-6683-4006-b79e-877f2ee58c77	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/kmanus88	\N	\N	f	2025-12-10 18:19:12.51021	2025-12-10 18:19:12.51021
0f3bc52a-ca37-425b-9990-d270d50a425d	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/kmanus88/	\N	\N	f	2025-12-10 18:19:12.510513	2025-12-10 18:19:12.510513
171c9a81-e81b-49c4-8d38-f7bd065474c0	d137bd3f-41e4-43a8-820a-7addc94df4ea	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/crypto_k_s_a	\N	\N	f	2025-12-10 18:19:12.513017	2025-12-10 18:19:12.513017
558b8cec-bdea-4e42-b3a0-79c76abad897	b824bf6a-408f-4ced-b623-4e8ac159c446	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/GoodieCalls	\N	\N	f	2025-12-10 18:19:12.51439	2025-12-10 18:19:12.51439
b7b6bad2-0897-4ec3-a3f1-b5e606cfa4a8	1d9ca24c-6c45-431b-9358-912bb0d7000b	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/noBScrypto	\N	\N	f	2025-12-10 18:19:12.448153	2025-12-10 18:19:12.448153
b9e23968-c279-47d6-b9f0-f9ea3ddd3420	d2b50556-4bc9-47d6-8a96-387edca98cde	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/notEezzy	\N	\N	f	2025-12-10 18:19:12.448834	2025-12-10 18:19:12.448834
71081fd5-1e96-471b-8cf3-aa90886a1f5b	59982833-d4f4-433d-8718-0facedf7460c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/okanaksoy54	\N	\N	f	2025-12-10 18:19:12.450082	2025-12-10 18:19:12.450082
fde9865a-5f0e-44c0-a697-e6925b4e262c	05b24779-78c6-498a-a515-cfd2c1110ff4	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/overdose_ai	\N	\N	f	2025-12-10 18:19:12.450692	2025-12-10 18:19:12.450692
b1e75906-6dc3-4cb5-808d-712c8f1fd7e6	34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	http://x.com/fuelkek	\N	\N	f	2025-12-10 18:19:12.451329	2025-12-10 18:19:12.451329
773dde99-a514-466f-a3d0-13017cdff1b7	77069309-1d94-457d-ae04-8f41f99b61ba	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Pentosh1	\N	\N	f	2025-12-10 18:19:12.453504	2025-12-10 18:19:12.453504
93c1e8a2-3cc2-43f8-bbb8-094c9b2368eb	2ffbb550-8ef7-4ee0-abbb-2bc8cc9b8626	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/PixOnChain	\N	\N	f	2025-12-10 18:19:12.454812	2025-12-10 18:19:12.454812
a1d1bf3c-145b-462d-b14f-74a96fbd4fbf	ce85846a-bdae-482d-9f88-5f846ff811fa	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/joeparys/	\N	\N	f	2025-12-10 18:19:12.455601	2025-12-10 18:19:12.455601
a3ef70d2-9e95-4b4a-8005-6c44ae7cf10d	794403fc-d937-456e-905d-ba1014f8ebdf	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/cryptokang/	\N	\N	f	2025-12-10 18:19:12.45664	2025-12-10 18:19:12.45664
b05eb9ad-9dfb-4f99-9a73-9e78a57302a6	64ce9410-1679-44f2-8c70-138792a1e087	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@cryptokang.reviews	\N	\N	f	2025-12-10 18:19:12.457424	2025-12-10 18:19:12.457424
8a539d85-c102-42e3-a029-4d26022bb758	64ce9410-1679-44f2-8c70-138792a1e087	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/thecryptokang	\N	\N	f	2025-12-10 18:19:12.457766	2025-12-10 18:19:12.457766
0319bddf-9fc0-4c78-871a-eb2f993bae4a	0d2da959-8d4e-4bdb-9e13-9a5558102ef5	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Route2FI	\N	\N	f	2025-12-10 18:19:12.459382	2025-12-10 18:19:12.459382
29913b26-7c05-44ae-a1c8-9bc09365dbb0	6f6d254a-63f2-4bcc-8f32-0a1e807e1297	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/rovercrc	\N	\N	f	2025-12-10 18:19:12.459908	2025-12-10 18:19:12.459908
04a85d46-a4f6-4e31-ba68-cb25a283ce26	6289c163-0a16-4bea-aac3-48248f825fd7	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/rutradebtc	\N	\N	f	2025-12-10 18:19:12.460884	2025-12-10 18:19:12.460884
47f3e5b1-baf3-4665-8e2d-292c7e80f834	9696fc6a-d3c9-481e-904e-72454a56cfb0	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@sarafinance	\N	\N	f	2025-12-10 18:19:12.462697	2025-12-10 18:19:12.462697
d2df917b-f488-474d-b050-94ac69f53ff0	3b9e651e-7b05-4ef5-971c-23f80efa20ec	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@stackersatoshi/videos	\N	\N	f	2025-12-10 18:19:12.463514	2025-12-10 18:19:12.463514
a0c81cca-e169-4573-9186-e962d279b7eb	3b9e651e-7b05-4ef5-971c-23f80efa20ec	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@satoshistackerde5649/videos	\N	\N	f	2025-12-10 18:19:12.463977	2025-12-10 18:19:12.463977
e07d2a06-0ddb-40b5-bae7-16c9dce31593	3b9e651e-7b05-4ef5-971c-23f80efa20ec	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@satoshistackerarabic3172/videos	\N	\N	f	2025-12-10 18:19:12.464316	2025-12-10 18:19:12.464316
d61f97c0-1957-4196-988f-29a20bed7e0d	183a902d-4b06-4904-8d47-3379609ab004	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/scottmelker	\N	\N	f	2025-12-10 18:19:12.46513	2025-12-10 18:19:12.46513
d31a3ec3-7b48-4679-b633-b4114c1e2c0b	183a902d-4b06-4904-8d47-3379609ab004	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoBanterGroup	\N	\N	f	2025-12-10 18:19:12.465466	2025-12-10 18:19:12.465466
9ac6ba83-1b25-4147-9cfd-6de7f721ffee	400be1dd-a2a9-42f5-90d0-d84fe069f387	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/sharecrypto/	\N	\N	f	2025-12-10 18:19:12.466122	2025-12-10 18:19:12.466122
6f358afb-d548-4996-bc11-48a8e0c46507	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Sheldon_Sniper	\N	\N	f	2025-12-10 18:19:12.466855	2025-12-10 18:19:12.466855
f04d9570-026a-4421-abf3-1cc4a9ed9c61	130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@CryptoBanterGroup	\N	\N	f	2025-12-10 18:19:12.46729	2025-12-10 18:19:12.46729
d8e3368e-5f30-46fe-8c2c-382723da2734	6a4abfcc-aef9-48c9-9ec2-c246cf7d11f2	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/stockmarket_times/	\N	\N	f	2025-12-10 18:19:12.467979	2025-12-10 18:19:12.467979
1969a5a7-246f-4545-a2b5-3370243100e6	40888ff9-372f-473a-9aef-29d1ba5af6d8	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Crypto_Alch	\N	\N	f	2025-12-10 18:19:12.468624	2025-12-10 18:19:12.468624
c72201b5-38c7-461e-a491-b237e3a4aeca	a40d7c70-e895-4a15-b8be-62e233876780	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Schoolofcrypto-hoc	\N	\N	f	2025-12-10 18:19:12.469785	2025-12-10 18:19:12.469785
be921a1c-cdab-4c16-af17-546134837f3d	a40d7c70-e895-4a15-b8be-62e233876780	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/+LPHXPe0nWlk4OTA1	\N	\N	f	2025-12-10 18:19:12.470105	2025-12-10 18:19:12.470105
d4d8d4b5-7702-40b5-99d5-d7582a58f2f2	70012215-6080-4feb-bd19-5a7da237d524	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@theniftyinvestor	\N	\N	f	2025-12-10 18:19:12.47226	2025-12-10 18:19:12.47226
ff4b9f02-ee19-44ac-9be5-eb7cec33ebc1	cfc44cf7-59b1-4830-a8e4-9689467b0c4c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/tikooww	\N	\N	f	2025-12-10 18:19:12.473275	2025-12-10 18:19:12.473275
babc0a1a-305e-41f7-affc-3f3a0d7eb66a	168dd1ca-e812-4069-bf8d-25b4843e7973	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/TracerAlpha	\N	\N	f	2025-12-10 18:19:12.474236	2025-12-10 18:19:12.474236
c4f281b4-f2a4-4dd9-9f23-4fa72ebe987c	69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@VirtualBacon/videos	\N	\N	f	2025-12-10 18:19:12.476014	2025-12-10 18:19:12.476014
7c084a1d-8af7-425f-a9cf-1478fc958b17	5fc1c616-8522-4ce7-aa55-4c2ed2009365	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@virtualbacon	\N	\N	f	2025-12-10 18:19:12.477398	2025-12-10 18:19:12.477398
a4b2e79b-d3e1-47d5-91f7-786d33d27ded	3de2647b-2c7e-4be4-a1ad-da663c52b49c	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@VoskCoin%60	\N	\N	f	2025-12-10 18:19:12.478155	2025-12-10 18:19:12.478155
b1fd8f05-28fd-4b73-afeb-dcbd2b54ab5b	fe3a36d9-b571-4767-87a6-d16e5b653b13	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/wallstreetbets	\N	\N	f	2025-12-10 18:19:12.478806	2025-12-10 18:19:12.478806
2295d2ef-157c-4b2b-bab7-f185bf7c3b59	cc54cc90-5051-4d2e-8116-185ffd1d55f9	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/alex_belov13/	\N	\N	f	2025-12-10 18:19:12.479525	2025-12-10 18:19:12.479525
6f01f8a6-894c-4768-9e8f-bca1d038e1a9	74b2dfe4-603a-48cb-a0f4-2326194f571c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/CryptoWizardd	\N	\N	f	2025-12-10 18:19:12.480179	2025-12-10 18:19:12.480179
653a32ce-2ebe-48bc-b50f-6d5fb4e725f0	7f14b79a-599d-4733-aa62-44518f5c617a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Thonyalvarez	\N	\N	f	2025-12-10 18:19:12.481735	2025-12-10 18:19:12.481735
7241d429-2968-4644-b166-1712e5511a7c	480c0dad-eb5a-4e45-b6c4-0d89a202aa18	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/c/Andehui%E5%BF%97%E8%BE%89	\N	\N	f	2025-12-10 18:19:12.483935	2025-12-10 18:19:12.483935
ceb3a6eb-b7b2-4684-b71b-f8eafffc6744	eca2971b-5e27-40bd-adec-2098a19fb964	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/Calman16910515	\N	\N	f	2025-12-10 18:19:12.48489	2025-12-10 18:19:12.48489
2b17fa00-79a3-4774-aacf-ac01a5aa6870	6f727607-1ad4-46cb-af3d-3a91fbb0eccf	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptosArnault	\N	\N	f	2025-12-10 18:19:12.487373	2025-12-10 18:19:12.487373
f86eeb81-da6f-4523-910b-1a90c30bbfb2	e8e64cd6-a80c-4e32-ac4a-c8d01273e444	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/FEIlXIE	\N	\N	f	2025-12-10 18:19:12.488582	2025-12-10 18:19:12.488582
901f8a7c-c17b-4eb4-abb5-850b381e33ad	6f3a5ab2-0286-4042-8629-37ee61bfb595	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/tmel0211	\N	\N	f	2025-12-10 18:19:12.4896	2025-12-10 18:19:12.4896
bbb70b6f-4912-420e-a838-d8d8db2e295d	4848c5c6-a3c4-43ce-bcdf-48e979e85356	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/CryptoLady_M	\N	\N	f	2025-12-10 18:19:12.490609	2025-12-10 18:19:12.490609
fe276d46-4a27-4e4d-95a0-d86df71059e9	db208873-6fb7-4ba6-9488-7539dd1ba769	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xNing0x	\N	\N	f	2025-12-10 18:19:12.491743	2025-12-10 18:19:12.491743
8073c2d3-7d90-409d-a236-11c4fe650b72	ac23f99a-bacd-45e6-9d89-31e63a19d59f	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/vvickym2	\N	\N	f	2025-12-10 18:19:12.492801	2025-12-10 18:19:12.492801
bdb77629-0d51-4844-bed8-a070e3a9b918	1378b622-ffc4-47d0-9c06-60198b6b925c	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/buereth	\N	\N	f	2025-12-10 18:19:12.493837	2025-12-10 18:19:12.493837
0aceb4ea-c2b0-4024-aee0-b5d4b060ce13	7128f876-3e36-4dcf-b53f-1d013c870dc5	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/channel/UCMkk-akdGTugIVu10-bXQEQ/featured	\N	\N	f	2025-12-10 18:19:12.494854	2025-12-10 18:19:12.494854
34613ff4-1db4-48f3-90c2-989ffcbc2f88	ac84bc3f-4964-438e-ae06-145366f680e6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/qklxsqf	\N	\N	f	2025-12-10 18:19:12.495949	2025-12-10 18:19:12.495949
c8665c69-f279-43dd-9813-4c33217a6fdd	28f63dbc-d59a-40ff-b38d-39ed1637e538	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/0xBclub	\N	\N	f	2025-12-10 18:19:12.49716	2025-12-10 18:19:12.49716
d7934d26-17fb-450a-97c7-5b21eb57ff6f	8dc919b6-d6dd-4bd3-b297-94c6023df030	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/R5Z5G	\N	\N	f	2025-12-10 18:19:12.498472	2025-12-10 18:19:12.498472
8afb8c6b-aae9-4b05-bbf0-37eb7aa971d1	6dfea2f7-777a-45ee-8554-6ddcbb59b841	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/zhuanfgghjnb	\N	\N	f	2025-12-10 18:19:12.499528	2025-12-10 18:19:12.499528
b6e061c9-ea64-40d4-958b-b532f19e28c7	32929a16-977e-4700-9ef2-21ade7141aca	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/iamyourchaos	\N	\N	f	2025-12-10 18:19:12.500502	2025-12-10 18:19:12.500502
b502aae3-5102-4ce0-8035-9cf34276a2d2	903eb4a1-3be5-4187-a23d-440d1160d717	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/xueqiu88	\N	\N	f	2025-12-10 18:19:12.501632	2025-12-10 18:19:12.501632
20aaa0f7-1a07-4e65-a7b1-5b139ae70a39	73054296-9cb6-4dc1-bb30-147fc0f14f47	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/lucas.amendolaa/	\N	\N	f	2025-12-10 18:19:12.503048	2025-12-10 18:19:12.503048
bb9470bb-9e78-4122-98d3-a6a21f0f679d	8317df96-4c13-4514-87df-b8c65d9e08dc	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@investimentosemko/videos	\N	\N	f	2025-12-10 18:19:12.503682	2025-12-10 18:19:12.503682
c9f78c73-c3b3-4f43-9d7c-1bb149a670ed	b1ec569f-83ee-4a17-9d07-53d70bbee703	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@lzacademy.pro1	\N	\N	f	2025-12-10 18:19:12.504345	2025-12-10 18:19:12.504345
dbd7144c-0c81-400b-9da4-9979473c9469	fb8dd599-e3bc-43cb-996d-4e11c82aadd6	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@Marcoslima-	\N	\N	f	2025-12-10 18:19:12.505009	2025-12-10 18:19:12.505009
65604813-28fd-4fa0-93b5-ce51abb0f230	6953adb3-42f6-4216-b602-14f8417c754a	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@matheus.bordin	\N	\N	f	2025-12-10 18:19:12.505653	2025-12-10 18:19:12.505653
99d486db-1df9-4e75-b1c5-c9117b709839	103659ba-e1f4-405d-b289-2fabf44ad1b8	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://www.youtube.com/@MychelMendes	\N	\N	f	2025-12-10 18:19:12.506265	2025-12-10 18:19:12.506265
f7eec492-2a73-45a4-b6e8-3a517d6a6bd9	0014cdbc-a111-4968-a413-828882e32e66	23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	https://youtube.com/@SandroCabrales	\N	\N	f	2025-12-10 18:19:12.506906	2025-12-10 18:19:12.506906
08c44653-3bab-4ba6-8d07-ef0c8cd888d5	aa54bc98-4f39-4229-9084-5e1c992c4b96	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/CryptoFuturo1	\N	\N	f	2025-12-10 18:19:12.508821	2025-12-10 18:19:12.508821
7077fc33-05e4-4b94-8c92-d6acadd94195	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://twitter.com/KmanuS88	\N	\N	f	2025-12-10 18:19:12.510357	2025-12-10 18:19:12.510357
ed2d5b37-5e5e-47b5-ae56-8d082560b53e	1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	a833496d-d109-42f7-a01f-be2a3180e5df	https://www.tiktok.com/@kmanus88	\N	\N	f	2025-12-10 18:19:12.51067	2025-12-10 18:19:12.51067
9711a3e6-0d71-4c02-9eb6-ce02cbb243a9	50480996-392e-4fbd-bcd3-b2d67cbb25ae	12ebc106-4857-49c8-9528-263dc3b96f85	https://www.instagram.com/finanzaspablo/	\N	\N	f	2025-12-10 18:19:12.511318	2025-12-10 18:19:12.511318
8dd6676f-5b25-4f5c-a209-4a23706302b1	d242154c-41ac-4bea-b101-f4fe9eac41a2	8564cdb8-9a90-4b0d-8bf9-c477c83814df	https://x.com/Crypto_K_S_A?t=b6OxWHB_MIDAeRCvgJOSYA&s=08	\N	\N	f	2025-12-10 18:19:12.512044	2025-12-10 18:19:12.512044
f33f5186-4324-460d-afad-0de29b418275	171a88d2-da6c-4fe1-960d-82b4f11998b2	77386a88-6ca3-44af-916f-807a0558671d	https://t.me/sharkyprivate	\N	\N	f	2025-12-10 18:19:12.515215	2025-12-10 18:19:12.515215
\.


--
-- Data for Name: kols; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.kols (id, name, tier_score, telegram_address, email, phone, notes, is_active, created_by, created_at, updated_at) FROM stdin;
a08f7952-90d4-4354-b8b9-5c0a5e255d9e	0xilhm	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.019889	2025-12-10 18:19:12.019889
92444995-2431-4c5f-a13c-7c2cc5ee7d30	0xmrred	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.028282	2025-12-10 18:19:12.028282
74e78d28-5150-484b-9db2-9446b75381d5	0XRemiss	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.032851	2025-12-10 18:19:12.032851
90cf70d3-9e96-408e-a2ba-36d6a28cef4a	Airdrop duyuru	\N	@Raiken35 @adtemre	\N	\N	\N	t	\N	2025-12-10 18:19:12.036428	2025-12-10 18:19:12.036428
edf54653-87a6-4af9-918b-71e27114f074	AİRDROP KASANLAR DERNEĞİ(AKD)	\N	@Kriptoakd_tr	\N	\N	\N	t	\N	2025-12-10 18:19:12.039307	2025-12-10 18:19:12.039307
e03a2d3a-3282-4b79-a7cd-56b93fd3b598	Ali tekin	2	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.04196	2025-12-10 18:19:12.04196
d54d1f0e-4025-4958-a212-cdfe52009005	Alpha	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.043853	2025-12-10 18:19:12.043853
da40d652-d045-4bff-8a32-e8003411b36b	AltcoinRookie	4	@altcoinrookie	\N	\N	\N	t	\N	2025-12-10 18:19:12.045793	2025-12-10 18:19:12.045793
c40a0124-19fe-4651-a59a-28cf46fbd787	Atamert Uysaler	3	@cenkmiahmet	\N	\N	\N	t	\N	2025-12-10 18:19:12.048003	2025-12-10 18:19:12.048003
a40312dd-0331-4a25-bed6-2b05e9152fbf	B the Bloomberger	3	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.050296	2025-12-10 18:19:12.050296
52494623-468b-4439-9818-d36645830dd0	Barbie Coin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.052554	2025-12-10 18:19:12.052554
d9cbeadb-d9c0-4afc-afd3-d0f317fa9867	Barış büyüktaş	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.054359	2025-12-10 18:19:12.054359
f735e4c0-39c3-4c66-92ad-908f7461a84f	Barış büyüktaş	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.056645	2025-12-10 18:19:12.056645
c5055660-0373-4b7a-8842-b53c9d810bc9	Barış kardeş	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.05932	2025-12-10 18:19:12.05932
10a0228d-8083-41d2-a11f-7fe4a61bbc16	batikaneth	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.061104	2025-12-10 18:19:12.061104
3a08982c-087b-47cf-8b8f-1a7afb5e4081	Batuhan Çalıkuşu	3	@nuhbatuhann	\N	\N	\N	t	\N	2025-12-10 18:19:12.062755	2025-12-10 18:19:12.062755
afec6c13-3295-4055-abeb-9d3d7329bb4b	Berkay Berksun	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.064094	2025-12-10 18:19:12.064094
05676f72-39b2-41e3-9957-a3a5b8d3cf3b	Bitcoin Meraklısı	3	@Bitcoinmeraklisi	\N	\N	\N	t	\N	2025-12-10 18:19:12.065837	2025-12-10 18:19:12.065837
cd1b83c9-d393-4140-b9aa-a03c8ad0cf20	Bitcoin Meraklısı	3	@Bitcoinmeraklisi	\N	\N	\N	t	\N	2025-12-10 18:19:12.067041	2025-12-10 18:19:12.067041
eb46fe18-5c1f-4b32-9071-63daa3da0e28	Borsa Ressamı	3	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.068426	2025-12-10 18:19:12.068426
26de4eaa-09f2-4943-ab51-f32f20f48e25	Bratu	\N	@ustadsplinter34	\N	\N	\N	t	\N	2025-12-10 18:19:12.070618	2025-12-10 18:19:12.070618
6cca21a7-d9b0-4c72-8743-d0c4d18861ae	Bu Coin Nedir	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.071783	2025-12-10 18:19:12.071783
849504e9-4b12-4f8c-946e-21eca7000980	CaglahanEth	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.07309	2025-12-10 18:19:12.07309
654a9fd7-e1fa-4ade-938c-dc90713e4f35	Casanova	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.074252	2025-12-10 18:19:12.074252
f3a3819e-212b-4aeb-a8fe-779243323abe	Cemal the MM	4	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.075361	2025-12-10 18:19:12.075361
8db1d0c5-9103-4cc7-aab4-8653349d2cd4	Cihan0x.ETH	4	@Cihan0xETH	\N	\N	\N	t	\N	2025-12-10 18:19:12.076412	2025-12-10 18:19:12.076412
40331030-31cb-4391-913b-acd387389679	CihanX	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.079096	2025-12-10 18:19:12.079096
9467920b-47ff-4786-ab2d-ba71bedb4520	Coin agend	2	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.080921	2025-12-10 18:19:12.080921
449eb148-3918-483d-ad31-078456bbfddc	Coin Hunters	3	@OneHundredEyez	\N	\N	\N	t	\N	2025-12-10 18:19:12.082112	2025-12-10 18:19:12.082112
c432674b-3697-4c92-9698-61ef46eedbe7	Coin Uzmanı	4	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.083571	2025-12-10 18:19:12.083571
a8e73e8b-e412-4d9b-971d-1bfb59309abb	coinkritik	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.084935	2025-12-10 18:19:12.084935
8e526547-e60a-4bb7-bbc8-ab2f9f3348f0	CoolPanda	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.086735	2025-12-10 18:19:12.086735
be5f976b-114d-4308-8242-52d14f4e9aa6	Crypto Chef	4	@KriptoChef	\N	\N	\N	t	\N	2025-12-10 18:19:12.089504	2025-12-10 18:19:12.089504
ac955c91-0b4f-4e7b-97e3-6d29389cf196	Crypto CNR	4	Kriptokrat	\N	\N	\N	t	\N	2025-12-10 18:19:12.091533	2025-12-10 18:19:12.091533
b6df55de-3cf9-4873-a65b-4ceac4dbfd1a	Crypto Epoch	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.093555	2025-12-10 18:19:12.093555
7dd5df99-0ee0-42f7-889c-9f5c98cd84fe	Crypto Hocam	3	@CRYPTOHOCAM1	\N	\N	\N	t	\N	2025-12-10 18:19:12.094911	2025-12-10 18:19:12.094911
9272a0a5-0def-403f-8dad-475fa62fdc71	Crypto Maker	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.09614	2025-12-10 18:19:12.09614
8bb3e252-e66b-4477-a145-8b03c028805d	Crypto Neo	4	@Crypto_Neooo	\N	\N	\N	t	\N	2025-12-10 18:19:12.097851	2025-12-10 18:19:12.097851
df663153-02e1-4bf6-8f3b-ac3efeefdb48	crypto oğuz	\N	@Crypto_Oguz	\N	\N	\N	t	\N	2025-12-10 18:19:12.100438	2025-12-10 18:19:12.100438
54848923-af3c-4528-a36f-b86babd69225	Crypto ScarFace	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.101438	2025-12-10 18:19:12.101438
b2e93254-185e-4547-a363-eb5a99078141	Crypto Troia	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.102592	2025-12-10 18:19:12.102592
15520237-b54c-4912-abf0-f29c1499181d	cryptoaty	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.104115	2025-12-10 18:19:12.104115
47abda88-d904-4402-8257-1e88c0ff6ef5	CryptObjektif	4	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.105348	2025-12-10 18:19:12.105348
1fec272f-7562-488b-9ec9-eff4656dcabe	CryptoIDO	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.107509	2025-12-10 18:19:12.107509
508162b5-5cc2-4cbe-932c-cccc7c7c526f	CryptoLFT	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.108915	2025-12-10 18:19:12.108915
003b2d41-7de0-4eec-8fe2-17374ae91d58	CryptoTurkeyFacts	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.109592	2025-12-10 18:19:12.109592
e0f32a2f-a1b6-4bce-9a48-3407f24062a5	Çaylak Kriptocu	3	@caylaktt	\N	\N	\N	t	\N	2025-12-10 18:19:12.110461	2025-12-10 18:19:12.110461
281f97e5-14e2-4a93-80af-80e0ed98bcff	Doktor	3	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.111256	2025-12-10 18:19:12.111256
f4b5744a-8dd0-4504-ba9c-be8992240fe3	Elif 	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.112336	2025-12-10 18:19:12.112336
186b1700-46b2-4e9f-b961-5f86f5efbfc1	Elit Türk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.113006	2025-12-10 18:19:12.113006
e6ef5e56-45a6-4c7c-a540-afc90b193143	Emre Torlak	4	@Legolas311	\N	\N	\N	t	\N	2025-12-10 18:19:12.113804	2025-12-10 18:19:12.113804
c6fb0205-1405-4198-940d-5c075949c13e	Engineer Trader	3	@EngineerTraderr	\N	\N	\N	t	\N	2025-12-10 18:19:12.114619	2025-12-10 18:19:12.114619
f09eb623-3bbd-4771-b853-aef41da517ed	Expert Kripto	3	@expert_kripto	\N	\N	\N	t	\N	2025-12-10 18:19:12.115138	2025-12-10 18:19:12.115138
d8fd8b3f-5e45-4e37-8a50-85bcbf23efd4	Expert Para	4	@crypto_expert_para	\N	\N	\N	t	\N	2025-12-10 18:19:12.115804	2025-12-10 18:19:12.115804
0a2f4d54-807c-4e33-866b-cfc22845d6e6	Fatih 	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.116296	2025-12-10 18:19:12.116296
fcc4d68f-ab2e-47e6-bc84-c8d8d13cd914	Fersah	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.116973	2025-12-10 18:19:12.116973
8ea77d03-8233-49e8-b39b-262daada91aa	Fit Trader	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.118054	2025-12-10 18:19:12.118054
888cbfe3-9c4b-4456-9d33-f72e0d002456	Foxy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.118898	2025-12-10 18:19:12.118898
df953e7c-659b-401e-a906-7b25f29fca41	Genel Patron01	3	@Genelpatron_01	\N	\N	\N	t	\N	2025-12-10 18:19:12.119836	2025-12-10 18:19:12.119836
88615501-f3e3-434c-bbff-9d5178d9274c	Genzo	4	@CryptoGenzo	\N	\N	\N	t	\N	2025-12-10 18:19:12.120689	2025-12-10 18:19:12.120689
febfc4b3-6c2f-4353-9059-2639e24ffec6	Gökhan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.122217	2025-12-10 18:19:12.122217
e90ebec3-3bc2-49b1-8548-173d50dd8873	Gökhan Gark	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.123154	2025-12-10 18:19:12.123154
2f3b4d72-0a9a-49e2-8985-50c9d816da4c	Han.eth	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.123837	2025-12-10 18:19:12.123837
83c11014-e12b-466b-a09d-e5ae72fc71ba	Hasan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.12474	2025-12-10 18:19:12.12474
84e5e479-8261-4a7c-a14d-08ba739fda95	Hassoyal medya	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.125369	2025-12-10 18:19:12.125369
43794457-3218-4378-8092-8391571c3ff3	HeatleyETH	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.125978	2025-12-10 18:19:12.125978
1ce65635-3d69-4b87-897d-1b42d241b66e	Hirozaki	4	Emir	\N	\N	\N	t	\N	2025-12-10 18:19:12.126901	2025-12-10 18:19:12.126901
38a50ecf-a0c9-4789-afff-10c9c04312fc	howtousecrypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.127634	2025-12-10 18:19:12.127634
f88e97b1-176a-4468-8fc8-f2c5c7c272e5	Hunter'ın Sol Kolu	3	@doruk1st	\N	\N	\N	t	\N	2025-12-10 18:19:12.128564	2025-12-10 18:19:12.128564
2c32254c-b0e3-4fe5-942c-70518f6be97b	İrfan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.129646	2025-12-10 18:19:12.129646
ad10b365-44b2-4b4c-bd9b-6b15a885598c	JessCoin	3	@CoinJess	\N	\N	\N	t	\N	2025-12-10 18:19:12.130375	2025-12-10 18:19:12.130375
1ab8dabf-b589-43a2-9fe3-beb74fcba4fc	Kadir Squirrel	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.13111	2025-12-10 18:19:12.13111
f68c7aaa-67e6-4b9a-8e61-07a74aca9a3a	Kahin	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.131895	2025-12-10 18:19:12.131895
8a9cfb0a-e0dd-4128-bc0d-73f2efaf20fe	Kerim Kalender	5	@Legolas311	\N	\N	\N	t	\N	2025-12-10 18:19:12.132653	2025-12-10 18:19:12.132653
c54006c7-737c-494d-8d18-b9de72a4d867	Koin Saati	\N	@ustadsplinter34	\N	\N	\N	t	\N	2025-12-10 18:19:12.135063	2025-12-10 18:19:12.135063
b6f673cd-c892-4a6b-80e4-e35d5047f905	Kripto Cem	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.136295	2025-12-10 18:19:12.136295
a50e21e7-b8e2-4678-a731-2602f1dd2bdb	Kripto Efsanesi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.137518	2025-12-10 18:19:12.137518
89184324-3bd9-4479-91d8-05dbb8704734	Kripto Gelişim	4	@ALPERcrypto	\N	\N	\N	t	\N	2025-12-10 18:19:12.138702	2025-12-10 18:19:12.138702
ee52295a-a14a-438d-8e93-b42966b44f57	Kripto Hayalet	3	@KriptoHaYalet	\N	\N	\N	t	\N	2025-12-10 18:19:12.140319	2025-12-10 18:19:12.140319
3a5c5674-5f0c-4d4f-83de-6557052c9cd6	Kripto Holder	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.141104	2025-12-10 18:19:12.141104
bb789f23-6d06-4380-a752-b391c3380210	Kripto Kafalar	3	@MertCaner	\N	\N	\N	t	\N	2025-12-10 18:19:12.141809	2025-12-10 18:19:12.141809
820af3e2-669e-43fd-9a5a-12cb06e50d80	Kripto Kahin	3	@KriptoKahinn	\N	\N	\N	t	\N	2025-12-10 18:19:12.142615	2025-12-10 18:19:12.142615
66f3145c-53d4-4244-91b4-0b84fdc87097	Kripto Kralı Yeniden	4	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.143446	2025-12-10 18:19:12.143446
10b7a7d7-e824-4296-a746-e88fc7511cd8	Kripto Nedir?	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.1446	2025-12-10 18:19:12.1446
02e32b42-7818-40fc-8014-22afc4e69092	Kripto Ofis	4	@mesut_ivy	\N	\N	\N	t	\N	2025-12-10 18:19:12.145425	2025-12-10 18:19:12.145425
ca768075-e597-4929-9a5c-d749932ee0a1	Kripto Sözlük	\N	@MertCaner	\N	\N	\N	t	\N	2025-12-10 18:19:12.146202	2025-12-10 18:19:12.146202
fe9fc6f0-2e95-4434-b379-9cf7cf7487c7	Kripto Warrior	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.147282	2025-12-10 18:19:12.147282
20bdeac7-b480-41bb-8f7a-1099626e3249	Kripto Zenci	3	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.148227	2025-12-10 18:19:12.148227
f390519c-40ea-4450-a54f-1e466b920e90	Kriptobi	3	@KriptobiCM	\N	\N	\N	t	\N	2025-12-10 18:19:12.149189	2025-12-10 18:19:12.149189
2f19af3f-119b-4b59-8e9e-ebc71c9c0d5e	KriptoBlue	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.149961	2025-12-10 18:19:12.149961
6a0a2d6f-4e55-4a9f-85db-5a653c93d682	Kriptokrat	4	@kriptokrat01	\N	\N	\N	t	\N	2025-12-10 18:19:12.150775	2025-12-10 18:19:12.150775
6661de6b-eee0-4b2f-bbf5-6a53ef2dd596	KriptoliaTR	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.151904	2025-12-10 18:19:12.151904
4f7141d7-ac31-4e32-8776-b4660f5c296b	Kriptolik	4	@Kriptolik1	\N	\N	\N	t	\N	2025-12-10 18:19:12.152712	2025-12-10 18:19:12.152712
6018f5e5-eb1b-4335-aef1-18b0e410cc15	KriptoLisa	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.154641	2025-12-10 18:19:12.154641
f0464a49-5b3a-477f-b898-579fbf10c159	Kriptoloki	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.155397	2025-12-10 18:19:12.155397
815b489f-3c8b-4439-b18d-79ac234d198e	Kripton	3	@kripton0	\N	\N	\N	t	\N	2025-12-10 18:19:12.156043	2025-12-10 18:19:12.156043
6d6ef876-21ca-47a0-9200-095074791c96	kuzey durden	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.157001	2025-12-10 18:19:12.157001
952bbd57-f1c2-4aa8-8fac-ae689e19e0d8	Lcasa	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.158315	2025-12-10 18:19:12.158315
b868509d-79d9-492e-b250-33a34d8cb0e8	Legolas	4	@Legolas311	\N	\N	\N	t	\N	2025-12-10 18:19:12.159251	2025-12-10 18:19:12.159251
7f2823e2-582f-4120-90d9-fd7d02ece572	Lord of Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.161031	2025-12-10 18:19:12.161031
92610a49-08e0-4bc3-b61c-9bbf8adee414	MagCoin	3	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.16174	2025-12-10 18:19:12.16174
7392cd69-e132-40c8-af99-dec18965f901	MAMcrypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.163298	2025-12-10 18:19:12.163298
0781049d-3f4f-4184-86be-abd5b52d47e3	Melik Berşah	3	@MelikBersahYoutube	\N	\N	\N	t	\N	2025-12-10 18:19:12.16428	2025-12-10 18:19:12.16428
48cfe773-1b13-41b3-92cf-f48af45125cb	Meric	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.165186	2025-12-10 18:19:12.165186
edaab8c7-830a-461a-8d12-026793c0ab63	MESGO	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.166015	2025-12-10 18:19:12.166015
b1780c0f-40ae-427a-ad1c-bf6f160dd8ff	Mete	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.166738	2025-12-10 18:19:12.166738
91b8f309-8a61-4967-b5e3-469a9e494ebf	Milyoner zihin	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.168078	2025-12-10 18:19:12.168078
2dc7b740-47c4-4dad-8e93-b9bf036609b6	MMTÜRK(ALAYLI)	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.16901	2025-12-10 18:19:12.16901
365c16ff-15dd-4cd9-bd00-5b56537423dc	Monte Kripto Kontu	4	Ömer	\N	\N	\N	t	\N	2025-12-10 18:19:12.169781	2025-12-10 18:19:12.169781
c3fd460c-b148-4f5e-94ed-f906607510d5	Nftmüfettisi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.170644	2025-12-10 18:19:12.170644
ef1ac0b2-e9b3-430c-9efb-8fc4f9989ff8	NikkiSixx7	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.171787	2025-12-10 18:19:12.171787
886bfe98-a961-4e36-8e32-f34eff9db46a	Oğuzhan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.172465	2025-12-10 18:19:12.172465
cf66d5bd-490b-4b80-aba5-d04df1288fab	omer	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.173142	2025-12-10 18:19:12.173142
2c7daabd-9713-4d6c-b44b-5295b1146e4b	onderyazici	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.174121	2025-12-10 18:19:12.174121
30c617a3-6840-4150-9a78-e479cdaaa6a1	ortegas	3	@ortegascrypto	\N	\N	\N	t	\N	2025-12-10 18:19:12.175044	2025-12-10 18:19:12.175044
d25cce7d-1b03-44ff-af78-c907300e06af	Ozi aka brrrrrr	3	@ozithe0x	\N	\N	\N	t	\N	2025-12-10 18:19:12.175807	2025-12-10 18:19:12.175807
9c5e0827-8042-4a8c-b133-6f02fe0d1661	P A N D A	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.176833	2025-12-10 18:19:12.176833
31ccb5b9-3232-49bf-8121-b0d49784a072	PABLO	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.17746	2025-12-10 18:19:12.17746
602788df-be32-4409-aa4a-331e1d3a3c12	Para Hub	4	@tarikbln	\N	\N	\N	t	\N	2025-12-10 18:19:12.178109	2025-12-10 18:19:12.178109
b4887d0c-2c72-4b6f-885f-530af72ea7aa	Paradoks	3	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.178782	2025-12-10 18:19:12.178782
0be00181-1078-4960-958c-dad896f508cd	Paradotor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.18015	2025-12-10 18:19:12.18015
5205065e-4780-4bba-841b-2bf3bb2b4b2f	Pland	3	@omerdemir7	\N	\N	\N	t	\N	2025-12-10 18:19:12.181285	2025-12-10 18:19:12.181285
e77c4488-a6ba-4bb3-9e0f-eb411cbab9f7	Rockerfeller	3	Neo	\N	\N	\N	t	\N	2025-12-10 18:19:12.181968	2025-12-10 18:19:12.181968
2dec5e7b-b6a4-488a-b145-5e7a75eb94f7	Satoshi'nin Kuzeni	3	@SatoshininKuzeni	\N	\N	\N	t	\N	2025-12-10 18:19:12.18303	2025-12-10 18:19:12.18303
f129f037-4617-4f13-91b6-2f0846f15594	SelCoin	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.184283	2025-12-10 18:19:12.184283
bce6a1f6-efce-43e9-9e1f-556d8c35aa44	Sercan YILDIZ	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.185357	2025-12-10 18:19:12.185357
f5b5de9d-4b8a-4197-96fb-e146b0fa74cd	sinavkk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.186454	2025-12-10 18:19:12.186454
61f2cb13-4d3c-4ed9-b942-5d94de5b10c5	Şener	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.187543	2025-12-10 18:19:12.187543
ea6c162c-6b68-45ba-a64c-5b80819411b1	Şeyma	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.188342	2025-12-10 18:19:12.188342
d17b7538-0204-4b2f-aecf-83f8af1d266c	Tarık Bilen	4	@tarikbln	\N	\N	\N	t	\N	2025-12-10 18:19:12.189203	2025-12-10 18:19:12.189203
22561ea9-e707-4082-afbf-0a706a3918d5	Tarık Eroğlu	4	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.190109	2025-12-10 18:19:12.190109
28dafb56-4f38-4051-ae2b-67dabda4b1d5	Teknikci Hoca	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.190838	2025-12-10 18:19:12.190838
e4477eab-179d-4400-aa9b-219169bf4111	Tufanoglu	3	@tufanoglu	\N	\N	\N	t	\N	2025-12-10 18:19:12.191582	2025-12-10 18:19:12.191582
e9a26452-e262-4411-8e73-d99449360b66	Tuğsan Gökgöz	3	@JordanBullsCoin	\N	\N	\N	t	\N	2025-12-10 18:19:12.192284	2025-12-10 18:19:12.192284
bd00f679-68f3-4b10-940d-4bce91e5918c	Türkmen	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.193331	2025-12-10 18:19:12.193331
fac03169-f6bd-4c63-904f-614e89932b1b	Umut Aktu	4	@Umutt1111	\N	\N	\N	t	\N	2025-12-10 18:19:12.194056	2025-12-10 18:19:12.194056
eada85b3-3437-4c8f-ad80-94ec9a2ae738	Umut ninja	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.195092	2025-12-10 18:19:12.195092
964f2ba0-aaa4-4d3f-92b5-72ad4db28001	Üstad Splinter	4	@ustadsplinter34	\N	\N	\N	t	\N	2025-12-10 18:19:12.195769	2025-12-10 18:19:12.195769
3375d125-c65b-4bbc-807c-d0e15580cc9b	V for Kripto	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.196995	2025-12-10 18:19:12.196995
cfd27e79-36d0-4646-af3d-3f66a790ca59	Valle	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.197838	2025-12-10 18:19:12.197838
6de1feb5-e286-467b-93fb-7cbf1dd12962	Velanor	3	@velanorETH	\N	\N	\N	t	\N	2025-12-10 18:19:12.199179	2025-12-10 18:19:12.199179
9c3deaef-c8ce-4788-b304-e79ce2cc92b7	Veli Mutlu	5	@vemutlu	\N	\N	\N	t	\N	2025-12-10 18:19:12.199877	2025-12-10 18:19:12.199877
b9cd222b-c28c-4c28-8522-2206f37de8ef	Via trader	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.201276	2025-12-10 18:19:12.201276
06fe751b-01d1-42e7-9e59-5d6e8e0a7a98	Windcrypto	3	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.202107	2025-12-10 18:19:12.202107
cf53fa17-a86a-4d2f-b72d-3232d84fdfdf	Yasin Abi	2	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.203104	2025-12-10 18:19:12.203104
c86137aa-11da-4736-a053-67db0a8d658d	Zoro	3	@CRZORO	\N	\N	\N	t	\N	2025-12-10 18:19:12.203892	2025-12-10 18:19:12.203892
e83b4167-fb5f-49c1-8ca0-d10e89aaefcb	 Lex Moreno	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.20485	2025-12-10 18:19:12.20485
3aecf454-6f25-40c9-b7f7-18cef6edcb32	 Pastanaga Crypto 	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.205784	2025-12-10 18:19:12.205784
de43e928-54d8-424f-b164-c6f6cf7b8301	Alvar Burn	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.206512	2025-12-10 18:19:12.206512
8ca620b9-34cc-4cb2-bde4-9e4e425fdf2c	CriptoMindYT	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.207361	2025-12-10 18:19:12.207361
7a267af5-6c9a-46e4-b7b6-b16612eba675	CriptomindYT	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.20833	2025-12-10 18:19:12.20833
98c97607-b8f8-4115-8bbf-a389eefb9298	Edu Heras	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.209282	2025-12-10 18:19:12.209282
81ea2a69-5998-4f99-9bef-ee4f79e2ed7d	Erika Espinal	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.210018	2025-12-10 18:19:12.210018
87d1c881-208d-42f3-9d46-76b2c427bae3	Guillem Ferrer	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.210763	2025-12-10 18:19:12.210763
34fd25ca-654a-4bed-b5e3-087641ff1da4	Haskell	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.211803	2025-12-10 18:19:12.211803
e625fed5-89b6-49a7-a2c4-94ed259ab0e6	Healthy Pockets	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.212663	2025-12-10 18:19:12.212663
e94b1181-5944-4cc0-87ca-e7cb96294cde	Inverarg	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.21372	2025-12-10 18:19:12.21372
2bbdb4a2-2ecb-4ef8-91a5-0d7e7d94a874	Johny Cabesa	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.21445	2025-12-10 18:19:12.21445
0534a13e-fd02-4cfb-8491-c59ac802ff56	Kakarot	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.215294	2025-12-10 18:19:12.215294
a63fdd89-7fdd-4a67-bd10-3ec3f948723d	La Mejor Estrategia	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.215853	2025-12-10 18:19:12.215853
0c9a840d-5ae1-405f-97d8-b4620bd69836	Nico Cabrera	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.21637	2025-12-10 18:19:12.21637
cfd6e494-2e99-4444-b0dd-cf0e39c35c3f	PlanBTC	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.217076	2025-12-10 18:19:12.217076
f8998b14-8d70-4926-9fb2-9254bd4ac494	RAGER - JUEGOS NFT	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.217676	2025-12-10 18:19:12.217676
3673e128-01f7-48b5-83e1-f5d132e0b124	Salvilla	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.218932	2025-12-10 18:19:12.218932
83c4db35-bc00-42ee-84a3-0c518581f849	Secreto DeFi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.220614	2025-12-10 18:19:12.220614
3275128f-dcb6-4a98-9250-0c658c74b22d	Shooterino	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.22159	2025-12-10 18:19:12.22159
b5c1a526-3c0d-4769-adad-454977d5b169	Tech Con Catalina	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.222976	2025-12-10 18:19:12.222976
2aef7c96-0171-4476-a1cc-b4f88b34e997	Alex Invest	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.223877	2025-12-10 18:19:12.223877
025435d6-5888-4fd6-8ea7-9920118431ca	Anufri	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.22449	2025-12-10 18:19:12.22449
3ac60df5-9ea5-4472-9504-061b503a0e98	Bezrabotniy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.224955	2025-12-10 18:19:12.224955
74cc7c04-8bd1-4dd4-84f8-5a0720a3244a	Cashflow	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.225434	2025-12-10 18:19:12.225434
31288d3a-60ff-4355-b0cc-22c27c795888	Cherryx	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.225902	2025-12-10 18:19:12.225902
ea1ad626-2645-444d-ab29-4baedb9de705	CloudGeo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.226681	2025-12-10 18:19:12.226681
5148040d-6f90-461f-a2f6-adeea2c0515d	Coin Metrika	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.227391	2025-12-10 18:19:12.227391
9d82b44c-4a01-4adc-a2b7-de0f341cb15b	CrypTomera	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.227897	2025-12-10 18:19:12.227897
5e24b43b-f14f-4683-96ff-4801f37d2bfa	Cryptos Education	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.228732	2025-12-10 18:19:12.228732
ed06996e-4ff3-4e67-ace1-49001541cd54	CryptoSensej	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.229552	2025-12-10 18:19:12.229552
6cd89218-572e-48b8-9073-39f9b8b25381	CryptTomera	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.230313	2025-12-10 18:19:12.230313
7dcf839d-4ab8-4b3a-ac69-4c87f94b234a	EazyScalping	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.23082	2025-12-10 18:19:12.23082
3c1350c6-7f72-4592-a6c7-8bf2953f02ad	Fateev	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.231281	2025-12-10 18:19:12.231281
13fe3906-7dbc-4eca-a595-90b86ce38b10	Golodynuk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.232011	2025-12-10 18:19:12.232011
d26ca139-43ec-4a9e-8978-775e1e824d24	Hodl	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.2329	2025-12-10 18:19:12.2329
1431f7e3-b5be-4c45-9499-2d38f736b916	Millionnaires Noted	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.233427	2025-12-10 18:19:12.233427
5251a6b3-70bb-4ab8-a580-9201fef78bcb	MongolKombat	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.233882	2025-12-10 18:19:12.233882
9f8d74a6-0dec-40df-89b4-ce350f23ea20	Nakbaev	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.234334	2025-12-10 18:19:12.234334
0a5197f5-c578-4532-b9ca-d826eda45631	Nazare Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.234799	2025-12-10 18:19:12.234799
279d7e14-1a00-4448-847a-313a0bbae58a	Ne nabludatel	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.23564	2025-12-10 18:19:12.23564
38ea5178-eace-462d-8eec-4012d0850ed3	Oleg Artemiev	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.236099	2025-12-10 18:19:12.236099
4563395a-81cd-427e-90b5-b22bef4ed6f7	PRO Blockchain	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.236558	2025-12-10 18:19:12.236558
6de7bcc9-5890-4201-92da-1d4a4b598bc6	ProBoy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.237134	2025-12-10 18:19:12.237134
b5c50956-be91-4641-87d2-4e3635864bc6	ProBoy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.237593	2025-12-10 18:19:12.237593
0285a773-0112-4881-81db-c2d3d1242270	The Cryptus	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.238189	2025-12-10 18:19:12.238189
3638ba04-11a1-48f9-a594-2ae8703f0e3e	Traders Life	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.238718	2025-12-10 18:19:12.238718
e08177fb-7fc4-4c64-8b7f-4d0560d08036	VictorCrypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.239442	2025-12-10 18:19:12.239442
3d26bd02-5bca-4102-bf05-d7ec0fbdaca9	Zhukovtrade	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.239993	2025-12-10 18:19:12.239993
e06c1478-8030-4267-ac23-46cdf1cb76e2	Артём Инвестор	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.240463	2025-12-10 18:19:12.240463
8c1c9363-457e-40d1-905b-7dfd9a87b1a9	Безработный Инвестор	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.240918	2025-12-10 18:19:12.240918
52ba9901-cd9e-4c75-a28b-3c74f84b21e5	Думай Действуй	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.241375	2025-12-10 18:19:12.241375
db0404d3-6d7c-4c35-87e8-14c991b6b894	Крипто ферма	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.241873	2025-12-10 18:19:12.241873
5261e50f-6740-406d-b27d-cbe14528d0f5	Academia Cripto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.242449	2025-12-10 18:19:12.242449
d3d42031-99ef-4704-b5cc-837a302fbc45	Gabriel	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.243268	2025-12-10 18:19:12.243268
5d3bb457-c8ed-4cb4-aad0-962a8deb4e06	Jimmy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.243969	2025-12-10 18:19:12.243969
a6e5af8d-b3ce-40f7-a650-659c2b733e3f	OuluH	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.244568	2025-12-10 18:19:12.244568
5b01d0aa-c26f-478e-835a-0d3560a3fc70	Salles RJ	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.245224	2025-12-10 18:19:12.245224
25407bcd-ae8d-46c3-a4d8-dced7f78d279	321Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.24589	2025-12-10 18:19:12.24589
80e338f3-e4dc-4b08-bef3-ccfd3cecd922	Czas to pieniadz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.246893	2025-12-10 18:19:12.246893
53dc91bc-b3ca-4daa-8068-3bae75b63cd3	DEX Lab	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.247387	2025-12-10 18:19:12.247387
7daebce3-f985-446e-892b-ce680f7811bb	FXMAG	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.248327	2025-12-10 18:19:12.248327
3909bc10-7b63-4f58-b952-b07cb94f25fa	Gotowy na Krypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.248905	2025-12-10 18:19:12.248905
2a44bd0d-60df-412f-b41b-0ee989031acc	Julian Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.249396	2025-12-10 18:19:12.249396
15e1cfe3-8c2d-4095-a1c0-84a959935c65	Koszary Tradingu	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.24988	2025-12-10 18:19:12.24988
2950382c-f095-469b-9d0a-03b3a4cac477	Krypto Inwestycje	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.250351	2025-12-10 18:19:12.250351
e5708ff0-79ca-4fe9-bf2e-5f23c9e83739	Kryptoblogger	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.251064	2025-12-10 18:19:12.251064
2fb528eb-fc7e-4684-9dac-ebdc7108c66e	Kryptowaluty dla Początkujących	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.252198	2025-12-10 18:19:12.252198
51d5f2ba-7110-46bc-8d63-14d0fa652a5d	kyudo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.253714	2025-12-10 18:19:12.253714
9d98647e-0c3f-43ac-a41f-889f2306c64a	Łukasz Michałek (Biblia Kryptowalut)	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.254921	2025-12-10 18:19:12.254921
c6322e44-f4a9-4aec-a2f6-850336b9ad9b	mactom	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.255783	2025-12-10 18:19:12.255783
20e4f5d9-9e02-4aa0-bba7-87626ebe280a	Marek Stiller	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.256438	2025-12-10 18:19:12.256438
98b58011-16fc-4ec7-b25e-a0a6dddd9fa2	Świat Krypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.257471	2025-12-10 18:19:12.257471
a3101525-7901-4a34-a80c-0fe955903e17	Genera tu sueldo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.258243	2025-12-10 18:19:12.258243
2f7314ea-dcf9-4ced-bbd0-12e235827ef6	Polaco	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.259255	2025-12-10 18:19:12.259255
b1ce0761-75e7-4bfc-970c-39c63c15beae	Gabriel Ressan 	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.259871	2025-12-10 18:19:12.259871
640ff371-f8ed-4280-b39e-636337db7a47	Israel Gonzalez	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.260603	2025-12-10 18:19:12.260603
c1240f25-cd0b-4059-8226-f5838f72a21d	Miguel Valencia	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.261706	2025-12-10 18:19:12.261706
c34b6e61-7e47-42af-8d0f-7258a892df93	Pato Madrazo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.262333	2025-12-10 18:19:12.262333
be2c7d26-cd3c-42b7-8462-426a2f77ca55	perecrypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.262959	2025-12-10 18:19:12.262959
5cc8dabb-2e93-4493-9b7e-5b2da6a992b9	salvatore giuseppee	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.263562	2025-12-10 18:19:12.263562
103f24c5-dd68-4ef5-b98a-4f38b6268929	Artur Guimaraes	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.264256	2025-12-10 18:19:12.264256
e1520e20-6b49-4942-a5bf-17db15a8b993	Cripto Explosiva	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.264801	2025-12-10 18:19:12.264801
a23d2de8-9182-49d0-8390-0892a0d120ac	Fabio Catalao	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.265376	2025-12-10 18:19:12.265376
a2cb2258-fdb6-4ece-a4e5-68d41668da04	Igor Freitas (Best Brazilian Binance KOL)	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.265883	2025-12-10 18:19:12.265883
ae6b7c13-ad5d-44e9-9c9d-13fa1caba3af	Insalubres	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.266395	2025-12-10 18:19:12.266395
a4d26b54-bc04-4df1-8b3d-c01939ba12ac	Pato Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.266921	2025-12-10 18:19:12.266921
78ff7e96-5a3d-47ee-89d4-ec56e551af4d	Ramon Cunha	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.267448	2025-12-10 18:19:12.267448
b9aa29a7-3446-4a57-9227-f04b897053d0	Thiago Moura	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.267924	2025-12-10 18:19:12.267924
c9a7f368-d571-4f16-88b2-953fa413afce	Walter	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.268545	2025-12-10 18:19:12.268545
2d783d0e-91d3-4232-b881-4c4f0e68b5ae	AirdropATM	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.269087	2025-12-10 18:19:12.269087
c08d0109-01e2-4143-9b50-5c7ec6ac0755	ARK	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.269579	2025-12-10 18:19:12.269579
8e474aae-efe1-4e65-9592-ebb65cf96d1d	bitmansour	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.27006	2025-12-10 18:19:12.27006
94310160-1f29-4873-b341-4b3a7b37554f	Booja	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.270638	2025-12-10 18:19:12.270638
d725e61f-ad5f-48e3-898f-c363c3346fc8	Century Whale	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.271144	2025-12-10 18:19:12.271144
341117c1-b380-463f-a2e1-df27dc642128	Churin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.27162	2025-12-10 18:19:12.27162
5747fab8-f04b-4ede-8a94-d17c74d00bfd	Churin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.272093	2025-12-10 18:19:12.272093
b91bc33b-adf3-462c-975e-4c9bc4dbef2a	Coin Gallery	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.272545	2025-12-10 18:19:12.272545
6fe10761-049b-40f7-abae-2fd5d58abb50	Coinking	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.273061	2025-12-10 18:19:12.273061
e9c3d54a-a260-442a-a346-7dff417300c0	Crypto jailbreak	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.273536	2025-12-10 18:19:12.273536
cfeb2b0f-270b-407f-a625-bd46c0b9b0e0	Crypto Judy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.274111	2025-12-10 18:19:12.274111
67f81b56-5b58-4fc0-b955-31f44ccb0135	Crypto Macase	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.274639	2025-12-10 18:19:12.274639
33991c64-7e13-4231-86c2-db7afbf10414	Crypto Panda	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.275117	2025-12-10 18:19:12.275117
63b322f6-5f56-40d3-bf84-bbace6c2c8a5	Dolgommagic	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.275734	2025-12-10 18:19:12.275734
f65cc96b-2042-4141-93d9-5b96d83bf05b	Dynasty	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.276194	2025-12-10 18:19:12.276194
e8e5e669-74a7-494e-b464-afbc843bb0bf	EnjoyMyHobby	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.276678	2025-12-10 18:19:12.276678
80ff1ea3-3187-45a8-8abf-a065791af2aa	Fireant Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.277141	2025-12-10 18:19:12.277141
6bdf87ef-ce76-411c-b0a9-3f2f7e312d18	GemHiveDao	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.277697	2025-12-10 18:19:12.277697
a7c0391f-039f-4893-9fed-342636e2c31a	Han	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.278188	2025-12-10 18:19:12.278188
564e6fa2-cbf8-48b7-ba16-8afeeeb36783	Heedan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.278674	2025-12-10 18:19:12.278674
711d739c-10ed-450c-80de-baace6f715fb	honeymouse	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.279215	2025-12-10 18:19:12.279215
391617a8-5422-4fa9-a00b-0a723927fda1	Insane Coin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.2797	2025-12-10 18:19:12.2797
d4704f1c-0bba-4dd0-b85f-d896be3c10c0	kkeongsmemo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.28043	2025-12-10 18:19:12.28043
261855bb-6dd5-4966-8d34-1229e29e6def	KOOB Crypto 2.1	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.280881	2025-12-10 18:19:12.280881
3d9705c4-60a6-43da-b2ae-e3694d363025	Liam	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.281346	2025-12-10 18:19:12.281346
485578d2-8745-4484-8692-b99c1113cd70	MBM	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.281829	2025-12-10 18:19:12.281829
c880e80b-e6e9-459b-b76c-613791b7b88d	Mujammin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.28231	2025-12-10 18:19:12.28231
402d4dcb-714d-4e15-95aa-94854f602c2f	Official Univercity of Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.282769	2025-12-10 18:19:12.282769
e09bee44-10ce-4d87-94b2-3cfd7eccd5ff	Ongsal	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.283233	2025-12-10 18:19:12.283233
e61fddef-5b5e-41df-8166-0013f41c935b	organic IDO	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.283702	2025-12-10 18:19:12.283702
57e7e20a-72d6-40ff-9b6f-74f7fb46808a	Rowna	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.284229	2025-12-10 18:19:12.284229
81c829f0-c889-4ece-a1a2-d0ff22503cee	Sena	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.284721	2025-12-10 18:19:12.284721
997edef2-76fb-4731-bf0e-61711f5b4c3d	Sipang	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.285212	2025-12-10 18:19:12.285212
d275cf87-cacc-4301-a48c-e4ff974c7107	Skygoma	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.286399	2025-12-10 18:19:12.286399
7fa6f945-2af4-443f-ac9e-021942d58ffe	WeCryptoTogether	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.287002	2025-12-10 18:19:12.287002
5510895e-1d4f-493b-bd7b-45c66d381b06	Yobeully	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.287689	2025-12-10 18:19:12.287689
107096f9-c4da-42a8-8b2e-bc08ff92a2c4	신기술은돈이된다	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.288214	2025-12-10 18:19:12.288214
162986b6-6231-4b77-9305-f09c3662d29a	차분남	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.288794	2025-12-10 18:19:12.288794
87991458-6510-4f9e-bcf8-59ccd6c2a424	포밍	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.289387	2025-12-10 18:19:12.289387
fb1e01f9-e5b4-4e1e-ac03-c1bc596610b9	admen	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.289897	2025-12-10 18:19:12.289897
b20b59c3-0b66-410d-aeb6-6cf85d2cccf6	Bankera	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.290392	2025-12-10 18:19:12.290392
ef37b1c3-a253-4086-89a2-5d9fcc9e40b5	Bb	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.290898	2025-12-10 18:19:12.290898
4169437c-a5e3-43a4-9f74-91d4396c859b	Coinclub Japan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.291377	2025-12-10 18:19:12.291377
629cbe03-cc05-414c-a94f-5f89f9741208	FUJIMANA	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.291858	2025-12-10 18:19:12.291858
7a1ad5c7-dd33-41d1-a520-d0e87bccb333	kiyu	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.29257	2025-12-10 18:19:12.29257
137cf437-1b62-4fb4-98a3-48c1671ff617	Moshin Channel	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.293036	2025-12-10 18:19:12.293036
6bf62d19-ea8a-4efd-87cf-2e3f8b4c9ab1	osa	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.293507	2025-12-10 18:19:12.293507
79c46d87-380e-4919-b522-d6e9043525e9	OtakuLabs	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.293974	2025-12-10 18:19:12.293974
47d52f8a-0574-4733-aca8-ce5f86afae48	Tokeneconomist	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.29457	2025-12-10 18:19:12.29457
538264a7-212c-4f12-b5b9-eb01130c695e	AfterSide Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.295102	2025-12-10 18:19:12.295102
44265096-ccf3-4de5-993b-57ca76e5936d	Angga Andinata	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.295826	2025-12-10 18:19:12.295826
fe992cec-9283-4d0e-b054-aac3273b2ea5	Federico Ronzoni	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.296875	2025-12-10 18:19:12.296875
04141f93-b2e1-41e2-9850-837cc8afe2b8	Francesco Carrino	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.297556	2025-12-10 18:19:12.297556
ae226d98-be72-441a-b8ef-e7c0de5eaa98	Investi sul web	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.298256	2025-12-10 18:19:12.298256
b2a1c05d-9609-469f-a37f-a90299d9b43e	Leonardo Vecchio	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.299397	2025-12-10 18:19:12.299397
9165be31-df7b-4b1b-a005-eddfd2b88020	Marc Nieto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.300087	2025-12-10 18:19:12.300087
d2c44e4b-1f6e-487f-8c87-56b1287ccfe5	Mauro Caimi	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.300995	2025-12-10 18:19:12.300995
012dc821-4451-48e8-b9f6-0c62b69b6b84	Michael Pino	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.301839	2025-12-10 18:19:12.301839
4d7bc637-9284-4927-b0cd-7e2193d71a75	Mind The Chart	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.303509	2025-12-10 18:19:12.303509
12ac870c-c81a-4a4f-8739-7fbe33c891b7	Riccardo Zanetti	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.30433	2025-12-10 18:19:12.30433
f27c16ab-f3c3-466d-930b-bf1d3f3ee406	Starting Finance	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.305061	2025-12-10 18:19:12.305061
1ee5115a-5f99-4c5d-913a-5b41b2e4bb68	The Crypto Gateway	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.306143	2025-12-10 18:19:12.306143
80f0e661-7d4d-4afd-b5a0-688b93830483	Tiziano Tridico	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.307554	2025-12-10 18:19:12.307554
7b66d829-14ac-4e8e-bc45-c4d7a3d6b5c8	AnC	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.308443	2025-12-10 18:19:12.308443
8de3c4eb-cc3f-4c1f-ba06-001992e8fbd7	Andre Rizky Investasi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.309221	2025-12-10 18:19:12.309221
8171aa82-e03c-419a-bd78-f8149d941ec5	andreasrtobing.hl	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.309883	2025-12-10 18:19:12.309883
8e7bc0f8-e12d-4f86-8cc1-c2172e20bfcb	Andy Tjoeng	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.310672	2025-12-10 18:19:12.310672
a729039a-942d-415a-80bd-9c882ed4ad40	Arzanocrypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.311382	2025-12-10 18:19:12.311382
90057bf7-6dfd-4f3c-acf1-e9f13ea5f207	belvin tannadi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.312055	2025-12-10 18:19:12.312055
1399c0fe-80f8-48af-88cc-ae8b8bff6911	Bitcoin Expert India	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.312746	2025-12-10 18:19:12.312746
8ed05502-d9d4-4f16-b115-990845279625	Choze	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.313432	2025-12-10 18:19:12.313432
74cdb61f-4460-4d79-9311-70c7fbb866da	Crypto Jargon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.314192	2025-12-10 18:19:12.314192
6d581354-2a55-4133-bdb6-58087f38dbe6	Crypto King Keyur	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.315183	2025-12-10 18:19:12.315183
87362c41-8e3b-4de9-9b7b-c1c80ab5551d	Crypto Yug	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.315859	2025-12-10 18:19:12.315859
bdae4eec-4bf0-4c0d-8e4a-bbf8e8ec525c	Earn With Sapna	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.316537	2025-12-10 18:19:12.316537
7a141736-4709-4f4d-9525-2fc61668753d	GE	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.317231	2025-12-10 18:19:12.317231
6c8989e0-27f3-4dea-9c9a-ea3d720bef74	Global Rashid	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.317916	2025-12-10 18:19:12.317916
e6ed116f-20ee-4e33-9e02-b94609a4b1d4	IhsanAgaz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.318805	2025-12-10 18:19:12.318805
109a6ec0-be3d-4328-b64b-b9b00f24b358	Kenal Kripto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.319975	2025-12-10 18:19:12.319975
eb3aa25c-3533-4267-b913-8fc8361590c3	Open4profit	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.320863	2025-12-10 18:19:12.320863
b01467c1-c5ff-419c-a878-5a6f6692c4a1	TODAY CRYPTO	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.321624	2025-12-10 18:19:12.321624
918eab5e-48c2-4b12-b710-a5ed470bbbdf	Tomket Lovers	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.322318	2025-12-10 18:19:12.322318
77004703-79c5-431a-b7b9-c61e9a5610e5	Wise Advise	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.323007	2025-12-10 18:19:12.323007
8880a9b3-e726-44ba-b8fb-8d81c9ca4bb1	Yan	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.32368	2025-12-10 18:19:12.32368
493085c2-5cfd-4739-bac2-00d9532d4886	Yonathan Dinata	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.324568	2025-12-10 18:19:12.324568
a7f4d186-7dbc-43ff-a6eb-071cb73bcd24	Yunepto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.325312	2025-12-10 18:19:12.325312
4a23b148-7768-4e61-8679-df0cd894ba5c	zksrzkshmr	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.326238	2025-12-10 18:19:12.326238
cedcd048-a84e-4c58-83dc-3e52a8dfac0b	Bitcoin2Go	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.326975	2025-12-10 18:19:12.326975
af71200b-6946-49bc-a2aa-6ad36368b8cf	Coin Check TV	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.328059	2025-12-10 18:19:12.328059
e9f2f9f2-b1ae-4249-b670-12fd5c38e6c0	Crypto Heroes	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.329023	2025-12-10 18:19:12.329023
822c81af-c1b5-4493-b0a8-55ff0fdbbfee	Crypto Tuts	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.329671	2025-12-10 18:19:12.329671
b40da33a-f72b-468b-9886-5aa16aea65d7	FFDK	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.330362	2025-12-10 18:19:12.330362
19300d02-feb6-42b9-8cf9-0cd847a24821	Krypto Faint	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.331215	2025-12-10 18:19:12.331215
fd93a113-b0fe-4a7a-bd1b-262a688517c6	Krypto_Nightowl	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.332201	2025-12-10 18:19:12.332201
c18ae991-a8fb-42f9-8cd0-7047fe39d597	Miss Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.333255	2025-12-10 18:19:12.333255
1812ef72-6275-4dd6-92d2-a91ed2871065	Moneten Dave	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.334049	2025-12-10 18:19:12.334049
d6167946-0ac9-431d-b151-1ef742b78f5d	XRP News	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.335072	2025-12-10 18:19:12.335072
ac3d5f2e-1d2e-4646-a8d5-87ede6865999	Alantrading	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.335924	2025-12-10 18:19:12.335924
f29618c2-ef58-4c56-a6d2-c11779262f12	Alantrading	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.337227	2025-12-10 18:19:12.337227
20901b9b-696f-41da-9b0a-56c2b8c2874d	Caroline Jurado	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.338544	2025-12-10 18:19:12.338544
fcef559c-c13e-4bc9-a2d9-4802e4f0e8e7	Caroline Jurado	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.339285	2025-12-10 18:19:12.339285
e2bf116b-8c1a-46ef-a704-e0e5e5891e2c	Charlie Seddine	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.34001	2025-12-10 18:19:12.34001
a34840e0-3c85-4209-94b7-445658014577	Crypto Futur	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.340759	2025-12-10 18:19:12.340759
718f59a6-8d16-4e31-84f0-61883efc83fe	Frenchstartupper	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.341811	2025-12-10 18:19:12.341811
87057b00-a0b9-436f-a9d3-fc7794a4acac	Frenchstartupper	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.342511	2025-12-10 18:19:12.342511
60a1caed-204b-423a-818a-476d229e4c56	Goku	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.343366	2025-12-10 18:19:12.343366
86adf090-8560-4038-839a-caabbb105de3	Hasheur	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.34486	2025-12-10 18:19:12.34486
50b93517-656c-431d-b111-9fc40557712f	Jeux Crypto FR	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.345675	2025-12-10 18:19:12.345675
18008409-4129-4af9-a114-f0ae6269ec2b	Julien Roman	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.346732	2025-12-10 18:19:12.346732
2cba013b-a76f-4d2a-bd8a-87605899cdd0	Les Rois du Bitcoin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.348133	2025-12-10 18:19:12.348133
4b43d6cc-7025-4896-be9f-9b30bf1fba98	Maxime Astuces	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.349352	2025-12-10 18:19:12.349352
5eecf188-ac02-4b8e-87da-3ec22550adbc	Orian Messai	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.350233	2025-12-10 18:19:12.350233
acdb7ded-63b9-4e74-a95c-96d584e05e85	Quarter	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.35132	2025-12-10 18:19:12.35132
78e1ae2e-d9aa-4721-a1b6-39b12e3ddeca	Quarter	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.352263	2025-12-10 18:19:12.352263
51465645-99e4-411b-84bb-c35db8063c51	Roro Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.353072	2025-12-10 18:19:12.353072
431f2005-da1f-4309-9b88-bc84e36a271f	Roro Crypto - InvestX	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.354419	2025-12-10 18:19:12.354419
6e27e554-7a48-45d4-878c-063a723e33c2	Tagado	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.356305	2025-12-10 18:19:12.356305
b4c91d20-b980-4a02-a0c7-65a824ea2358	TibTalks	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.35757	2025-12-10 18:19:12.35757
eb01735c-541b-4bc9-b357-080cdea8f749	Yoan GJ Play	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.358513	2025-12-10 18:19:12.358513
66e31a78-d9ee-4475-8324-824f1d7a5e01	Yrille	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.359589	2025-12-10 18:19:12.359589
afed05b8-7348-4604-949d-9e25de692f4e	0xMistBlade	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.360506	2025-12-10 18:19:12.360506
9c1bf7b5-24fa-4f81-b0e7-d78ec3b5fe79	0xMistBlade	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.361396	2025-12-10 18:19:12.361396
78288a3c-91c0-4414-af3b-6fb308bdb9fe	0xSweep	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.362606	2025-12-10 18:19:12.362606
58b959a9-0137-4f52-b2a3-1388ccd167c2	ACX	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.363331	2025-12-10 18:19:12.363331
6073dca8-6f3b-4a4c-bd89-51c4599d76a1	Alex Becker	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.364196	2025-12-10 18:19:12.364196
6bdc05dd-b9aa-421b-810e-10ae2c309d74	Alex Wacy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.365062	2025-12-10 18:19:12.365062
37dcd61b-db39-4503-a4ee-d1bc37d4052a	Altcoin Daily	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.366228	2025-12-10 18:19:12.366228
03a0a906-acb5-4276-af0e-56ffff01be45	ALTSTEIN TRADE	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.367191	2025-12-10 18:19:12.367191
209afc83-5f38-41e7-afca-a46ff03f9f69	Ansem	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.368045	2025-12-10 18:19:12.368045
7d4d69a7-e764-479b-af12-259c90e4a56c	Ardizor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.368918	2025-12-10 18:19:12.368918
58e8eed6-92e8-4555-bda2-4ef60f159516	Ardizor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.370232	2025-12-10 18:19:12.370232
c8aa5616-b8b6-488c-baea-d0ff1b42ad60	Ash Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.371563	2025-12-10 18:19:12.371563
f30fbc03-1379-4a3f-9cb0-4e53194f41d5	BagCalls	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.372612	2025-12-10 18:19:12.372612
136f2845-8bf7-4324-bd2e-2e7f84025cd3	Big Wiz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.373506	2025-12-10 18:19:12.373506
56d2d5ce-e67a-4a46-97cb-8ef4fde0e960	BillionAireSon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.374557	2025-12-10 18:19:12.374557
db3a7a94-caa7-4a9f-899a-f25c24199e2a	Bitcoin Page	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.375436	2025-12-10 18:19:12.375436
f8799383-8829-494d-b9ea-6d6acb56178e	bitcoinpricedaily	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.37615	2025-12-10 18:19:12.37615
a9ecee9d-41ff-4c3e-8f4c-34d2bab8c651	Blockchain Bob	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.376851	2025-12-10 18:19:12.376851
d29938f5-3fb9-40c9-a64f-12dcaa311692	Blocklantis	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.37768	2025-12-10 18:19:12.37768
aeaafa1a-e889-432d-88f9-096455b63aeb	Brommy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.378358	2025-12-10 18:19:12.378358
66a68c02-2321-453b-bd50-79ff47082a9c	Bull BNB	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.379582	2025-12-10 18:19:12.379582
6c5a4dc5-d1d6-422f-bfc7-ee145ea2680a	businesswithnoah	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.380431	2025-12-10 18:19:12.380431
a3d597ea-4118-46ad-bd41-49950351a7f5	Carl the moon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.380967	2025-12-10 18:19:12.380967
78747028-16fc-42c1-ba68-ad630d5a5bda	cevo	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.381857	2025-12-10 18:19:12.381857
1a75ba2a-e021-4c3e-b068-c55029a8a923	Coin Gape	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.382707	2025-12-10 18:19:12.382707
2472142d-690e-4406-b8af-eea74d1afa6f	Coin Post	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.38366	2025-12-10 18:19:12.38366
b36c6d5b-3cfd-4b76-8af1-93d565960d54	CoinGrams	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.385548	2025-12-10 18:19:12.385548
efae8184-423d-41e4-9557-7aa10924710b	comet	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.386327	2025-12-10 18:19:12.386327
899cfad6-04d0-442d-bfd0-cb91e18ae0d0	Craftygems	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.387296	2025-12-10 18:19:12.387296
6ffa6051-8a12-4c47-9b02-0eac4e5a3cb0	Crypto Ding	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.388157	2025-12-10 18:19:12.388157
30d9c8ad-0e04-428f-8fd2-576ca87228c8	Crypto Mason	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.388856	2025-12-10 18:19:12.388856
c3bc5eaa-f1f4-4426-937c-d9b713c9fd16	Crypto Pablo	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.390196	2025-12-10 18:19:12.390196
e9e3fb40-6e36-48d9-918a-25cb5975cf0b	Crypto Pages	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.391362	2025-12-10 18:19:12.391362
05d4763c-6190-4df5-b97f-e60500a9df99	Crypto Rand (RR2 Capital)	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.392103	2025-12-10 18:19:12.392103
0a540629-6aec-455d-9339-5f467913ff9d	CryptoCapo_ 	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.392821	2025-12-10 18:19:12.392821
c5e25267-6809-4882-b749-9662946912c2	cryptocita	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.393525	2025-12-10 18:19:12.393525
3c0e3bbc-66d9-4333-ad39-961ae3d102b7	cryptocita	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.394271	2025-12-10 18:19:12.394271
a8dd7f18-3436-471c-a958-69575f764986	Cryptocurrency World	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.394997	2025-12-10 18:19:12.394997
d96d57cb-c038-4b44-b083-b324eeef60a9	CryptoGodJohn	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.396085	2025-12-10 18:19:12.396085
dd17ec84-8e30-4a2d-9bd5-c0040ed4ca05	Cryptolyze	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.396801	2025-12-10 18:19:12.396801
c5942cef-4b45-44ae-bd78-d60f38a052b5	CryptoMason & Megz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.397859	2025-12-10 18:19:12.397859
5ef7275a-ff14-4948-aebb-fa5d6b6a0e9b	CryptoMichael	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.398691	2025-12-10 18:19:12.398691
4d33ea45-8f4e-4a4d-a09b-ba34b57ba3e9	CryptoPizzaGirl	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.399585	2025-12-10 18:19:12.399585
b462869e-5bc0-4ff4-ada6-6944092d9e59	CryptoRus	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.400122	2025-12-10 18:19:12.400122
0909af86-2dc6-41b3-8787-53eb87b387bb	CryptoThannos	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.401019	2025-12-10 18:19:12.401019
0bf4c131-d69b-4b4b-af65-b795960d06f7	CryptoThannos	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.402031	2025-12-10 18:19:12.402031
449d6043-e4a5-4cb7-882d-6523c4fa5319	Cyclop	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.402886	2025-12-10 18:19:12.402886
2a9688a8-1ddf-4b40-9b13-4eebdd046e59	Davinci	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.403763	2025-12-10 18:19:12.403763
fe5aaf1e-a0d8-4a32-aea5-ad9c2b81e110	Dippy.eth	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.404686	2025-12-10 18:19:12.404686
9836277c-c853-4951-a303-f6bac411c107	Dusty BC	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.405572	2025-12-10 18:19:12.405572
f0c334b2-8671-46e9-aafe-e3148ee23adf	Eric Cryptoman	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.406457	2025-12-10 18:19:12.406457
ba69463e-a9d1-4935-9596-b00294a5234a	Ethereum Updates	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.407128	2025-12-10 18:19:12.407128
3950674f-2bc5-4911-bf0a-53ae0ba48d8c	Eunicedwong	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.407954	2025-12-10 18:19:12.407954
d441e7f0-bb3b-41f6-8eca-3736eb26c9f1	Farmercist	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.408627	2025-12-10 18:19:12.408627
7d370edc-909f-498d-ae21-6bc2ccfb00b1	Financial Wolf	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.409497	2025-12-10 18:19:12.409497
d923e4ba-e0d1-4fa1-9837-2755a8b33f04	fuel zee bags	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.410196	2025-12-10 18:19:12.410196
23a054f8-f81e-414c-bb6a-eb295bc619a6	Gainzy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.41113	2025-12-10 18:19:12.41113
56bb5d62-6d41-462b-9f29-6f224d84763d	GEM DETECTER	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.411971	2025-12-10 18:19:12.411971
d72e298a-d2f6-45c3-8b09-7e0294eabf5e	GEM INSIDER	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.41285	2025-12-10 18:19:12.41285
d266b55c-cef1-451f-a3ce-4b71e887543e	GennadyM	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.413976	2025-12-10 18:19:12.413976
8f9f112d-f597-4978-90fc-5906ccff773b	Hardy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.414765	2025-12-10 18:19:12.414765
bb3c65c7-9823-4df6-8c9e-051332a6cedb	Ignas	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.415633	2025-12-10 18:19:12.415633
394ff94e-831c-49cb-a04b-896128421240	InTELigent Cryptocurrency	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.416328	2025-12-10 18:19:12.416328
352bfcd2-9a94-4791-b9c1-1b7d43bc8db2	Investing Mentors	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.417034	2025-12-10 18:19:12.417034
ce1e5343-b310-4e6f-94ef-5824a2c167a7	icedknife	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.417779	2025-12-10 18:19:12.417779
a1345f80-0740-403c-857a-c2a066e9c8c3	inspiredanalyst	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.419025	2025-12-10 18:19:12.419025
f9862fe3-43b4-4742-892e-713694464801	Joe Parys 11	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.419799	2025-12-10 18:19:12.419799
ba03bb82-201c-4b85-afd6-3fceeec703ef	Joe Parys	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.420606	2025-12-10 18:19:12.420606
b5756577-7ac1-4ea5-8a7b-67d1d5712382	jollygreeninvestor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.427059	2025-12-10 18:19:12.427059
ff53a665-8e8b-4311-971a-fe2b51985a00	Justin Wu	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.428177	2025-12-10 18:19:12.428177
746d71ca-9353-48de-8ae8-dbfc0654538a	King.sol	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.429203	2025-12-10 18:19:12.429203
81d595eb-74a1-4698-b416-46c09ac155d9	Lady of Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.43034	2025-12-10 18:19:12.43034
ffc65822-d148-468b-ba2c-18d9b231b8e5	Lark Davis	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.431372	2025-12-10 18:19:12.431372
901eb416-3a46-4d7c-aa0c-93decf104d01	Layah Heilpern	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.432382	2025-12-10 18:19:12.432382
e1b258fb-7611-4b39-a601-09d38c5d6dff	Levi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.433504	2025-12-10 18:19:12.433504
5920a748-45c1-4867-b792-8a6c7845a6fb	Luke Belmar	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.434828	2025-12-10 18:19:12.434828
4d95ba58-5fcf-451c-9d78-6d8a02719d51	Macandbtc	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.435752	2025-12-10 18:19:12.435752
67e93fc8-55a3-412c-9740-0bb6d9141177	MadApes Calls	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.436611	2025-12-10 18:19:12.436611
59df3d5e-434c-44cb-9361-a252d1e8dc78	ManLy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.437765	2025-12-10 18:19:12.437765
57d33458-6158-4457-a863-416a59f2bcd3	Mario Nawfal	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.438793	2025-12-10 18:19:12.438793
360939ba-f9a5-4122-860b-bf8f6a700d5b	Marvin Favis	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.439556	2025-12-10 18:19:12.439556
950c1fce-9af9-489d-9057-23e42ebd5e2a	Megbzk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.440193	2025-12-10 18:19:12.440193
598acdcf-7247-4bb0-b980-91b71380899b	megbzk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.441022	2025-12-10 18:19:12.441022
7cbda437-88bb-47c1-b598-cb6eb72ea01a	Meta Culture	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.442132	2025-12-10 18:19:12.442132
4055d5a9-7d7f-451b-beb9-4dea063dfb23	Meta Gorgonite	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.44302	2025-12-10 18:19:12.44302
01fa437e-dded-42ac-a1ab-795135b5c433	Michael Sixgods	5	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.443838	2025-12-10 18:19:12.443838
cb476e55-39c3-4257-944f-3b1c93f8bc1a	Miles Deutscher	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.444806	2025-12-10 18:19:12.444806
14f0e2a6-31b7-4617-9bb7-9a70be9e185c	moneycoachvince	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.445678	2025-12-10 18:19:12.445678
294b5801-e218-4601-81e8-cc59f67d38ea	Mr. APE aka GEM Hunter	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.446285	2025-12-10 18:19:12.446285
5e0d6233-37b7-429b-b437-7c9e80a88217	NFT Globally	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.447137	2025-12-10 18:19:12.447137
1d9ca24c-6c45-431b-9358-912bb0d7000b	No BS Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.447814	2025-12-10 18:19:12.447814
d2b50556-4bc9-47d6-8a96-387edca98cde	notEezzy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.448648	2025-12-10 18:19:12.448648
59982833-d4f4-433d-8718-0facedf7460c	Okan	\N	@okanaksoy	\N	\N	\N	t	\N	2025-12-10 18:19:12.449923	2025-12-10 18:19:12.449923
05b24779-78c6-498a-a515-cfd2c1110ff4	overdose_ai	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.450538	2025-12-10 18:19:12.450538
34534106-7a2d-4ce3-9b1a-0eb3a58f18d7	PENGU is what i love	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.451146	2025-12-10 18:19:12.451146
77069309-1d94-457d-ae04-8f41f99b61ba	Pentoshi	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.453032	2025-12-10 18:19:12.453032
2ffbb550-8ef7-4ee0-abbb-2bc8cc9b8626	Pix	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.45457	2025-12-10 18:19:12.45457
ce85846a-bdae-482d-9f88-5f846ff811fa	Poseidon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.455395	2025-12-10 18:19:12.455395
794403fc-d937-456e-905d-ba1014f8ebdf	Prince Cryptokang	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.45649	2025-12-10 18:19:12.45649
64ce9410-1679-44f2-8c70-138792a1e087	Prince Cryptokang	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.457203	2025-12-10 18:19:12.457203
cc3e9660-9e46-4ae1-8ac6-060ab08ad10b	Ramy Zaycman	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.458189	2025-12-10 18:19:12.458189
4e528c7a-acc8-4f9a-a623-07a80b4d81a6	Real_Doomed_Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.458779	2025-12-10 18:19:12.458779
0d2da959-8d4e-4bdb-9e13-9a5558102ef5	Route 2 FI	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.459233	2025-12-10 18:19:12.459233
6f6d254a-63f2-4bcc-8f32-0a1e807e1297	Rover	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.459779	2025-12-10 18:19:12.459779
6289c163-0a16-4bea-aac3-48248f825fd7	rutradebtc	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.460717	2025-12-10 18:19:12.460717
bdb16884-7662-42a2-b2ef-07ae7ff01a1a	rutradebtc	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.461528	2025-12-10 18:19:12.461528
9696fc6a-d3c9-481e-904e-72454a56cfb0	sarafinance	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.462503	2025-12-10 18:19:12.462503
3b9e651e-7b05-4ef5-971c-23f80efa20ec	Satoshi Stacker	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.463069	2025-12-10 18:19:12.463069
a40d7c70-e895-4a15-b8be-62e233876780	The House Of Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.469438	2025-12-10 18:19:12.469438
1264f97e-0a23-4690-8272-23123de6547a	The Wolf Of Bitcoins	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.470779	2025-12-10 18:19:12.470779
954bc336-4c17-4f7d-90be-16658e264c5a	thecryptohippie	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.471453	2025-12-10 18:19:12.471453
72ac3de4-eeaa-49cf-932a-cb0d421745db	therealmelaninking	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.472605	2025-12-10 18:19:12.472605
168dd1ca-e812-4069-bf8d-25b4843e7973	Tracer	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.473907	2025-12-10 18:19:12.473907
08a2e539-1261-4c96-8955-f115d42bf27f	Tradinator	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.47499	2025-12-10 18:19:12.47499
bd49d3d2-b6d9-435d-8e51-70b36eb92d79	Corné Marchand	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.480802	2025-12-10 18:19:12.480802
e484f6a3-69db-421b-983a-004a7555a023	Cryptojams	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.48244	2025-12-10 18:19:12.48244
53ca5fed-83fb-483b-8828-fc44b82f2151	ABC Bitcoin Times	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.48307	2025-12-10 18:19:12.48307
f38f2d0e-222a-466c-94f6-a5ae59722d48	Calman	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.484263	2025-12-10 18:19:12.484263
8bdb3443-0b3c-4c0e-af70-8d5445637c2d	Coocolab	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.485249	2025-12-10 18:19:12.485249
1bb1b2be-d8ea-455b-8548-7e3b2f26d998	CryptoWilson	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.48781	2025-12-10 18:19:12.48781
dbec632d-00a9-4f98-89f2-a03331e47f5e	Fiona	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.488918	2025-12-10 18:19:12.488918
3276768e-5aba-468c-892b-24adbfd7d455	K线教主	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.489941	2025-12-10 18:19:12.489941
632ed109-9131-4e88-a37a-66627509d544	Nancy	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.491099	2025-12-10 18:19:12.491099
f961b49d-105b-4814-84f2-0430331ed65a	Victalk	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.492139	2025-12-10 18:19:12.492139
1354a7ef-fa5e-4b15-864b-84711dda47c3	Wlabs	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.49315	2025-12-10 18:19:12.49315
2d2ccc2f-e903-4f5d-8438-451b39f6fe35	十一地主	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.494178	2025-12-10 18:19:12.494178
62c0ce66-d822-4ca7-9f0d-82f71e8f1b02	妙蛙种子	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.495232	2025-12-10 18:19:12.495232
e2aa0ef9-010f-4ccf-aabc-6a7623e9fca0	愉悦	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.496283	2025-12-10 18:19:12.496283
6c907c1f-121a-41ce-aff6-4977ab588fed	杀破狼	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.497505	2025-12-10 18:19:12.497505
c5d5f602-291e-4544-a901-332f8fda700c	萌小主	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.498839	2025-12-10 18:19:12.498839
435df992-7b96-4eae-8936-b9b36b91405c	链游小捕手	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.499863	2025-12-10 18:19:12.499863
95fbb6fc-10f3-4dc6-8cbe-090094ba417a	雨中狂睡	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.50083	2025-12-10 18:19:12.50083
277f9203-92c7-4a39-809d-e81eee5e5637	Cryptomaniacos	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.502031	2025-12-10 18:19:12.502031
73054296-9cb6-4dc1-bb30-147fc0f14f47	Investidor 4.2	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.502713	2025-12-10 18:19:12.502713
7c4c65ad-dec4-4abe-93bf-6c7011711ea5	Tubarao Da Bolsa	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.507812	2025-12-10 18:19:12.507812
aa54bc98-4f39-4229-9084-5e1c992c4b96	Crypto Futuro	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.508492	2025-12-10 18:19:12.508492
a116e420-674e-4867-b4b7-0bfdd644559b	Diego Seib	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.509447	2025-12-10 18:19:12.509447
1cdf32f6-03ee-4d00-8991-2bd0b8be7ff6	KmanuS88	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.510057	2025-12-10 18:19:12.510057
d137bd3f-41e4-43a8-820a-7addc94df4ea	CRYPTOKSA	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.512848	2025-12-10 18:19:12.512848
1d187818-23de-4b40-8beb-3890620ae1d6	Alex Krüger	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.513486	2025-12-10 18:19:12.513486
0646f91d-d655-47bd-a1aa-fe8effe5748d	ANBESSA	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.513855	2025-12-10 18:19:12.513855
b824bf6a-408f-4ced-b623-4e8ac159c446	DMT (Free) By Goodie	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.51423	2025-12-10 18:19:12.51423
bfe734dd-14ea-4ac1-b1e1-a96b5573c31d	MacroCRG	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.514881	2025-12-10 18:19:12.514881
3f9531ab-be53-40a5-b8a7-593ce25db906	Viktor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.515545	2025-12-10 18:19:12.515545
183a902d-4b06-4904-8d47-3379609ab004	Scott Melker	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.464936	2025-12-10 18:19:12.464936
400be1dd-a2a9-42f5-90d0-d84fe069f387	Share Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.465959	2025-12-10 18:19:12.465959
130f5fb2-4ca1-4f96-ab26-3a3147cdbe67	Sheldon The Snipper	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.466653	2025-12-10 18:19:12.466653
6a4abfcc-aef9-48c9-9ec2-c246cf7d11f2	Stock Market Times	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.467809	2025-12-10 18:19:12.467809
40888ff9-372f-473a-9aef-29d1ba5af6d8	The Alchemist	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.468459	2025-12-10 18:19:12.468459
70012215-6080-4feb-bd19-5a7da237d524	theniftyinvestor	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.472041	2025-12-10 18:19:12.472041
cfc44cf7-59b1-4830-a8e4-9689467b0c4c	Tiko	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.473113	2025-12-10 18:19:12.473113
69d047d2-2e00-4af4-bd4d-47ec32eb0b3a	Virtual Bacon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.475813	2025-12-10 18:19:12.475813
5fc1c616-8522-4ce7-aa55-4c2ed2009365	Virtual Bacon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.477206	2025-12-10 18:19:12.477206
3de2647b-2c7e-4be4-a1ad-da663c52b49c	Voskcoin	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.477861	2025-12-10 18:19:12.477861
fe3a36d9-b571-4767-87a6-d16e5b653b13	Wall Street Bets	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.478616	2025-12-10 18:19:12.478616
cc54cc90-5051-4d2e-8116-185ffd1d55f9	White crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.479358	2025-12-10 18:19:12.479358
74b2dfe4-603a-48cb-a0f4-2326194f571c	Wizz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.480015	2025-12-10 18:19:12.480015
7f14b79a-599d-4733-aa62-44518f5c617a	Anthony Alvarez	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.481581	2025-12-10 18:19:12.481581
480c0dad-eb5a-4e45-b6c4-0d89a202aa18	Andehui志辉	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.483557	2025-12-10 18:19:12.483557
eca2971b-5e27-40bd-adec-2098a19fb964	Calman	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.484741	2025-12-10 18:19:12.484741
6f727607-1ad4-46cb-af3d-3a91fbb0eccf	Crypto Arnaud	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.487014	2025-12-10 18:19:12.487014
e8e64cd6-a80c-4e32-ac4a-c8d01273e444	FEI | 0xKEY	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.488411	2025-12-10 18:19:12.488411
6f3a5ab2-0286-4042-8629-37ee61bfb595	Haotian	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.489411	2025-12-10 18:19:12.489411
4848c5c6-a3c4-43ce-bcdf-48e979e85356	Lady Crypto	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.490446	2025-12-10 18:19:12.490446
db208873-6fb7-4ba6-9488-7539dd1ba769	NingNing	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.491585	2025-12-10 18:19:12.491585
ac23f99a-bacd-45e6-9d89-31e63a19d59f	Vvicky绵绵	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.492646	2025-12-10 18:19:12.492646
1378b622-ffc4-47d0-9c06-60198b6b925c	不二.eth	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.493665	2025-12-10 18:19:12.493665
7128f876-3e36-4dcf-b53f-1d013c870dc5	大方BigFang	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.494693	2025-12-10 18:19:12.494693
ac84bc3f-4964-438e-ae06-145366f680e6	子清	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.495768	2025-12-10 18:19:12.495768
28f63dbc-d59a-40ff-b38d-39ed1637e538	摸金校尉	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.496987	2025-12-10 18:19:12.496987
8dc919b6-d6dd-4bd3-b297-94c6023df030	茶哥	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.498311	2025-12-10 18:19:12.498311
6dfea2f7-777a-45ee-8554-6ddcbb59b841	蜡币小鑫	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.499364	2025-12-10 18:19:12.499364
32929a16-977e-4700-9ef2-21ade7141aca	链游小捕手	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.500345	2025-12-10 18:19:12.500345
903eb4a1-3be5-4187-a23d-440d1160d717	雪球	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.501336	2025-12-10 18:19:12.501336
8317df96-4c13-4514-87df-b8c65d9e08dc	Investimento sem KO	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.503527	2025-12-10 18:19:12.503527
b1ec569f-83ee-4a17-9d07-53d70bbee703	Luiz Fernandoz	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.504167	2025-12-10 18:19:12.504167
fb8dd599-e3bc-43cb-996d-4e11c82aadd6	Marcos Lima	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.504851	2025-12-10 18:19:12.504851
6953adb3-42f6-4216-b602-14f8417c754a	Matheus Bordini	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.505496	2025-12-10 18:19:12.505496
103659ba-e1f4-405d-b289-2fabf44ad1b8	Mychel Mendes	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.506113	2025-12-10 18:19:12.506113
0014cdbc-a111-4968-a413-828882e32e66	Sandro Cabrales	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.506742	2025-12-10 18:19:12.506742
50480996-392e-4fbd-bcd3-b2d67cbb25ae	Pablo aguer	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.511146	2025-12-10 18:19:12.511146
d242154c-41ac-4bea-b101-f4fe9eac41a2	CRYPTOKSA	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.511893	2025-12-10 18:19:12.511893
4404ad54-d491-4d4b-8c0d-8218300bbf03	Altcoin Gordon	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.513672	2025-12-10 18:19:12.513672
deec6016-27a4-4e2d-9bdb-16fdfedda9ff	Devchart	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.514039	2025-12-10 18:19:12.514039
4607beda-e522-4834-9c33-f1df046c527c	Kaduna	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.51472	2025-12-10 18:19:12.51472
171a88d2-da6c-4fe1-960d-82b4f11998b2	Sharks Private Group	\N	\N	\N	\N	\N	t	\N	2025-12-10 18:19:12.515058	2025-12-10 18:19:12.515058
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.languages (id, name, code, is_active) FROM stdin;
51efe1a5-35b2-4aa1-a0d9-246e5b42afe6	Turkish	tr	t
792bca6d-7eca-48b2-8995-b3bf9e33310d	English	en	t
e067e28c-a32a-485a-869c-57ea20a2b8a3	French	fr	t
e05ba476-4d4f-43df-9cf3-78911ac7226a	Spanish	es	t
ead6e18d-ebac-4263-9906-8fb7d0aba98a	Russian	ru	t
f301d383-13a9-4e27-a871-4e8bcc7e48b1	Arabic	ar	t
9c6bb2e7-362e-4730-996c-343fcfdd5c5f	Chinese	zh	t
c042ca5c-43ad-4974-aac6-78aa92612acc	Japanese	ja	t
75b12421-5398-45b2-b773-8464d8bdc06c	Korean	ko	t
702d5b5d-69a2-49c6-b503-97fd568df444	German	de	t
fff4700b-ceac-4ede-8374-8e45eaaa4708	Italian	it	t
f020540f-6d7c-4348-8f2d-6ec1433b5239	Vietnamese	vi	t
e0d6d34d-7c96-430f-b82a-ff3bc9c4c37c	Brasilian	pt-br	t
76b2d05e-aa5f-425c-b6f8-14d2c3c08d14	Portuguese	pt	t
4ff25d92-d264-4ca2-aebc-e29cb488835f	Colombia	es-co	t
77f6770e-dd6f-4c20-ac36-835a6dd877fe	Argentina	es-ar	t
9962c526-8c82-45c1-8f1c-747bde8e6817	Peru	es-pe	t
79fefe98-1e8b-4bd1-b340-c6cccb136cd5	Mexico	es-mx	t
75b6b966-8683-43f2-b80b-9f5b2c1ae6ec	Indonesia	id	t
f5064011-924d-4bcf-941f-2aeb1abbc11a	Polish	pl	t
58e932c2-ada0-4961-a156-ee1b84291133	Dutch	nl	t
0ebf082f-7e17-4d63-903f-3e09bd533183	Latam	es-latam	t
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.sessions (id, user_id, token, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: social_media; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.social_media (id, name, icon, is_active) FROM stdin;
8564cdb8-9a90-4b0d-8bf9-c477c83814df	X	x	t
77386a88-6ca3-44af-916f-807a0558671d	Telegram	telegram	t
12ebc106-4857-49c8-9528-263dc3b96f85	Instagram	instagram	t
23ca93d6-211c-4861-a1e0-fe4d6dd6ccd3	Youtube	youtube	t
a833496d-d109-42f7-a01f-be2a3180e5df	Tiktok	tiktok	t
f0128abd-bf9f-492e-8736-c5ca41213ce4	Buy signal	signal	t
2e38e750-abc1-4251-9f50-bf1d67ef7947	Youtube integration	youtube-integration	t
819643c5-b15d-4121-a78a-0aa5ea9ec440	X Thread	x-thread	t
31f79ae1-4f8f-41b7-ade0-b094bbbe05ec	X Quote	x-quote	t
47c5fd8c-d86b-4336-88fa-96ef9a4e23e6	Youtube (2nd channel)	youtube-2	t
790cda9d-2846-4e50-9f66-255e02acd1ad	Youtube integration (2nd channel)	youtube-integration-2	t
73179661-bd14-475e-b86b-7ef13217feeb	IG Reels	ig-reels	t
3b065b0a-9511-44f4-8235-f556c4cc703a	IG Story	ig-story	t
f4db0899-8cc2-4f42-86ad-3d69dadfc42c	IG Post	ig-post	t
c71b4393-f0eb-4097-acb0-10bb3a0fa4ac	AMA	ama	t
dae44f90-b066-4e51-9f93-47374d7c01df	Giveaway	giveaway	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: acar
--

COPY public.users (id, username, email, password, role, is_active, created_at, updated_at, last_login) FROM stdin;
f9e5a44b-d0b4-470f-8d8b-c799ad91017c	admin	admin@magnor.com	$2b$10$d/AEQ3vje03DKtRhowGWfeWD6JJ8B3/PQxpoWMLXYgDW227fgCPHy	admin	t	2025-12-09 10:22:53.580022	2025-12-17 08:04:58.488	2025-12-11 12:19:03.26
\.


--
-- Name: agencies agencies_name_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.agencies
    ADD CONSTRAINT agencies_name_unique UNIQUE (name);


--
-- Name: agencies agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_unique UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: kol_agencies kol_agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_agencies
    ADD CONSTRAINT kol_agencies_pkey PRIMARY KEY (id);


--
-- Name: kol_categories kol_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_categories
    ADD CONSTRAINT kol_categories_pkey PRIMARY KEY (id);


--
-- Name: kol_languages kol_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_languages
    ADD CONSTRAINT kol_languages_pkey PRIMARY KEY (id);


--
-- Name: kol_pricing kol_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_pricing
    ADD CONSTRAINT kol_pricing_pkey PRIMARY KEY (id);


--
-- Name: kol_social_media kol_social_media_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_social_media
    ADD CONSTRAINT kol_social_media_pkey PRIMARY KEY (id);


--
-- Name: kols kols_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kols
    ADD CONSTRAINT kols_pkey PRIMARY KEY (id);


--
-- Name: languages languages_code_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_code_unique UNIQUE (code);


--
-- Name: languages languages_name_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_name_unique UNIQUE (name);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_token_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_unique UNIQUE (token);


--
-- Name: social_media social_media_name_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.social_media
    ADD CONSTRAINT social_media_name_unique UNIQUE (name);


--
-- Name: social_media social_media_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.social_media
    ADD CONSTRAINT social_media_pkey PRIMARY KEY (id);


--
-- Name: kol_categories unique_kol_category; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_categories
    ADD CONSTRAINT unique_kol_category UNIQUE (kol_id, category_id);


--
-- Name: kol_languages unique_kol_language; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_languages
    ADD CONSTRAINT unique_kol_language UNIQUE (kol_id, language_id);


--
-- Name: kol_social_media unique_kol_social_link; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_social_media
    ADD CONSTRAINT unique_kol_social_link UNIQUE (kol_id, social_media_id, link);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: kol_agencies_kol_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_agencies_kol_id_idx ON public.kol_agencies USING btree (kol_id);


--
-- Name: kol_categories_kol_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_categories_kol_id_idx ON public.kol_categories USING btree (kol_id);


--
-- Name: kol_languages_kol_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_languages_kol_id_idx ON public.kol_languages USING btree (kol_id);


--
-- Name: kol_pricing_kol_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_pricing_kol_id_idx ON public.kol_pricing USING btree (kol_id);


--
-- Name: kol_social_media_kol_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_social_media_kol_id_idx ON public.kol_social_media USING btree (kol_id);


--
-- Name: kol_social_media_social_media_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kol_social_media_social_media_id_idx ON public.kol_social_media USING btree (social_media_id);


--
-- Name: kols_name_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kols_name_idx ON public.kols USING btree (name);


--
-- Name: kols_tier_score_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX kols_tier_score_idx ON public.kols USING btree (tier_score);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: public; Owner: acar
--

CREATE INDEX sessions_user_id_idx ON public.sessions USING btree (user_id);


--
-- Name: kol_agencies kol_agencies_agency_id_agencies_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_agencies
    ADD CONSTRAINT kol_agencies_agency_id_agencies_id_fk FOREIGN KEY (agency_id) REFERENCES public.agencies(id) ON DELETE CASCADE;


--
-- Name: kol_agencies kol_agencies_kol_id_kols_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_agencies
    ADD CONSTRAINT kol_agencies_kol_id_kols_id_fk FOREIGN KEY (kol_id) REFERENCES public.kols(id) ON DELETE CASCADE;


--
-- Name: kol_categories kol_categories_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_categories
    ADD CONSTRAINT kol_categories_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: kol_categories kol_categories_kol_id_kols_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_categories
    ADD CONSTRAINT kol_categories_kol_id_kols_id_fk FOREIGN KEY (kol_id) REFERENCES public.kols(id) ON DELETE CASCADE;


--
-- Name: kol_languages kol_languages_kol_id_kols_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_languages
    ADD CONSTRAINT kol_languages_kol_id_kols_id_fk FOREIGN KEY (kol_id) REFERENCES public.kols(id) ON DELETE CASCADE;


--
-- Name: kol_languages kol_languages_language_id_languages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_languages
    ADD CONSTRAINT kol_languages_language_id_languages_id_fk FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;


--
-- Name: kol_pricing kol_pricing_created_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_pricing
    ADD CONSTRAINT kol_pricing_created_by_users_id_fk FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: kol_pricing kol_pricing_kol_id_kols_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_pricing
    ADD CONSTRAINT kol_pricing_kol_id_kols_id_fk FOREIGN KEY (kol_id) REFERENCES public.kols(id) ON DELETE CASCADE;


--
-- Name: kol_social_media kol_social_media_kol_id_kols_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_social_media
    ADD CONSTRAINT kol_social_media_kol_id_kols_id_fk FOREIGN KEY (kol_id) REFERENCES public.kols(id) ON DELETE CASCADE;


--
-- Name: kol_social_media kol_social_media_social_media_id_social_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kol_social_media
    ADD CONSTRAINT kol_social_media_social_media_id_social_media_id_fk FOREIGN KEY (social_media_id) REFERENCES public.social_media(id) ON DELETE CASCADE;


--
-- Name: kols kols_created_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.kols
    ADD CONSTRAINT kols_created_by_users_id_fk FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: sessions sessions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: acar
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict esZs5dmySXswn0gv0ZWrrjCdyozxZEReXL63yUiLRiKM9B4mRleo3JIBIvZlWrZ

