--
-- PostgreSQL database dump
--

-- Dumped from database version 13.15 (Debian 13.15-1.pgdg120+1)
-- Dumped by pg_dump version 13.15 (Debian 13.15-1.pgdg120+1)

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
-- Name: CategoryProductStatus; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."CategoryProductStatus" AS ENUM (
    'DRAFT',
    'SHOW'
);


ALTER TYPE public."CategoryProductStatus" OWNER TO tp_user;

--
-- Name: Gender; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


ALTER TYPE public."Gender" OWNER TO tp_user;

--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED',
    'FAILED'
);


ALTER TYPE public."OrderStatus" OWNER TO tp_user;

--
-- Name: ProductStatus; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."ProductStatus" AS ENUM (
    'DRAFT',
    'SHOW'
);


ALTER TYPE public."ProductStatus" OWNER TO tp_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Article; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Article" (
    id integer NOT NULL,
    title text NOT NULL,
    content text,
    published boolean DEFAULT false,
    "authorId" integer,
    category_id integer,
    slug text NOT NULL
);


ALTER TABLE public."Article" OWNER TO tp_user;

--
-- Name: Article_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Article_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Article_id_seq" OWNER TO tp_user;

--
-- Name: Article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Article_id_seq" OWNED BY public."Article".id;


--
-- Name: Cart; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Cart" (
    id integer NOT NULL,
    token text NOT NULL,
    item_count integer NOT NULL,
    total_price double precision NOT NULL,
    note text,
    customer_id integer NOT NULL
);


ALTER TABLE public."Cart" OWNER TO tp_user;

--
-- Name: Cart_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Cart_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cart_id_seq" OWNER TO tp_user;

--
-- Name: Cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Cart_id_seq" OWNED BY public."Cart".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    image text,
    parent_id integer,
    slug text NOT NULL,
    status public."CategoryProductStatus" DEFAULT 'DRAFT'::public."CategoryProductStatus" NOT NULL
);


ALTER TABLE public."Category" OWNER TO tp_user;

--
-- Name: CategoryArticle; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."CategoryArticle" (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    image text,
    slug text NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."CategoryArticle" OWNER TO tp_user;

--
-- Name: CategoryArticle_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."CategoryArticle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CategoryArticle_id_seq" OWNER TO tp_user;

--
-- Name: CategoryArticle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."CategoryArticle_id_seq" OWNED BY public."CategoryArticle".id;


--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO tp_user;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Customer; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Customer" (
    id integer NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    name text,
    gender public."Gender",
    birtday timestamp(3) without time zone
);


ALTER TABLE public."Customer" OWNER TO tp_user;

--
-- Name: Customer_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Customer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Customer_id_seq" OWNER TO tp_user;

--
-- Name: Customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Customer_id_seq" OWNED BY public."Customer".id;


--
-- Name: Option; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Option" (
    id integer NOT NULL,
    name text NOT NULL,
    "position" integer NOT NULL,
    product_id integer NOT NULL,
    "values" text[]
);


ALTER TABLE public."Option" OWNER TO tp_user;

--
-- Name: Option_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Option_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Option_id_seq" OWNER TO tp_user;

--
-- Name: Option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Option_id_seq" OWNED BY public."Option".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    token text NOT NULL,
    code text NOT NULL,
    customer_id integer NOT NULL,
    total_price double precision NOT NULL,
    temp_price double precision NOT NULL,
    ship_price double precision NOT NULL,
    discount double precision NOT NULL,
    note text,
    status integer NOT NULL,
    promotions jsonb[],
    shipping jsonb NOT NULL,
    payment jsonb NOT NULL
);


ALTER TABLE public."Order" OWNER TO tp_user;

--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO tp_user;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    description_html text,
    vendor text,
    available boolean DEFAULT true NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    published_at timestamp(3) without time zone,
    barcode text,
    short_description text,
    meta_title text,
    meta_description text,
    meta_keywords text,
    featured_image text DEFAULT ''::text NOT NULL,
    price double precision DEFAULT 0 NOT NULL,
    compare_at_price double precision DEFAULT 0 NOT NULL,
    price_max double precision DEFAULT 0 NOT NULL,
    price_min double precision DEFAULT 0 NOT NULL,
    category_id integer,
    images text[] DEFAULT ARRAY[]::text[]
);


ALTER TABLE public."Product" OWNER TO tp_user;

--
-- Name: ProductOrder; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductOrder" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    category_title text NOT NULL,
    category_id integer NOT NULL,
    vendor text NOT NULL,
    barcode text,
    line_price double precision NOT NULL,
    price double precision NOT NULL,
    price_original double precision NOT NULL,
    line_price_original double precision NOT NULL,
    variant_id integer NOT NULL,
    product_id integer NOT NULL,
    product_title text NOT NULL,
    variant_title text NOT NULL,
    variant_options text[],
    quantity integer NOT NULL,
    image text NOT NULL,
    selected boolean NOT NULL,
    "cartId" integer,
    "orderId" integer
);


ALTER TABLE public."ProductOrder" OWNER TO tp_user;

--
-- Name: ProductOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductOrder_id_seq" OWNER TO tp_user;

--
-- Name: ProductOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductOrder_id_seq" OWNED BY public."ProductOrder".id;


--
-- Name: ProductSpecifications; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductSpecifications" (
    id integer NOT NULL,
    type_id integer NOT NULL,
    name text NOT NULL,
    value text[],
    description text
);


ALTER TABLE public."ProductSpecifications" OWNER TO tp_user;

--
-- Name: ProductSpecifications_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductSpecifications_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductSpecifications_id_seq" OWNER TO tp_user;

--
-- Name: ProductSpecifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductSpecifications_id_seq" OWNED BY public."ProductSpecifications".id;


--
-- Name: ProductVariant; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductVariant" (
    id integer NOT NULL,
    barcode text,
    option1 text NOT NULL,
    option2 text NOT NULL,
    option3 text NOT NULL,
    "position" integer NOT NULL,
    compare_at_price double precision NOT NULL,
    price double precision NOT NULL,
    sku text NOT NULL,
    title text NOT NULL,
    updated_at timestamp(3) without time zone,
    inventory_quantity integer NOT NULL,
    available boolean NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public."ProductVariant" OWNER TO tp_user;

--
-- Name: ProductVariant_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductVariant_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductVariant_id_seq" OWNER TO tp_user;

--
-- Name: ProductVariant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductVariant_id_seq" OWNED BY public."ProductVariant".id;


--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Product_id_seq" OWNER TO tp_user;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: SpecificationsType; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."SpecificationsType" (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public."SpecificationsType" OWNER TO tp_user;

--
-- Name: SpecificationsType_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."SpecificationsType_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SpecificationsType_id_seq" OWNER TO tp_user;

--
-- Name: SpecificationsType_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."SpecificationsType_id_seq" OWNED BY public."SpecificationsType".id;


--
-- Name: Store; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Store" (
    id integer NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    address text,
    url_map text
);


ALTER TABLE public."Store" OWNER TO tp_user;

--
-- Name: Store_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Store_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Store_id_seq" OWNER TO tp_user;

--
-- Name: Store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Store_id_seq" OWNED BY public."Store".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    email text NOT NULL,
    name text
);


ALTER TABLE public."User" OWNER TO tp_user;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO tp_user;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _ProductToProductSpecifications; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."_ProductToProductSpecifications" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToProductSpecifications" OWNER TO tp_user;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO tp_user;

--
-- Name: Article id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article" ALTER COLUMN id SET DEFAULT nextval('public."Article_id_seq"'::regclass);


--
-- Name: Cart id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Cart" ALTER COLUMN id SET DEFAULT nextval('public."Cart_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: CategoryArticle id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."CategoryArticle" ALTER COLUMN id SET DEFAULT nextval('public."CategoryArticle_id_seq"'::regclass);


--
-- Name: Customer id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Customer" ALTER COLUMN id SET DEFAULT nextval('public."Customer_id_seq"'::regclass);


--
-- Name: Option id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Option" ALTER COLUMN id SET DEFAULT nextval('public."Option_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductOrder id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder" ALTER COLUMN id SET DEFAULT nextval('public."ProductOrder_id_seq"'::regclass);


--
-- Name: ProductSpecifications id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductSpecifications" ALTER COLUMN id SET DEFAULT nextval('public."ProductSpecifications_id_seq"'::regclass);


--
-- Name: ProductVariant id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductVariant" ALTER COLUMN id SET DEFAULT nextval('public."ProductVariant_id_seq"'::regclass);


--
-- Name: SpecificationsType id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsType" ALTER COLUMN id SET DEFAULT nextval('public."SpecificationsType_id_seq"'::regclass);


--
-- Name: Store id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store" ALTER COLUMN id SET DEFAULT nextval('public."Store_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Article; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Article" (id, title, content, published, "authorId", category_id, slug) FROM stdin;
\.


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Cart" (id, token, item_count, total_price, note, customer_id) FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Category" (id, title, description, image, parent_id, slug, status) FROM stdin;
2	iPad Pro		ipad-pro.jpg	1	ipad-pro	SHOW
3	iPad Air		ipad-air.jpg	1	ipad-air	SHOW
4	iPad Gen		iphone-11.jpg	1	ipad-gen	SHOW
5	iPad Mini		iphone-11.jpg	1	ipad-mini	SHOW
15	Ipad cũ	\N	\N	\N	ipad-cu	SHOW
14	Phụ kiện	\N	\N	\N	phu-kien	SHOW
16	Iphone	\N	\N	\N	iphone	SHOW
17	Iphone cũ	\N	\N	\N	iphone-cu	SHOW
\.


--
-- Data for Name: CategoryArticle; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."CategoryArticle" (id, title, description, image, slug, status) FROM stdin;
1	Công nghệ	\N	\N	cong-nghe	1
2	Đời sống	\N	\N	doi-song	1
3	Tin tức	\N	\N	tin-tuc	1
4	Tin hot	\N	\N	tin-hot	1
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Customer" (id, email, phone, name, gender, birtday) FROM stdin;
\.


--
-- Data for Name: Option; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Option" (id, name, "position", product_id, "values") FROM stdin;
3	Màu sắc	1	2	{Hồng,Bạc,Vàng,Xanh}
4	Dung lượng	2	2	{64GB,256GB}
5	Màu sắc	1	3	{Bạc,Xám}
6	Dung lượng	2	3	{64GB,256GB}
7	Màu sắc	1	4	{Hồng,Tím,"Trắng vàng",Xám,Xanh}
8	Dung lượng	2	4	{64GB,256GB}
9	Màu sắc	1	5	{Tím,"Trắng vàng",Hồng,Xám}
10	Dung lượng	2	5	{64GB,256GB}
11	Màu sắc	1	6	{Bạc,Xám}
12	Dung lượng	2	6	{64GB,256GB,512GB,1T}
13	Màu sắc	1	7	{Xám,"Xanh lá","Xanh dương","Vàng hồng",Bạc}
14	Dung lượng	2	7	{64GB,256GB}
15	Màu sắc	1	8	{"Trắng vàng","Xanh dương",Xám,Tím}
16	Dung lượng	2	8	{128GB,256GB,512GB,1T}
17	Màu sắc	1	9	{Bạc,Xám}
18		2	9	{128GB,256GB,512GB}
19	Dung lượng	1	10	{64GB,256GB}
20	Màu sắc	1	11	{Xám,Bạc}
21	Dung lượng	2	11	{128GB,256GB,512GB,1TB,2TB}
22	Dung lượng	1	12	{128GB,256GB,512GB}
23	Màu sắc	1	13	{Bạc,Xám}
24	Dung lượng	2	13	{128GB,256GB,512GB}
25	Màu sắc	1	14	{Bạc,Đen}
26	Dung lượng	2	14	{256GB,512GB,1TB,2TB}
27	Màu sắc	1	15	{"Xanh dương",Xám,Vàng,Tím}
28	Dung lượng	2	15	{128GB,256GB}
29	Màu sắc	1	16	{"Xanh dương",Xám,Vàng,Tím}
30	Dung lượng	2	16	{128GB,256GB}
31	Màu sắc	1	17	{Hồng,"Xanh dương",Bạc,Vàng}
32	Dung lượng	2	17	{64GB,256GB}
33	Màu sắc	1	18	{Trắng}
34	Màu sắc	1	19	{Đen}
35	Màu sắc	1	20	{Trắng}
36	Màu sắc	1	21	{Trắng}
37	Màu sắc	1	22	{Trắng}
38	Màu sắc	1	23	{Đen}
39	Màu sắc	1	24	{Trắng}
40	Màu sắc	1	25	{Trắng}
41	Màu sắc	1	26	{Trắng,"Xanh dương",Tím,Vàng}
42	Màu sắc	1	27	{Trắng,Đen}
43	Màu sắc	1	28	{Trắng,Bạc}
44	Màu sắc	1	29	{Trắng,Đen}
45	Màu sắc	1	30	{Trắng,Xám}
46	Màu sắc	1	31	{Bạc,Vàng,Xám,Tím}
47	Dung lượng	2	31	{256GB,1TB}
48	Màu sắc	1	32	{Bạc,Vàng,Xám,Tím}
49	Dung lượng	2	32	{128GB}
50	Màu sắc	1	33	{Đen,Tím,"Xanh dương"}
51	Dung lượng	2	33	{128GB,256GB,512GB}
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Order" (id, token, code, customer_id, total_price, temp_price, ship_price, discount, note, status, promotions, shipping, payment) FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Product" (id, title, slug, description_html, vendor, available, status, created_at, updated_at, published_at, barcode, short_description, meta_title, meta_description, meta_keywords, featured_image, price, compare_at_price, price_max, price_min, category_id, images) FROM stdin;
2	iPad Gen 10	ipad-gen-10	<h4>iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple</h4><p>iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.</p>	Apple	t	1	2024-06-12 15:53:52.571	\N	\N	\N	iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.	\N	\N	\N	/product/ipad-gen-10/thum.jpg	11490000	0	11490000	11490000	4	{/product/ipad-gen-10/thum.jpg,https://m.media-amazon.com/images/I/61uA2UVnYWL._AC_SX522_.jpg,https://m.media-amazon.com/images/I/61uA2UVnYWL._AC_SX522_.jpg}
3	Ipad gen 9	ipad-gen-9	\N	Apple	t	1	2024-06-12 16:15:20.083	\N	\N	\N	\N	\N	\N	\N	https://i.pinimg.com/736x/b3/b6/dd/b3b6dd519638967c2a674f70cf2aa37a.jpg	11490000	0	11490000	11490000	4	{https://i.pinimg.com/736x/b3/b6/dd/b3b6dd519638967c2a674f70cf2aa37a.jpg,https://i.pinimg.com/564x/2e/55/0a/2e550a693e06757f991210424d1a1c1a.jpg}
4	iPad Air 5	ipad-air-5	\N	Apple	t	1	2024-06-12 16:24:24.605	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	11490000	0	11490000	11490000	3	{https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/9/_/9_44_1.jpg}
5	iPad mini 6	ipad-mini-6	\N	Apple	t	1	2024-06-12 16:31:55.995	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	11490000	0	11490000	11490000	5	{https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_246_1.jpg}
6	Ipad pro 2018 11inch	ipad-pro-2018-11inch	\N	Apple	t	1	2024-06-12 16:38:07.109	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro2018_3_3.jpg	11490000	0	11490000	11490000	2	{https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro2018_3_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro20181_3_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_3_1.jpg}
9	iPad Pro M2 12.9 inch WiFi	ipad-pro-m2-129-inch-wifi	<h3><a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch</a>&nbsp;là mẫu tablet mới nhất được nhà Apple phát hành vào tháng 10/2022. Thiết bị được coi là tâm điểm của giới công nghệ tại thời điểm ra mắt khi được trang bị con chip Apple M2 mạnh mẽ, bên cạnh đó sẽ là những ưu điểm khác vượt trội như: hệ điều hành iPadOS 16, quay video 4K với tốc độ khung hình 60 FPS, tần số quét 120 Hz,...</h3><h3>Hoàn thiện cao cấp</h3><p>Tổng quan về tablet thì máy sẽ được hoàn thiện với phần mặt lưng kim loại chắc chắn, khung viền được vát cạnh ở xung quanh và đi kèm với 4 góc bo cong nhẹ để mang lại cái nhìn thanh thoát - hiện đại.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103052.jpg" alt="Thiết kế cao cấp - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Năm nay nhà Apple đã sắp xếp linh kiện một cách thông minh và tối ưu phần cứng tốt hơn nên máy chỉ dày khoảng 6.4 mm, điều này giúp cho iPad Pro M2 trở thành chiếc tablet có kích thước siêu mỏng đáng kinh ngạc.</p><h3>Sức mạnh đáng kinh ngạc đến từ chipset M2</h3><p>Apple M2 chắc hẳn không còn xa lạ đối với phần lớn tín đồ công nghệ bởi đây là cái tên từng xuất hiện trên dòng Macbook vào giữa năm 2022. Kể từ khi ra mắt, Apple M2 bỗng dưng trở thành một hiện tượng khi xuất hiện trên hầu hết các mặt báo với nhiều chủ đề xoay quanh đến nội dung “hiệu năng vô đối”.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103056.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Giờ đây Apple đã đưa con chip này đến với dòng tablet nhằm giúp khách hàng có thể xử lý các công việc đồ họa một cách dễ dàng, nâng cấp trải nghiệm lên một tầm cao mới để người dùng có thể cảm nhận như đang sử dụng một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> hiệu năng cao siêu mỏng nhẹ.</p><p>Apple M2 khi được trang bị trên dòng iPad Pro 2022 sẽ có 8 lõi CPU và 10 lõi GPU, hãng có công bố về hiệu suất của thế hệ chip mới này sẽ mạnh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với Apple M1. Vì thế máy có thể xử lý tốt hầu hết mọi tác vụ từ chơi game, chỉnh sửa video hay thiết kế hình ảnh cả về 2D lẫn 3D.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103059.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>iPad Pro M2 sẽ được hỗ trợ hệ điều hành iPadOS 16 mới nhất cho năm 2022, đây được xem là một sự nâng cấp vượt bậc so với thế hệ trước, bởi phiên bản này sẽ hỗ trợ nhiều tính năng hay ho hơn, tối ưu giao diện đẹp mắt cũng như tăng cường khả năng bảo mật để thông tin cá nhân của bạn được an toàn.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103105.jpg" alt="Bổ sung nhiều tính năng - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Bên cạnh việc nâng cấp trải nghiệm trực tiếp trên thiết bị, iPad Pro M2 còn có khả năng xử lý việc truyền tải dữ liệu sang màn hình khác ổn định hơn, giảm thiểu độ trễ đáng kể để có thể đồng bộ hóa các thao tác của bạn một cách tốt nhất.</p><h3>Màn hình đảm bảo độ chính xác màu sắc cực cao</h3><p>iPad Pro M2 sẽ được tích hợp một màn hình có kích thước 12.9 inch và độ phân giải 2048 x 2732 Pixels. Chỉ cần trang bị thêm một chiếc <a href="https://www.thegioididong.com/phu-kien-thong-minh/ban-phim-magic-keyboard-apple-mk2a3">Magic Keyboard</a> là người dùng sẽ có được cảm nhận tương tự như một chiếc laptop thực thụ, bởi nội dung hình ảnh mà màn hình mang tới là cực kỳ rộng lớn và đã mắt.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103101.jpg" alt="Màn hình rộng lớn - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Đối với các công nghệ màn hình thì lần này Apple tích hợp cho iPad Pro M2 một tấm nền Liquid Retina XDR mini-LED LCD được sản xuất bởi hãng, đi kèm với đó là dải màu rộng P3 và True Tone giúp tăng độ chính xác về màu sắc mỗi khi hiển thị, phù hợp cho các tác vụ thiết kế - in ấn nhờ khả năng hạn chế độ sai lệch màu mỗi khi in ra thành phẩm.</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><p>Một điểm nổi bật khác cũng không hề kém cạnh là tần số quét 120 Hz, điều này sẽ giúp ích cho người dùng mỗi khi chơi các tựa game FPS cao hay thao tác trơn tru hơn trong lúc sử dụng cùng với <a href="https://www.thegioididong.com/phu-kien-thong-minh/apple-pencil-the-he-2">Apple Pencil 2</a>.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103102.jpg" alt="Tương thích tốt hơn - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><h3>Hỗ trợ khả năng quay - chụp chuẩn chuyên nghiệp</h3><p><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này&nbsp;được hỗ trợ 2 camera trong đó cảm biến chính có độ phân giải 12 MP và 10 MP đối với cái còn lại để hỗ trợ cho việc chụp ảnh góc siêu rộng. Bổ sung theo đó là các tính năng nổi bật như quay chậm (Slow Motion), tua nhanh thời gian (Time‑lapse) và Smart HDR 4.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103109.jpg" alt="Camera chất lượng - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>iPad Pro M2 không đơn thuần là <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> xử lý công việc như trên một chiếc laptop gọn nhẹ nữa, mà giờ đây hãng đã không ngừng cải tiến để thiết bị có thể thay thế cameraphone về khoản quay - chụp, mang đến khả năng tối ưu hai tác vụ quay - dựng trên cùng một thiết bị nhằm giúp công việc của các bạn làm về chỉnh sửa nội dung video trở nên thuận tiện hơn thông qua chuẩn video tối đa mà máy quay được là 4K 2160p@60fps.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103111.jpg" alt="Hỗ trợ quay video chuẩn 4K - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Mặt trước sẽ là camera TrueDepth 12 MP và được hỗ trợ tính năng nhận diện khuôn mặt thông minh Face ID, nhờ có sự nâng cấp về thuật toán trên Apple M2 nên máy sẽ có khả năng nhận diện chính xác hơn, đối với những điều kiện thiếu sáng thì phần camera này cũng hoạt động khá nhạy để bạn có thể mở khóa thiết bị nhanh chóng hơn.</p><h3>Nâng cao thời gian sử dụng</h3><p>Tích hợp bên trong sẽ là viên pin có dung lượng 40.88 Wh hay có thể nói là xấp xỉ 10.835 mAh. Đối với những nhu cầu cơ bản như xem phim, nghe nhạc hay lướt web thì iPad Pro M2 hoàn toàn có thể đáp ứng cho bạn thời lượng dùng cả ngày, dao động tầm 8 - 10 tiếng sử dụng liên tục ở kết nối mạng Wi-Fi.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103104.jpg" alt="An tâm sử dụng dài lâu - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a>&nbsp;năm nay chắc hẳn sẽ làm các tín đồ công nghệ mê mẩn không thôi bởi độ mạnh mẽ vượt trội về hiệu năng so với các sản phẩm trong cùng phân khúc, sự xuất hiện của Apple M2 trên dòng iPad Pro 2022 đang ngầm khẳng định vị thế số 1 của hãng cũng như khoảng cách rất xa mà nhà Apple đã vượt mặt các đối thủ.</p>	Apple	t	1	2024-06-16 15:29:16.971	\N	\N	\N	Sau iPhone, iPad chính là sản phẩm tiếp theo được Apple cho ra mắt phiên bản 2022. Máy tính bảng iPad Pro 12.9 inch 2022 M2 Wifi được trang bị con chip M2 thế hệ mới, camera chụp ảnh chuyên nghiệp cùng Apple Pencil giúp mang lại cho người dùng những trải nghiệm di chuột ấn tượng.	\N	\N	\N	https://i.pinimg.com/736x/76/1c/be/761cbe916cf57904b3c6ca13e35b494b.jpg	11490000	0	11490000	11490000	2	{https://i.pinimg.com/736x/76/1c/be/761cbe916cf57904b3c6ca13e35b494b.jpg,https://i.pinimg.com/564x/dc/0c/70/dc0c70d6eea10a10566b2f6c30f5a2b6.jpg,https://i.pinimg.com/564x/a8/43/7e/a8437e8843219055a663af9543763142.jpg}
8	iPad Air 6	ipad-air-6	<h2><strong>ĐẶC ĐIỂM NỔI BẬT</strong></h2><ul><li>Trang bị chip Apple M2 mạnh mẽ, xử lý mượt mà mọi tác vụ, từ công việc văn phòng đến sáng tạo nội dung.</li><li>Màn hình Liquid Retina rực rỡ cho trải nghiệm hình ảnh sống động, sắc nét và chân thực.</li><li>Gọi video call chất lượng cao với camera trước góc siêu rộng 12MP.</li><li>Thiết kế mỏng nhẹ, di động linh hoạt, dễ dàng mang theo bên mình mọi lúc mọi nơi, phục vụ đa dạng nhu cầu.</li></ul><p>iPad Air 6 M2 11 inch sở hữu màn hình Retina 11 inch với công nghệ IPS cùng dải màu P3 hỗ trợ hiển thị hình ảnh sống động. iPad với màn hình độ sáng cao tới 500 nits cùng với lớp phủ oleophobia chống dấu vân tay vượt trội. Cùng với đó <a href="https://cellphones.com.vn/tablet/ipad-air/ipad-air-2024.html"><strong>iPad Air 6 M2 2024</strong></a> này hoạt động trên con chip Apple M2 cùng dung lượng RAM 8GB.</p><h2><strong>So sánh&nbsp;iPad Air 6 M2 11 inch Wifi và iPad Air 5</strong></h2><p><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 11 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>11 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p>Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p>&nbsp;</p><h3><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p>&nbsp;</p><p>Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p>Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p>&nbsp;</p><h3><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p>iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p>&nbsp;</p><h3><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p>Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p>&nbsp;</p>	Apple	t	1	2024-06-16 15:09:34.435	\N	\N	\N	iPad Air 6 M2 11 inch sở hữu màn hình Retina 11 inch với công nghệ IPS cùng dải màu P3 hỗ trợ hiển thị hình ảnh sống động. iPad với màn hình độ sáng cao tới 500 nits cùng với lớp phủ oleophobia chống dấu vân tay vượt trội. Cùng với đó iPad Air 6 M2 2024 này hoạt động trên con chip Apple M2 cùng dung lượng RAM 8GB.	\N	\N	\N	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch_2_1.jpg	11490000	0	11490000	11490000	3	{https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch_2_1.jpg,https://i.pinimg.com/736x/08/da/11/08da11b670a7250719088c41a46aa370.jpg}
10	iPad mini 5 WiFi	ipad-mini-5-wifi	<h2><strong>iPad Mini 5 - Hiệu năng mượt mà, ngoại hình sang trọng</strong></h2><p>Sau sự thành công của thế hệ iPad Mini 4 ở những năm 2015, năm nay Apple đánh dấu sự trở lại của dòng sản phẩm này với <a href="https://cellphones.com.vn/tablet/ipad-mini.html">iPad Mini</a> 5 đầy hứa hẹn. Nếu bạn đang cần một thiết bị máy tính bảng đầy đủ các tính năng, mạnh mẽ, mỏng nhẹ, hiện đại: <strong>iPad Mini 5 Wifi 64GB</strong> chính là sự lựa chọn không thể bỏ qua.</p><p>Ngoài ra, bạn cũng có thể tham khảo <a href="https://cellphones.com.vn/ipad-mini-6.html">iPad Mini 6</a> sắp ra mắt với nhiều nâng cấp về hiệu năng.</p><h3><strong>Màn hình 7.9 inch rộng rãi, tấm nền IPS LCD, hỗ trợ Apple Pencil</strong></h3><p><strong>iPad Mini 5</strong> được trang bị màn hình 7.9 inch với độ phân giải 1536 x 2048. Với mật độ điểm ảnh 324 ppi, máy mang đến cho người dùng không gian trải nghiệm thoải mái, rộng lớn, sắc nét. Nhờ vào tấm nền IPS LCD mà hình ảnh trên máy thể hiện rất trung thực, hình ảnh nổi khối, độ sáng cao cũng như góc nhìn tuyệt đối.</p><p>Đặc biệt hơn, bạn sẽ có một chiếc máy tính bảng hỗ trợ Apple Pencil. Với chiếc bút Stylus này, bạn có thể thực hiện rất nhiều thao tác thú vị như vẽ, viết, thiết kế, cũng như là ghi chú công việc. Bên cạnh đó, máy tính bảng cũng hỗ trợ kết nối với vỏ bàn phím thông minh của hãng. Nhìn chung, với hai phụ kiện này, cùng màn hình rộng rãi, iPad Mini 5 thật sự là công cụ đắc lực cho công việc và giải trí.</p><p><img src="https://cellphones.com.vn/media/wysiwyg/tablet/apple/ipad-mini-5-wifi-64gb-2.jpg" alt="Apple iPad Mini 5 Wifi 64GB hỗ trợ Apple Pencil" width="840" height="557"></p><h3><strong>Cấu hình mạnh mẽ với Apple A12, 3GB RAM, bộ nhớ trong 64GB</strong></h3><p>Về cấu hình phần cứng, máy tính bảng&nbsp;<i><strong>iPad Mini 5</strong></i> được trang bị vi xử lý mới nhất của Apple: Bionic A12. Đây là một CPU được thiết kế trên tiến trình 7nm, khả năng xử lý tăng 40% so với Apple A11. Với những gì vi xử lý này đã thể hiện trên thế hệ iPhone 2018, chúng ta có thể khẳng định rằng dòng iPad mới này sẽ mang lại hiệu năng rất tuyệt vời, nhanh nhẹn.</p><p>Song song với đó, thiết bị cũng sở hữu 3GB RAM cùng 64GB bộ nhớ trong. Dung lượng RAM lớn nói trên sẽ giúp người dùng thao tác, sử dụng các tính năng đa nhiệm được mượt mà hơn. Bên cạnh đó, bộ nhớ trong 64GB cũng sẽ giúp chúng ta thoải mái lưu trữ, tải game ứng dụng, cũng như sử dụng lâu dài hơn rất nhiều. Với một thiết bị máy tính bảng nhỏ gọn như iPad Mini 5 64GB, phiên bản cấu hình (64GB/3GB RAM) trên thật sự là rất đủ, cũng như là hợp túi tiền của người dùng.</p>	Apple	t	1	2024-06-21 17:56:27.811	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb-1.jpg	11490000	0	11490000	11490000	5	{https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb-1.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb.jpg}
7	iPad Air 4	ipad-air-4	<h3>Chip mạnh hàng đầu cho trải nghiệm hoàn hảo</h3><p>Apple trang bị cho <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a> 4 chip A14 Bionic 6 nhân. Số lượng bóng bán dẫn đạt 11.8 tỷ cao hơn 40% so với A13 Bionic (8.5 tỷ). Có thể thấy số lượng bóng bán dẫn càng lớn thì chip càng mạnh và tiết kiệm năng lượng hơn.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg" alt="Trang bị chip A14 mạnh hàng đầu của Apple | iPad Air 2020" width="800" height="533"></figure><p>A14 Bionic có 6 lõi chip, trong đó 2 lõi hiệu suất cao cho tác vụ phức tạp và 4 lõi còn lại cho các tác vụ thông thường.</p><p>Bên cạnh đó, bộ xử lý đồ hoạ GPU 4 lõi mang lại hiệu suất tối đa, nhanh hơn 30% so với thế hệ trước hứa hẹn iPad Air có thể chơi các trò chơi phức tạp đòi hỏi độ phân giải cao, video 4K,...</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg" alt="Chơi game hay nặng hay xem video 4K đều mượt mà | iPad Air 2020" width="800" height="533"></figure><p>A14 Bionic mang đến tốc độ xử lý vượt trội, nhanh chóng hơn cùng với khả năng xử lý đa nhiệm mượt mà cũng như <a href="https://www.thegioididong.com/may-tinh-bang-rom-64gb">bộ nhớ trong 64 GB</a> cho bạn không gian lưu trữ hình ảnh, video,...</p><h3>Tinh tế trong thiết kế cùng nhiều màu sắc đi kèm</h3><p>iPad Air 4 64GB có kiểu dáng mới tương tự iPad Pro 2020 nhưng có kích thước nhỏ hơn và dày chỉ 6.1 mm, khối lượng đạt 460 g dễ dàng mang theo bên mình mọi lúc mọi nơi. Thiết kế này giúp tương thích với bàn phím Apple Smart Keyboard Folio, Magic Keyboard của iPad Pro 11 inch và hỗ trợ bút Apple Pencil 2.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg" alt="Bàn phím Apple Smart Keyboard Folio | iPad Air 2020" width="1020" height="570"></figure><p>Thiết kế trong iPad Air 4 vuông vắn hơn nếu so với những dòng iPad trước, các góc cạnh được bo tròn nhẹ nhàng tạo cảm giác mềm mại hơn cho tổng thể.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg" alt="Góc cạnh bo tròn cho cảm giác mềm mại  | iPad Air 2020" width="800" height="533"></figure><p>iPad Air 2020 được thiết kế nguyên khối đẳng cấp cùng nhiều màu sắc trẻ trung cho bạn có nhiều sự lựa chọn hơn như: bạc, xám, vàng hồng, xanh lá và xanh dương.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg" alt="Đa màu sắc tăng thêm sự lựa chọn | iPad Air 2020" width="800" height="533"></figure><p>Nút Home truyền thống được loại bỏ trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>, tạo không gian hiển thị rộng hơn và tích hợp cảm biến vân tay Touch ID trên nút nguồn đặt ở phía trên của thân máy. Đồng thời, iPad Air trở thành sản phẩm đầu tiên của Apple tích hợp tính năng nhận diện vân tay vào chung với nút nguồn.&nbsp;</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg" alt="Touch ID tích hợp nút nguồn mở khoá nhanh chóng | iPad Air 2020" width="800" height="533"></figure><h3>Màn hình rộng, không gian hiển thị tuyệt vời</h3><p>iPad Air 2020 sử dụng công nghệ Liquid Retina và có độ phân giải 1640 x 2360 Pixels giúp iPad Air hiển thị hình ảnh sắc nét, màu sắc chân thật hơn. Từ đó, bạn có thể tận hưởng trọn vẹn những thước phim bom tấn ấn tượng hay chơi game phải gọi là "bao mướt".&nbsp;</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg" alt="Màn hình đạt chuẩn Liquid Retina | iPad Air 2020" width="800" height="533"></figure><p>Màn hình của iPad Air có hỗ trợ dải màu rộng DCI-P3 với tính năng True-Tone cho khả năng tái tạo màu sắc chính xác hỗ trợ ưu việt cho công việc đồ họa. Hơn nữa, có lớp phủ chống lóa bề mặt, độ sáng cao giúp luôn hiển thị tốt trong nhiều điều kiện ánh sáng khác nhau, ngoài trời cũng không thành vấn đề.</p><h3>Camera đơn đa chức năng</h3><p>Camera sau có độ phân giải 12 MP cùng với đó là khả năng quay video 4K/60fps chống rung được nâng cấp, hỗ trợ Smart HDR 3.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181820-041847.jpg" alt="Camera sau với cảm biến 12 MP | iPad Air 2020" width="800" height="533"></figure><p><br>Ở mặt trước được trang bị camera 7 MP, hỗ trợ quay video HD phục vụ tốt các tác vụ gọi Facetime họp hành hay đơn giản là trò chuyện cùng người thân.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182120-042155.jpg" alt="Camera FaceTime với cảm biến 7 MP | iPad Air 2020" width="800" height="533"></figure><h3>Cổng sạc Type-C thuận lợi</h3><p>iPad Air 2020 chuyển mình với cổng Type-C giống trên các thiết bị iPad Pro. Viên pin cũng được nâng cấp và có khả năng lướt web lên 10 tiếng đem đến những trải nghiệm, làm việc giải trí liên tục.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183820-053819.jpg" alt="Cổng sạc Type-C thuận lợi trong quá trình sử dụng | iPad Air 2020" width="800" height="533"></figure><p>Nhìn chung có thể thấy, iPad Air là một phiên bản rút gọn của iPad Pro với mức giá phải chăng hơn. Trong đó, tần số quét 120Hz, Face ID và cụm camera LiDAR là những thứ không có trên iPad Air. Nếu bạn không cần những thiếu sót ấy thì iPad Air 2020 là sự lựa chọn rất hợp lý.</p><p><br>&nbsp;</p>	Apple	t	1	2024-06-16 13:06:59.589	\N	\N	\N	Apple đã trình làng máy tính bảng iPad Air 4 Wifi 64 GB (2020). Đây là thiết bị đầu tiên của hãng được trang bị chip A14 Bionic - chip di động mạnh nhất của Apple (năm 2020). Và có màn lột xác nhờ thiết kế được thừa hưởng từ iPad Pro với viền màn hình mỏng bo cong quanh máy.	\N	\N	\N	https://i.pinimg.com/736x/46/7d/04/467d0438050da4590c5d5df9324136f2.jpg	11490000	0	11490000	11490000	3	{https://i.pinimg.com/736x/46/7d/04/467d0438050da4590c5d5df9324136f2.jpg,https://i.pinimg.com/564x/1c/a8/02/1ca802a9537710a9225d00dd5ff7c955.jpg}
11	iPad Pro 11 2021 M1 WiFi	ipad-pro-11-2021-m1-wifi	<h2><strong>iPad Pro 2021 11 inch – Tablet cấu mình mạnh với chip M1 mới</strong></h2><p>Như thường lệ hằng năm Apple lại cho ra mắt chiếc máy tính bảng của mình.&nbsp;<strong>iPad Pro&nbsp;2021 </strong>phiên bản&nbsp;11 inch hứa hẹn mang đến một trải nghiệm mạnh vẽ với nhiều tính năng nổi bật.</p><p>Nếu phiên bản 2021 chưa đủ để mang đến trải nghiệm, năm 2022 Apple đã ra mắt phiên bản <a href="https://cellphones.com.vn/ipad-pro-2022-11-inch.html"><strong>iPad Pro M2</strong></a> mà quý khách có thể quan tâm!</p><h3><strong>Thiết kế vuông vức sang trọng, màn hình 11 inch</strong></h3><p>iPad Pro 11 inch 2021 sở hữu ngoại hình mang nhiều điểm tương tự về ngoại hình với chiếc iPad Pro trước đó.&nbsp;<a href="https://cellphones.com.vn/tablet/ipad-pro.html">Apple iPad Pro 2021</a> sử dụng màn hình kích thước 11 inch và sử dụng màn hình LCD truyền thống.&nbsp; Màn hình trên iPad Pro 2021 này với công nghệ màu&nbsp;ProMotion cùng độ phân giải cao&nbsp;264 pixel mỗi inch. Màn hình này cũng được trang bị lớp phủ chống bám vân tay và chống phản xạ, nâng cao trải nghiệm cho người dùng.</p><h3><strong>Sức mạnh kinh ngạc từ con chip Apple M1</strong></h3><p>iPad Pro 11 2021 được cung cấp sức mạnh bởi con chip M1 với CPU 8 nhân và GPU 8 nhân. Nhờ đó mà thế hệ iPad Pro năm nay nhanh hơn rất nhiều lần so với iPad 2010 ban đầu và nhanh hơn tới 50% so với iPad Pro 2020. Theo nhà sản xuất cho biết, những cái tiến này giúp máy thực hiện chỉnh sửa video 4K và thiết kế 3D tốt hơn.</p><p><br>&nbsp;</p>	Apple	t	1	2024-06-23 08:25:52.782	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	11490000	0	11490000	11490000	2	{https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg,https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg}
12	iPad Pro 11 2020 4G	ipad-pro-11-2020-4g	<h2><strong>iPad Pro 11 2020 4G – Tablet với hệ thống camera sau và con chip A12Z ấn tượng</strong></h2><p><i>Sau iPad Pro 11 2018, sự trở lại sau 2 năm với iPad Pro 11 2020 4G khiến cho cộng đồng công nghệ lại một lần nữa phát “sốt”. Sự nâng cấp hệ thống camera, trang bị cho iPad con chip A12Z giúp <strong>iPad Pro 11 2020 4G</strong> mang đến hiệu năng ấn tượng và mang đến cho người dùng những trải nghiệm tuyệt vời hơn.</i></p><h3><strong>Hỗ trợ kết nối với mạng 4G cùng mạng wifi tiện lợi</strong></h3><p>iPad Pro 11 2020 4G kết nối WiFi với đường truyền ổn định giúp người dùng có thể lướt web, chơi game online, gọi video call,… hoặc sử dụng các ứng dụng trực tuyến cần internet.</p><h3>&nbsp;</h3><h3>Khác với phiên bản <a href="https://cellphones.com.vn/apple-ipad-pro-11-2020-wifi-128-gb.html">iPad Pro 11 2020 WiFi</a> chỉ có thể sử dụng kết nối mạng không dây,<i> iPad Pro 11 2020 4G</i> còn hỗ trợ cả kết nối 4G. Nghĩa là iPad Pro 11 2020 4G có khe cắm sim để bạn có thể sử dụng mạng 3G/4G, giúp bạn luôn trong trạng thái trực tuyến ngay cả khi không có WiFi. iPad Pro 11 2020 4G mang đến sự tiện lợi, giúp bạn có thể sử dụng internet mọi lúc mọi nơi. Tuy nhiên bạn chỉ có thể sử dụng sim để kết nối mạng 4G, sử dụng internet nhưng không thể thực hiện các cuộc gọi hay nhắn tin thông thường.</h3><h3><strong>Thiết kế mỏng nhẹ độ mỏng 5.9mm, các góc cạnh bo tròn mềm mại, màu bạc thanh lịch</strong></h3><p>iPad Pro 11 2020 4G có thiết kế không khác với người tiền nhiệm của mình tuy nhiên vẫn có sự thay đổi như hệ thống camera sau được đặt trong một hình vuông và trọng lượng 473g cho cảm giác nặng tay hơn. Kích thước 247.6 x 178.5 mm và độ mỏng chỉ 5.9mm, iPad Pro 11 2020 4G sẽ vô cùng mỏng nhẹ, tiện lợi khi mang theo và sử dụng lúc di chuyển.</p>	Apple	t	1	2024-06-23 08:38:48.302	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi__4.png	11490000	0	11490000	11490000	2	{https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi__4.png,https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_2_4.png}
13	iPad Pro 11 inch 2022 M2 Wifi	ipad-pro-11-inch-2022-m2-wifi	<h2><strong>iPad Pro M2 11 inch 128GB Wifi - Sự lựa chọn tuyệt vời cho người dùng</strong></h2><p><a href="https://didongviet.vn/ipad-pro-m2-11-inch-128gb-wifi.html">iPad Pro M2 11 inch 128GB Wifi</a> vừa qua đã được nhà Apple công bố với nhiều cải tiến mới mẻ. Phiên bản này cho người dùng những trải nghiệm mới mẻ như hiệu năng hoạt động mạnh mẽ hơn với chip xử lý M2, dung lượng pin cho thời gian sử dụng lâu và bền bỉ hơn. Ngoài ra, nó còn được trang bị nhiều tính năng hiện đại hỗ trợ cho việc học tập, giải trí của người dùng ấn tượng nhất.</p><h3><strong>Kết nối và truyền dữ liệu nhanh chóng</strong></h3><p>Đây là một trong những chiếc <a href="https://didongviet.vn/ipad-pro-2022.html">iPad Pro 2022</a> có khả năng kết nối và truyền dữ liệu nhanh chóng. Với công nghệ kết nối Wifi 6 người dùng có thể thực hiện các thao tác kết nối mượt mà hỗ trợ cho các hoạt động giải trí, chơi game cực đã. Bên cạnh đó, máy cũng sẽ hỗ trợ người dùng truyền dữ liệu nhanh chóng nhờ có Thunderbolt 4. Đảm bảo bạn hoàn thành công việc một cách hiệu quả nhất.</p><p>&nbsp;</p><h3><strong>Dung lượng pin cải thiện, hỗ trợ công nghệ sạc nhanh</strong></h3><p>iPad Pro M2 11 inch 128GB Wifi được trang bị viên pin với dung lượng lớn cho phép người dùng sử dụng xuyên suốt cả ngày dài mà không lo bị gián đoạn giữa chừng. Bên cạnh đó, máy còn được hỗ trợ tính năng sạc nhanh giúp người dùng có thể sạc pin nhanh chóng, cho trải nghiệm trọn vẹn hơn bao giờ hết.</p><h3><strong>Hỗ trợ kết nối với các thiết bị công nghệ hiện đại</strong></h3><p>Khi sử dụng iPad Pro M2 người dùng sẽ được hỗ trợ kết nối nhanh chóng với các thiết bị công nghệ hiện đại đến từ nhà Apple. Để nâng cao trải nghiệm đánh máy, nhà sản xuất cho phép thiết bị có thể kết nối với bàn phím Magic hỗ trợ đèn màu mang đến hiệu quả công việc tốt nhất.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2023/7/2/0/1690956710543_6_ipad_pro_m2_didongviet.jpg" alt="Kết nối và truyền dữ liệu nhanh chóng" width="780" height="520"></figure><p>Không những thế, máy còn có thể kết nối với bút Apple Pencil giúp bạn thực hiện thao tác nhanh chóng cùng với bộ điều khiển chơi game vô cùng hiện đại.</p><h3><strong>Sở hữu thiết kế sang trọng, hiện đại</strong></h3><p>Người dùng sẽ bị thu hút bởi vẻ đẹp bên ngoài của chiếc Apple iPad Pro 11 2022 M2 WiFi 128GB. Bởi chúng sở hữu một thiết kế đặc trưng, được gia công bằng nhôm chắc chắn, gọn nhẹ khi trọng lượng chỉ 466g. Từ đó, người dùng có thể dễ dàng mang theo bên mình đến bất cứ nơi đâu họ thích.&nbsp;</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/thiet-ke-ipad-pro-m2-11-inch-128gb-wifi-didongviet_1.jpg" alt="Sở hữu thiết kế sang trọng, hiện đại" width="780" height="520"></figure><p>Bên cạnh đó, phiên bản này còn sở hữu những màu sắc độc quyền giúp cho người dùng toát lên vẻ đẹp sang trọng, quý phái khi cầm trên tay chiếc iPad này.</p>	Apple	t	1	2024-06-23 08:52:07.407	\N	\N	\N	\N	\N	\N	\N	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01_1_1_1.jpg	11490000	0	11490000	11490000	2	{https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01_1_1_1.jpg,https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2_3.png,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-pro-13-select-202210_1_1_1.png}
14	iPad Pro M4 11 inch Wifi	ipad-pro-m4-11-inch-wifi	<h2><strong>1. Giới thiệu về sản phẩm iPad Pro M4 256GB 11 inch WiFi</strong></h2><p><a href="https://didongviet.vn/may-tinh-bang/ipad-pro-m4-11-inch-256gb-wifi.html"><strong>iPad Pro M4&nbsp;256GB&nbsp;11 inch&nbsp;WiFi</strong></a>&nbsp;là dòng máy tính bảng lý tưởng cho nhu cầu công việc chuyên nghiệp nhờ được trang bị chip M4 mạnh mẽ mang lại hiệu suất vượt trội. Phiên bản iPad Pro mới này không chỉ có thiết kế mỏng nhẹ hơn mà còn sở hữu màn hình Ultra Retina XDR đẹp mắt. Ngoài ra,&nbsp;sản phẩm&nbsp;có dung lượng pin&nbsp;31.29Wh&nbsp;trâu để phục vụ được bạn trong suốt ngày dài.</p><h2><strong>2. iPad Pro M4 256GB 11 inch WiFi chính hãng giá bao nhiêu? Rẻ hơn bao nhiêu so với Apple Store Online?</strong></h2><p>Sản phẩm&nbsp;<a href="https://didongviet.vn/ipad-pro-m4-2024.html"><strong>iPad Pro M4</strong></a> phiên bản<strong> </strong>11inch WiFi&nbsp;256GB dự kiến sẽ có giá <strong>27.990.000 VNĐ</strong> khi mới mở bán tại Di Động Việt. Khi so với giá bán hiện tại trên Apple Store Online là <strong>28.999.000 VNĐ</strong>, mức giá này rẻ hơn khoảng <strong>1.000.000 VNĐ</strong>. Hơn thế nữa, khi mua sắm tại Di Động Việt, bạn còn được hưởng nhiều ưu đãi hấp dẫn khác để tiết kiệm nhiều hơn.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178037861_1_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 256GB 11 inch WiFi" width="780" height="520"></figure><p><strong>Lưu ý:</strong> Giá bán của tablet được nêu trên được cập nhật tới thời điểm viết và sẽ có thể thay đổi theo thời gian và chương trình khuyến mãi có tại cửa hàng.</p><h2><strong>3. Lý do nên mua iPad Pro M4 256GB 11 inch WiFi</strong></h2><p>iPad Pro M4 256GB 11 inch Wifi đang thu hút sự chú ý của cộng đồng công nghệ nhờ những cải tiến đáng kể về cả cấu hình và thiết kế. Phiên bản Pro M4 2024 này không chỉ mang lại sức mạnh vượt trội để đáp ứng các nhu cầu công việc chuyên nghiệp mà còn có thiết kế mỏng nhẹ, giúp tăng tính linh hoạt khi sử dụng.</p><h3><strong>3.1. Thiết kế siêu mỏng, tinh tế</strong></h3><p>iPad Pro M4 Wifi&nbsp;256GB&nbsp;11 inch&nbsp;sở hữu&nbsp;một thiết kế đột phá, đánh dấu bước chuyển mình lớn cho các dòng máy tính bảng tương lai của Apple. Phiên bản iPad Pro 11 inch mới này mỏng hơn đáng kể so với thế hệ iPad Pro M2 trước đó với độ dày chỉ <strong>5.3 mm</strong>. Nhờ&nbsp;ngoại hình siêu mỏng, trọng lượng của&nbsp;máy cũng được giảm xuống còn <strong>444 gram</strong>&nbsp;nên người dùng có thể chủ động đem đi bất cứ đâu.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178056344_2_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 11 inch WiFi 256GB" width="780" height="520"></figure><h3><strong>3.2. Màn hình hiển thị chất lượng với công nghệ cao</strong></h3><p>Ngoài kiểu dáng mỏng nhẹ, chiếc iPad Pro M4 256GB 11 inch WiFi được trang bị màn hình <strong>Ultra Retina XDR</strong> mới, giúp nâng cao chất lượng hiển thị. Nhờ ứng dụng công nghệ <strong>OLED 2 lớp</strong>, màn hình của thiết bị được cải thiện về độ sáng và độ tương phản, mang đến hình ảnh sắc nét và màu sắc sống động. Ngoài ra, viền màn hình cũng được thu gọn lại, giúp tỷ lệ hiển thị nội dung đạt tới <strong>84,2%</strong>.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178090254_3_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 256GB WiFi 11 inch" width="780" height="520"></figure><h3><strong>3.3. Hiệu năng bất bại với vi xử lý M4</strong></h3><p>Apple đã tích hợp chip <strong>M4</strong> mới nhất cho iPad Pro 2024&nbsp;11 inch WiFi 256GB&nbsp;thay vì chip M3 như nhiều tin đồn. Với bộ vi xử lý Silicon M-Series thế hệ tiếp theo sử dụng công nghệ 3nm, máy sẽ&nbsp;mang lại hiệu năng mạnh mẽ, đủ sức xử lý các tựa game đồ họa nặng và render video 4K cực kỳ&nbsp;mượt mà, không giật lag. Ngoài ra, Neural Engine mới nhất&nbsp;cũng&nbsp;giúp cải thiện tốc độ tính toán, đáp ứng tốt các tác vụ liên quan đến AI.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178133216_4_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 256GB 11 inch WiFi" width="780" height="520"></figure><p>Bên cạnh đó, Apple cũng trang bị cho mẫu iPad Pro 256GB 11 inch WiFi này&nbsp;<strong>8GB RAM</strong>, hỗ trợ đảm bảo khả năng đa nhiệm mượt mà. Chưa hết, máy tính bảng&nbsp;có dung lượng bộ nhớ <strong>256GB</strong>, giúp người dùng&nbsp;lưu trữ nội dung đa phương tiện và cài đặt ứng dụng&nbsp;thoải mái hơn mà không lo bị đầy bộ nhớ.</p><h3><strong>3.4. Dung lượng pin</strong></h3><p>Tablet iPad Pro M4&nbsp;256GB&nbsp;11 inch Wifi được trang bị pin <strong>Lithium-Polymer</strong> với dung lượng <strong>31.29Wh</strong>. Viên pin này đảm bảo thời lượng sử dụng lâu dài,&nbsp;hỗ trợ&nbsp;người dùng thoải mái làm việc và giải trí suốt cả ngày. Ngoài ra, nó còn kết hợp&nbsp;với chip M4 và màn hình OLED tiết kiệm năng lượng, đem lại&nbsp;khả năng duyệt web và xem video trực tuyến trong nhiều giờ liên tục&nbsp;mà không hề bị cạn quá nhanh.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178143744_5_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 256GB 11 inch WiFi" width="780" height="520"></figure><h3><strong>3.5. Các điểm nổi bật khác</strong></h3><p>Không chỉ có những điểm hay ho trên, siêu phẩm iPad Pro M4 2024 11 inch 256GB WiFi của nhà Apple còn có những ưu điểm nổi bật sau có thể bạn chưa ngờ tới sau đây:</p><ul><li>Hỗ trợ HDR, ProMotion với tốc độ làm mới 120Hz và công nghệ True Tone.</li><li>Camera sau kép 12MP bao gồm camera góc rộng và góc siêu rộng.</li><li>Camera trước 12MP với tính năng Center Stage, giúp&nbsp;tự động giữ bạn trong khung hình khi gọi video.</li><li>LiDAR Scanner hỗ trợ lấy nét tự động trong điều kiện thiếu sáng và khả năng AR tiên tiến.</li><li>Wi-Fi 6E cho tốc độ mạng nhanh hơn.</li><li>Tương thích với&nbsp;Apple Pencil Pro&nbsp;và Magic Keyboard.</li></ul><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/20/0/1716178152542_6_ipad_pro_m4_didongviet.jpg" alt="iPad Pro M4 256GB 11 inch WiFi" width="780" height="520"></figure><h2><strong>4. Ai nên mua phiên bản iPad Pro M4 256GB 11 inch WiFi?</strong></h2><p>Phiên bản iPad Pro M4 256GB 11 inch WiFi là lựa chọn lý tưởng cho những người làm công việc sáng tạo như thiết kế đồ họa, biên tập video và lập trình&nbsp;bởi nó có&nbsp;hiệu năng mạnh mẽ của chip M4 và dung lượng lưu trữ lớn. Ngoài ra, màn hình Ultra Retina XDR&nbsp;cũng mang đến chất lượng hiển thị tuyệt vời, hỗ trợ tốt cho các công việc yêu cầu độ chính xác cao về màu sắc.</p>	Apple	t	1	2024-06-23 08:58:17.338	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247712333_thumb_ipad_pro_m4_11_inch_didongviet.jpg	11490000	0	11490000	11490000	2	{https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247712333_thumb_ipad_pro_m4_11_inch_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715154018478_2_ipad_pro_m4_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715154020602_3_ipad_pro_m4_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715154022517_4_ipad_pro_m4_didongviet.jpg}
15	iPad Air 6 M2 11 inch Wifi	ipad-air-6-m2-11-inch-wifi	<h2><strong>1. Giới thiệu về iPad Air 6 M2 11 inch | 128GB Wifi</strong></h2><p><a href="https://didongviet.vn/may-tinh-bang/ipad-air-6-11-inch-128gb.html"><strong>iPad Air 6 M2 11 inch 128GB Wifi</strong></a><strong> </strong>sở hữu màn hình Retina 11 inch ấn tượng. Kết hợp cùng sự nâng cấp mạnh mẽ với con chip Apple M2 mang đến trải nghiệm hiệu năng mượt mà, ổn định. Hãy cùng bài viết đi vào đánh giá sâu hơn về sản phẩm iPad Air M2 2024 này dưới đây nhé.&nbsp;&nbsp;</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715937558356_gioi_thieu_ve_ipad_air_6_11_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><h2><strong>2. iPad Air 6 M2 11 inch | 128GB Wifi giá bao nhiêu? Rẻ hơn bao nhiêu so với Apple Store Online</strong></h2><p>Đầu tiên, hãy cùng bài viết cập nhật qua mức giá bán dự kiến cập nhật mới nhất của <a href="https://didongviet.vn/ipad-air-6.html"><strong>iPad Air 6</strong></a> chip&nbsp; M2 11 inch 128GB Wifi trên Apple Store Online dưới đây nhé.&nbsp;</p><p><i>Lưu ý: Giá bán iPad Air 6 M2 11 inch 128GB Wifi chỉ là giá tham khảo cập nhật ngày 17.5.2024.</i></p><figure class="table"><table><tbody><tr><td><strong>Phiên bản 11inch - 128GB</strong></td><td><strong>Giá bán dự kiến ngày 17.5.2024</strong></td></tr><tr><td>Giá bán dự kiến tham khảo tại Di Động Việt&nbsp;</td><td>16.490.000 VNĐ</td></tr><tr><td>Giá bán trên Apple Store Online</td><td>16.999.000 VNĐ</td></tr></tbody></table></figure><p>&nbsp;</p><h2><strong>3. Lý do nên mua iPad Air 6 M2 11 inch | 128GB Wifi</strong></h2><p>iPad Air 6 M2 11 inch 128GB Wifi với những nâng cấp vượt trội đầy ấn tượng không chỉ mạnh mẽ về hiệu năng, trang bị các tính năng mới. Hãy cùng bài viết điểm qua những lý do nổi bật đáng sở hữu nhất của sản phẩm này trong năm nay dưới đây nhé.&nbsp;</p><h3><strong>3.1. Thiết kế khung viền vuông vức nhỏ gọn</strong></h3><p>iPad Air 6 M2 11 inch 128GB Wifi sở hữu thiết kế mang phong cách cổ điển nhưng không kém phần sang trọng. Khung máy vuông vắn tạo cảm giác chắc chắn, trong khi các góc bo cong nhẹ nhàng giúp tăng khả năng cầm nắm thoải mái.</p><p>Ngoài ra, iPad Air M2 còn được cung cấp trong nhiều lựa chọn màu sắc vintage, mang lại sự đa dạng cho người dùng. Các tùy chọn như<strong> tím, xanh da trời, vàng ánh sao, xám </strong>sẽ là những gam màu hoài cổ, đem lại vẻ đẹp tinh tế và độc đáo cho thiết bị.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715937547871_thiet_ke_ipad_air_6_11_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><h3><strong>3.2. Màn hình siêu mỏng đầy tinh tế</strong></h3><p>Màn hình Retina IPS LCD 11 inch trên iPad Air 6 M2 là một điểm nhấn đáng chú ý của thiết bị này. Với độ phân giải cao <strong>1640 x 2360px,</strong> người dùng sẽ được trải nghiệm những hình ảnh sắc nét, chi tiết. Đặc biệt, màn hình này còn đạt chuẩn màu sắc rực rỡ và chính xác nhờ công nghệ màu rộng P3.</p><p>Nhờ<strong> công nghệ màu rộng P3</strong>, iPad Air 6 M2 11 inch có thể hiển thị phạm vi màu sắc rộng hơn, mang lại những gam màu sống động, trung thực. Điều này rất có ích cho những người làm việc chuyên nghiệp trong các lĩnh vực như thiết kế đồ họa, chỉnh sửa ảnh và video.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715937539792_man_hinh_ipad_air_6_11_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><h3><strong>3.3. Hiệu năng đầy mạnh mẽ với con chip Apple M2</strong></h3><p>iPad Air 6 M2 nổi bật nhất vẫn nhờ vào <strong>nâng cấp con chip Apple M2</strong>, với 8 lõi CPU và 10 lõi GPU mạnh mẽ. Điều này mang đến sức mạnh xử lý vượt trội so với thế hệ trước, không chỉ giúp đẩy nhanh các tác vụ hàng ngày mà còn cho phép người dùng thực hiện những công việc đòi hỏi tính toán nặng nề như<strong> chỉnh sửa video 4K, thiết kế 3D </strong>và chơi game đồ họa nặng mà không gặp bất kỳ rào cản nào.</p><p>Thêm vào đó, bộ xử lý Neural Engine nâng cấp trên chip M2 cũng đóng vai trò quan trọng. Nhờ đó, các tính năng sử dụng trí tuệ nhân tạo như tra cứu và chụp văn bản trực tiếp trở nên mạnh mẽ và hiệu quả hơn đến 40%. Điều này mang đến những trải nghiệm thông minh và tiện dụng cho người dùng.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715938145720_hieu_nang_ipad_air_6_11_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><p><br>&nbsp;</p><h3><strong>3.4. Dung lượng pin vẫn bền bỉ liên tục phục vụ cả ngày dài</strong></h3><p>Một trong những điểm cộng đáng chú ý trên iPad Air M2 là tuổi thọ pin ấn tượng. Với viên pin có <strong>dung lượng 28.93 Wh</strong>, thiết bị có thể hoạt động <strong>liên tục lên đến 10 giờ</strong> khi lướt web hay xem video, theo công bố của nhà sản xuất.&nbsp;</p><p>Đây là một lợi thế lớn đối với những ai cần sự linh hoạt và độc lập năng lượng, đặc biệt là khi sử dụng ngoài trời hoặc di chuyển, khi khả năng tiếp cận nguồn sạc có thể bị hạn chế. Điều này giúp người dùng thoải mái thực hiện các tác vụ quan trọng mà không phải lo lắng về nhu cầu sạc thường xuyên.&nbsp;</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715937521830_dung_luong_pin_ipad_air_6_11_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure>	Apple	t	1	2024-06-23 09:09:15.65	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247360328_thumb_ipad_air_6_11_inch_didongviet.jpg	11490000	0	11490000	11490000	3	{https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247360328_thumb_ipad_air_6_11_inch_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715152885895_1_ipad_air_6_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715152887931_2_ipad_air_6_didongviet.jpg}
16	iPad Air 6 M2 13 inch Wifi	ipad-air-6-m2-13-inch-wifi	<h2><strong>1. Giới thiệu về iPad Air 6 M2 13 inch | 128GB Wifi</strong></h2><p><a href="https://didongviet.vn/may-tinh-bang/ipad-air-6-13-inch-128gb.html"><strong>iPad Air 6 M2 13 inch 128GB Wifi</strong></a><strong> </strong>sở hữu màn hình lớn 13 inch, với công nghệ hiển thị IPS và dải màu P3 rộng, cùng độ sáng 600 nits, mang lại chất lượng hình ảnh ấn tượng. Thiết bị được trang bị con chip Apple M2 đầy mạnh mẽ mang đến những trải nghiệm vượt trội đáng mong đợi.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715938687291_gioi_thieu_ve_ipad_air_6_13_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><h2><strong>2. iPad Air 6 M2 13 inch | 128GB Wifi giá bao nhiêu? Rẻ hơn bao nhiêu so với Apple Store Online</strong></h2><p>Đầu tiên, hãy cùng bài viết tham khảo qua mức giá dự kiến của <a href="https://didongviet.vn/ipad-air-6.html"><strong>iPad Air M2</strong></a> phiên bản 13 inch 128GB Wifi trong bảng bên dưới để có được cái nhìn tổng quan về giá của sản phẩm năm nay trước nhé.&nbsp;</p><p><i>Lưu ý: Giá bán iPad Air 6 M2 13 inch 128GB Wifi bên dưới được tham khảo cập nhật ngày 17.5.2024.</i></p><h2><strong>3. Lý do nên mua iPad Air 6 M2 13 inch | 128GB Wifi</strong></h2><p>Tiếp đến, hãy cùng bài viết điểm qua một số lý do nổi bật mà chiếc iPad Air 6 M2 13 inch 128GB Wifi năm nay rất đáng để sở hữu dưới đây nhé.&nbsp;</p><h3><strong>3.1. Thiết kế siêu mỏng với kích thước lớn 13inch ấn tượng</strong></h3><p>iPad Air 6 M2 13 inch 128GB Wifi sở hữu thiết kế tinh tế và lịch lãm, với khung viền vuông góc bo cong mềm mại. Tổng thể máy có độ mỏng gọn cùng trọng lượng nhẹ, mang lại cảm giác cầm nắm chắc chắn.&nbsp;</p><p>Ngoài ra, thiết bị có nhiều tùy chọn màu sắc đa dạng, từ những gam màu nổi bật như xanh dương, tím, vàng đến màu trung tính như xám không gian, giúp người dùng dễ dàng lựa chọn phiên bản ưng ý. Đây cũng là lần đầu tiên dòng iPad Air sở hữu kích thước màn hình 13inch hoàn toàn mới. Mang đến cho người dùng lựa chọn phiên bản kích thước rộng rãi hơn.&nbsp;</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2024/4/17/0/1715938700995_thiet_ke_ipad_air_6_13_inch_128gb_didongviet.jpg" alt="" width="780" height="520"></figure><h3><strong>3.2. Màn hình 13inch rộng rãi ấn tượng</strong></h3><p>Màn hình của iPad Air 6 M2 13 inch 128GB Wifi được trang bị công nghệ Multi-Touch tiên tiến, mang lại trải nghiệm thao tác cảm ứng mượt mà và chính xác. Với <strong>kích thước 13 inch </strong>và thiết kế viền mỏng, màn hình hiển thị hình ảnh sắc nét, <strong>công nghệ LED </strong>giúp nâng cao độ tương phản và độ sáng.&nbsp;</p><p>Đặc biệt, Apple đã nâng <strong>độ phân giải lên mức 2732 x 2048px</strong>, cho phép người dùng tận hưởng những bức ảnh và video với độ chi tiết cao, mang lại sự sống động và đầy chân thực.&nbsp;</p>	Apple	t	1	2024-06-23 09:13:54.469	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247541803_thumb_ipad_air_6_13_inch_didongviet.jpg	11490000	0	11490000	11490000	3	{https://cdn-v2.didongviet.vn/files/products/2024/5/13/1/1718247541803_thumb_ipad_air_6_13_inch_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715152937786_1_ipad_air_6_13_inch_didongviet.jpg,https://cdn-v2.didongviet.vn/files/products/2024/4/8/1/1715152939755_2_ipad_air_6_13_inch_didongviet.jpg}
17	iPad 10.9-inch 2022 | 256GB Wifi	ipad-109-inch-2022--256gb-wifi	<h2><strong>iPad 10.9-inch 2022 256GB Wifi - Thiết kế mới, nhiều màu sắc độc lạ</strong></h2><p><a href="https://didongviet.vn/ipad-gen-10-256gb-wifi.html">iPad 10.9-inch 2022 256GB Wifi</a> vừa qua được hà Apple cho ra mắt vào ngày 18/10. Chiếc iPad này được cải tiến với nhiều tính năng và hiệu năng mới mẻ. Bên cạnh đó, thiết kế cũng được thay đổi với nhiều phiên bản màu sắc mới lạ. Hứa hẹn sẽ mang đến những trải nghiệm tuyệt vời cho người dùng.</p><h2><strong>Đánh giá iPad 10.9-inch 2022 256GB Wifi</strong></h2><p>Chiếc iPad 10.9-inch Gen 10 này đã mang đến cho người dùng nhiều sự tò mò. Khi sở hữu một thiết kế trẻ trung với nhiều màu sắc hiện đại. Lần này nhà Apple cũng đã loại bỏ nút home nhằm không cản trở trải nghiệm của người dùng. Bên cạnh đó, với việc trang bị chipset A14 Bionic đã mang đến hiệu năng hoạt động mạnh mẽ, hỗ trợ các nhu cầu tối đa của người dùng. Ấy vậy mà chiếc iPad này lại có mức giá vô cùng phải chăng, đây chắc chắn sẽ là thiết bị bạn nên trải nghiệm trong năm 2022 này.</p><h3><strong>Thiết kế bắt mắt, nhiều màu sắc mới lạ</strong></h3><p>Về ngoài hình, iPad 10.9-inch 2022 256GB Wifi dường như vẫn thừa hưởng những tinh hoa của người đàn anh thế hệ trước. Nó vẫn được thiết kế vuông vắn với các cạnh bo tròn tạo nên cảm giác trẻ trung, đẹp mắt. Bên cạnh đó, với thiết kế nhỏ gọn cùng với trọng lượng nhẹ nhàng cho phép người dùng có thể mang đi bất cứ nơi đâu mà họ thích.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/default/2023/7/2/0/1690951858686_2_ipad_gen_10_didongviet.jpg" alt="Thiết kế bắt mắt, nhiều màu sắc mới lạ" width="780" height="520"></figure><p>Ta cũng có thể thấy, nút home đã được loại bỏ và chuyển sang cảm biến vân tay với nút nguồn đặt ở cạnh trên của chiếc máy. Điều này đã mang đến cảm giác trải nghiệm rộng lớn và không gian tương tác thoải mái hơn cho người dùng.</p><p>Ngoài ra, năm nay nhà sản xuất đã trang bị nhiều màu sắc trẻ trung và hiện đại như: màu bạc, xanh, hồng và vàng. Từ đó, bạn có thể lựa chọn màu sắc yêu thích và phù hợp với cá tính của bản thân một cách dễ dàng.</p><h3><strong>Màn hình rộng lớn cho trải nghiệm mãn nhãn hơn</strong></h3><p>Những chiếc <a href="https://didongviet.vn/ipad-10-9.html">iPad 10.9-inch Gen 10</a> năm nay đã mang đến cho người dùng những trải nghiệm rộng lớn hơn. Bởi phiên bản này được trang bị màn hình IPS LCD 10.9 inch với độ phân giải 1640 x 2360 pixels cho phép hiển thị hình ảnh rõ ràng, chi tiết và sắc nét.&nbsp;</p>	Apple	t	1	2024-06-23 09:20:53.285	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/ipad-2022-256gb-wifi-didongviet.jpg	11490000	0	11490000	11490000	4	{https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/ipad-2022-256gb-wifi-didongviet.jpg}
29	Apple iPad Pro 11 2021 M1 5G 256GB Like New	apple-ipad-pro-11-2021-m1-5g-256gb-like-new	<h2><strong>Pad Pro 11 inch (2021) 5G: Màn hình chất lượng, tần số quét 120Hz,&nbsp;tính năng HDR10 và&nbsp;kết nối 5G hiện đại</strong></h2><p>iPad Pro 11 inch (2021) 5G&nbsp;sở hữu một thiết kế đẹp cấu hình mạnh, vì thế chiếc iPad này hứa hẹn sẽ thu hút được nhiều sự quan tâm từ người dùng.</p><p><img src="https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021.jpg" alt="Ipad Pro 2021" srcset="https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021.jpg 780w, https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-500x262.jpg 500w, https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-768x402.jpg 768w, https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-150x78.jpg 150w" sizes="100vw" width="780" height="408"></p><h3><strong>iPad Pro 11 inch (2021) 5G có thiết kế đẹp mắt</strong></h3><p><strong>iPad Pro 11 inch (2021) 5G</strong>&nbsp;sở hữu&nbsp;<strong>thiết kế kim loại nguyên khối</strong>, đem lại cảm giác cầm nắm chắc chắn, vừa tay.</p><p>Tương tự trên phiên bản Wifi, iPad Pro 11 inch (2021) 5G cũng có kích thước&nbsp;<strong>247.6 x 178.5 x 5.9 mm</strong>. Tuy nhiên, phiên bản 5G sẽ có trọng lượng nặng hơn một chút so với phiên bản wifi. Cụ thể iPad Pro 11 inch (2021) 5G&nbsp;<strong>nặng 470g</strong>.</p><p><img src="https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-kich-thuoc.jpg" alt="Ipad Pro 2021 Kich Thuoc" srcset="https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-kich-thuoc.jpg 750w, https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-kich-thuoc-500x286.jpg 500w, https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-2021-kich-thuoc-150x86.jpg 150w" sizes="100vw" width="750" height="429"></p><p><i>iPad Pro 11 inch (2021) 5G nặng hơn một chút so với phiên bản Wifi</i></p><p>Vẫn mang một thiết kế cổ điển với b<strong>ộ khung vuông vức, nam tính</strong>. Tuy nhiên, có vẻ màn hình trên chiếc iPad Pro 11 inch (2021) 5G mỏng hơn một chút so với những chiếc máy tiền nhiệm.</p><p>iPad Pro 11 inch (2021) 5G&nbsp;<strong>có hai phiên bản màu sắc</strong>: Xám và Bạc. Trong đó, phiên bản màu bạc được dự đoán là sẽ nhanh chóng chạy hàng tại trường Việt Nam.</p><h3><strong>iPad Pro 11 inch (2021) 5G được trang bị tính năng HDR10 cho khả năng tương phản tốt</strong></h3><p>iPad Pro 11 inch (2021) 5G có&nbsp;<strong>kích thước 11 inch, độ phân giải 1668 x 2388 pixels</strong>&nbsp;cùng tấm nền<strong>&nbsp;Liquid Retina IPS LCD</strong>&nbsp;đem lại khả năng hiển thị chân thực, sống động.</p><p><img src="https://www.techone.vn/wp-content/uploads/2021/05/iPad-Pro-2021-man-hinh-1.jpg" alt="Ipad Pro 2021 Man Hinh" srcset="https://www.techone.vn/wp-content/uploads/2021/05/iPad-Pro-2021-man-hinh-1.jpg 1500w, https://www.techone.vn/wp-content/uploads/2021/05/iPad-Pro-2021-man-hinh-1-500x278.jpg 500w, https://www.techone.vn/wp-content/uploads/2021/05/iPad-Pro-2021-man-hinh-1-768x427.jpg 768w, https://www.techone.vn/wp-content/uploads/2021/05/iPad-Pro-2021-man-hinh-1-150x83.jpg 150w" sizes="100vw" width="1500" height="834"></p><p><i>iPad Pro 11 inch (2021) 5G có chất lượng màn hình tốt</i></p><p>Đặc biệt, iPad Pro 11 inch (2021) 5G còn được trang bị&nbsp;<strong>tính năng HDR10</strong>&nbsp;đem lại chất lượng hiển thị có độ tương phản cao.</p><p>Ngoài ra,&nbsp;<strong>tần số quét màn hình 120Hz</strong>&nbsp;trên chiếc máy giúp đem lại một trải nghiệm thao tác vuốt nhẹ nhàng, nhanh chóng và vô cùng mượt mà.</p><h3><strong>iPad Pro 11 inch (2021) 5G có cấu hình mạnh mẽ</strong></h3><p>iPad Pro 11 inch (2021) 5G được trang bị cấu hình với&nbsp;<strong>con chip Apple M1</strong>&nbsp;mới mẻ. Con chip này được biết sẽ đem lại hiệu năng mạnh mẽ hơn 50% so với phiên bản iPad 2020.</p><p><img src="https://www.techone.vn/wp-content/uploads/2021/05/mua-ipad-pro-2021-o-dau-tai-tp-hcm.jpg" alt="Mua Ipad Pro 2021 O Dau Tai Tp Hcm" srcset="https://www.techone.vn/wp-content/uploads/2021/05/mua-ipad-pro-2021-o-dau-tai-tp-hcm.jpg 780w, https://www.techone.vn/wp-content/uploads/2021/05/mua-ipad-pro-2021-o-dau-tai-tp-hcm-500x333.jpg 500w, https://www.techone.vn/wp-content/uploads/2021/05/mua-ipad-pro-2021-o-dau-tai-tp-hcm-768x512.jpg 768w, https://www.techone.vn/wp-content/uploads/2021/05/mua-ipad-pro-2021-o-dau-tai-tp-hcm-150x100.jpg 150w" sizes="100vw" width="780" height="520"></p><p><i>iPad Pro 11 inch (2021) 5G sở hữu cấu hình với chip M1 mạnh mẽ</i></p><p>iPad Pro 11 inch (2021) 5G sở hữu viên pin khủng dung lượng lên đến&nbsp;<strong>7538 mAh</strong>. Viên pin này dư sức đem lại thời gian sử dụng lên đến 1-2 ngày cho một lần sạc.</p>	Apple	t	1	2024-06-23 09:55:53.753	\N	\N	\N	\N	\N	\N	\N	https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-11-2021_2.jpg	11490000	0	11490000	11490000	15	{https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-11-2021_2.jpg}
18	Củ sạc nhanh Apple iPhone 20W Type-C Chính Hãng	cu-sac-nhanh-apple-iphone-20w-type-c-chinh-hang	<h2><a href="https://didongviet.vn/cu-sac-nhanh-apple-iphone-20w-type-c-chinh-hang"><strong>Củ sạc nhanh Apple iPhone 20W Type-C</strong></a><strong>&nbsp;được thiết kế siêu nhỏ gọn, tinh tế giúp bạn có thể mang đến bất cứ nơi đâu. Chất liệu cao cấp cùng màu trắng nổi bật mang đến sự sang trọng và độ bền bỉ cùng với thời gian.</strong></h2><p>&nbsp;</p><h3><strong>Đặc điểm nổi bật của Củ sạc nhanh Apple iPhone 20W Type-C Chính hãng</strong></h3><p>Củ sạc&nbsp;nhanh Apple iPhone 20W Type-C&nbsp; chính hãng được thiết kế siêu nhỏ gọn, tinh tế giúp bạn có thể mang đến bất cứ nơi đâu. Chất liệu cao cấp cùng màu trắng nổi bật mang đến sự sang trọng và độ bền bỉ cùng với thời gian.</p>	Apple	t	1	2024-06-23 09:34:24.92	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/c/u/cu-sac-nhanh-apple-20w-type-c-didongviet.jpg	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/c/u/cu-sac-nhanh-apple-20w-type-c-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/c/u/cu-sac-nhanh-apple-iphone-20w-mhje3za-didongviet.png}
19	Chuột Apple Magic Mouse Multi-Touch Surface Chính Hãng	chuot-apple-magic-mouse-multi-touch-surface-chinh-hang	<p><strong>Chuột Apple Magic Mouse Multi-Touch Surface&nbsp;&nbsp;</strong>là phiên bản được <strong>phân phối chính thức</strong> bởi&nbsp;<strong>Apple Việt Nam</strong>. Chuột&nbsp;sở hữu thiết kế&nbsp;<strong>tối ưu hóa</strong> cho phép nó lướt <strong>nhẹ nhàng</strong> trên bàn của bạn. Pin bên trong <strong>lâu dài</strong> sẽ cung cấp năng lượng cho Magic Mouse của bạn trong khoảng<strong> một tháng</strong> hoặc hơn giữa các lần sạc. Trang bị tính năng<strong> tự động kết nối</strong> với máy <strong>Mac</strong> thông qua cổng <strong>Lightning</strong>. Ngoài ra,&nbsp;khi quý khách mua hàng sẽ hưởng nhiều ưu đãi, khuyến mãi hấp dẫn khác.</p>	Apple	t	1	2024-06-23 09:35:29.001	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/c/h/chuot-apple-magic-mouse-multi-touch-surface-didongviet_1.jpg	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/c/h/chuot-apple-magic-mouse-multi-touch-surface-didongviet_1.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/c/h/chuot-apple-magic-mouse-multi-touch-surface-mau-den-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/n/g/nghieng-phai-chuot-apple-magic-mouse-multi-touch-surface-didongviet.jpg}
20	Chuột không dây Apple Magic Mouse 2 2021 MK2E3ZA/A	chuot-khong-day-apple-magic-mouse-2-2021-mk2e3zaa	<h2><strong>Apple Magic Mouse 2 2021&nbsp;MK2E3ZA/A -&nbsp;Cung cấp thao tác di có độ chính xác cao, cầm tay thoải mái</strong></h2><p><a href="https://didongviet.vn/chuot-khong-day-apple-magic-mouse-2-2021.html">Apple Magic Mouse 2 2021 MK2E3ZA/A</a>&nbsp;là dòng sản phẩm chuột không dây thế hệ thứ 2 dành cho <a href="https://didongviet.vn/apple-macbook-imac">Mac</a>. Magic Mouse 2 có thiết kế độc đáo, cực kì dễ sử dụng và giúp góc làm việc của người dùng trở nên tối giản hơn.</p><h3><strong>Đặc điểm nổi bật</strong></h3><ul><li>Chuột không dây Apple Magic Mouse 2 là phiên bản nâng cấp đáng giá của Apple với những cải tiến hấp dẫn như: thiết kế đẹp và nhẹ hơn đáng kể giúp người dùng di chuyển dễ dàng và chính xác hơn.</li><li>Công nghệ kết nối Bluetooth 4.0 trên Apple Magic Mouse 2 cho khả năng xử lý hiệu quả và nhanh chóng. Bên cạnh đó đầu thu tín hiệu nhỏ gọn, ổn định và rất nhạy cho thao tác sử dụng chuột vô cùng mượt mà, nhanh chóng và dễ dàng.</li><li>Cổng Lightning bên dưới đáy của chuột&nbsp; Apple Magic Mouse 2 giúp sạc nhanh chóng, chỉ cần 2 phút có thể sử dụng lên đến 9 giờ. Tặng kèm cáp Lightning khi mua chuột cho phép bạn dùng chung với cả iPhone và iPad.</li><li>Bề mặt Multi-Touch trên chuột không dây Apple Magic Mouse 2 dễ dàng thao tác như sang trang web, di chuyển tài liệu,...</li></ul><h3><strong>Thiết kế cao cấp, tiện dụng</strong></h3><p>Apple Magic Mouse 2 2021&nbsp;MK2E3ZA/A&nbsp;mang trong mình thiết kế tối giản với phần khung và thân chuột được làm bằng kim loại mang lại sự cao cấp, sang trọng nhất định. Phần thao tác (bề mặt chuột) được làm bằng nhựa cao cấp, bền bỉ với độ cảm ứng tốt giúp người dùng có thể thao tác nhanh gọn, thoải mái nhất có thể.</p><p>Chuột không dây Apple Magic Mouse 2 2021 cũng được đánh giá cao bởi nó có trọng lượng khá nhẹ, chỉ khoảng 90g, so với Magic Mouse thì chú chuột này đã nhẹ hơn. Mang đến một trải nghiệm mới cho người dùng, không gây đau mỏi khi dùng liên tục trong thời gian dài. Tuy nhiên, đối với những người có bàn tay to thì nên cân nhắc tham khảo thử dòng <a href="https://didongviet.vn/apple-magic-trackpad-2">Apple Magic Trackpad 2</a> để có được trải nghiệm tốt hơn.</p><h3><strong>Khả năng kết nối tốt, thời lượng pin ấn tượng</strong></h3><p>Apple Magic Mouse 2 2021&nbsp;MK2E3ZA/A&nbsp;vì là một thiết bị do Apple phát triển nên việc kết nối với những sản phẩm Apple sẽ cực kỳ ổn định mang lại trải nghiệm vô cùng mượt mà. Việc kết nối khá đơn giản. Người dùng chỉ cần kết nối một lần với thiết bị, những lần sau chuột sẽ tự động nhận thiết bị ấy.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/A54-5G/kha-nang-ket-noi-apple-magic-mouse-2-2021-didongviet.jpg" alt="Khả năng kết nối tốt, thời lượng pin ấn tượng trên Apple Magic Mouse 2 2021" width="780" height="520"></figure><p>Chuột không dây Apple Magic Mouse 2 2021&nbsp;MK2E3ZA/A&nbsp;được trang bị viên pin bền bỉ bên trong, đem đến năng lượng hoạt động cho chuột trong khoảng 1 tháng. Người dùng có thể sử dụng liên tục, không lo xảy ra tình trạng hết pin. Tuy nhiên, Apple không biết vô tình hay cố ý đã trang bị cổng sạc dưới đáy chuột và gây ra sự khó chịu cho người dùng.</p><h3><strong>Thông số kỹ thuật&nbsp;</strong></h3><p>Chiều cao: 0,85 inch (2,16 cm)</p><p>Chiều rộng: 2,25 inch (5,71 cm)</p><p>Độ dày: 4.47 inch (11.35 cm)</p><p>Trọng lượng: 0,22 pound (0,099 kg)</p><p>Kết nối Bluetooth và cảm ứng đa điểm</p><p>Pin : Li-Po 1986 mAH</p>	Apple	t	1	2024-06-23 09:36:49.169	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/products/2023/6/14/1/1689315354333_thumb_magic_mouse_2_didongviet.jpg	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/products/2023/6/14/1/1689315354333_thumb_magic_mouse_2_didongviet.jpg}
21	Bút cảm ứng Apple Pencil 2 Chính Hãng	but-cam-ung-apple-pencil-2-chinh-hang	<h2><strong>Bút cảm ứng Apple Pencil 2 - Thiết kế nhỏ gọn, phản hồi nhanh</strong></h2><p><a href="https://didongviet.vn/but-cam-ung-apple-pencil-2-chinh-hang"><strong>Bút cảm ứng Apple Pencil 2</strong></a> sở hữu thiết kế đẹp cùng những nâng cấp lớn, giúp những thao tác cho việc vẽ, ghi chú và đánh dấu tài liệu một cách nhanh chóng và cực kỳ chính xác.&nbsp;Phù hợp dùng mỗi ngày, hầu hết tất cả mọi người đều có thể sử dụng với mục đích đơn giản nhất là viết lách đến các thao tác phức tạp hơn như vẽ, hội hoạ hay chỉnh sửa photoshop.&nbsp;</p><h3><strong>Thiết kế thon thả, gọn nhẹ</strong></h3><p>Bút cảm ứng Apple Pencil 2 có thiết kế giống như một chiếc bút chì bình thường. Bút cảm ứng có chiều dài 6,53 inch (166 mm), đường kính 0,35 inch (8,9 mm) và trọng lượng 20,7 gram. Apple Pencil 2 mang lại khả năng cầm chắc tay, nhẹ nhàng, linh hoạt khi viết.&nbsp;</p><p>Bút cảm ứng Apple Pencil 2 có bề mặt nhám mờ, mang đến cảm giác thoải mái khi sử dụng. Ngoài ra, thiết bị còn được vát ở vị trí trên thân, giúp nó dính vào iPad Pro, mặt vát này cũng giúp người dùng cầm bút thoải mái và có điểm tựa hơn.</p><h3><strong>Tương thích sạc không dây</strong></h3><p>Apple Pencil 2 sẽ được sạc không dây thông qua kết nối từ tính khi người dùng đính nó vào cạnh của iPad Pro và để hai thiết bị tự động ghép đôi với nhau. Đây là giải pháp tốt hơn hẳn so với phương thức sạc cắm trực tiếp vào cổng Lightning khá kỳ quặc trước đây.&nbsp;</p><p>Ngoài ra, việc cất giữ thiết bị cũng được nâng cao. Apple Pencil 1 không được trang bị vị trí để cất giữ, khi sử dụng xong người dùng không biết phải cất ở nơi nào. Apple Pencil 2 đã được nâng cấp về tính năng đó. Và thiết bị không làm người dùng thất vọng, bằng nam châm, người dùng dễ dàng dán bút vào cạnh của chiếc iPad. Điều này vừa làm tăng độ thẩm mỹ của thiết bị vừa tiện lợi dễ dàng rút ra và gắn vào để sử dụng.</p><h3><strong>Phản hồi nhanh</strong></h3><p>Các phản ứng từ của Apple Pencil 2 rất nhanh, độ trễ hầu như là trông thấy được, cho thấy sự hoàn hảo của điện thoại. Chiếc iPad Pro biết người dùng đang sử dụng ngón tay hay <a href="https://didongviet.vn/phu-kien-apple-chinh-hang"><strong>Apple Pencil</strong></a>. Khi chiếc iPad Pro nhận biết được Apple Pencil, các hệ thống phụ quét tín hiệu đến 240 lần mỗi giây, cho nó hai lần các điểm dữ liệu mà nó thu thập tay của người dùng.</p><p>Người dùng có thể viết và phác họa trên thư email và thậm chí vẽ trực tiếp trong các ứng dụng như Keynote trên bút cảm ứng Apple Pencil 2. Để chụp ảnh màn hình bằng cách nhấn đồng thời sau đó thả nút bên và nút tăng âm lượng, sau đó đánh dấu ảnh bạn vừa chụp</p><h3><strong>Điều khiển cử chỉ&nbsp;</strong></h3><p>Bút cảm ứng Apple Pencil 2 còn được trang bị thao tác điều khiển cử chỉ, cho phép người dùng chạm vào các cạnh bút để chuyển đổi công cụ sử dụng trên màn hình. Ví dụ, trong ứng dụng Notes, người dùng có thể chạm hai lần vào bút để chuyển từ công cụ bút chì sang cục tẩy. Thao tác điều khiển cử chỉ này tất nhiên có thể tùy biến được, do đó người dùng có thể gán nó cho các chức năng khác trong các ứng dụng vẽ khác trên iPad của mình.</p>	Apple	t	1	2024-06-23 09:39:10.584	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/a/p/apple-pencil-2-2022-didongviet.png	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/a/p/apple-pencil-2-2022-didongviet.png,https://cdn-v2.didongviet.vn/files/media/catalog/product/b/u/but-cam-ung-apple-pencil-2_1.jpg}
22	Cáp Apple USB-C sang Lightning (1m) Chính Hãng	cap-apple-usb-c-sang-lightning-1m-chinh-hang	<p><strong>Cáp Apple USB-C Lightning (1m) Chính hãng</strong>&nbsp;có&nbsp;thiết kế nhỏ gọn, trang nhã,&nbsp;chiều dài 1m&nbsp;giúp kết nối thuận tiện, dễ dàng quấn gọn để mang theo.&nbsp;Tương thích với các dòng iPhone</p><p>Cáp sạc Apple Watch 2m&nbsp;là phiên bản được phân phối chính thức bởi Apple Việt Nam, được bảo hành&nbsp;12 tháng</p>	Apple	t	1	2024-06-23 09:41:14.714	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/c/a/cap-apple-usb-c-lightning-1m.png	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/c/a/cap-apple-usb-c-lightning-1m.png,https://cdn-v2.didongviet.vn/files/media/catalog/product/c/a/cap-apple-usb-c-lightning-1m-trang-didongviet.jpg}
23	Bàn phím Smart Keyboard iPad Pro 12.9inch	ban-phim-smart-keyboard-ipad-pro-129inch	<h2><strong>Bàn phím Smart Keyboard iPad Pro 12.9inch - Phản ứng nhạy bén,&nbsp; hành trình phím tốt đem đến cảm giác gõ chữ thoải mái nhất</strong></h2><p><a href="https://didongviet.vn/ban-phim-smart-keyboard-12-9inch"><strong>Bàn phím Smart Keyboard iPad Pro 12.9inch</strong></a> chắc chắn là món phụ kiện xuất sắc nhất dành cho hiện nay. Với nhiều nâng cấp về tính năng như: đèn nền, khả năng điều chỉnh bản lề và bàn phím với cơ chế cắt kéo sẽ biến chiếc iPad Pro thành một công cụ làm việc chuyên nghiệp, đem tới những trải nghiệm hoàn toàn khác biệt cho người dùng.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-Phu-kien-Laptop/ban-phim/cau-truc-ban-phim-smart-keyboard-12-9inch-didongviet.jpg" alt="Bàn phím Smart Keyboard iPad Pro 12.9inch - Phản ứng nhạy bén,&nbsp; hành trình phím tốt đem đến cảm giác gõ chữ thoải mái nhất" width="780" height="520"></figure><h2><strong>Đặc điểm nổi bật</strong></h2><ul><li>Sản xuất với độ hoàn thiện chắc chắn, cơ chế cắt kéo</li><li>Mặt trong trang bị một lớp vải microfiber giúp chống trầy, xước dăm</li><li>Phím có độ nảy tốt, êm ái, nhẹ nhàng nhưng vẫn mang lại độ chính xác cao</li><li>Hỗ trợ Trackpad với cảm ứng đa điểm</li><li>Bản lề với tính linh động cao, tích hợp cổng sạc USB-C</li></ul><h2><strong>Đánh giá bàn phím Smart Keyboard iPad Pro 12.9inch</strong></h2><p>Bàn phím Smart Keyboard thiết kế dành riêng phù hợp với kích thước iPad Pro 12.9inch được nghiên cứu và phát triển bởi Apple. Bàn phím làm từ chất liệu cao cấp, cấu tạo thông minh bảo vệ iPad Pro của bạn khỏi những rủi ro trong quá trình sử dụng rất tốt. Để biết thêm chi tiết sản phẩm, mời các bạn tiếp tục theo dõi bài viết bên dưới nhé.</p><h3><strong>Thiết kế hiện đại với độ hoàn thiện cao</strong></h3><p>Bàn phím Smart Keyboard iPad Pro 12.9inch được thiết kế theo phong cách tối giản nhưng vẫn mang lại những nét hiện đại, tinh tế. Sản phẩm có độ hoàn thiện cực kỳ cao, mặc dù không sử dụng bất kì con ốc nào nhưng vẫn mang lại độ chắc chắn, cứng cáp.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-Phu-kien-Laptop/ban-phim/thiet-ke-ban-phim-smart-keyboard-12-9inch-didongviet.jpg" alt="Thiết kế hiện đại với độ hoàn thiện cao" width="780" height="520"></figure><p>Mặt ngoài của bàn phím Smart Keyboard iPad Pro 12.9inch được làm từ cao su, được phủ thêm một lớp màu tối giúp tăng độ cứng cáp cho sản phẩm. Mặt trong được trang bị một lớp vải microfiber giúp chống trầy, xước dăm cho iPad Pro 12.9inch 2020.</p><h3><strong>Bàn phím với cơ chế cắt kéo, hỗ trợ đèn nền</strong></h3><p>Một trong những cải tiến đáng giá nhất trên bàn phím Smart Keyboard iPad Pro 12.9inch đó là được trang bị bàn phím với cơ chế cắt kéo. Đây là cơ chế được Apple sử dụng trên các dòng Macbook mới nhất của hãng. <a href="https://didongviet.vn/ban-phim-apple"><strong>Bàn phím Apple</strong></a>&nbsp;có hành trình phím 1mm, tuy không quá dài nhưng vẫn mang lại cảm giác gõ khá tốt. Phím có độ nảy tốt, êm ái, nhẹ nhàng nhưng vẫn mang lại độ chính xác cao tạo cảm giác gõ phím khá giống như trên các dòng Macbook hiện tại.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-Phu-kien-Laptop/ban-phim/cam-ung-diem-ban-phim-smart-keyboard-12-9inch-didongviet.jpg" alt="Bàn phím với cơ chế cắt kéo, hỗ trợ đèn nền" width="780" height="520"></figure><p>Bàn phím Smart Keyboard iPad Pro 12.9inch hỗ trợ gần như đầy đủ phím bấm như trên một chiếc laptop bình thường. Ngoài ra, bàn phím còn hỗ trợ đèn nền tự động điều chỉnh độ sáng dựa vào cảm biến trên iPad Pro.</p>	Apple	t	1	2024-06-23 09:42:12.905	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/b/a/ban-phim-smart-keyboard-12-9inch.png	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/b/a/ban-phim-smart-keyboard-12-9inch.png}
24	Bút cảm ứng Apple Pencil 1 Chính Hãng	but-cam-ung-apple-pencil-1-chinh-hang	<h2><strong>Bút cảm ứng Apple Pencil 1- chính hãng - viết cực êm</strong></h2><p>Bút cảm ứng Apple Pencil Gen 1 là một trong những phụ kiện công nghệ độc đáo không thể thiếu của chiếc máy tính bảng iPad Pro. Sản phẩm này mang đến cho người dùng những trải nghiệm cực kỳ thú vị. Cùng Di động Việt tìm hiểu một số tính năng tuyệt vời này nhé.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/hinh-dang-but-apple-pencil-1-didongviet.jpg" alt="bút cảm ứng Apple Pencil 1" width="780" height="520"></figure><h3><strong>Đặc điểm nổi bật của bút cảm ứng Apple Pencil 1</strong></h3><ul><li>Thiết kế nhỏ gọn, nhiều tính năng</li><li>Không có độ trễ, phản hồi cực nhanh</li><li>Dễ phác họa với trang bị cảm ứng cực nhạy</li><li>Sạc nhanh với cổng Lightning</li></ul><h4><strong>Thiết kế nhỏ gọn, nhiều tính năng&nbsp;</strong></h4><p>Nhìn từ bên ngoài, bút cảm ứng Apple Pencil Gen 1 trông khá đơn giản, trông giống như một cây bút truyền thống. Kiểu dáng bút thon dài, trọng lượng siêu nhẹ tạo cho người dùng cảm giác thoải mái, cầm vừa tay khi dùng. Nhưng bên trong thì được Apple đầu tư và chăm chút rất kỹ từ khâu thiết kế đến thiết lập các tính năng rất vượt trội.&nbsp;</p><h4><strong>Không có độ trễ, phản hồi cực nhanh</strong></h4><p>Qua một số khảo sát thì hầu như chiếc bút cảm ứng Apple Pencil Gen 1 được đánh giá rất cao về độ phản ứng. Và độ trễ của chiếc bút này hầu như không thể thấy được, cho thấy được sự hoàn hảo đến mức độ cao của chiếc bút. Các hệ thống của iPad Pro sẽ phụ quét tín hiệu đến 240 lần/s nếu nhận biết được đó là Apple Pencil Gen 1.</p><h4><strong>Dễ phác họa với trang bị cảm ứng cực nhạy</strong></h4><p>Một trong những tính năng gây ấn tượng cho người dùng của chiếc bút cảm ứng Apple Pencil Gen 1 này chính là công nghệ cảm ứng lực nhấn. Người dùng có thể dễ dàng điều chỉnh độ đậm nhạt của nét vẽ. Máy tính bảng Apple iPad sẽ chỉ nhận những nét vẽ từ cây bút này và loại bỏ đi những phần cảm ứng từ tay bạn. Vì vậy khi dùng nó, bạn có thể tha hồ sáng tạo, vẽ vời theo ý mình mà không cần lo lắng bất cứ điều gì. Những tính năng này rất có ích đối với những người họa sĩ, nhà thiết kế…&nbsp;</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/do-nhay-but-apple-pencil-1-didongviet.jpg" alt="Dễ phác họa với trang bị cảm ứng cực nhạy" width="780" height="520"></figure><h4><strong>Sạc nhanh với cổng Lightning</strong></h4><p>Nhằm giúp người dùng dễ dàng sạc pin hoặc cắm trực tiếp vào chiếc iPad Pro để sạc thì Apple đã bố trí cổng kết nối Lightning sạc nhanh ở phần đuôi. Bút có thời lượng sử dụng lên đến 12 giờ cho 1 lần sạc. Nếu như bạn đang có việc gấp hoặc không có nhiều thời gian thì chỉ cần sạc 15 giây là đã đủ cho bạn sử dụng trong vòng nửa giờ.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/pin-but-apple-pencil-1-didongviet.jpg" alt="Sạc nhanh với cổng Lightning" width="780" height="520"></figure><p>&nbsp;</p><h3><strong>Có nên mua Bút cảm ứng Apple Pencil 1 không?</strong></h3><p>Một chiếc bút với thiết kế nhỏ gọn, trẻ trung, hiện đại cùng với những tính năng độc đáo thú vị. Hỗ trợ hết mình cho bạn trong công việc sáng tạo cũng như thư giãn. Không những vậy, nó còn giúp bạn toát lên vẻ sang trọng, đẳng cấp khi bạn cầm chiếc bút Apple Pencil 1. Vậy thì còn ngần ngại gì mà không sở hữu cho mình một chiếc bút “xịn sò” này nhỉ?</p>	Apple	t	1	2024-06-23 09:43:07.111	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/a/p/apple-pencil-1-didongviet_1.png	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/a/p/apple-pencil-1-didongviet_1.png,https://cdn-v2.didongviet.vn/files/media/catalog/product/a/p/apple-pencil-1-didongviet_1.png}
25	Bàn phím Apple Magic Keyboard + Touch ID 2021 MK293 Chính Hãng	ban-phim-apple-magic-keyboard--touch-id-2021-mk293-chinh-hang	<h2><strong>Bàn phím&nbsp;Apple Magic Keyboard Touch ID 2021 - Công nghệ cho phép sử dụng Touch ID&nbsp;tiện dụng</strong></h2><p><a href="https://didongviet.vn/apple-magic-keyboard-touch-id-2021"><strong>Apple Magic Keyboard Touch ID 2021</strong></a> là chiếc bàn phím bluetooth mới nhất vừa được Apple giới thiệu trong buổi ra mắt iMac 2021 M1. Sản phẩm sở hữu đầy đủ các tính năng người dùng cần ở một chiếc bàn phím Apple Magic Keyboard và một Touch ID hỗ trợ cho khả năng bảo mật giúp đăng nhập vào các ứng dụng cá nhân.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-Phu-kien-Laptop/ban-phim/mo-dau-ban-phim-apple-magic-keyboard-touch-id-2021-didongviet.jpg" alt="Bàn phím&nbsp;Apple Magic Keyboard Touch ID 2021 - Công nghệ cho phép sử dụng Touch ID,&nbsp;nhỏ gọn, tiện dụng" width="780" height="520"></figure><h2><strong>Đặc điểm nổi bật&nbsp;</strong></h2><ul><li>Kết nối Bluetooth không dây</li><li>Pin sạc tích hợp</li><li>Thiết kế sang trọng, tinh tế</li><li>Độ giãn cách của các phím và độ rộng tăng cường cho các thao tác gõ phím</li><li>Touch ID được trang bị chức năng bảo mật Secure Enclave&nbsp;giúp tăng cường bảo mật đến mức tối ưu</li><li>Tích hợp khả năng tương thích với thiết bị mang&nbsp;chipset M1</li></ul><h3><strong>Thiết kế tối giản, siêu mỏng gọn dễ dàng mang theo</strong></h3><p>Apple Magic Keyboard Touch ID 2021 có thiết kế vô cùng tối giản với các cạnh bàn phím đã được làm bo cong hơn so với các phiên bản trước. Từng phím bấm và khoảng cách giữa các phím đều được tối ưu hóa nhằm tiết kiệm diện tích tối đa. Không chỉ vậy, sản phẩm còn sở hữu nhiều màu sắc khác nhau cực kỳ ấn tượng, tinh tế, không kém phần sang trọng.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/A54-5G/thiet-ke-apple-magic-keyboard-touch-id-20201.jpg" alt="Thiết kế tối giản, siêu mỏng gọn dễ dàng mang theo" width="780" height="520"></figure><p>Bàn phím Apple Magic Keyboard Touch ID 2021 có kích thước tổng thể là 27.89 x 11.49 x 1.09 cm với trọng lượng chỉ vỏn vẹn 230 gram. Đây là một trong những mẫu bàn phím không dây nhỏ gọn nhất thị trường hiện tại. Điều này giúp người dùng có thể mang <a href="https://didongviet.vn/ban-phim-apple"><strong>bàn phím Apple</strong></a>&nbsp;đi mọi nơi mà không sợ chiếm quá nhiều diện tích trong balo.</p><h3><strong>Kết nối Bluetooth nhanh, tương thích&nbsp;hầu hết các thiết bị của Apple</strong></h3><p>Kết nối Bluetooth trên bàn phím Apple Magic Keyboard Touch ID 2021 được tối ưu hóa để có thể tự động nhận diện và liên kết với các dòng sản phẩm Mac khi đặt gần nhau. Chủ nhân chiếc bàn phím không cần phải thực hiện quá trình nối dây hay cài đặt rườm rà. Quy trình tương tác không dây sẽ giúp bàn làm việc của bạn trở nên gọn gàng hơn, không bị vướng víu bởi cáp kết nối và thoải mái sắp xếp vị trí ngồi một cách đơn giản.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/A54-5G/ket-noi-khong-day-apple-magic-keyboard-touch-id-20201.jpg" alt="Kết nối Bluetooth nhanh chóng, tương thích với hầu hết các thiết bị của Apple" width="780" height="520"></figure><p>Apple Magic Keyboard Touch ID 2021 vì là một thiết bị do Apple phát triển nên việc kết nối với những sản phẩm Apple sẽ cực kỳ ổn định mang lại trải nghiệm vô cùng mượt mà. Sản phẩm&nbsp; đạt độ tương tích tốt nhất về phần mềm với các nền tảng như macOS (từ macOS 11.3 trở về sau), iPadOS (từ iPadOS 14.5 trở đi) và iOS (kể từ bản cập nhật iOS 14.5).</p>	Apple	t	1	2024-06-23 09:43:59.637	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/b/a/ban-phim-apple-magic-keyboard-touch-id-2021-didongviet.jpg	11490000	0	0	0	14	{https://cdn-v2.didongviet.vn/files/media/catalog/product/b/a/ban-phim-apple-magic-keyboard-touch-id-2021-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/b/a/ban-phim-apple-magic-keyboard-touch-id-2021-silver-didongviet_1.jpg}
26	Máy tính bảng iPad 10.9 (2022) Gen 10 64GB 5G – Like New	may-tinh-bang-ipad-109-2022-gen-10-64gb-5g---like-new	<p><strong>Máy tính bảng&nbsp;iPad 10.9 inch 2022 5G – Nâng cao hiệu suất làm việc</strong></p><p>iPad 10.9 inch 2022 5G là một bước tiến mạnh mẽ của Apple trong việc đẩy mạnh về hiệu năng. Phiên bản&nbsp;<strong>iPad&nbsp;gen 10</strong>&nbsp;này sẽ mang đến cho người dùng những trải nghiệm về kết nối, về khả năng chụp hình mà chưa từng thấy ở những mẫu iPad trước đó.<br><img src="https://genk.mediacdn.vn/139269124445442048/2022/10/19/6170407ipadgen105-1666154899625-16661548996861199262542-1666164270333-166616427078916525627.jpg" alt="Sốc với giá bán iPad Gen 10: Apple đang toan tính điều gì?" width="2000" height="1238"><br>&nbsp;</p><p><strong>Thiết kế ấn tượng với màn hình được mở rộng</strong></p><p>Nếu iPad Air luôn gắn liền với những thiết kế nịnh mắt thì lần này, iPad 10.9 inch 2022 5G sẽ mang đến một diện mạo hoàn toàn mới với vẻ đẹp sắc sảo. Vẫn giữ nguyên lối thiết kế tối giản đặc trưng, nhưng Apple đã tối ưu các viền màn hình giúp cho chúng có thêm nhiều không gian hiển thị, cảm giác như cạnh viền siêu mỏng tràn sát mép máy.</p><p>Màn hình sở hữu kích thước lớn 10.9 inch với Liquid Retina HD và độ phân giải 2360 x 1640 Pixels mang đến khả năng hiển thị vô cùng sắc nét và chân thực. Cạnh đó, không giống như những phiên bản trước, lần này hãng đã bỏ đi nút Home huyền thoại. Thay vào đó là kết hợp áp dụng cảm biến Touch ID vào trong nút nguồn được đặt ở cạnh bên của máy. Nhờ vậy mà việc mở khóa cũng nhanh chóng, dễ dàng hơn và còn đảm bảo được sự bảo mật, an toàn cho người dùng.</p><p><strong>Sở hữu sức mạnh hiệu năng đặc biệt</strong></p><p>iPad 10.9 inch 2022 5G được trang bị bộ vi xử lý Apple A14 Bionic – chip 4 nhân có tốc độ vận hành tốt nhất và nhanh hơn nhiều so với thế hệ trước đó. Cùng với đó chính là bộ nhớ trong 64 GB hỗ trợ tốt cho nhiều ứng dụng chỉnh sửa hình ảnh, nhiều tác vụ thực hiện cùng lúc và thỏa thích chơi game chiến hạng nhẹ.</p><p><strong>Camera xịn sò tái hiện rõ những chi tiết</strong></p><p>Sự trang bị của camera chính mặt sau 12 MP đã mang đến khả năng chụp ảnh xịn sò cùng chức năng quay video 4K xuất sắc. Kết hợp cùng khả năng xử lý mạnh mẽ của chip mà chất lượng và khả năng xử lý tín hiệu hình ảnh được nâng cao, cho ra những hình ảnh ấn tượng. Ngoài ra, với một số tính năng được kết hợp mà những bức ảnh luôn được chỉnh sửa hậu kỳ tốt cùng các chi tiết cũng được hiển thị rõ ràng hơn.</p><p>Camera selfie mặt trước cũng được trang bị độ phân giải 12 MP không những mang đến những bức ảnh selfie tuyệt vời mà còn giúp tối ưu trải nghiệm với cuộc gọi video call. Với chế độ gọi điện video, hệ thống camera cũng sẽ tự động căn chỉnh giúp chủ thể luôn được giữ ngay trung tâm của khung hình, đồng thời sẽ tự động điều chỉnh kích cỡ, góc quay khi có nhiều người cùng xuất hiện trong khung hình.</p><p><strong>Khả năng kết nối mạng 5G và WiFi 6 tiện lợi</strong></p><p>Với sự phát triển của công nghệ kết nối 5G, Apple không bao giờ để cho các sản phẩm của mình bị tụt hậu phía sau. Bằng chứng là iPad 10.9 inch 2022 Wifi + 5G 64GB đã được trang bị kết nối Wifi + 5G giúp cho người dùng có thể thỏa sức tận hưởng tốc độ mạng di động cực kỳ ấn tượng. Đồng thời, WiFi 6 cũng sẽ giúp cho mọi kết nối trở nên tiện lợi hơn, quá trình tải xuống, lướt web, chơi game hay xem video của người dùng cũng sẽ nhanh hơn bao giờ hết.</p><p>Thiết bị cũng được hỗ trợ cổng tương tác USB-C cải thiện tốc độ sạc và có khả năng truyền tải gấp 2 lần so với những phiên bản trước đó. Chính nhờ thế mà quá trình truyền tải ảnh và video hoặc kết nối với các thiết bị khác cũng trở nên nhanh chóng, dễ dàng hơn. Cạnh đó, với mức dung lượng pin được trang bị, iPad cũng sẽ mang đến 9-10 giờ sử dụng cho người dùng.</p>	Apple	t	1	2024-06-23 09:48:21.32	\N	\N	\N	\N	\N	\N	\N	https://www.techone.vn/wp-content/uploads/2022/10/ipad-2022-256gb-4g-mau-hong.jpg	11490000	0	11490000	11490000	15	{https://www.techone.vn/wp-content/uploads/2022/10/ipad-2022-256gb-4g-mau-hong.jpg,https://www.techone.vn/wp-content/uploads/2022/10/ipad-2022-256gb-4g-mau-bac.jpg}
27	iPad Pro 11 2021 M1 WiFi 256GB I Like New	ipad-pro-11-2021-m1-wifi-256gb-i-like-new	<p><strong>iPad Pro 11 inch 2021 Wifi mới đã chính thức được ra mắt và Apple đã giữ đúng lời hứa khi tuyên bố rằng sẽ nâng cấp chiếc máy tính bảng thế hệ mới của mình ưu việt hơn so với trước đây bằng cách trang bị những công nghệ mới tiên tiến và hiện đại, đặc biệt là con chip M1 vô cùng mạnh mẽ. Hãy cùng xem Apple đã mang đến những gì thú vị trên thiết bị “mới ra lò” này nhé!</strong></p><h3><strong>Giữ nguyên thiết kế quen thuộc với kiểu dáng vuông vức, sang trọng</strong></h3><p>Thiết kế màn hình của iPad Pro 11 inch 2021 Wifi không có nhiều sự khác biệt so với “người anh tiền nhiệm” iPad Pro 2020 của mình. Với phiên bản này, iPad Pro 2021 sở hữu kích thước màn hình chuẩn 11 inch và vẫn được trang bị màn hình LCD truyền thống. Bên cạnh đó, màn hình của thiết bị còn được phủ một lớp chống hắt sáng, hạn chế tối đa việc lưu lại dấu vân tay.</p><p>Là một thiết bị đề cao tính di động thế nhưng iPad Pro 11 2021 vẫn mang đến cho người dùng những trải nghiệm hình ảnh cao cấp hàng đầu hiện nay. Màn hình Liquid Retina không chỉ mang lại chất lượng hiển thị tuyệt đẹp, sắc nét một cách đáng kinh ngạc mà còn được trang bị những công nghệ vô cùng hiện đại. Công nghệ True Tone và dải màu rộng P3 hiển thị màu sắc sinh động, chân thực như trong cuộc sống thường ngày. Màn hình với tần số quét 120Hz kết hợp với công nghệ ProMotion giúp mọi thao tác, chuyển cảnh trên màn hình trở nên nhạy bén hơn bao giờ hết, mọi thứ đều diễn ra một cách vô cùng mượt mà và hấp dẫn.</p><p><img src="https://file.hstatic.net/1000063620/file/ipad-pro-11-icnh-2021-wifi-hinh-anh1_3868216216444377bf8b9e4c4f49e85e.jpg" alt="iPad Pro M1 11 inch Wifi ( 2021 ) - Chính Hãng VN/A ( Đặt Hàng )" width="800" height="446"></p><h3><strong>Sự xuất hiện của con chip M1 cực “đỉnh”</strong></h3><p>iPad Pro 11 inch 2021 Wifi được Apple vô cùng “ưu ái” khi trang bị chipset M1 có sức mạnh ưu việt nhất hiện nay, điều mà người dùng chỉ có thể tìm thấy trên thế hệ MacBook M1 2020.</p><p>Chipset hỗ trợ một CPU 8 lõi, một GPU 8 lõi với bộ nhớ được tích hợp, mang đến khả năng truy cập bộ nhớ nhanh hơn gấp đôi, hiệu suất CPU nhanh hơn 50% và đồ họa nhanh hơn 40% so với những thế hệ iPad Pro trước đó. Những nâng cấp này giúp thiết bị thực hiện những công việc chỉnh sửa video 4K và thiết kế 3D được tốt hơn.</p><p>Bên cạnh đó, iPad Pro 11 inch 2021 còn được trang bị RAM chạm mức 16GB. Và người dùng&nbsp;sẽ còn nhận được nhiều hơn như vậy nếu lựa chọn phiên bản có dung lượng bộ nhớ trong 1TB hoặc 2TB, trong khi những phiên bản khác có RAM 8GB. Ngoài ra, iPad Pro 11 inch 2021 còn có thêm một phiên bản di động hỗ trợ 5G, bao gồm mmWave ở thị trường Mỹ, có khả năng kết nối và truyền tải đạt tốc độ lên đến 3,5Gb/giây.</p><p><img src="https://file.hstatic.net/1000063620/file/ipad-pro-11-icnh-2021-wifi-hinh-anh2_fc9c3244d10f4febb56db7deb9135ee4.jpg" alt="iPad Pro M1 11 inch Wifi ( 2021 ) - Chính Hãng VN/A ( Đặt Hàng )" width="800" height="450"></p><h3><strong>Cụm camera 12MP cho trải nghiệm chụp ảnh bằng tablet vô cùng ấn tượng</strong></h3><p>iPad Pro 11 inch 2021 sở hữu một camera trước có độ phân giải cao 12MP, đặc biệt là góc siêu rộng lên đến 122 độ. Giờ đây những cuộc gọi FaceTime sẽ trở nên hoàn hảo hơn với độ sắc nét cao và khung hình rộng. Không những vậy, tính năng Center Stage giúp gương mặt của người dùng luôn nằm ở trung tâm của khung hình khi thực hiện cuộc gọi video. Ngay cả khi có nhiều hơn một người trong khung hình, thiết bị cũng có thể cân chỉnh một cách khéo léo để có được góc nhìn tốt nhất. Ngoài ra, ống kính camera này cũng hỗ trợ tính năng TrueDepth, giúp mở khóa thiết bị bằng nhận diện khuôn mặt một cách an toàn.</p><p>Trên mặt lưng phía sau của thiết bị là hệ thống camera chuyên nghiệp bao gồm một camera chính 12MP, một camera góc siêu rộng 10MP và cảm biến LiDAR. Với bộ xử lý hình ảnh ISP mạnh mẽ hơn trên con chip M1, đây là lần đầu tiên iPad Pro hỗ trợ tính năng Smart HDR 3, cho phép chụp ảnh hoàn hảo ngay cả trong điều kiện ánh sáng phức tạp. Trong khi đó, cảm biến LiDAR sẽ làm tốt nhiệm vụ của mình khi hỗ trợ trong những trải nghiệm công nghệ thực tế tăng cường AR, đồng thời hỗ trợ lấy nét khi chụp ảnh cũng như quay video trong điều kiện thiếu sáng.</p><p><img src="https://file.hstatic.net/1000063620/file/ipad-pro-11-icnh-2021-wifi-hinh-anh3_e4223681a61243c7b663b6852835510f.jpg" alt="iPad Pro M1 11 inch Wifi ( 2021 ) - Chính Hãng VN/A ( Đặt Hàng )" width="800" height="450"></p><h3><strong>Hệ thống loa ngoài Dolby Atmos đỉnh cao</strong></h3><p>Trên iPad Pro 11 inch 2021được trang bị tới 5 micro với chất lượng phòng thu, ghi lại âm thanh một cách rõ nét khi người dùng ghi âm, quay video, thực hiện gọi FaceTime… Đồng thời khả năng phát lại cũng rất đáng nể nhờ hệ thống 4 loa ngoài, mang đến âm thanh vòm ảo và hỗ trợ chất lượng Dolby Atmos cao cấp. Dù là trong công việc hay giải trí, chất lượng âm thanh sống động của iPad Pro 11 inch 2021 cũng khiến mọi thứ trở nên thú vị hơn rất nhiều.</p><h3><strong>Cổng kết nối Thunderbolt mạnh mẽ và đa năng</strong></h3><p>iPad Pro 11 inch 2021 được trang bị cổng kết nối mạnh mẽ và đa năng bậc nhất hiện nay, đó chính là cổng Thunderbolt dưới giao thức USB-C. Bên cạnh tốc độ truyền tải dữ liệu lên đến 40Gb/s, cổng Thunderbolt còn cho phép người dùng kết nối thiết bị với nhiều phụ kiện khác, kể cả xuất ra màn hình lớn. iPad Pro 11 inch 2021 có thể xuất hình ảnh với độ phân giải lên đến 6K, giúp người dùng làm việc một cách trực quan và chuyên nghiệp hơn.</p><p><img src="https://file.hstatic.net/1000063620/file/ipad-pro-11-icnh-2021-wifi-hinh-anh4_735536fbd5d64e12a2bc42b1b2c261b5.jpg" alt="iPad Pro M1 11 inch Wifi ( 2021 ) - Chính Hãng VN/A ( Đặt Hàng )" width="800" height="450"></p><h3><strong>Đi kèm Magic Keyboard màu sắc mới toanh</strong></h3><p>iPad Pro 11 inch 2021 Wifi được hỗ trợ bàn phím Magic Keyboard với sự thay đổi về mặt màu sắc. Lần ra mắt này, Apple đã mang đến bàn phím Magic với phiên bản màu trắng. Tuy nhiên, thiết bị sẽ không được hỗ trợ sạc Magsafe đi kèm khi mua, và cũng sẽ không hỗ trợ phiên bản mới của Apple Pencil. iPad Pro 11 inch 2021 Wifi sẽ tái sử dụng với Apple Pencil 2, cho phép người dùng viết, vẽ, ghi chú và đánh dấu tài liệu.</p>	Apple	t	1	2024-06-23 09:51:03.506	\N	\N	\N	\N	\N	\N	\N	https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-11-2021_2.jpg	11490000	0	11490000	11490000	15	{https://www.techone.vn/wp-content/uploads/2021/05/ipad-pro-11-2021_2.jpg}
28	iPad Gen 7 10.2 inch 2019 Like New	ipad-gen-7-102-inch-2019-like-new	<h2><strong>iPad Gen 7 10.2 inch 2019&nbsp;– Tablet màn hình lớn hơn trải nghiệm tốt hơn</strong></h2><p><i>Sau sự thành công của iPad 9.7&nbsp;thì Apple chuẩn bị cho ra mắt&nbsp;<strong>iPad Gen 7</strong> với nhiều nâng cấp mạnh mẽ về thiết kế cũng như cấu hình. Apple hứa hẹn sẽ mang tới trải nghiệm tốt nhất cho người dùng với chiếc iPad này, điều đặc biệt là theo như thông tin tiết lộ mức giá bán được cho là khá mềm cực kỳ hấp dẫn phải không nào.&nbsp;</i></p><h3><strong>Khung nhôm nguyên khối cứng cáp, mỏng 0.7mm</strong></h3><p>Về mặt thiết kế, mẫu&nbsp;iPad 10.2 inch&nbsp;không có nhiều điểm mới so với các dòng iPad tiền nhiệm, tuy nhiên phần khung của máy được làm từ kim loại nhôm tái chế để thân thiện hơn với môi trường. Các chi tiết máy được hoàn thiện rất tỷ mỷ và chau chuốt, các góc cạnh được bo rất tinh tế mang lại sử sang trọng và đẳng cấp cho chiếc iPad này.</p><p>Chiếc iPad này vô cùng mọng và nhẹ khi mỏng 0.7 cm và chỉ nặng 483g cho khả năng bỏ vừa nhiều loại túi hiện nay, cùng theo chân người dùng đến bất cứ nơi đâu.</p><h3><strong>Màn hình 10.2 inch cho hình ảnh sống động</strong></h3><p>Màn hình trên chiếc iPad 10.2 có kích thước 10.2 inch lớn hơn hẳn so với đàn anh tiền nhiệm iPad 9. và cũng mỏn hơn nhiều.Chính điều đó làm thiết kế tổng thể máy trở nên khá gọn gàng khi sử dụn. Điểm đáng chú ý nhất trên thế hệ iPad mới phải kể tới việc trang bịtấm nền Retina&nbsp;với khả năng hiển thị vô cùng sinh động, vốn chỉ có trên các dòng&nbsp;<strong>iPad Pro</strong>&nbsp;trước đây.</p><p>Với màn hình được nâng cấp lớn hơn này, người dùng sẽ có những phút giây tuyệt vời nhất khi xem phím, đọc báo. Chưa dừng lại ở đấy Camera 8MP kết hợp với màn hình lớn sẽ cho bạn những khung hình đẹp nhất có thể.</p><h3><strong>Vi xử lý&nbsp;Apple A10 Fusion&nbsp;cho&nbsp;hiệu năng ấn tượng</strong></h3><p><strong>iPad 2019</strong>&nbsp;được Apple trang bị bộ vi xử lý&nbsp;Apple A10 Fusion cho hiệu năng ấn tượng mà theo Apple nhấn mạnh là “mạnh gấp đôi” so với các mẫu máy PC trên thị trường hiện nay. Ram 3 GB cho khả năng xử lý các đa nhiệm cực kì tốt và tốc độ xử lý cực kì nhanh chóng.</p><p>Với cấu hình này, bạn hoàn toàn có những trải nghiệm tốt ở thời điểm hiện nay. Chẳng có một thể loại game nặng hay một đa nhiệm nào có thể làm khó bạn bởi sự mạnh mẽ mà Apple trang bị cho chiếc iPad Gen 7.</p><h3><strong>Bộ nhớ 32GB cho khả năng lưu trữ dữ liệu lớn</strong></h3><p>Vấn đề lưu trữ dữ liệu trên các dòng iPad luôn là một vấn đề nan giải, để giải quyết bài toán khó này “Táo khuyết ”đã trang bị cho đứa con cưng của mình bộ nhớ lên tới 32GB cho khả năng lưu trữ lớn, ấn tượng. Người dùng có thể thỏa mái cài đặt ứng dụng lưu trữ hình ảnh mà không sợ bộ nhớ bị đầy như các dòng iPad trước đây nữa.</p><p>Nếu bộ nhớ 32GB chưa đủ làm bạn hài lòng, thì đừng lo Apple đã tinh tế hơn khi còn cho ra mắt&nbsp;<strong>iPad Gen 7</strong>&nbsp;với bộ nhớ 128 GB cho khả năng lưu trữ khủng. Bên cạnh đó hệ điều hành iOS 13 sẽ được ra mắt trong thời gian tới khiến chiếc iPad này sẽ lại như “hổ mọc thêm cánh”.</p><h3><strong>Tương thích smart-keyboard Apple, công nghệ mạng không dây LTE gigabit</strong></h3><p>Không chỉ có cấu hình và thiết kế được nâng cấp&nbsp;iPad 10.2&nbsp;còn tương thích với Apple Pencil và bàn phím smart-keyboard của Apple. Thiết bị được kỳ vọng là vô cùng phù hợp với học sinh, sinh viên hay các nhân viên văn phòng nhờ trang bị nhiều tính năng với mức giá hấp dẫn.</p><p>Bên cạnh đó, Apple đã tích hợp công nghệ mạng không dây LTE gigabit trên dòng sản phẩm của mình. Sản phẩm vẫn sẽ chỉ sử dụng cổng Lightning cơ bản thay vì USB-C như trên iPad Pro</p>	Apple	t	1	2024-06-23 09:54:35.596	\N	\N	\N	\N	\N	\N	\N	https://techone.vn/wp-content/uploads/2024/03/apple-ipad-10-2-2019-wi-fi-32gb-1_2.webp	11490000	0	11490000	11490000	15	{https://techone.vn/wp-content/uploads/2024/03/apple-ipad-10-2-2019-wi-fi-32gb-1_2.webp,https://www.techone.vn/wp-content/uploads/2024/03/apple-ipad-10-2-2019-wi-fi-32gb-3_2.webp}
30	iPad 10.2 (2021) Gen 9 64GB Wifi Like New	ipad-102-2021-gen-9-64gb-wifi-like-new	<p>iPad&nbsp;9 ra mắt và đây tiếp tục là thiết bị dành cho nhu cầu học tập và giải trí khi trang bị A13 Bionic (nâng cấp từ A12) cũng như Apple vẫn sử dụng thiết kế cũ với phím home và màn hình 10.2 cũng như sử dụng kèm với Smart Keyboard và Apple Pencil 1.</p><p>&nbsp;</p><p>iPad 9 hỗ trợ con chip A13 cho hiệu năng CPU cao hơn 30% và GPU mạnh hơn 20% so với iPad 8, đặc biệt Apple cho rằng iPad mới cũng nhanh hơn 6 lần so với các tablet android khác. Apple nhấn mạnh vào hiệu năng cho phép sử dụng các app sáng tạo, vẽ, cũng như chơi game, soạn thảo văn bản,…</p><p>&nbsp;</p><p>Camera trước 12MP ultrawide hỗ trợ Center Stage khi camera sẽ di chuyển theo người đang gọi FaceTime nhờ dựa vào Neural Engine trên A13. Center Stage hỗ trợ khi có 2 người trong khung hình và có thể dùng khi iPad xoay ngang và dọc. Center Stage cũng hỗ trợ cho các gọi video bên ngoài chẳng hạn như zoom chẳng hạn<br>&nbsp;</p><p>Camera sau thì có độ phân giải 8MP f/2.4Với việc trang bị Smart Connector mà iPad vẫn tiếp tục sử dụng Smart Keyboard cũng như Apple Pencil – tối ưu “combo” dành cho sử dụng học tập và làm việc, đặc biệt những ai làm việc trong lĩnh vực sáng tạo.</p>	Apple	t	1	2024-06-23 09:59:20.887	\N	\N	\N	\N	\N	\N	\N		11490000	0	11490000	11490000	15	{https://www.techone.vn/wp-content/uploads/2021/09/e2798127-d2fb-4e6c-8b29-013b6f6377d6.07c31dee737c1164e1a2263fe50c88f9.jpeg,https://www.techone.vn/wp-content/uploads/2021/09/bb2bb6b8-7824-419c-8d3c-e4da96dd8ef3.fdf82267d3de61f9f9039d596ea86bba.jpeg}
31	iPhone 14 Pro	iphone-14-pro	<h2><strong>iPhone 14 Pro 256GB - Chiếc smartphone “hot” nhất trong thị trường điện thoại hiện nay</strong></h2><p><a href="https://didongviet.vn/dien-thoai/iphone-14-pro-256gb.html"><i><strong>iPhone 14 Pro 256GB</strong></i></a> đã được trình làng vào năm 2022 và không thể nào phủ nhận độ “hot” mà nó đã tạo ra đối với người dùng thởi điểm đó. Chắc hẳn không ít người tò mò về hiệu năng cũng như thiết kế của chiếc smartphone này. Nếu như bạn muốn giải quyết những thắc mắc đó thì đừng bỏ lỡ bài đánh giá chi tiết dưới đây nhé.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/mo-dau-iphone-14-pro-didongviet.jpg" alt="iPhone 14 Pro 256GB - Chiếc smartphone “hot” nhất trong thị trường điện thoại hiện nay" width="780" height="520"></figure><h3><strong>Hiệu năng hoạt động mạnh mẽ với chip thế hệ mới Apple A16 Bionic</strong></h3><p><a href="https://didongviet.vn/iphone-14.html"><i><strong>iPhone 14 Pro</strong></i> </a>được nhà Apple trang bị cho con chip hoàn toàn mới mang tên Apple A16 Bionic. Đây là con chip mới nhất của nhà Apple và có hiệu năng hoạt động mạnh mẽ khi được sản xuất trên tiến trình 4nm. Apple A16 Bionic không những có hiệu năng hoạt động mạnh hơn mà còn tiết kiệm điện năng hơn so với con chip Apple 15 Bionic. Chip này cho phép người dùng thực hiện đa nhiệm tác vụ một cách nhanh chóng và trơn tru.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/cau-hinh-iphone-14-pro-didongviet.jpg" alt="Hiệu năng hoạt động mạnh mẽ với chip thế hệ mới Apple A16 Bionic" width="780" height="520"></figure><p>Bên cạnh đó, iPhone 14 Pro 256GB còn được trang bị chip đồ họa Apple GPU 7 nhân, bạn có thể dễ dàng thực hiện các tác vụ liên quan đến đồ họa, thậm chí có thể chỉnh sửa và sản xuất ra các video ngay trên chiếc smartphone của mình.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/hieu-nang-iphone-14-pro-didongviet.jpg" alt="dung lượng 6GB RAM, iPhone 14 Pro 256GB mang đến cho người dùng khả năng hoạt động đa tác vụ cùng một lúc, không lo hiện tượng giật, đứng, đơ điện thoại." width="780" height="520"></figure><p>Với dung lượng 6GB RAM, iPhone 14 Pro 256GB mang đến cho người dùng khả năng hoạt động đa tác vụ cùng một lúc, không lo hiện tượng giật, đứng, đơ điện thoại.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/ve-dep-iphone-14-pro-didongviet.jpg" alt="Bộ nhớ trong 256GB" width="780" height="520"></figure><p>Ngoài ra, người dùng cũng có một không gian lưu trữ rộng lớn nhờ máy được trang bị bộ nhớ trong lên đến 256GB, với bộ nhớ này bạn có thể thoải thích lưu những hình ảnh, khoảnh khắc đáng nhớ, những thước phim cũng như tài liệu hỗ trợ cho việc học tập và làm việc của mình.</p><h3><strong>Bộ ba camera cho những hình ảnh và thước phim huyền ảo</strong></h3><p>Hẳn những ai là iFan thì luôn bị iPhone mê hoặc bởi tính năng chụp ảnh siêu nét và chất lượng. iPhone 14 Pro 256GB được trang bị bộ 3 camera với độ phân giải 12MP mang đến cho người dùng những hình ảnh vô cùng sắc nét, chân thật. Bộ lọc màu được trang bị sản trên máy mang lại những bức ảnh với màu sắc tươi tắn. Bạn có thể post ngay lên mạng xã hội sau khi chụp mà không cần thông qua chỉnh sửa.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/bo-3-camera-iphone-14-pro-didongviet.jpg" alt="Bộ ba camera cho những hình ảnh và thước phim huyền ảo" width="780" height="520"></figure><p>Bên cạnh việc cho ra những bức ảnh đẹp thì iPhone 14 Pro 256GB còn có khả năng quay phim với chế độ điện ảnh Cinematic. Cho người dùng những thước phim chuyên nghiệp, huyền ảo, tự tin sáng tạo mọi lúc mọi nơi.</p>	Apple	t	1	2024-06-23 10:09:39.602	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/c/a/cac-mau-sac-iphone-14-pro-14-pro-max-didongviet_1.png	11490000	0	11490000	11490000	16	{https://cdn-v2.didongviet.vn/files/media/catalog/product/c/a/cac-mau-sac-iphone-14-pro-14-pro-max-didongviet_1.png,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-13-pro-256gb-didongviet_1.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-13-pro-256gb-mau-tim-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-13-pro-256gb-mau-bac-didongviet.jpg}
32	iPhone 14	iphone-14	<h2><strong>iPhone 14 Pro 256GB - Chiếc smartphone “hot” nhất trong thị trường điện thoại hiện nay</strong></h2><p><a href="https://didongviet.vn/dien-thoai/iphone-14-pro-256gb.html"><i><strong>iPhone 14 Pro 256GB</strong></i></a> đã được trình làng vào năm 2022 và không thể nào phủ nhận độ “hot” mà nó đã tạo ra đối với người dùng thởi điểm đó. Chắc hẳn không ít người tò mò về hiệu năng cũng như thiết kế của chiếc smartphone này. Nếu như bạn muốn giải quyết những thắc mắc đó thì đừng bỏ lỡ bài đánh giá chi tiết dưới đây nhé.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/mo-dau-iphone-14-pro-didongviet.jpg" alt="iPhone 14 Pro 256GB - Chiếc smartphone “hot” nhất trong thị trường điện thoại hiện nay" width="780" height="520"></figure><h3><strong>Hiệu năng hoạt động mạnh mẽ với chip thế hệ mới Apple A16 Bionic</strong></h3><p><a href="https://didongviet.vn/iphone-14.html"><i><strong>iPhone 14 Pro</strong></i> </a>được nhà Apple trang bị cho con chip hoàn toàn mới mang tên Apple A16 Bionic. Đây là con chip mới nhất của nhà Apple và có hiệu năng hoạt động mạnh mẽ khi được sản xuất trên tiến trình 4nm. Apple A16 Bionic không những có hiệu năng hoạt động mạnh hơn mà còn tiết kiệm điện năng hơn so với con chip Apple 15 Bionic. Chip này cho phép người dùng thực hiện đa nhiệm tác vụ một cách nhanh chóng và trơn tru.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/cau-hinh-iphone-14-pro-didongviet.jpg" alt="Hiệu năng hoạt động mạnh mẽ với chip thế hệ mới Apple A16 Bionic" width="780" height="520"></figure><p>Bên cạnh đó, iPhone 14 Pro 256GB còn được trang bị chip đồ họa Apple GPU 7 nhân, bạn có thể dễ dàng thực hiện các tác vụ liên quan đến đồ họa, thậm chí có thể chỉnh sửa và sản xuất ra các video ngay trên chiếc smartphone của mình.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/hieu-nang-iphone-14-pro-didongviet.jpg" alt="dung lượng 6GB RAM, iPhone 14 Pro 256GB mang đến cho người dùng khả năng hoạt động đa tác vụ cùng một lúc, không lo hiện tượng giật, đứng, đơ điện thoại." width="780" height="520"></figure><p>Với dung lượng 6GB RAM, iPhone 14 Pro 256GB mang đến cho người dùng khả năng hoạt động đa tác vụ cùng một lúc, không lo hiện tượng giật, đứng, đơ điện thoại.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/A-iphone-14/iPhone-14-pro/ve-dep-iphone-14-pro-didongviet.jpg" alt="Bộ nhớ trong 256GB" width="780" height="520"></figure><p>Ngoài ra, người dùng cũng có một không gian lưu trữ rộng lớn nhờ máy được trang bị bộ nhớ trong lên đến 256GB, với bộ nhớ này bạn có thể thoải thích lưu những hình ảnh, khoảnh khắc đáng nhớ, những thước phim cũng như tài liệu hỗ trợ cho việc học tập và làm việc của mình.</p>	Apple	t	1	2024-06-23 10:19:25.8	\N	\N	\N	\N	\N	\N	\N		11490000	0	11490000	11490000	16	{https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-128gb-mau-trang-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-128gb-mau-xanh-didongviet.jpg}
33	iPhone 14 Plus	iphone-14-plus	<h2><strong>iPhone 14 Plus 128GB - Chiếc iPhone hoàn toàn mới và đáng mong chờ nhất năm 2022</strong></h2><p><a href="https://didongviet.vn/dien-thoai/iphone-14-plus-128gb.html"><strong>iPhone 14 Plus 128GB</strong></a> đã được Apple cho ra mắt vào năm 2022 với diện mạo vô cùng xuất sắc cùng với những tính năng mới lạ.&nbsp; Ở thời điểm đó nếu những ai theo dõi về dòng sản phẩm của iPhone thì đã biết năm 2022, iPhone 14 Plus là sản phẩm với cái tên hoàn toàn khác so với các dòng tiền nhiệm iPhone 13 mini, iPhone 13 Pro. Cùng xem những đánh giá dưới đây để xem sản phẩm này có gì khác biệt so với những dòng khác nhé.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/hinh-dang-iphone-14-plus-128gb-didongviet.jpg" alt="iPhone 14 Plus 128GB - Chiếc iPhone hoàn toàn mới và đáng mong chờ nhất năm 2022" width="780" height="520"></figure><h3><strong>Màn hình rộng 6.7 inches cùng với tần số quét 60Hz</strong></h3><p>Với những ai thích sử dụng iPhone với màn hình rộng nhưng vẫn muốn có mức giá vừa phải thì <a href="https://didongviet.vn/iphone-14.html"><strong>iPhone 14 Plus</strong></a> là một lựa chọn phù hợp cho bạn. Bởi ở phiên bản mới này của năm 2022, nhà Apple đã trang bị cho thiết bị màn hình rộng lên đến 6.7 inches cho phép người dùng trải nghiệm chìm đắm.</p><p>Sở hữu tấm nền OLED cùng với độ phân giải 1170 x 2532 Pixels mang đến khả năng hiển thị sắc nét, rõ ràng đến từng chi tiết dù bạn đang ở môi trường có điều kiện ánh sáng tốt hay xấu.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/man-hinh-iphone-14-plus-128gb-didongviet.jpg" alt="Màn hình rộng 6.7 inches cùng với tần số quét 120Hz" width="780" height="520"></figure><p>Thiết bị có khả năng tự điều chỉnh tần số quét phù hợp với độ sáng và nội dung hiển thị cho người dùng. Nhờ đó có thể vừa tiết kiệm được dung lượng pin tối đa đồng thời không làm khó chịu cảm giác trải nghiệm của người dùng.</p><p>Ngoài ra, màn hình còn được bảo vệ bởi mặt kính cường lực Ceramic Shield có độ bền bỉ cao với khả năng chống trầy, xước gần như tuyệt đối, người dùng có thể an tâm khi sử dụng.</p><h3><strong>Thiết kế toát lên vẻ đẹp sang trọng, tinh tế đến từng chi tiết</strong></h3><p>Thiết kế của những dòng iPhone thường không có quá nhiều thay đổi bởi độ hoàn hảo của chúng luôn khiến người dùng xao xuyến. Ở phiên bản iPhone 14 Plus&nbsp;thì về thiết kế cũng không có quá nhiều sự thay đổi so với những người anh em tiền nhiệm.</p><p>Khung viền của thiết bị được hoàn thiện từ chất liệu thép không gỉ, giữ được độ bền bỉ lâu dài cho sản phẩm. Hai mặt trước và sau của điện thoại được phủ một lớp kính cường lực bóng bẩy khiến cho bạn luôn tỏa sáng khi cầm nó trên tay.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/thiet-ke-iphone-14-plus-128gb-didongviet.jpg" alt="Thiết kế toát lên vẻ đẹp sang trọng, tinh tế đến từng chi tiết" width="780" height="520"></figure><p>Bốn góc được bo tròn mềm mại, tinh tế đến từng chi tiết mang đến cảm giác thoải mái, dễ chịu khi sử dụng.</p><p>Với nhiều phiên bản như: Đen (Midnight), Trắng ( Starlight) , Đỏ ( Product Red), Xanh dương (Blue), Tím (Purple). Người dùng có thể tự do lựa chọn những màu sắc phù hợp với sở thích cũng như cá tính của chính mình.</p><h3><strong>Hiệu năng hoạt động mạnh mẽ với con chip Apple A15 Bionic</strong></h3><p>iPhone 14 Plus có hiệu năng hoạt động mạnh mẽ nhờ được trang bị con chip Apple A15 Bionic được sản xuất trên tiến trình 5nm. Với con chip này bạn có thể thoải mái chơi những tựa game đồ họa cao hay là có thể biên tập những video 4K một cách dễ dàng. Hỗ trợ đa nhiệm cho người dùng có thể giải quyết được nhiều công việc trong cùng một lúc.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/chip-iphone-14-plus-128gb-didongviet.jpg" alt="Hiệu năng hoạt động mạnh mẽ với con chip Apple A15 Bionic" width="780" height="520"></figure><p>Với bộ nhớ RAM 6GB cho phép người dùng thực hiện đa tác vụ từ chỉnh sửa video, xem phim, lướt web, các hoạt động giải trí…diễn ra một cách trơn tru, không có hiện giật lag. Bên cạnh đó với bộ nhớ trong 128GB bạn có thể thoải mái lưu trữ tài liệu, hình ảnh, âm thanh hoặc bất kể tài liệu nào cần cho công việc.</p><h3><strong>Thời lượng pin cho phép trải nghiệm cả ngày dài</strong></h3><p>Dung lượng pin của phiên bản iPhone 14 Plus cũng được nâng cấp đáng kể cho phép người dùng sử dụng thoải mái trong ngày dài lên đến 26 giờ đồng hồ. Vì thế, bạn&nbsp;không cần phải quá&nbsp;lo lắng về việc bị gián đoạn trong khi đang dùng.</p><figure class="image"><img style="aspect-ratio:780/520;" src="https://cdn-v2.didongviet.vn/files/media/wysiwyg/2022/san-pham/apple-product/pin-iphone-14-plus-128gb-didongviet.jpg" alt="Thời lượng pin cho phép trải nghiệm cả ngày dài" width="780" height="520"></figure><p>Ngoài ra, thiết bị còn được hỗ trợ thiết bị sạc nhanh và sạc không dây đảm bảo quá trình nạp năng lượng nhanh chóng, tiết kiệm tối đa thời gian của người dùng.</p><h3><strong>Bộ đôi camera cho những bức ảnh, thước phim chuyên nghiệp</strong></h3><p>Về camera của iPhone thì không thể bỏ không nhắc đến bởi độ hoàn hảo mà chúng mang lại những người sử dụng chúng. Và camera của iPhone 14 Plus cũng&nbsp;được trang bị bộ đôi camera có độ phân giải 12MP, khẩu độ f/1.5 tích hợp tính năng AutoFocus hỗ trợ camera chính thu được nhiều ánh sáng hơn. Đồng thời, kết hợp với chip đời mới nhất Apple A15&nbsp;Bionic cùng thuật toán thông minh mang đến cho người dùng những bức ảnh sống động, rõ nét và hoàn hảo nhất.</p>	Apple	t	1	2024-06-23 10:24:50.261	\N	\N	\N	\N	\N	\N	\N	https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-plus-128gb-didongviet.jpg	11490000	0	11490000	11490000	16	{https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-plus-128gb-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-plus-128gb-mau-do-didongviet.jpg,https://cdn-v2.didongviet.vn/files/media/catalog/product/i/p/iphone-14-plus-128gb-mau-trang-didongviet.jpg}
\.


--
-- Data for Name: ProductOrder; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductOrder" (id, title, slug, category_title, category_id, vendor, barcode, line_price, price, price_original, line_price_original, variant_id, product_id, product_title, variant_title, variant_options, quantity, image, selected, "cartId", "orderId") FROM stdin;
\.


--
-- Data for Name: ProductSpecifications; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductSpecifications" (id, type_id, name, value, description) FROM stdin;
40	1	Tran Hong An	{123}	\N
41	3	Kích thước màn hình	{"7.9 inches"}	\N
42	3	Công nghệ màn hình	{"IPS LCD"," cảm ứng điện dung"," 16 triệu màu"}	\N
43	4	Camera sau	{"8 MP"," f/2.4"," 32mm"}	\N
44	4	Camera trước	{"7 MP"," f/2.2"," 31mm"}	\N
45	1	Chip	{" Apple A12 Bionic (7 nm)"}	\N
46	5	Pin	{"Li-Ion 5124 mAh"}	\N
47	3	Độ phân giải màn hình	{"1536 x 2048 pixels"}	\N
48	3	Kích thước màn hình	{"11 inches"}	\N
49	4	Camera sau	{"12MP góc rộng 10MP góc siêu rộng"}	\N
50	4	Camera trước	{"12MP góc siêu rộng 122 độ"}	\N
51	1	Chip	{"Apple M1 8 nhân"}	\N
52	2	Dung lượng RAM	{8GB}	\N
53	5	Pin	{7538mAh}	\N
54	3	Độ phân giải màn hình	{"2048 x 2732 pixels"}	\N
55	3	Công nghệ màn hình	{"IPS LCD"," 16 triệu màu"," True-tone"," 120Hz"," 600 nits"}	\N
56	4	Camera sau	{"12 MP góc rộng","khẩu độ f/1.8 10 MP góc siêu rộng f/2.4"}	\N
57	4	Camera trước	{"7 MP khẩu độ f/2.2"}	\N
58	1	Chip	{"Apple A12Z Bionic"}	\N
59	2	Dung lượng RAM	{"6 GB"}	\N
60	5	Pin	{"Khoảng 7600 mAh"}	\N
61	6	Thẻ SIM	{" Nano-SIM + eSIM"}	\N
62	3	Độ phân giải màn hình	{"1668 x 2388 pixel"}	\N
63	2	Công nghệ màn hình	{"Liquid Retina IPS LCD"}	\N
64	3	Công nghệ màn hình	{"Liquid Retina IPS LCD"}	\N
65	4	Camera sau	{"12 MP + 10 MP + TOF 3D LiDAR"}	\N
66	4	Camera trước	{" 12 MP"}	\N
67	6	Wifi	{" Wi-Fi 802.11 a/b/g/n/ac/6"," dual-band"," hotspot"}	\N
68	6	Cổng kết nối/sạc	{" USB Type-C 4 (Thunderbolt 4)"}	\N
69	3	Công nghệ màn hình	{" Ultra Retina XDR"}	\N
70	3	Độ phân giải	{" 2420x1668 pixel"}	\N
71	4	Camera sau	{" Camera góc siêu rộng 12MP"," ƒ/2.4"}	\N
72	4	Camera trước	{" Camera góc rộng: 12MP"," ƒ/1.8"}	\N
73	1	Chip	{"Apple M4"}	\N
74	6	Cổng kết nối/sạc	{" USB Type-C"}	\N
75	1	Chip 	{"Apple M2"}	\N
76	4	Camera trước	{" Camera trước Ultra Wide 12MP trên cạnh ngang / Khẩu độ ƒ/2.4"}	\N
77	1	Tốc độ CPU	{" CPU 8 lõi với 4 lõi hiệu năng và 4 lõi tiết kiệm điện"}	\N
78	6	Wifi	{" Wi‑Fi 6E (802.11ax) với 4x4 MIMO5"}	\N
79	5	Loại pin	{" Tích hợp pin sạc Li-Po 28","93 watt‑giờ"}	\N
80	3	Kích thước màn hình	{" 13 inches"}	\N
81	3	Độ phân giải	{" 2360 x 1640 pixel"}	\N
82	4	Camera sau	{" Camera góc rộng 12MP"," khẩu độ ƒ/1.8"}	\N
83	4	Camera trước	{" Camera trước Ultra Wide 12MP trên cạnh ngang / Khẩu độ ƒ/2.4"}	\N
84	3	Kích thước màn hình	{" 10.9 inch - Tần số quét 60Hz"}	\N
85	3	Độ phân giải	{"1640 x 2360 pixels"}	\N
86	1	Hệ điều hành	{" iPadOS 16"}	\N
87	1	Chip	{" A14 Bionic"}	\N
88	2	Dung lượng RAM	{4GB}	\N
89	6	Bluetooth Tai nghe	{Có}	\N
90	8	Kích thước	{"166 mm x 8.9 mm"}	\N
91	6	Tương thích	{iOS," PadOS"}	\N
92	3	Kích thước màn hình	{"10.2 inches"}	\N
93	3	Độ phân giải	{"1620 x 2160 pixel"}	\N
94	1	Chip	{"Apple A13 Bionic"}	\N
95	1	Hệ điều hành	{"iPadOS 15"}	\N
96	5	Dung lượng pin	{"32.4 Wh"}	\N
97	3	Công nghệ màn hình	{" OLED"}	\N
98	3	Độ phân giải	{"1170 x 2532 Pixels"}	\N
99	4	Camera sau	{" Chính 48 MP & Phụ 12 MP"," 12 MP"}	\N
100	1	Hệ điều hành	{" iOS 16"}	\N
101	1	CPU	{" Apple A16 Bionic 6 nhân"}	\N
102	5	Loại pin	{Li-Ion}	\N
103	5	Công nghệ pin	{"Sạc không dây MagSafe / Sạc pin nhanh / Tiết kiệm pin"}	\N
104	6	Mạng di động	{" Hỗ trợ 5G"}	\N
105	6	Cổng kết nối/sạc	{Lightning}	\N
106	1	Chip	{"Apple A15 Bionic 6 nhân"}	\N
107	6	Wifi	{" Wi‑Fi 6 (802.11ax) with 2x2 MIMO"}	\N
108	6	Jack tai nghe	{Không}	\N
109	3	Độ phân giải	{"1284 x 2778 Pixels"}	\N
\.


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductVariant" (id, barcode, option1, option2, option3, "position", compare_at_price, price, sku, title, updated_at, inventory_quantity, available, product_id) FROM stdin;
9	\N	Hồng	64GB		0	14990000	11490000	6aca9a82-b8fa-4022-99de-f5c47d300f9c	Hồng / 64GB	\N	1	t	2
10	\N	Hồng	256GB		1	14990000	11490000	421aee0c-1ae4-4437-820c-2f5ccc5abe95	Hồng / 256GB	\N	1	t	2
11	\N	Bạc	64GB		2	14990000	11490000	180c0a75-4dac-4aca-8adc-087680d95648	Bạc / 64GB	\N	1	t	2
12	\N	Bạc	256GB		3	14990000	11490000	5461a353-a579-4ce0-af98-3d1fd9b036bb	Bạc / 256GB	\N	1	t	2
13	\N	Vàng	64GB		4	14990000	11490000	5d5db157-c3ff-4118-90be-7e3b2e9c3e6e	Vàng / 64GB	\N	1	t	2
14	\N	Vàng	256GB		5	14990000	11490000	5c56374e-bdbc-4a84-965e-8f6c9a095377	Vàng / 256GB	\N	1	t	2
15	\N	Xanh	64GB		6	14990000	11490000	5707f98b-8b86-4274-9305-46a8e0c554f3	Xanh / 64GB	\N	1	t	2
16	\N	Xanh	256GB		7	14990000	11490000	447ed480-400d-4399-8008-4956d4e910ab	Xanh / 256GB	\N	1	t	2
17	\N	Bạc	64GB		0	14990000	11490000	07095188-ff63-4440-b782-49e35b24cd95	Bạc / 64GB	\N	1	t	3
18	\N	Bạc	256GB		1	14990000	11490000	552e3461-2ee6-4d90-ac47-80152560effa	Bạc / 256GB	\N	1	t	3
19	\N	Xám	64GB		2	14990000	11490000	739d7146-8d40-4886-98fa-ba92f5cb0001	Xám / 64GB	\N	1	t	3
20	\N	Xám	256GB		3	14990000	11490000	19c95762-4615-4872-b559-111ab0c0a331	Xám / 256GB	\N	1	t	3
21	\N	Hồng	64GB		0	14990000	11490000	8e04f16f-d99a-4b32-ac7b-30d37e62edc8	Hồng / 64GB	\N	1	t	4
22	\N	Hồng	256GB		1	14990000	11490000	0f158567-1503-4c54-843e-76a4c7e73b03	Hồng / 256GB	\N	1	t	4
23	\N	Tím	64GB		2	14990000	11490000	f5498e02-ed1d-469f-81c0-4c46247983c7	Tím / 64GB	\N	1	t	4
24	\N	Tím	256GB		3	14990000	11490000	fc7b9e05-1f53-44a6-8dea-853079f6cb3b	Tím / 256GB	\N	1	t	4
25	\N	Trắng vàng	64GB		4	14990000	11490000	d825e4f7-197b-4cfd-a250-bc2fc7b30a38	Trắng vàng / 64GB	\N	1	t	4
26	\N	Trắng vàng	256GB		5	14990000	11490000	deb75aa4-8338-4dac-b883-d50cce520b8e	Trắng vàng / 256GB	\N	1	t	4
27	\N	Xám	64GB		6	14990000	11490000	0df5cf01-ae15-44af-8287-30adb51c39b4	Xám / 64GB	\N	1	t	4
28	\N	Xám	256GB		7	14990000	11490000	9fab65d1-7615-4d5f-b054-71813d6454f0	Xám / 256GB	\N	1	t	4
29	\N	Xanh	64GB		8	14990000	11490000	69e1b08b-fa6d-47eb-8e0f-b73292c89f8c	Xanh / 64GB	\N	1	t	4
30	\N	Xanh	256GB		9	14990000	11490000	b20e203c-5926-4c62-be63-d68e4fceb3e0	Xanh / 256GB	\N	1	t	4
31	\N	Tím	64GB		0	14990000	11490000	fcf51767-2258-41d2-a00d-e1316e6fd312	Tím / 64GB	\N	1	t	5
32	\N	Tím	256GB		1	14990000	11490000	3df110ed-4686-4619-b41a-340e091f9f10	Tím / 256GB	\N	1	t	5
33	\N	Trắng vàng	64GB		2	14990000	11490000	9f19e276-f0c1-405a-b8b3-2475a9f8388c	Trắng vàng / 64GB	\N	1	t	5
34	\N	Trắng vàng	256GB		3	14990000	11490000	0dfefdaf-c293-4f00-87c5-40b823660c59	Trắng vàng / 256GB	\N	1	t	5
35	\N	Hồng	64GB		4	14990000	11490000	78c748e4-bb20-40ab-949a-d256a94252f8	Hồng / 64GB	\N	1	t	5
36	\N	Hồng	256GB		5	14990000	11490000	abed52dc-1914-4572-8ed2-b95b32fd7ea6	Hồng / 256GB	\N	1	t	5
37	\N	Xám	64GB		6	14990000	11490000	9f053218-52de-4081-96b3-7aa342495d04	Xám / 64GB	\N	1	t	5
38	\N	Xám	256GB		7	14990000	11490000	2e75392d-e4c7-451e-88f7-35ab289c425b	Xám / 256GB	\N	1	t	5
39	\N	Bạc	64GB		0	14990000	11490000	a715d0ad-bd8f-4b7c-9410-2a5c5edf3137	Bạc / 64GB	\N	1	t	6
40	\N	Bạc	256GB		1	14990000	11490000	a75d8d4f-ba0a-4588-be8f-da359d5605cf	Bạc / 256GB	\N	1	t	6
41	\N	Bạc	512GB		2	14990000	11490000	5956e48c-e2d4-41aa-b3d7-c49fb8d0f6b7	Bạc / 512GB	\N	1	t	6
42	\N	Bạc	1T		3	14990000	11490000	a68fa7dd-f7f9-499a-9724-c6c247b21f31	Bạc / 1T	\N	1	t	6
43	\N	Xám	64GB		4	14990000	11490000	a608da21-b6f7-4d61-8403-33c775b1a817	Xám / 64GB	\N	1	t	6
44	\N	Xám	256GB		5	14990000	11490000	cbc0c6b8-5dc1-43a3-a8a1-5842656f3df0	Xám / 256GB	\N	1	t	6
45	\N	Xám	512GB		6	14990000	11490000	1796d3b9-7534-425c-8f88-50ddb1d3b9a3	Xám / 512GB	\N	1	t	6
46	\N	Xám	1T		7	14990000	11490000	032e7f22-1e83-4c56-aef8-2edc32611d11	Xám / 1T	\N	1	t	6
48	\N	Xám	256GB		1	14990000	11490000	3e6f507a-f7bc-410b-8666-587aaa4feef6	Xám / 256GB	\N	1	t	7
49	\N	Xanh lá	64GB		2	14990000	11490000	5ff7a03e-a86b-495d-b895-f1bada559fac	Xanh lá / 64GB	\N	1	t	7
50	\N	Xanh lá	256GB		3	14990000	11490000	2eebfa49-46f3-4aaa-94a0-7cd0822773e2	Xanh lá / 256GB	\N	1	t	7
51	\N	Xanh dương	64GB		4	14990000	11490000	1df2cbbc-27c9-4510-8ebb-7dc2f751c197	Xanh dương / 64GB	\N	1	t	7
52	\N	Xanh dương	256GB		5	14990000	11490000	969cb2fa-1c9a-4be8-9abd-d47c42c11100	Xanh dương / 256GB	\N	1	t	7
53	\N	Vàng hồng	64GB		6	14990000	11490000	f9ae5638-3a4c-48a1-91ec-0c60fa560e61	Vàng hồng / 64GB	\N	1	t	7
54	\N	Vàng hồng	256GB		7	14990000	11490000	51d5d2ee-f932-4774-ae76-24f1fd77fb8f	Vàng hồng / 256GB	\N	1	t	7
55	\N	Bạc	64GB		8	14990000	11490000	105b5ed8-dabd-4491-8a1b-bf67f0ce1bd2	Bạc / 64GB	\N	1	t	7
56	\N	Bạc	256GB		9	14990000	11490000	542af904-0692-4efc-806a-14c429c2d975	Bạc / 256GB	\N	1	t	7
57	\N	Trắng vàng	128GB		0	14990000	11490000	fb9ad052-a9ca-44e3-999f-3d654e4cce48	Trắng vàng / 128GB	\N	1	t	8
58	\N	Trắng vàng	256GB		1	14990000	11490000	3aaad330-1eed-4e21-a49c-ac477981f688	Trắng vàng / 256GB	\N	1	t	8
59	\N	Trắng vàng	512GB		2	14990000	11490000	b788c231-e226-4279-9b34-ba94dd400f1d	Trắng vàng / 512GB	\N	1	t	8
60	\N	Trắng vàng	1T		3	14990000	11490000	1f0716d4-ce7a-47b2-a345-1710bacd31bf	Trắng vàng / 1T	\N	1	t	8
61	\N	Xanh dương	128GB		4	14990000	11490000	f14f2488-dff4-4ff3-aabb-8dca1ba6b918	Xanh dương / 128GB	\N	1	t	8
62	\N	Xanh dương	256GB		5	14990000	11490000	b080377e-5a72-4489-8ac9-724eedd5fb72	Xanh dương / 256GB	\N	1	t	8
63	\N	Xanh dương	512GB		6	14990000	11490000	e2c1d530-a01f-440a-b1af-e9394cce96ae	Xanh dương / 512GB	\N	1	t	8
64	\N	Xanh dương	1T		7	14990000	11490000	c1b56e9d-abc7-4a06-9db5-5336bc0ef090	Xanh dương / 1T	\N	1	t	8
65	\N	Xám	128GB		8	14990000	11490000	d0f07e5a-b484-4e1c-a57a-fe954f2feec4	Xám / 128GB	\N	1	t	8
66	\N	Xám	256GB		9	14990000	11490000	9762c7c6-cd32-4d9f-b04b-9c39060b8419	Xám / 256GB	\N	1	t	8
67	\N	Xám	512GB		10	14990000	11490000	43400a49-b03d-4aea-8eea-142992f51fe0	Xám / 512GB	\N	1	t	8
68	\N	Xám	1T		11	14990000	11490000	5b9fb7db-ce72-4975-a43b-8aba9fd15a7c	Xám / 1T	\N	1	t	8
69	\N	Tím	128GB		12	14990000	11490000	4253fb86-378b-4758-b9ab-d987b5f0a084	Tím / 128GB	\N	1	t	8
70	\N	Tím	256GB		13	14990000	11490000	b35756c3-8e2b-4e74-9492-a6bed26264c7	Tím / 256GB	\N	1	t	8
71	\N	Tím	512GB		14	14990000	11490000	e3df58cc-1681-48e9-be39-960cedb4dde4	Tím / 512GB	\N	1	t	8
72	\N	Tím	1T		15	14990000	11490000	56c1fa86-d8f0-4d04-a266-abb57b3848a0	Tím / 1T	\N	1	t	8
73	\N	Bạc	128GB		0	14990000	11490000	eb69e7c0-4e14-4a65-a0e1-dabc67b5ba5b	Bạc / 128GB	\N	1	t	9
74	\N	Bạc	256GB		1	14990000	11490000	7e0a40f3-ef97-4f80-9d72-092dcce16cf9	Bạc / 256GB	\N	1	t	9
75	\N	Bạc	512GB		2	14990000	11490000	da464a3c-e17d-4cca-bfac-d51e1cabde3e	Bạc / 512GB	\N	1	t	9
76	\N	Xám	128GB		3	14990000	11490000	feaeaa15-55c5-4de5-8b25-352a2a17f70e	Xám / 128GB	\N	1	t	9
77	\N	Xám	256GB		4	14990000	11490000	beec923f-546e-46f3-9988-a426e906e661	Xám / 256GB	\N	1	t	9
78	\N	Xám	512GB		5	14990000	11490000	69682eed-c6ec-4e1d-98cc-3da07a9ca8df	Xám / 512GB	\N	1	t	9
79	\N	64GB			0	14990000	11490000	e786a39f-e8eb-4e1f-9ee9-7a2574d17cbe	64GB	\N	1	t	10
80	\N	256GB			1	14990000	11490000	24ebde7e-0702-46b9-9ec2-acd10d5bbef3	256GB	\N	1	t	10
47	\N	Xám	64GB		0	14990000	12490000	1377aca5-6fa3-4713-b92f-dd88d0d8b38c	Xám / 64GB	\N	1	t	7
81	\N	Xám	128GB		0	14990000	11490000	ec964d72-f141-4ef0-bbd7-82b4b0ac95ab	Xám / 128GB	\N	1	t	11
82	\N	Xám	256GB		1	14990000	11490000	f122d337-11f2-44fb-9e02-82601488ed2f	Xám / 256GB	\N	1	t	11
83	\N	Xám	512GB		2	14990000	11490000	d9f1c775-5b28-4984-a2d5-9668c329b515	Xám / 512GB	\N	1	t	11
84	\N	Xám	1TB		3	14990000	11490000	fad20377-849c-40a6-9bc6-ef1be93bdd55	Xám / 1TB	\N	1	t	11
85	\N	Xám	2TB		4	14990000	11490000	ac5aa616-8bb3-4630-b70b-2545ef3755b3	Xám / 2TB	\N	1	t	11
86	\N	Bạc	128GB		5	14990000	11490000	723aba36-5862-44c4-aff4-d67a2a915ae1	Bạc / 128GB	\N	1	t	11
87	\N	Bạc	256GB		6	14990000	11490000	b1b6d9af-4cb5-41b5-858c-32d647416ca0	Bạc / 256GB	\N	1	t	11
88	\N	Bạc	512GB		7	14990000	11490000	8425315a-f58b-4df9-93ae-8ab604a6db14	Bạc / 512GB	\N	1	t	11
89	\N	Bạc	1TB		8	14990000	11490000	5b976623-f191-4be8-b277-d9889c5ffe3b	Bạc / 1TB	\N	1	t	11
90	\N	Bạc	2TB		9	14990000	11490000	0d5c3e6a-c9eb-4293-a117-41c4065fb28f	Bạc / 2TB	\N	1	t	11
91	\N	128GB			0	14990000	11490000	020ddf55-ea11-41a7-aea4-748ab322e24d	128GB	\N	1	t	12
92	\N	256GB			1	14990000	11490000	e32dce87-b662-4518-a932-6d055833adbe	256GB	\N	1	t	12
93	\N	512GB			2	14990000	11490000	245029eb-c04a-4ae6-a9f4-044e1d4131a6	512GB	\N	1	t	12
94	\N	Bạc	128GB		0	14990000	11490000	24bd00c3-9f49-40a2-8f21-bf3a2e6be3e6	Bạc / 128GB	\N	1	t	13
95	\N	Bạc	256GB		1	14990000	11490000	29683e2a-2209-4649-aae7-5a55fbc370ab	Bạc / 256GB	\N	1	t	13
96	\N	Bạc	512GB		2	14990000	11490000	a9b84ac5-f6b1-4f44-a223-776159fd87ad	Bạc / 512GB	\N	1	t	13
97	\N	Xám	128GB		3	14990000	11490000	9401ceda-6666-4a94-851b-3bb72b2cc1a4	Xám / 128GB	\N	1	t	13
98	\N	Xám	256GB		4	14990000	11490000	cf6e2fbc-c9ac-4216-b75a-78cb3e32095a	Xám / 256GB	\N	1	t	13
99	\N	Xám	512GB		5	14990000	11490000	8bd95c65-584e-4957-bf93-9abd0898dd05	Xám / 512GB	\N	1	t	13
100	\N	Bạc	256GB		0	14990000	11490000	3882223f-59db-4f1a-8f13-7449c28d8e5d	Bạc / 256GB	\N	1	t	14
101	\N	Bạc	512GB		1	14990000	11490000	ca679278-1e61-4171-b863-cd3dde8534fe	Bạc / 512GB	\N	1	t	14
102	\N	Bạc	1TB		2	14990000	11490000	bfbc91c9-a796-4f74-9b94-326d6edb4a48	Bạc / 1TB	\N	1	t	14
103	\N	Bạc	2TB		3	14990000	11490000	7ec4f853-6039-42dc-a766-c929c454f796	Bạc / 2TB	\N	1	t	14
104	\N	Đen	256GB		4	14990000	11490000	dba59808-fb96-4e67-8deb-95326025c76a	Đen / 256GB	\N	1	t	14
105	\N	Đen	512GB		5	14990000	11490000	51c79edc-7b61-4043-a714-970b59dc966c	Đen / 512GB	\N	1	t	14
106	\N	Đen	1TB		6	14990000	11490000	853d4331-3204-4aab-9760-b75343983709	Đen / 1TB	\N	1	t	14
107	\N	Đen	2TB		7	14990000	11490000	a7e31083-d428-435f-8954-0063154932de	Đen / 2TB	\N	1	t	14
108	\N	Xanh dương	128GB		0	14990000	11490000	066c82e8-f1d0-448c-b31e-48fed8caf29c	Xanh dương / 128GB	\N	1	t	15
109	\N	Xanh dương	256GB		1	14990000	11490000	ac281e73-bd1f-4760-96ee-388f0121c29c	Xanh dương / 256GB	\N	1	t	15
110	\N	Xám	128GB		2	14990000	11490000	f9dce57a-9a24-429b-aee5-1c6472f9255a	Xám / 128GB	\N	1	t	15
111	\N	Xám	256GB		3	14990000	11490000	e212a989-dbcb-4ea3-94af-ced5ce0acaed	Xám / 256GB	\N	1	t	15
112	\N	Vàng	128GB		4	14990000	11490000	ef076b07-7eed-4f44-af2c-f40e927ade2a	Vàng / 128GB	\N	1	t	15
113	\N	Vàng	256GB		5	14990000	11490000	2e445e50-3e4a-4d42-8f40-ff48721dafed	Vàng / 256GB	\N	1	t	15
114	\N	Tím	128GB		6	14990000	11490000	b0d31a6e-d378-4508-898a-2f67ef15d70b	Tím / 128GB	\N	1	t	15
115	\N	Tím	256GB		7	14990000	11490000	805100b3-fd88-4d50-b395-891090469636	Tím / 256GB	\N	1	t	15
116	\N	Xanh dương	128GB		0	14990000	11490000	8d4bffd4-5bc7-47f1-af8c-47c138444a20	Xanh dương / 128GB	\N	1	t	16
117	\N	Xanh dương	256GB		1	14990000	11490000	5a6d47d9-b9ac-4895-9e16-6bcddac3f680	Xanh dương / 256GB	\N	1	t	16
118	\N	Xám	128GB		2	14990000	11490000	a82073ec-ca93-4e55-9a1b-e2fee2348b4f	Xám / 128GB	\N	1	t	16
119	\N	Xám	256GB		3	14990000	11490000	4fe93fec-b428-43fe-9265-e33fe4ed9119	Xám / 256GB	\N	1	t	16
120	\N	Vàng	128GB		4	14990000	11490000	f2959abe-89c9-4a67-9e47-7d7eb0b0766f	Vàng / 128GB	\N	1	t	16
121	\N	Vàng	256GB		5	14990000	11490000	34321b20-b406-4e1d-a925-b87d78a4b5a5	Vàng / 256GB	\N	1	t	16
122	\N	Tím	128GB		6	14990000	11490000	4ec7ceef-05e5-4cbd-9cf9-359fdfec6d4b	Tím / 128GB	\N	1	t	16
123	\N	Tím	256GB		7	14990000	11490000	a4927f41-a0d6-4388-8d9f-2a6e4d53edf3	Tím / 256GB	\N	1	t	16
124	\N	Hồng	64GB		0	14990000	11490000	9cd57a7c-4a02-466b-9580-d503f4712bd4	Hồng / 64GB	\N	1	t	17
125	\N	Hồng	256GB		1	14990000	11490000	50ba8bac-11dc-4472-bc0a-05a4d447d36d	Hồng / 256GB	\N	1	t	17
126	\N	Xanh dương	64GB		2	14990000	11490000	50c6b1be-f806-4394-b955-2ad7246694eb	Xanh dương / 64GB	\N	1	t	17
127	\N	Xanh dương	256GB		3	14990000	11490000	67a8947e-69aa-4a0e-ab28-ed64a7fa46e3	Xanh dương / 256GB	\N	1	t	17
128	\N	Bạc	64GB		4	14990000	11490000	bac9b380-a1f4-435e-a481-ab76051957c3	Bạc / 64GB	\N	1	t	17
129	\N	Bạc	256GB		5	14990000	11490000	e94567df-2f08-4652-bf02-8ef65369c1f0	Bạc / 256GB	\N	1	t	17
130	\N	Vàng	64GB		6	14990000	11490000	60a46a51-9000-4b08-9f96-66f941c13f86	Vàng / 64GB	\N	1	t	17
131	\N	Vàng	256GB		7	14990000	11490000	be064394-7aa2-47aa-b3d4-fa3e0817f9b4	Vàng / 256GB	\N	1	t	17
132	\N	Trắng			0	14990000	11490000	5897cce1-48e4-454f-887b-983cd696ce4d	Trắng	\N	1	t	18
133	\N	Đen			0	14990000	11490000	7f4e3843-e9c0-4e95-8547-14198f5d982d	Đen	\N	1	t	19
134	\N	Trắng			0	14990000	11490000	37763b67-7a88-43b2-a957-740f9f73d856	Trắng	\N	1	t	20
135	\N	Trắng			0	14990000	11490000	97b44e98-1fa0-4d8e-8a88-8988924dcb2e	Trắng	\N	1	t	21
136	\N	Trắng			0	14990000	11490000	6707a986-f0d2-498c-9140-90135186bb63	Trắng	\N	1	t	22
137	\N	Đen			0	14990000	11490000	d33d6e04-3382-45d1-b162-8c43e99ffa28	Đen	\N	1	t	23
138	\N	Trắng			0	14990000	11490000	311ce57d-3ec6-49a3-859b-c626065c889b	Trắng	\N	1	t	24
139	\N	Trắng			0	14990000	11490000	03288a07-ca5b-41a9-8ebc-b4e607398917	Trắng	\N	1	t	25
140	\N	Trắng			0	14990000	11490000	fbcadc3d-9edb-4ed3-b20f-58df0bd29c83	Trắng	\N	1	t	26
141	\N	Xanh dương			1	14990000	11490000	5355db29-fd7f-4e6a-aab0-ed8a88047351	Xanh dương	\N	1	t	26
142	\N	Tím			2	14990000	11490000	2f418b50-c431-4d7f-9c0d-3d33c5d33bfc	Tím	\N	1	t	26
143	\N	Vàng			3	14990000	11490000	5e2cd0cf-72ee-415a-b013-7e9095aebcf1	Vàng	\N	1	t	26
144	\N	Trắng			0	14990000	11490000	84d8cd36-3fa2-4911-9742-6c79bf4964cc	Trắng	\N	1	t	27
145	\N	Đen			1	14990000	11490000	f9f1bdd2-b43c-4fac-8e6f-67966cd9649b	Đen	\N	1	t	27
146	\N	Trắng			0	14990000	11490000	f4d47453-2cc3-495f-a5a8-6f0ab940ddce	Trắng	\N	1	t	28
147	\N	Bạc			1	14990000	11490000	3ff8ba7c-746d-4042-a22a-124ea9ab8c45	Bạc	\N	1	t	28
148	\N	Trắng			0	14990000	11490000	386ceea3-3a44-4b17-8082-2ea202f3f5df	Trắng	\N	1	t	29
149	\N	Đen			1	14990000	11490000	302cbf59-c7e0-449e-bb9f-2e69514f4691	Đen	\N	1	t	29
150	\N	Trắng			0	14990000	11490000	810f7896-2496-49c2-b77b-d4adb21ab683	Trắng	\N	1	t	30
151	\N	Xám			1	14990000	11490000	6824fc43-8a41-4df4-a1a0-f4371db7c5fd	Xám	\N	1	t	30
152	\N	Bạc	256GB		0	14990000	11490000	fd5e32d3-73f8-4491-b9be-5904e76417e9	Bạc / 256GB	\N	1	t	31
153	\N	Bạc	1TB		1	14990000	11490000	50d383d3-2a9e-46b5-ba17-fcbdcd90c3b4	Bạc / 1TB	\N	1	t	31
154	\N	Vàng	256GB		2	14990000	11490000	365317ee-7b9e-4a7c-86cb-de820ba083dc	Vàng / 256GB	\N	1	t	31
155	\N	Vàng	1TB		3	14990000	11490000	f2c7db07-1ab9-445b-b326-0b2a96bd700e	Vàng / 1TB	\N	1	t	31
156	\N	Xám	256GB		4	14990000	11490000	032b1bf3-ef52-46c6-85cb-533545d9b106	Xám / 256GB	\N	1	t	31
157	\N	Xám	1TB		5	14990000	11490000	1e34bc87-d36a-417e-9e00-4d8977642130	Xám / 1TB	\N	1	t	31
158	\N	Tím	256GB		6	14990000	11490000	8a465f3d-0a6c-4cb0-939a-e4fed00a8964	Tím / 256GB	\N	1	t	31
159	\N	Tím	1TB		7	14990000	11490000	27c35deb-d12e-42e4-9a64-c20b89e25416	Tím / 1TB	\N	1	t	31
160	\N	Bạc	128GB		0	14990000	11490000	49714c82-b648-4e67-8df5-3b41c4b79eb4	Bạc / 128GB	\N	1	t	32
161	\N	Vàng	128GB		1	14990000	11490000	29c6d761-cff4-4cf7-b7ba-c70b024504e1	Vàng / 128GB	\N	1	t	32
162	\N	Xám	128GB		2	14990000	11490000	0b316d79-c731-400e-a5bd-73d7389bed42	Xám / 128GB	\N	1	t	32
163	\N	Tím	128GB		3	14990000	11490000	55a8fdd7-7b2c-4e9b-aa5b-207eb9da008f	Tím / 128GB	\N	1	t	32
164	\N	Đen	128GB		0	14990000	11490000	27f94899-bb26-4629-8b0c-499588280305	Đen / 128GB	\N	1	t	33
165	\N	Đen	256GB		1	14990000	11490000	037f438d-d50b-4aba-a790-4889ca683569	Đen / 256GB	\N	1	t	33
166	\N	Đen	512GB		2	14990000	11490000	356e08ca-0983-4ab5-b0c5-c436cf302efd	Đen / 512GB	\N	1	t	33
167	\N	Tím	128GB		3	14990000	11490000	a9549852-ef53-4133-947e-e72737a4a3bc	Tím / 128GB	\N	1	t	33
168	\N	Tím	256GB		4	14990000	11490000	7d1be0c6-93d2-478d-9330-7ac11e531284	Tím / 256GB	\N	1	t	33
169	\N	Tím	512GB		5	14990000	11490000	831aa3ae-bbc4-4bd5-9477-cdccebc26beb	Tím / 512GB	\N	1	t	33
170	\N	Xanh dương	128GB		6	14990000	11490000	b6528bef-82e8-41fa-afff-91a65a629241	Xanh dương / 128GB	\N	1	t	33
171	\N	Xanh dương	256GB		7	14990000	11490000	96c552ef-fb83-4b28-8a0e-b27f33689554	Xanh dương / 256GB	\N	1	t	33
172	\N	Xanh dương	512GB		8	14990000	11490000	434b6620-8295-422a-8cb3-641670b9f13d	Xanh dương / 512GB	\N	1	t	33
\.


--
-- Data for Name: SpecificationsType; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."SpecificationsType" (id, name, description) FROM stdin;
1	Hệ điều hành & CPU	\N
2	RAM	\N
3	Màn hình	\N
4	Camera	\N
5	Pin, Sạc	\N
6	Kết nối	\N
7	Tiện ích	\N
8	Thông tin chung	\N
\.


--
-- Data for Name: Store; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Store" (id, name, phone, address, url_map) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."User" (id, email, name) FROM stdin;
\.


--
-- Data for Name: _ProductToProductSpecifications; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."_ProductToProductSpecifications" ("A", "B") FROM stdin;
10	41
10	42
10	43
10	44
10	45
10	46
10	47
11	42
11	48
11	49
11	50
11	51
11	52
11	53
12	45
12	48
12	55
12	56
12	57
12	59
12	60
12	61
12	62
13	48
13	52
13	65
13	66
13	67
13	68
14	52
14	70
14	71
14	72
14	73
14	74
15	48
15	52
15	64
15	71
15	75
15	76
15	77
15	78
15	79
16	52
16	64
16	75
16	77
16	78
16	82
16	83
17	49
17	64
17	66
17	84
17	85
17	86
17	87
17	88
21	89
21	90
21	91
26	64
26	84
26	85
26	86
26	87
26	88
27	51
27	52
30	92
30	93
30	94
30	95
30	96
31	59
31	66
31	97
31	98
31	99
31	100
31	101
31	102
31	103
31	104
31	105
32	59
32	66
32	97
32	98
32	100
32	102
32	103
32	105
32	106
32	107
32	108
33	59
33	66
33	97
33	100
33	102
33	103
33	105
33	106
33	108
33	109
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
22837024-66a9-47e4-855c-3ed7f7954cb6	bd11a5f4e2e6f03b49a3f2af6e645b13792b74c207a7f5adc6c882acd384ef71	2024-06-21 16:37:14.624537+00	20240617143522_update	\N	\N	2024-06-21 16:37:14.520484+00	1
6ac2eb83-e4e1-4d53-9108-1525cb625dc1	80a6b6dc2ba1f8d8c9cbd14a03169274fe430f49d70b323053b3835f92be0259	2024-06-21 16:37:14.633031+00	20240617144041_update	\N	\N	2024-06-21 16:37:14.626289+00	1
d284b48b-1bce-444e-9f4e-8d58cd85955f	538c43aac8608ff14dc1fd2404982b5cee34408326dd4801866fbe07f53a04c1	2024-06-12 13:57:46.484312+00	20240526103018_init	\N	\N	2024-06-12 13:57:46.422604+00	1
794fa8f4-d7f1-47cc-9297-8545ae5fe20e	0ade505f01d79c99636d38207a433514c692e880bd4ab7bdca6038129d698520	2024-06-12 13:57:46.509674+00	20240527161616_update	\N	\N	2024-06-12 13:57:46.485176+00	1
29ffe8f0-b07c-4cc6-9a52-dbe64f2929c9	6fc0e0a727fe4bb1499cf7698bfe350af7e88bc236d17ff3de3b0c73aadba3bd	2024-06-12 13:57:46.518603+00	20240528154611_fix	\N	\N	2024-06-12 13:57:46.510587+00	1
c3caf4d4-987f-4f09-9677-b6371882e767	8b6d2c9ae5f678a1f50c2ccf6b4dbe6d4c58567c6c36409a141b221dff3ee10b	2024-06-12 13:57:46.531417+00	20240528155203_fix	\N	\N	2024-06-12 13:57:46.519376+00	1
d8daaece-3c78-4f4c-b2d8-b4acc3068587	467bd702906da4eb316a0f6334f47ea59154988b20f581e9c79bbbdfc96821b2	2024-06-12 13:57:46.553203+00	20240601103929_update	\N	\N	2024-06-12 13:57:46.532239+00	1
dd943159-4260-46d7-b865-d6c030fb598d	a98376e41a9d8b002c38e9d9dc8700917a30dd3ecefce4d191f6231861fb8471	2024-06-12 13:57:46.560403+00	20240601104846_update	\N	\N	2024-06-12 13:57:46.554195+00	1
12bae645-6b46-46f3-a528-420c205ff8df	f791e631283703f5c99c103f0b850b723990d4e069eef33e1c2cf019a409b065	2024-06-12 13:57:46.563503+00	20240602070029_update	\N	\N	2024-06-12 13:57:46.561186+00	1
9a918058-8d60-46fb-b03a-b27cbab11549	2700c476018d9144a9bf75e360a388a29e5c9f485779021341fec71918f5f814	2024-06-12 13:57:46.567358+00	20240602092033_update	\N	\N	2024-06-12 13:57:46.564245+00	1
78b1fa3e-d661-4d41-b13d-9274da5e4c60	1d5c9336f582c482a525da371512cde29a7db5e34a5be811f9b1a757274879e4	2024-06-12 13:57:46.570666+00	20240606132820_update	\N	\N	2024-06-12 13:57:46.568081+00	1
88255cf4-050d-4625-aebc-e60bc754d78e	52dd9c9811427128ee69a32337bf1b93633bbf974ef9bc2c497e8d4d93b06a2e	2024-06-12 13:57:46.577354+00	20240606134754_init	\N	\N	2024-06-12 13:57:46.571444+00	1
1c1175a8-69d9-426a-9603-8ec1a69fc6be	63d21dcc4957fc0acb96ca94383d4ca805a551778f4a289979a1843e6d711124	2024-06-12 13:57:46.585718+00	20240611151135_up	\N	\N	2024-06-12 13:57:46.579915+00	1
7f3805fa-91db-4dd2-b059-43de7ee575b7	2acf2fabeb927853c6c795fb69bc876fe1b4e7ee050e93ee2bbfa21be6265025	2024-06-12 13:57:46.594431+00	20240612133818_change	\N	\N	2024-06-12 13:57:46.58659+00	1
0f96f71d-7bae-4065-a3d5-e0144270fca0	7b547fcb39a4d5338b93f18b03b50b5e82363f3c0e5f886f8143cfdec0440496	2024-06-12 13:57:46.606162+00	20240612134950_change	\N	\N	2024-06-12 13:57:46.595382+00	1
799e52cf-a21e-4873-852a-37558483e6c5	20f041dfdf2fde21eb290f9ca2605f447c395d2aca09efd78f11cf3e0e66cc77	\N	20240612135202_change	A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20240612135202_change\n\nDatabase error code: 42P01\n\nDatabase error:\nERROR: relation "ProductImage" does not exist\n\nDbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42P01), message: "relation \\"ProductImage\\" does not exist", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("namespace.c"), line: Some(432), routine: Some("RangeVarGetRelidExtended") }\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name="20240612135202_change"\n             at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:106\n   1: schema_core::commands::apply_migrations::Applying migration\n           with migration_name="20240612135202_change"\n             at schema-engine/core/src/commands/apply_migrations.rs:91\n   2: schema_core::state::ApplyMigrations\n             at schema-engine/core/src/state.rs:226	2024-06-12 13:59:59.532971+00	2024-06-12 13:57:46.60693+00	0
5859ddb2-5b50-4f78-8999-e807d0ac7225	20f041dfdf2fde21eb290f9ca2605f447c395d2aca09efd78f11cf3e0e66cc77	2024-06-12 13:59:59.534365+00	20240612135202_change		\N	2024-06-12 13:59:59.534365+00	0
\.


--
-- Name: Article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Article_id_seq"', 1, false);


--
-- Name: Cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Cart_id_seq"', 1, false);


--
-- Name: CategoryArticle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."CategoryArticle_id_seq"', 4, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Category_id_seq"', 17, true);


--
-- Name: Customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Customer_id_seq"', 1, false);


--
-- Name: Option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Option_id_seq"', 51, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- Name: ProductOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductOrder_id_seq"', 1, false);


--
-- Name: ProductSpecifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductSpecifications_id_seq"', 109, true);


--
-- Name: ProductVariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductVariant_id_seq"', 172, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Product_id_seq"', 33, true);


--
-- Name: SpecificationsType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."SpecificationsType_id_seq"', 8, true);


--
-- Name: Store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Store_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Article Article_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_pkey" PRIMARY KEY (id);


--
-- Name: Cart Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY (id);


--
-- Name: CategoryArticle CategoryArticle_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."CategoryArticle"
    ADD CONSTRAINT "CategoryArticle_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: Option Option_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Option"
    ADD CONSTRAINT "Option_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: ProductOrder ProductOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder"
    ADD CONSTRAINT "ProductOrder_pkey" PRIMARY KEY (id);


--
-- Name: ProductSpecifications ProductSpecifications_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductSpecifications"
    ADD CONSTRAINT "ProductSpecifications_pkey" PRIMARY KEY (id);


--
-- Name: ProductVariant ProductVariant_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: SpecificationsType SpecificationsType_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsType"
    ADD CONSTRAINT "SpecificationsType_pkey" PRIMARY KEY (id);


--
-- Name: Store Store_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Article_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Article_slug_key" ON public."Article" USING btree (slug);


--
-- Name: Cart_token_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Cart_token_key" ON public."Cart" USING btree (token);


--
-- Name: CategoryArticle_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "CategoryArticle_slug_key" ON public."CategoryArticle" USING btree (slug);


--
-- Name: CategoryArticle_title_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "CategoryArticle_title_key" ON public."CategoryArticle" USING btree (title);


--
-- Name: Category_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Category_slug_key" ON public."Category" USING btree (slug);


--
-- Name: Category_title_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Category_title_key" ON public."Category" USING btree (title);


--
-- Name: Customer_email_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Customer_email_key" ON public."Customer" USING btree (email);


--
-- Name: Order_token_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Order_token_key" ON public."Order" USING btree (token);


--
-- Name: ProductOrder_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "ProductOrder_slug_key" ON public."ProductOrder" USING btree (slug);


--
-- Name: ProductVariant_barcode_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "ProductVariant_barcode_key" ON public."ProductVariant" USING btree (barcode);


--
-- Name: ProductVariant_sku_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "ProductVariant_sku_key" ON public."ProductVariant" USING btree (sku);


--
-- Name: Product_barcode_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Product_barcode_key" ON public."Product" USING btree (barcode);


--
-- Name: Product_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Product_slug_key" ON public."Product" USING btree (slug);


--
-- Name: Product_title_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Product_title_key" ON public."Product" USING btree (title);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: _ProductToProductSpecifications_AB_unique; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "_ProductToProductSpecifications_AB_unique" ON public."_ProductToProductSpecifications" USING btree ("A", "B");


--
-- Name: _ProductToProductSpecifications_B_index; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE INDEX "_ProductToProductSpecifications_B_index" ON public."_ProductToProductSpecifications" USING btree ("B");


--
-- Name: Article Article_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Article Article_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."CategoryArticle"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Option Option_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Option"
    ADD CONSTRAINT "Option_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductOrder ProductOrder_cartId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder"
    ADD CONSTRAINT "ProductOrder_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES public."Cart"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductOrder ProductOrder_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder"
    ADD CONSTRAINT "ProductOrder_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductSpecifications ProductSpecifications_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductSpecifications"
    ADD CONSTRAINT "ProductSpecifications_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."SpecificationsType"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _ProductToProductSpecifications _ProductToProductSpecifications_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_ProductToProductSpecifications"
    ADD CONSTRAINT "_ProductToProductSpecifications_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToProductSpecifications _ProductToProductSpecifications_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_ProductToProductSpecifications"
    ADD CONSTRAINT "_ProductToProductSpecifications_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductSpecifications"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

