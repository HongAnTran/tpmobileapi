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
    category_id integer
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
    slug text NOT NULL,
    status public."CategoryProductStatus" DEFAULT 'DRAFT'::public."CategoryProductStatus" NOT NULL,
    parent_id integer
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
    promotions jsonb[],
    shipping jsonb NOT NULL,
    payment jsonb NOT NULL,
    status integer NOT NULL
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
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    published_at timestamp(3) without time zone,
    barcode text,
    short_description text,
    category_id integer,
    meta_title text,
    meta_description text,
    meta_keywords text,
    status integer DEFAULT 0 NOT NULL,
    featured_image text DEFAULT ''::text NOT NULL,
    price double precision DEFAULT 0 NOT NULL,
    price_max double precision DEFAULT 0 NOT NULL,
    price_min double precision DEFAULT 0 NOT NULL,
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
    value text NOT NULL,
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
    compare_at_price double precision NOT NULL,
    option1 text NOT NULL,
    option2 text NOT NULL,
    option3 text NOT NULL,
    "position" integer NOT NULL,
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

COPY public."Article" (id, title, content, published, "authorId", category_id) FROM stdin;
\.


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Cart" (id, token, item_count, total_price, note, customer_id) FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Category" (id, title, description, image, slug, status, parent_id) FROM stdin;
1	Máy tính bảng		ipad-air.jpg	may-tinh-bang	SHOW	\N
2	iPad Pro		ipad-pro.jpg	ipad-pro	SHOW	1
3	iPad Air		ipad-air.jpg	ipad-air	SHOW	1
4	iPad Gen		iphone-11.jpg	ipad-gen	SHOW	1
5	iPad Mini		iphone-11.jpg	ipad-mini	SHOW	1
14	phụ kiện	\N	\N	phu-kien	SHOW	\N
\.


--
-- Data for Name: CategoryArticle; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."CategoryArticle" (id, title, description, image, slug, status) FROM stdin;
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
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Order" (id, token, code, customer_id, total_price, temp_price, ship_price, discount, note, promotions, shipping, payment, status) FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Product" (id, title, slug, description_html, vendor, available, created_at, updated_at, published_at, barcode, short_description, category_id, meta_title, meta_description, meta_keywords, status, featured_image, price, price_max, price_min, images) FROM stdin;
2	iPad Gen 10	ipad-gen-10	<h4>iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple</h4><p>iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.</p>	Apple	t	2024-06-12 15:53:52.571	\N	\N	\N	iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.	4	\N	\N	\N	1	/product/ipad-gen-10/thum.jpg	11490000	11490000	11490000	{/product/ipad-gen-10/thum.jpg,https://m.media-amazon.com/images/I/61uA2UVnYWL._AC_SX522_.jpg,https://m.media-amazon.com/images/I/61uA2UVnYWL._AC_SX522_.jpg}
3	Ipad gen 9	ipad-gen-9	\N	Apple	t	2024-06-12 16:15:20.083	\N	\N	\N	\N	4	\N	\N	\N	1	https://i.pinimg.com/736x/b3/b6/dd/b3b6dd519638967c2a674f70cf2aa37a.jpg	11490000	11490000	11490000	{https://i.pinimg.com/736x/b3/b6/dd/b3b6dd519638967c2a674f70cf2aa37a.jpg,https://i.pinimg.com/564x/2e/55/0a/2e550a693e06757f991210424d1a1c1a.jpg}
4	iPad Air 5	ipad-air-5	\N	Apple	t	2024-06-12 16:24:24.605	\N	\N	\N	\N	3	\N	\N	\N	1	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	11490000	11490000	11490000	{https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/9/_/9_44_1.jpg}
5	iPad mini 6	ipad-mini-6	\N	Apple	t	2024-06-12 16:31:55.995	\N	\N	\N	\N	5	\N	\N	\N	1	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	11490000	11490000	11490000	{https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png,https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_246_1.jpg}
6	Ipad pro 2018 11inch	ipad-pro-2018-11inch	\N	Apple	t	2024-06-12 16:38:07.109	\N	\N	\N	\N	2	\N	\N	\N	1	https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro2018_3_3.jpg	11490000	11490000	11490000	{https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro2018_3_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/r/pro20181_3_3.jpg,https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_3_1.jpg}
7	iPad Air 4	ipad-air-4	<h3>Chip mạnh hàng đầu cho trải nghiệm hoàn hảo</h3><p>Apple trang bị cho <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a> 4 chip A14 Bionic 6 nhân. Số lượng bóng bán dẫn đạt 11.8 tỷ cao hơn 40% so với A13 Bionic (8.5 tỷ). Có thể thấy số lượng bóng bán dẫn càng lớn thì chip càng mạnh và tiết kiệm năng lượng hơn.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg" alt="Trang bị chip A14 mạnh hàng đầu của Apple | iPad Air 2020" width="800" height="533"></figure><p>A14 Bionic có 6 lõi chip, trong đó 2 lõi hiệu suất cao cho tác vụ phức tạp và 4 lõi còn lại cho các tác vụ thông thường.</p><p>Bên cạnh đó, bộ xử lý đồ hoạ GPU 4 lõi mang lại hiệu suất tối đa, nhanh hơn 30% so với thế hệ trước hứa hẹn iPad Air có thể chơi các trò chơi phức tạp đòi hỏi độ phân giải cao, video 4K,...</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg" alt="Chơi game hay nặng hay xem video 4K đều mượt mà | iPad Air 2020" width="800" height="533"></figure><p>A14 Bionic mang đến tốc độ xử lý vượt trội, nhanh chóng hơn cùng với khả năng xử lý đa nhiệm mượt mà cũng như <a href="https://www.thegioididong.com/may-tinh-bang-rom-64gb">bộ nhớ trong 64 GB</a> cho bạn không gian lưu trữ hình ảnh, video,...</p><h3>Tinh tế trong thiết kế cùng nhiều màu sắc đi kèm</h3><p>iPad Air 4 64GB có kiểu dáng mới tương tự iPad Pro 2020 nhưng có kích thước nhỏ hơn và dày chỉ 6.1 mm, khối lượng đạt 460 g dễ dàng mang theo bên mình mọi lúc mọi nơi. Thiết kế này giúp tương thích với bàn phím Apple Smart Keyboard Folio, Magic Keyboard của iPad Pro 11 inch và hỗ trợ bút Apple Pencil 2.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg" alt="Bàn phím Apple Smart Keyboard Folio | iPad Air 2020" width="1020" height="570"></figure><p>Thiết kế trong iPad Air 4 vuông vắn hơn nếu so với những dòng iPad trước, các góc cạnh được bo tròn nhẹ nhàng tạo cảm giác mềm mại hơn cho tổng thể.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg" alt="Góc cạnh bo tròn cho cảm giác mềm mại  | iPad Air 2020" width="800" height="533"></figure><p>iPad Air 2020 được thiết kế nguyên khối đẳng cấp cùng nhiều màu sắc trẻ trung cho bạn có nhiều sự lựa chọn hơn như: bạc, xám, vàng hồng, xanh lá và xanh dương.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg" alt="Đa màu sắc tăng thêm sự lựa chọn | iPad Air 2020" width="800" height="533"></figure><p>Nút Home truyền thống được loại bỏ trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>, tạo không gian hiển thị rộng hơn và tích hợp cảm biến vân tay Touch ID trên nút nguồn đặt ở phía trên của thân máy. Đồng thời, iPad Air trở thành sản phẩm đầu tiên của Apple tích hợp tính năng nhận diện vân tay vào chung với nút nguồn.&nbsp;</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg" alt="Touch ID tích hợp nút nguồn mở khoá nhanh chóng | iPad Air 2020" width="800" height="533"></figure><h3>Màn hình rộng, không gian hiển thị tuyệt vời</h3><p>iPad Air 2020 sử dụng công nghệ Liquid Retina và có độ phân giải 1640 x 2360 Pixels giúp iPad Air hiển thị hình ảnh sắc nét, màu sắc chân thật hơn. Từ đó, bạn có thể tận hưởng trọn vẹn những thước phim bom tấn ấn tượng hay chơi game phải gọi là "bao mướt".&nbsp;</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg" alt="Màn hình đạt chuẩn Liquid Retina | iPad Air 2020" width="800" height="533"></figure><p>Màn hình của iPad Air có hỗ trợ dải màu rộng DCI-P3 với tính năng True-Tone cho khả năng tái tạo màu sắc chính xác hỗ trợ ưu việt cho công việc đồ họa. Hơn nữa, có lớp phủ chống lóa bề mặt, độ sáng cao giúp luôn hiển thị tốt trong nhiều điều kiện ánh sáng khác nhau, ngoài trời cũng không thành vấn đề.</p><h3>Camera đơn đa chức năng</h3><p>Camera sau có độ phân giải 12 MP cùng với đó là khả năng quay video 4K/60fps chống rung được nâng cấp, hỗ trợ Smart HDR 3.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181820-041847.jpg" alt="Camera sau với cảm biến 12 MP | iPad Air 2020" width="800" height="533"></figure><p><br>Ở mặt trước được trang bị camera 7 MP, hỗ trợ quay video HD phục vụ tốt các tác vụ gọi Facetime họp hành hay đơn giản là trò chuyện cùng người thân.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182120-042155.jpg" alt="Camera FaceTime với cảm biến 7 MP | iPad Air 2020" width="800" height="533"></figure><h3>Cổng sạc Type-C thuận lợi</h3><p>iPad Air 2020 chuyển mình với cổng Type-C giống trên các thiết bị iPad Pro. Viên pin cũng được nâng cấp và có khả năng lướt web lên 10 tiếng đem đến những trải nghiệm, làm việc giải trí liên tục.</p><figure class="image"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183820-053819.jpg" alt="Cổng sạc Type-C thuận lợi trong quá trình sử dụng | iPad Air 2020" width="800" height="533"></figure><p>Nhìn chung có thể thấy, iPad Air là một phiên bản rút gọn của iPad Pro với mức giá phải chăng hơn. Trong đó, tần số quét 120Hz, Face ID và cụm camera LiDAR là những thứ không có trên iPad Air. Nếu bạn không cần những thiếu sót ấy thì iPad Air 2020 là sự lựa chọn rất hợp lý.</p><p><br>&nbsp;</p>	Apple	t	2024-06-16 13:06:59.589	\N	\N	\N	Apple đã trình làng máy tính bảng iPad Air 4 Wifi 64 GB (2020). Đây là thiết bị đầu tiên của hãng được trang bị chip A14 Bionic - chip di động mạnh nhất của Apple (năm 2020). Và có màn lột xác nhờ thiết kế được thừa hưởng từ iPad Pro với viền màn hình mỏng bo cong quanh máy.	4	\N	\N	\N	1	https://i.pinimg.com/736x/46/7d/04/467d0438050da4590c5d5df9324136f2.jpg	11490000	11490000	11490000	{https://i.pinimg.com/736x/46/7d/04/467d0438050da4590c5d5df9324136f2.jpg,https://i.pinimg.com/564x/1c/a8/02/1ca802a9537710a9225d00dd5ff7c955.jpg}
9	iPad Pro M2 12.9 inch WiFi	ipad-pro-m2-129-inch-wifi	<h3><a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch</a>&nbsp;là mẫu tablet mới nhất được nhà Apple phát hành vào tháng 10/2022. Thiết bị được coi là tâm điểm của giới công nghệ tại thời điểm ra mắt khi được trang bị con chip Apple M2 mạnh mẽ, bên cạnh đó sẽ là những ưu điểm khác vượt trội như: hệ điều hành iPadOS 16, quay video 4K với tốc độ khung hình 60 FPS, tần số quét 120 Hz,...</h3><h3>Hoàn thiện cao cấp</h3><p>Tổng quan về tablet thì máy sẽ được hoàn thiện với phần mặt lưng kim loại chắc chắn, khung viền được vát cạnh ở xung quanh và đi kèm với 4 góc bo cong nhẹ để mang lại cái nhìn thanh thoát - hiện đại.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103052.jpg" alt="Thiết kế cao cấp - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Năm nay nhà Apple đã sắp xếp linh kiện một cách thông minh và tối ưu phần cứng tốt hơn nên máy chỉ dày khoảng 6.4 mm, điều này giúp cho iPad Pro M2 trở thành chiếc tablet có kích thước siêu mỏng đáng kinh ngạc.</p><h3>Sức mạnh đáng kinh ngạc đến từ chipset M2</h3><p>Apple M2 chắc hẳn không còn xa lạ đối với phần lớn tín đồ công nghệ bởi đây là cái tên từng xuất hiện trên dòng Macbook vào giữa năm 2022. Kể từ khi ra mắt, Apple M2 bỗng dưng trở thành một hiện tượng khi xuất hiện trên hầu hết các mặt báo với nhiều chủ đề xoay quanh đến nội dung “hiệu năng vô đối”.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103056.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Giờ đây Apple đã đưa con chip này đến với dòng tablet nhằm giúp khách hàng có thể xử lý các công việc đồ họa một cách dễ dàng, nâng cấp trải nghiệm lên một tầm cao mới để người dùng có thể cảm nhận như đang sử dụng một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> hiệu năng cao siêu mỏng nhẹ.</p><p>Apple M2 khi được trang bị trên dòng iPad Pro 2022 sẽ có 8 lõi CPU và 10 lõi GPU, hãng có công bố về hiệu suất của thế hệ chip mới này sẽ mạnh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với Apple M1. Vì thế máy có thể xử lý tốt hầu hết mọi tác vụ từ chơi game, chỉnh sửa video hay thiết kế hình ảnh cả về 2D lẫn 3D.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103059.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>iPad Pro M2 sẽ được hỗ trợ hệ điều hành iPadOS 16 mới nhất cho năm 2022, đây được xem là một sự nâng cấp vượt bậc so với thế hệ trước, bởi phiên bản này sẽ hỗ trợ nhiều tính năng hay ho hơn, tối ưu giao diện đẹp mắt cũng như tăng cường khả năng bảo mật để thông tin cá nhân của bạn được an toàn.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103105.jpg" alt="Bổ sung nhiều tính năng - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Bên cạnh việc nâng cấp trải nghiệm trực tiếp trên thiết bị, iPad Pro M2 còn có khả năng xử lý việc truyền tải dữ liệu sang màn hình khác ổn định hơn, giảm thiểu độ trễ đáng kể để có thể đồng bộ hóa các thao tác của bạn một cách tốt nhất.</p><h3>Màn hình đảm bảo độ chính xác màu sắc cực cao</h3><p>iPad Pro M2 sẽ được tích hợp một màn hình có kích thước 12.9 inch và độ phân giải 2048 x 2732 Pixels. Chỉ cần trang bị thêm một chiếc <a href="https://www.thegioididong.com/phu-kien-thong-minh/ban-phim-magic-keyboard-apple-mk2a3">Magic Keyboard</a> là người dùng sẽ có được cảm nhận tương tự như một chiếc laptop thực thụ, bởi nội dung hình ảnh mà màn hình mang tới là cực kỳ rộng lớn và đã mắt.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103101.jpg" alt="Màn hình rộng lớn - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Đối với các công nghệ màn hình thì lần này Apple tích hợp cho iPad Pro M2 một tấm nền Liquid Retina XDR mini-LED LCD được sản xuất bởi hãng, đi kèm với đó là dải màu rộng P3 và True Tone giúp tăng độ chính xác về màu sắc mỗi khi hiển thị, phù hợp cho các tác vụ thiết kế - in ấn nhờ khả năng hạn chế độ sai lệch màu mỗi khi in ra thành phẩm.</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><p>Một điểm nổi bật khác cũng không hề kém cạnh là tần số quét 120 Hz, điều này sẽ giúp ích cho người dùng mỗi khi chơi các tựa game FPS cao hay thao tác trơn tru hơn trong lúc sử dụng cùng với <a href="https://www.thegioididong.com/phu-kien-thong-minh/apple-pencil-the-he-2">Apple Pencil 2</a>.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103102.jpg" alt="Tương thích tốt hơn - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><h3>Hỗ trợ khả năng quay - chụp chuẩn chuyên nghiệp</h3><p><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này&nbsp;được hỗ trợ 2 camera trong đó cảm biến chính có độ phân giải 12 MP và 10 MP đối với cái còn lại để hỗ trợ cho việc chụp ảnh góc siêu rộng. Bổ sung theo đó là các tính năng nổi bật như quay chậm (Slow Motion), tua nhanh thời gian (Time‑lapse) và Smart HDR 4.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103109.jpg" alt="Camera chất lượng - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>iPad Pro M2 không đơn thuần là <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> xử lý công việc như trên một chiếc laptop gọn nhẹ nữa, mà giờ đây hãng đã không ngừng cải tiến để thiết bị có thể thay thế cameraphone về khoản quay - chụp, mang đến khả năng tối ưu hai tác vụ quay - dựng trên cùng một thiết bị nhằm giúp công việc của các bạn làm về chỉnh sửa nội dung video trở nên thuận tiện hơn thông qua chuẩn video tối đa mà máy quay được là 4K 2160p@60fps.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103111.jpg" alt="Hỗ trợ quay video chuẩn 4K - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p>Mặt trước sẽ là camera TrueDepth 12 MP và được hỗ trợ tính năng nhận diện khuôn mặt thông minh Face ID, nhờ có sự nâng cấp về thuật toán trên Apple M2 nên máy sẽ có khả năng nhận diện chính xác hơn, đối với những điều kiện thiếu sáng thì phần camera này cũng hoạt động khá nhạy để bạn có thể mở khóa thiết bị nhanh chóng hơn.</p><h3>Nâng cao thời gian sử dụng</h3><p>Tích hợp bên trong sẽ là viên pin có dung lượng 40.88 Wh hay có thể nói là xấp xỉ 10.835 mAh. Đối với những nhu cầu cơ bản như xem phim, nghe nhạc hay lướt web thì iPad Pro M2 hoàn toàn có thể đáp ứng cho bạn thời lượng dùng cả ngày, dao động tầm 8 - 10 tiếng sử dụng liên tục ở kết nối mạng Wi-Fi.</p><figure class="image"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294105/ipad-pro-m2-12-9-inch-251022-103104.jpg" alt="An tâm sử dụng dài lâu - iPad Pro M2 12.9 inch WiFi 128GB" width="1020" height="570"></figure><p><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a>&nbsp;năm nay chắc hẳn sẽ làm các tín đồ công nghệ mê mẩn không thôi bởi độ mạnh mẽ vượt trội về hiệu năng so với các sản phẩm trong cùng phân khúc, sự xuất hiện của Apple M2 trên dòng iPad Pro 2022 đang ngầm khẳng định vị thế số 1 của hãng cũng như khoảng cách rất xa mà nhà Apple đã vượt mặt các đối thủ.</p>	Apple	t	2024-06-16 15:29:16.971	\N	\N	\N	Sau iPhone, iPad chính là sản phẩm tiếp theo được Apple cho ra mắt phiên bản 2022. Máy tính bảng iPad Pro 12.9 inch 2022 M2 Wifi được trang bị con chip M2 thế hệ mới, camera chụp ảnh chuyên nghiệp cùng Apple Pencil giúp mang lại cho người dùng những trải nghiệm di chuột ấn tượng.	2	\N	\N	\N	1	https://i.pinimg.com/736x/76/1c/be/761cbe916cf57904b3c6ca13e35b494b.jpg	11490000	11490000	11490000	{https://i.pinimg.com/736x/76/1c/be/761cbe916cf57904b3c6ca13e35b494b.jpg,https://i.pinimg.com/564x/dc/0c/70/dc0c70d6eea10a10566b2f6c30f5a2b6.jpg,https://i.pinimg.com/564x/a8/43/7e/a8437e8843219055a663af9543763142.jpg}
8	iPad Air 6	ipad-air-6	<h2><strong>ĐẶC ĐIỂM NỔI BẬT</strong></h2><ul><li>Trang bị chip Apple M2 mạnh mẽ, xử lý mượt mà mọi tác vụ, từ công việc văn phòng đến sáng tạo nội dung.</li><li>Màn hình Liquid Retina rực rỡ cho trải nghiệm hình ảnh sống động, sắc nét và chân thực.</li><li>Gọi video call chất lượng cao với camera trước góc siêu rộng 12MP.</li><li>Thiết kế mỏng nhẹ, di động linh hoạt, dễ dàng mang theo bên mình mọi lúc mọi nơi, phục vụ đa dạng nhu cầu.</li></ul><p>iPad Air 6 M2 11 inch sở hữu màn hình Retina 11 inch với công nghệ IPS cùng dải màu P3 hỗ trợ hiển thị hình ảnh sống động. iPad với màn hình độ sáng cao tới 500 nits cùng với lớp phủ oleophobia chống dấu vân tay vượt trội. Cùng với đó <a href="https://cellphones.com.vn/tablet/ipad-air/ipad-air-2024.html"><strong>iPad Air 6 M2 2024</strong></a> này hoạt động trên con chip Apple M2 cùng dung lượng RAM 8GB.</p><h2><strong>So sánh&nbsp;iPad Air 6 M2 11 inch Wifi và iPad Air 5</strong></h2><p><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 11 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>11 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p>Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p>&nbsp;</p><h3><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p>&nbsp;</p><p>Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p>Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p>&nbsp;</p><h3><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p>iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p>&nbsp;</p><h3><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p>Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p>&nbsp;</p>	Apple	t	2024-06-16 15:09:34.435	\N	\N	\N	iPad Air 6 M2 11 inch sở hữu màn hình Retina 11 inch với công nghệ IPS cùng dải màu P3 hỗ trợ hiển thị hình ảnh sống động. iPad với màn hình độ sáng cao tới 500 nits cùng với lớp phủ oleophobia chống dấu vân tay vượt trội. Cùng với đó iPad Air 6 M2 2024 này hoạt động trên con chip Apple M2 cùng dung lượng RAM 8GB.	3	\N	\N	\N	1	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch_2_1.jpg	11490000	11490000	11490000	{https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch_2_1.jpg,https://i.pinimg.com/736x/08/da/11/08da11b670a7250719088c41a46aa370.jpg}
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
1	1	Hệ điều hành	iPadOS 17	\N
2	1	Chip xử lý (CPU)	Apple A14 Bionic 6 nhân	\N
3	1	Tốc độ CPU	2 nhân 3.1 GHz & 4 nhân 1.8 GHz	\N
4	1	Chip đồ hoạ (GPU)	Apple GPU 4 nhân	\N
5	2	RAM	4 GB	\N
6	3	Công nghệ màn hình	Retina IPS LCD	\N
7	3	Độ phân giải	1640 x 2360 Pixels	\N
8	3	Màn hình rộng	10.9 - Tần số quét 60 Hz	\N
9	3	Màn hình	10.2"Retina IPS LCD	\N
10	1	Hệ điều hành	iPadOS 15	\N
11	1	Chip	Apple A13 Bionic	\N
12	6	Kết nối	Nghe gọi qua FaceTime	\N
13	4	Camera sau	8 MP	\N
14	5	Pin, Sạc	32.4 Wh (~ 8600 mAh)20 W	\N
15	3	màn hình	10.9 inches	\N
16	3	Công nghệ màn hình	Liquid Retina	\N
17	4	Camera sau	12MP	\N
18	4	Camera trước	12MP	\N
19	1	Chip	Apple M1 8 nhân	\N
20	5	Pin	28.6 Wh (~ 7587 mAh)	\N
21	3	màn hình	8.3 inches	\N
22	3	Công nghệ màn hình	Mini LED	\N
23	4	Camera sau	12MP khẩu độ f/1.8	\N
24	4	Camera trước	12MP góc rộng	\N
25	1	Chip	Apple A15 Bionic 6 nhân	\N
26	5	Pin	19.3 Wh (~ 5175 mAh)	\N
27	1	Hệ điều hành	iPadOS 15	\N
28	3	Kích thước màn hình	10.86 inches	\N
29	4	Camera trước	Camera trước Ultra Wide 12MP trên cạnh ngang Khẩu độ ƒ/2.4	\N
30	1	Chip	Apple M2	\N
31	5	Pin	Tích hợp pin sạc Li-Po 28,93 watt‑giờ	\N
32	1	Hệ điều hành	iPadOS 17	\N
33	3	Độ phân giải màn hình	2360 x 1640 pixel	\N
34	3	Màn hình	12.9"Liquid Retina XDR	
35	1	Hệ điều hành	iPadOS 16	
36	1	Chip	Apple M2 8 nhân	\N
37	4	Camera sau	Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR	\N
38	4	Camera trước	12 MP	\N
39	5	Pin, Sạc	40.88 Wh (~ 10.835 mAh)20 W	\N
\.


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductVariant" (id, barcode, compare_at_price, option1, option2, option3, "position", price, sku, title, updated_at, inventory_quantity, available, product_id) FROM stdin;
9	\N	14990000	Hồng	64GB		0	11490000	6aca9a82-b8fa-4022-99de-f5c47d300f9c	Hồng / 64GB	\N	1	t	2
10	\N	14990000	Hồng	256GB		1	11490000	421aee0c-1ae4-4437-820c-2f5ccc5abe95	Hồng / 256GB	\N	1	t	2
11	\N	14990000	Bạc	64GB		2	11490000	180c0a75-4dac-4aca-8adc-087680d95648	Bạc / 64GB	\N	1	t	2
12	\N	14990000	Bạc	256GB		3	11490000	5461a353-a579-4ce0-af98-3d1fd9b036bb	Bạc / 256GB	\N	1	t	2
13	\N	14990000	Vàng	64GB		4	11490000	5d5db157-c3ff-4118-90be-7e3b2e9c3e6e	Vàng / 64GB	\N	1	t	2
14	\N	14990000	Vàng	256GB		5	11490000	5c56374e-bdbc-4a84-965e-8f6c9a095377	Vàng / 256GB	\N	1	t	2
15	\N	14990000	Xanh	64GB		6	11490000	5707f98b-8b86-4274-9305-46a8e0c554f3	Xanh / 64GB	\N	1	t	2
16	\N	14990000	Xanh	256GB		7	11490000	447ed480-400d-4399-8008-4956d4e910ab	Xanh / 256GB	\N	1	t	2
17	\N	14990000	Bạc	64GB		0	11490000	07095188-ff63-4440-b782-49e35b24cd95	Bạc / 64GB	\N	1	t	3
18	\N	14990000	Bạc	256GB		1	11490000	552e3461-2ee6-4d90-ac47-80152560effa	Bạc / 256GB	\N	1	t	3
19	\N	14990000	Xám	64GB		2	11490000	739d7146-8d40-4886-98fa-ba92f5cb0001	Xám / 64GB	\N	1	t	3
20	\N	14990000	Xám	256GB		3	11490000	19c95762-4615-4872-b559-111ab0c0a331	Xám / 256GB	\N	1	t	3
21	\N	14990000	Hồng	64GB		0	11490000	8e04f16f-d99a-4b32-ac7b-30d37e62edc8	Hồng / 64GB	\N	1	t	4
22	\N	14990000	Hồng	256GB		1	11490000	0f158567-1503-4c54-843e-76a4c7e73b03	Hồng / 256GB	\N	1	t	4
23	\N	14990000	Tím	64GB		2	11490000	f5498e02-ed1d-469f-81c0-4c46247983c7	Tím / 64GB	\N	1	t	4
24	\N	14990000	Tím	256GB		3	11490000	fc7b9e05-1f53-44a6-8dea-853079f6cb3b	Tím / 256GB	\N	1	t	4
25	\N	14990000	Trắng vàng	64GB		4	11490000	d825e4f7-197b-4cfd-a250-bc2fc7b30a38	Trắng vàng / 64GB	\N	1	t	4
26	\N	14990000	Trắng vàng	256GB		5	11490000	deb75aa4-8338-4dac-b883-d50cce520b8e	Trắng vàng / 256GB	\N	1	t	4
27	\N	14990000	Xám	64GB		6	11490000	0df5cf01-ae15-44af-8287-30adb51c39b4	Xám / 64GB	\N	1	t	4
28	\N	14990000	Xám	256GB		7	11490000	9fab65d1-7615-4d5f-b054-71813d6454f0	Xám / 256GB	\N	1	t	4
29	\N	14990000	Xanh	64GB		8	11490000	69e1b08b-fa6d-47eb-8e0f-b73292c89f8c	Xanh / 64GB	\N	1	t	4
30	\N	14990000	Xanh	256GB		9	11490000	b20e203c-5926-4c62-be63-d68e4fceb3e0	Xanh / 256GB	\N	1	t	4
31	\N	14990000	Tím	64GB		0	11490000	fcf51767-2258-41d2-a00d-e1316e6fd312	Tím / 64GB	\N	1	t	5
32	\N	14990000	Tím	256GB		1	11490000	3df110ed-4686-4619-b41a-340e091f9f10	Tím / 256GB	\N	1	t	5
33	\N	14990000	Trắng vàng	64GB		2	11490000	9f19e276-f0c1-405a-b8b3-2475a9f8388c	Trắng vàng / 64GB	\N	1	t	5
34	\N	14990000	Trắng vàng	256GB		3	11490000	0dfefdaf-c293-4f00-87c5-40b823660c59	Trắng vàng / 256GB	\N	1	t	5
35	\N	14990000	Hồng	64GB		4	11490000	78c748e4-bb20-40ab-949a-d256a94252f8	Hồng / 64GB	\N	1	t	5
36	\N	14990000	Hồng	256GB		5	11490000	abed52dc-1914-4572-8ed2-b95b32fd7ea6	Hồng / 256GB	\N	1	t	5
37	\N	14990000	Xám	64GB		6	11490000	9f053218-52de-4081-96b3-7aa342495d04	Xám / 64GB	\N	1	t	5
38	\N	14990000	Xám	256GB		7	11490000	2e75392d-e4c7-451e-88f7-35ab289c425b	Xám / 256GB	\N	1	t	5
39	\N	14990000	Bạc	64GB		0	11490000	a715d0ad-bd8f-4b7c-9410-2a5c5edf3137	Bạc / 64GB	\N	1	t	6
40	\N	14990000	Bạc	256GB		1	11490000	a75d8d4f-ba0a-4588-be8f-da359d5605cf	Bạc / 256GB	\N	1	t	6
41	\N	14990000	Bạc	512GB		2	11490000	5956e48c-e2d4-41aa-b3d7-c49fb8d0f6b7	Bạc / 512GB	\N	1	t	6
42	\N	14990000	Bạc	1T		3	11490000	a68fa7dd-f7f9-499a-9724-c6c247b21f31	Bạc / 1T	\N	1	t	6
43	\N	14990000	Xám	64GB		4	11490000	a608da21-b6f7-4d61-8403-33c775b1a817	Xám / 64GB	\N	1	t	6
44	\N	14990000	Xám	256GB		5	11490000	cbc0c6b8-5dc1-43a3-a8a1-5842656f3df0	Xám / 256GB	\N	1	t	6
45	\N	14990000	Xám	512GB		6	11490000	1796d3b9-7534-425c-8f88-50ddb1d3b9a3	Xám / 512GB	\N	1	t	6
46	\N	14990000	Xám	1T		7	11490000	032e7f22-1e83-4c56-aef8-2edc32611d11	Xám / 1T	\N	1	t	6
47	\N	14990000	Xám	64GB		0	11490000	1377aca5-6fa3-4713-b92f-dd88d0d8b38c	Xám / 64GB	\N	1	t	7
48	\N	14990000	Xám	256GB		1	11490000	3e6f507a-f7bc-410b-8666-587aaa4feef6	Xám / 256GB	\N	1	t	7
49	\N	14990000	Xanh lá	64GB		2	11490000	5ff7a03e-a86b-495d-b895-f1bada559fac	Xanh lá / 64GB	\N	1	t	7
50	\N	14990000	Xanh lá	256GB		3	11490000	2eebfa49-46f3-4aaa-94a0-7cd0822773e2	Xanh lá / 256GB	\N	1	t	7
51	\N	14990000	Xanh dương	64GB		4	11490000	1df2cbbc-27c9-4510-8ebb-7dc2f751c197	Xanh dương / 64GB	\N	1	t	7
52	\N	14990000	Xanh dương	256GB		5	11490000	969cb2fa-1c9a-4be8-9abd-d47c42c11100	Xanh dương / 256GB	\N	1	t	7
53	\N	14990000	Vàng hồng	64GB		6	11490000	f9ae5638-3a4c-48a1-91ec-0c60fa560e61	Vàng hồng / 64GB	\N	1	t	7
54	\N	14990000	Vàng hồng	256GB		7	11490000	51d5d2ee-f932-4774-ae76-24f1fd77fb8f	Vàng hồng / 256GB	\N	1	t	7
55	\N	14990000	Bạc	64GB		8	11490000	105b5ed8-dabd-4491-8a1b-bf67f0ce1bd2	Bạc / 64GB	\N	1	t	7
56	\N	14990000	Bạc	256GB		9	11490000	542af904-0692-4efc-806a-14c429c2d975	Bạc / 256GB	\N	1	t	7
57	\N	14990000	Trắng vàng	128GB		0	11490000	fb9ad052-a9ca-44e3-999f-3d654e4cce48	Trắng vàng / 128GB	\N	1	t	8
58	\N	14990000	Trắng vàng	256GB		1	11490000	3aaad330-1eed-4e21-a49c-ac477981f688	Trắng vàng / 256GB	\N	1	t	8
59	\N	14990000	Trắng vàng	512GB		2	11490000	b788c231-e226-4279-9b34-ba94dd400f1d	Trắng vàng / 512GB	\N	1	t	8
60	\N	14990000	Trắng vàng	1T		3	11490000	1f0716d4-ce7a-47b2-a345-1710bacd31bf	Trắng vàng / 1T	\N	1	t	8
61	\N	14990000	Xanh dương	128GB		4	11490000	f14f2488-dff4-4ff3-aabb-8dca1ba6b918	Xanh dương / 128GB	\N	1	t	8
62	\N	14990000	Xanh dương	256GB		5	11490000	b080377e-5a72-4489-8ac9-724eedd5fb72	Xanh dương / 256GB	\N	1	t	8
63	\N	14990000	Xanh dương	512GB		6	11490000	e2c1d530-a01f-440a-b1af-e9394cce96ae	Xanh dương / 512GB	\N	1	t	8
64	\N	14990000	Xanh dương	1T		7	11490000	c1b56e9d-abc7-4a06-9db5-5336bc0ef090	Xanh dương / 1T	\N	1	t	8
65	\N	14990000	Xám	128GB		8	11490000	d0f07e5a-b484-4e1c-a57a-fe954f2feec4	Xám / 128GB	\N	1	t	8
66	\N	14990000	Xám	256GB		9	11490000	9762c7c6-cd32-4d9f-b04b-9c39060b8419	Xám / 256GB	\N	1	t	8
67	\N	14990000	Xám	512GB		10	11490000	43400a49-b03d-4aea-8eea-142992f51fe0	Xám / 512GB	\N	1	t	8
68	\N	14990000	Xám	1T		11	11490000	5b9fb7db-ce72-4975-a43b-8aba9fd15a7c	Xám / 1T	\N	1	t	8
69	\N	14990000	Tím	128GB		12	11490000	4253fb86-378b-4758-b9ab-d987b5f0a084	Tím / 128GB	\N	1	t	8
70	\N	14990000	Tím	256GB		13	11490000	b35756c3-8e2b-4e74-9492-a6bed26264c7	Tím / 256GB	\N	1	t	8
71	\N	14990000	Tím	512GB		14	11490000	e3df58cc-1681-48e9-be39-960cedb4dde4	Tím / 512GB	\N	1	t	8
72	\N	14990000	Tím	1T		15	11490000	56c1fa86-d8f0-4d04-a266-abb57b3848a0	Tím / 1T	\N	1	t	8
73	\N	14990000	Bạc	128GB		0	11490000	eb69e7c0-4e14-4a65-a0e1-dabc67b5ba5b	Bạc / 128GB	\N	1	t	9
74	\N	14990000	Bạc	256GB		1	11490000	7e0a40f3-ef97-4f80-9d72-092dcce16cf9	Bạc / 256GB	\N	1	t	9
75	\N	14990000	Bạc	512GB		2	11490000	da464a3c-e17d-4cca-bfac-d51e1cabde3e	Bạc / 512GB	\N	1	t	9
76	\N	14990000	Xám	128GB		3	11490000	feaeaa15-55c5-4de5-8b25-352a2a17f70e	Xám / 128GB	\N	1	t	9
77	\N	14990000	Xám	256GB		4	11490000	beec923f-546e-46f3-9988-a426e906e661	Xám / 256GB	\N	1	t	9
78	\N	14990000	Xám	512GB		5	11490000	69682eed-c6ec-4e1d-98cc-3da07a9ca8df	Xám / 512GB	\N	1	t	9
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
2	1
2	2
2	3
2	4
2	5
2	6
2	7
2	8
3	6
3	9
3	10
3	11
3	12
3	13
3	14
4	10
4	15
4	16
4	17
4	18
4	19
4	20
5	21
5	22
5	23
5	24
5	25
5	26
5	27
8	27
8	28
8	29
8	30
8	31
8	32
8	33
9	33
9	34
9	35
9	36
9	37
9	38
9	39
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
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

SELECT pg_catalog.setval('public."CategoryArticle_id_seq"', 1, false);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Category_id_seq"', 14, true);


--
-- Name: Customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Customer_id_seq"', 1, false);


--
-- Name: Option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Option_id_seq"', 18, true);


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

SELECT pg_catalog.setval('public."ProductSpecifications_id_seq"', 39, true);


--
-- Name: ProductVariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductVariant_id_seq"', 78, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Product_id_seq"', 9, true);


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
    ADD CONSTRAINT "ProductSpecifications_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."SpecificationsType"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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

