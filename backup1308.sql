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
-- Name: Gender; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


ALTER TYPE public."Gender" OWNER TO tp_user;

--
-- Name: LocationType; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."LocationType" AS ENUM (
    'PROVINCE',
    'DISTRICT',
    'WARD'
);


ALTER TYPE public."LocationType" OWNER TO tp_user;

--
-- Name: LocationTypeCode; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."LocationTypeCode" AS ENUM (
    'PROVINCE',
    'DISTRICT',
    'WARD'
);


ALTER TYPE public."LocationTypeCode" OWNER TO tp_user;

--
-- Name: OptionStyle; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."OptionStyle" AS ENUM (
    'IMAGE',
    'COLOR',
    'CIRCLE',
    'RECTANGLE',
    'RADIO'
);


ALTER TYPE public."OptionStyle" OWNER TO tp_user;

--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PENDING',
    'COMPLETED',
    'FAILED'
);


ALTER TYPE public."PaymentStatus" OWNER TO tp_user;

--
-- Name: PermissionType; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."PermissionType" AS ENUM (
    'READ_ONLY',
    'READ_WRITE'
);


ALTER TYPE public."PermissionType" OWNER TO tp_user;

--
-- Name: ShippingStatus; Type: TYPE; Schema: public; Owner: tp_user
--

CREATE TYPE public."ShippingStatus" AS ENUM (
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED'
);


ALTER TYPE public."ShippingStatus" OWNER TO tp_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Address; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Address" (
    id integer NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ward_id integer NOT NULL,
    district_id integer NOT NULL,
    province_id integer NOT NULL,
    updated_at timestamp(3) without time zone,
    customer_id integer NOT NULL,
    detail_address text NOT NULL
);


ALTER TABLE public."Address" OWNER TO tp_user;

--
-- Name: Address_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Address_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Address_id_seq" OWNER TO tp_user;

--
-- Name: Address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Address_id_seq" OWNED BY public."Address".id;


--
-- Name: Answer; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Answer" (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    author_id integer,
    customer_id integer,
    question_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public."Answer" OWNER TO tp_user;

--
-- Name: Answer_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Answer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Answer_id_seq" OWNER TO tp_user;

--
-- Name: Answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Answer_id_seq" OWNED BY public."Answer".id;


--
-- Name: Article; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Article" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    status integer NOT NULL,
    content text,
    category_id integer,
    thumnal_url text,
    description text,
    meta_data jsonb,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    author_id integer
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
-- Name: AttributeValues; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."AttributeValues" (
    id integer NOT NULL,
    value text NOT NULL,
    slug text NOT NULL,
    hex_color text,
    attribute_id integer NOT NULL
);


ALTER TABLE public."AttributeValues" OWNER TO tp_user;

--
-- Name: AttributeValues_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."AttributeValues_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AttributeValues_id_seq" OWNER TO tp_user;

--
-- Name: AttributeValues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."AttributeValues_id_seq" OWNED BY public."AttributeValues".id;


--
-- Name: Attributes; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Attributes" (
    id integer NOT NULL,
    name text NOT NULL,
    style public."OptionStyle" DEFAULT 'RECTANGLE'::public."OptionStyle" NOT NULL,
    key text
);


ALTER TABLE public."Attributes" OWNER TO tp_user;

--
-- Name: Attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Attributes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Attributes_id_seq" OWNER TO tp_user;

--
-- Name: Attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Attributes_id_seq" OWNED BY public."Attributes".id;


--
-- Name: Brand; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Brand" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    logo text
);


ALTER TABLE public."Brand" OWNER TO tp_user;

--
-- Name: Brand_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Brand_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Brand_id_seq" OWNER TO tp_user;

--
-- Name: Brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Brand_id_seq" OWNED BY public."Brand".id;


--
-- Name: Cart; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Cart" (
    id integer NOT NULL,
    token text NOT NULL,
    item_count integer NOT NULL,
    total_price double precision NOT NULL,
    note text,
    customer_id integer,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
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
    slug text NOT NULL,
    description text,
    image text,
    published boolean DEFAULT false,
    meta_data jsonb
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
    published boolean DEFAULT false,
    meta_data jsonb
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
    email text,
    password text NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    gender public."Gender",
    birthday timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    provider text NOT NULL,
    provider_id text
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
-- Name: File; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."File" (
    id integer NOT NULL,
    id_root text,
    url text NOT NULL,
    format text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name text NOT NULL,
    folder_id integer,
    size integer NOT NULL
);


ALTER TABLE public."File" OWNER TO tp_user;

--
-- Name: File_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."File_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."File_id_seq" OWNER TO tp_user;

--
-- Name: File_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."File_id_seq" OWNED BY public."File".id;


--
-- Name: Folder; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Folder" (
    id integer NOT NULL,
    name text NOT NULL,
    parent_id integer,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Folder" OWNER TO tp_user;

--
-- Name: Folder_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Folder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Folder_id_seq" OWNER TO tp_user;

--
-- Name: Folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Folder_id_seq" OWNED BY public."Folder".id;


--
-- Name: Location; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    name text NOT NULL,
    type public."LocationTypeCode" NOT NULL,
    code text,
    parent_code text
);


ALTER TABLE public."Location" OWNER TO tp_user;

--
-- Name: Location_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Location_id_seq" OWNER TO tp_user;

--
-- Name: Location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Location_id_seq" OWNED BY public."Location".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    token text NOT NULL,
    code text NOT NULL,
    total_price double precision NOT NULL,
    temp_price double precision NOT NULL,
    ship_price double precision NOT NULL,
    discount double precision NOT NULL,
    note text,
    status integer NOT NULL,
    promotions jsonb[],
    customer_id integer,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
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
-- Name: Page; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Page" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    content_html text NOT NULL,
    meta_data jsonb,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Page" OWNER TO tp_user;

--
-- Name: Page_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Page_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Page_id_seq" OWNER TO tp_user;

--
-- Name: Page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Page_id_seq" OWNED BY public."Page".id;


--
-- Name: Payment; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Payment" (
    id integer NOT NULL,
    order_id integer NOT NULL,
    method text NOT NULL,
    transaction_id text,
    amount double precision NOT NULL,
    status public."PaymentStatus" NOT NULL,
    payment_date timestamp(3) without time zone
);


ALTER TABLE public."Payment" OWNER TO tp_user;

--
-- Name: Payment_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Payment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Payment_id_seq" OWNER TO tp_user;

--
-- Name: Payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Payment_id_seq" OWNED BY public."Payment".id;


--
-- Name: Permission; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Permission" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Permission" OWNER TO tp_user;

--
-- Name: Permission_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Permission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permission_id_seq" OWNER TO tp_user;

--
-- Name: Permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Permission_id_seq" OWNED BY public."Permission".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    description_html text,
    available boolean DEFAULT true NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    published_at timestamp(3) without time zone,
    barcode text,
    short_description text,
    meta_data jsonb,
    price double precision DEFAULT 0 NOT NULL,
    compare_at_price double precision DEFAULT 0 NOT NULL,
    price_max double precision DEFAULT 0 NOT NULL,
    price_min double precision DEFAULT 0 NOT NULL,
    brand_id integer,
    category_id integer NOT NULL,
    meta_tags jsonb,
    related integer[] DEFAULT ARRAY[]::integer[]
);


ALTER TABLE public."Product" OWNER TO tp_user;

--
-- Name: ProductAttributes; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductAttributes" (
    id integer NOT NULL,
    product_id integer NOT NULL,
    attribute_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public."ProductAttributes" OWNER TO tp_user;

--
-- Name: ProductAttributes_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductAttributes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductAttributes_id_seq" OWNER TO tp_user;

--
-- Name: ProductAttributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductAttributes_id_seq" OWNED BY public."ProductAttributes".id;


--
-- Name: ProductCategories; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductCategories" (
    id integer NOT NULL,
    priority integer,
    category_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public."ProductCategories" OWNER TO tp_user;

--
-- Name: ProductCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductCategories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductCategories_id_seq" OWNER TO tp_user;

--
-- Name: ProductCategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductCategories_id_seq" OWNED BY public."ProductCategories".id;


--
-- Name: ProductImage; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."ProductImage" (
    id integer NOT NULL,
    url text NOT NULL,
    alt_text text,
    "position" integer NOT NULL,
    is_featured boolean DEFAULT false NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public."ProductImage" OWNER TO tp_user;

--
-- Name: ProductImage_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."ProductImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ProductImage_id_seq" OWNER TO tp_user;

--
-- Name: ProductImage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."ProductImage_id_seq" OWNED BY public."ProductImage".id;


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
    cart_id integer,
    order_id integer
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
    value text NOT NULL,
    group_id integer NOT NULL,
    link text
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
    "position" integer NOT NULL,
    compare_at_price double precision NOT NULL,
    price double precision NOT NULL,
    sku text NOT NULL,
    title text NOT NULL,
    updated_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    inventory_quantity integer NOT NULL,
    available boolean NOT NULL,
    product_id integer NOT NULL,
    image_id integer,
    price_origin double precision DEFAULT 0 NOT NULL,
    sold_quantity integer DEFAULT 0 NOT NULL
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
-- Name: Question; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Question" (
    id integer NOT NULL,
    content text NOT NULL,
    product_id integer NOT NULL,
    customer_id integer,
    email text,
    phone text,
    full_name text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public."Question" OWNER TO tp_user;

--
-- Name: Question_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Question_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Question_id_seq" OWNER TO tp_user;

--
-- Name: Question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Question_id_seq" OWNED BY public."Question".id;


--
-- Name: Rating; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Rating" (
    id integer NOT NULL,
    rate integer NOT NULL,
    content text,
    images text[],
    product_id integer NOT NULL,
    customer_id integer NOT NULL,
    like_count integer DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public."Rating" OWNER TO tp_user;

--
-- Name: Rating_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Rating_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rating_id_seq" OWNER TO tp_user;

--
-- Name: Rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Rating_id_seq" OWNED BY public."Rating".id;


--
-- Name: Role; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Role" (
    id integer NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    description text
);


ALTER TABLE public."Role" OWNER TO tp_user;

--
-- Name: RolePermission; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."RolePermission" (
    id integer NOT NULL,
    "roleId" integer NOT NULL,
    "permissionId" integer NOT NULL,
    type public."PermissionType" NOT NULL
);


ALTER TABLE public."RolePermission" OWNER TO tp_user;

--
-- Name: RolePermission_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."RolePermission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."RolePermission_id_seq" OWNER TO tp_user;

--
-- Name: RolePermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."RolePermission_id_seq" OWNED BY public."RolePermission".id;


--
-- Name: Role_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Role_id_seq" OWNER TO tp_user;

--
-- Name: Role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;


--
-- Name: Setting; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Setting" (
    id integer NOT NULL,
    key text NOT NULL,
    value jsonb,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    access_control integer[]
);


ALTER TABLE public."Setting" OWNER TO tp_user;

--
-- Name: SettingHistory; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."SettingHistory" (
    id integer NOT NULL,
    setting_id integer NOT NULL,
    "oldValue" jsonb NOT NULL,
    "newValue" jsonb NOT NULL,
    "updatedBy" text,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."SettingHistory" OWNER TO tp_user;

--
-- Name: SettingHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."SettingHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SettingHistory_id_seq" OWNER TO tp_user;

--
-- Name: SettingHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."SettingHistory_id_seq" OWNED BY public."SettingHistory".id;


--
-- Name: Setting_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Setting_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Setting_id_seq" OWNER TO tp_user;

--
-- Name: Setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Setting_id_seq" OWNED BY public."Setting".id;


--
-- Name: Shipping; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Shipping" (
    id integer NOT NULL,
    order_id integer NOT NULL,
    address text NOT NULL,
    province text NOT NULL,
    district text NOT NULL,
    ward text NOT NULL,
    country text NOT NULL,
    address_full text NOT NULL,
    ship_date timestamp(3) without time zone,
    tracking_number text,
    phone text NOT NULL,
    fullname text NOT NULL,
    status public."ShippingStatus" DEFAULT 'PROCESSING'::public."ShippingStatus" NOT NULL,
    tracking_url text,
    carrier text,
    estimated_delivery_date timestamp(3) without time zone,
    shipping_method text,
    delivery_status text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public."Shipping" OWNER TO tp_user;

--
-- Name: Shipping_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Shipping_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Shipping_id_seq" OWNER TO tp_user;

--
-- Name: Shipping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Shipping_id_seq" OWNED BY public."Shipping".id;


--
-- Name: SpecificationsGroup; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."SpecificationsGroup" (
    id integer NOT NULL,
    name text NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public."SpecificationsGroup" OWNER TO tp_user;

--
-- Name: SpecificationsGroup_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."SpecificationsGroup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SpecificationsGroup_id_seq" OWNER TO tp_user;

--
-- Name: SpecificationsGroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."SpecificationsGroup_id_seq" OWNED BY public."SpecificationsGroup".id;


--
-- Name: SpecificationsType; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."SpecificationsType" (
    id integer NOT NULL,
    name text NOT NULL
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
    phone text,
    url_map text,
    ward_id integer NOT NULL,
    district_id integer NOT NULL,
    province_id integer NOT NULL,
    detail_address text
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
-- Name: Tags; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."Tags" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    published boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Tags" OWNER TO tp_user;

--
-- Name: Tags_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."Tags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tags_id_seq" OWNER TO tp_user;

--
-- Name: Tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."Tags_id_seq" OWNED BY public."Tags".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    username text NOT NULL,
    avt text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    meta_data jsonb,
    email text NOT NULL
);


ALTER TABLE public."User" OWNER TO tp_user;

--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."UserRole" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "roleId" integer NOT NULL
);


ALTER TABLE public."UserRole" OWNER TO tp_user;

--
-- Name: UserRole_id_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public."UserRole_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserRole_id_seq" OWNER TO tp_user;

--
-- Name: UserRole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public."UserRole_id_seq" OWNED BY public."UserRole".id;


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
-- Name: _AttributeValuesToProductAttributes; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."_AttributeValuesToProductAttributes" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_AttributeValuesToProductAttributes" OWNER TO tp_user;

--
-- Name: _AttributeValuesToProductVariant; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."_AttributeValuesToProductVariant" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_AttributeValuesToProductVariant" OWNER TO tp_user;

--
-- Name: _ProductToProductSpecifications; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."_ProductToProductSpecifications" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToProductSpecifications" OWNER TO tp_user;

--
-- Name: _ProductToTags; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public."_ProductToTags" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToTags" OWNER TO tp_user;

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
-- Name: Address id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address" ALTER COLUMN id SET DEFAULT nextval('public."Address_id_seq"'::regclass);


--
-- Name: Answer id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Answer" ALTER COLUMN id SET DEFAULT nextval('public."Answer_id_seq"'::regclass);


--
-- Name: Article id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article" ALTER COLUMN id SET DEFAULT nextval('public."Article_id_seq"'::regclass);


--
-- Name: AttributeValues id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."AttributeValues" ALTER COLUMN id SET DEFAULT nextval('public."AttributeValues_id_seq"'::regclass);


--
-- Name: Attributes id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Attributes" ALTER COLUMN id SET DEFAULT nextval('public."Attributes_id_seq"'::regclass);


--
-- Name: Brand id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Brand" ALTER COLUMN id SET DEFAULT nextval('public."Brand_id_seq"'::regclass);


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
-- Name: File id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."File" ALTER COLUMN id SET DEFAULT nextval('public."File_id_seq"'::regclass);


--
-- Name: Folder id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Folder" ALTER COLUMN id SET DEFAULT nextval('public."Folder_id_seq"'::regclass);


--
-- Name: Location id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Location" ALTER COLUMN id SET DEFAULT nextval('public."Location_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Page id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Page" ALTER COLUMN id SET DEFAULT nextval('public."Page_id_seq"'::regclass);


--
-- Name: Payment id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Payment" ALTER COLUMN id SET DEFAULT nextval('public."Payment_id_seq"'::regclass);


--
-- Name: Permission id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Permission" ALTER COLUMN id SET DEFAULT nextval('public."Permission_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductAttributes id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductAttributes" ALTER COLUMN id SET DEFAULT nextval('public."ProductAttributes_id_seq"'::regclass);


--
-- Name: ProductCategories id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductCategories" ALTER COLUMN id SET DEFAULT nextval('public."ProductCategories_id_seq"'::regclass);


--
-- Name: ProductImage id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductImage" ALTER COLUMN id SET DEFAULT nextval('public."ProductImage_id_seq"'::regclass);


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
-- Name: Question id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Question" ALTER COLUMN id SET DEFAULT nextval('public."Question_id_seq"'::regclass);


--
-- Name: Rating id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Rating" ALTER COLUMN id SET DEFAULT nextval('public."Rating_id_seq"'::regclass);


--
-- Name: Role id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);


--
-- Name: RolePermission id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."RolePermission" ALTER COLUMN id SET DEFAULT nextval('public."RolePermission_id_seq"'::regclass);


--
-- Name: Setting id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Setting" ALTER COLUMN id SET DEFAULT nextval('public."Setting_id_seq"'::regclass);


--
-- Name: SettingHistory id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SettingHistory" ALTER COLUMN id SET DEFAULT nextval('public."SettingHistory_id_seq"'::regclass);


--
-- Name: Shipping id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Shipping" ALTER COLUMN id SET DEFAULT nextval('public."Shipping_id_seq"'::regclass);


--
-- Name: SpecificationsGroup id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsGroup" ALTER COLUMN id SET DEFAULT nextval('public."SpecificationsGroup_id_seq"'::regclass);


--
-- Name: SpecificationsType id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsType" ALTER COLUMN id SET DEFAULT nextval('public."SpecificationsType_id_seq"'::regclass);


--
-- Name: Store id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store" ALTER COLUMN id SET DEFAULT nextval('public."Store_id_seq"'::regclass);


--
-- Name: Tags id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Tags" ALTER COLUMN id SET DEFAULT nextval('public."Tags_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserRole id; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."UserRole" ALTER COLUMN id SET DEFAULT nextval('public."UserRole_id_seq"'::regclass);


--
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Address" (id, name, phone, created_at, ward_id, district_id, province_id, updated_at, customer_id, detail_address) FROM stdin;
\.


--
-- Data for Name: Answer; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Answer" (id, content, "createdAt", author_id, customer_id, question_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Article; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Article" (id, title, slug, status, content, category_id, thumnal_url, description, meta_data, created_at, updated_at, author_id) FROM stdin;
1	Có nên mua iPad cũ? Kinh nghiệm chọn mua iPad đúng chuẩn năm 2024	co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-chuan-nam-2024	1	<h2><a href="https://tpmobile.com.vn/danh-muc/ipad-cu">iPad</a> là sản phẩm <a href="https://tpmobile.com.vn/danh-muc/ipad-pro">máy tính bảng</a> của Apple - đây là một trong những dòng tablet bán chạy nhất thế giới. Bởi nó không chỉ sở hữu thiết kế tuyệt đẹp, đơn giản mà sức mạnh và hiệu năng của nó rất tuyệt vời. Nhưng không phải ai cũng đủ kinh tế để sở hữu một con iPad mới vậy có nên mua một con <a href="https://www.thegioididong.com/may-doi-tra/may-tinh-bang">iPad cũ</a> hay không. Bài viết sau đây sẽ giải đáp thắc mắc nè và đưa ra cho bạn thêm một số kinh nghiệm chọn iPad cũ đúng chuẩn nhất.</h2><h3><strong>1. iPad cũ là gì?</strong></h3><p>iPad cũ là mẫu iPad đã qua sử dụng, nhưng chất lượng còn rất tốt và ngoại hình gần như mới. So với iPad mới thì iPad cũ không còn nguyên hộp hoặc thiếu đi các phụ kiện đi kèm do người dùng trước không còn giữ lại. iPad cũ thể là sẽ vẫn còn hoặc đã hết thời gian bảo hành.</p><figure class="image" style="height:auto;"><img style="aspect-ratio:800/583;" src="https://cdn.tgdd.vn/News/1474739/co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-3-800x583.jpg" alt="Tìm hiểu về iPad cũ" width="800" height="583"></figure><p style="text-align:center;">Tìm hiểu về iPad cũ</p><h3><strong>2. Có nên mua iPad cũ? Lợi ích và rủi ro là gì?</strong></h3><h4><strong>Lợi ích</strong></h4><p>Một trong những lợi ích khi mua iPad cũ là luôn nhận mức giá siêu hời tiết kiệm được nhiều chi phía. Nhưng tính năng và tiện ích của iPad cũ mang lại vẫn đầy đủ, vận hành vẫn trơn tru trong khi giá thành thấp hơn hẳn iPad mua mới.</p><p>iPad thuộc họ nhà Apple nên có chính sách hỗ trợ người dùng rất tốt. Mặc dù bạn dùng iPad cũ, Apple vẫn hỗ trợ nâng cấp hệ điều hành thường xuyên. Bạn hoàn toàn có thể sử dụng được các tính năng của bản iOS mới thông qua chiếc iPad thế hệ cũ.</p><figure class="image" style="height:auto;"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/News/1474739/co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-4-800x533.jpg" alt="iPad cũ giá siêu hời, chất lượng cao" width="800" height="533"></figure><p style="text-align:center;">iPad cũ giá siêu hời, chất lượng cao</p><h4><strong>Rủi ro</strong></h4><p>Máy có thể bị thay linh kiện, mua phải hàng dựng lại không còn nguyên cấu hình như ban đầu; máy đã qua sửa chữa nhiều lần, không đảm bảo chất lượng cũng như tính năng sử dụng… Tổng quan bên ngoài của máy sẽ không còn mới và đẹp như ban đầu, xuất hiện thêm một số vết xước bên ngoài tùy mức độ bảo quản của người dùng trước đó.</p><p>Một điều đáng lo ngại, trên thị trường đã xuất hiện khá nhiều iPad cũ là hàng dựng. Chúng được dựng lại bằng những linh kiện kém chất lượng từ Trung Quốc. Do vậy, những sản phẩm này thường có tuổi thọ cực thấp, ảnh hưởng rất nhiều tới trải nghiệm người dùng.</p><figure class="image" style="height:auto;"><img style="aspect-ratio:800/450;" src="https://cdn.tgdd.vn/News/1474739/co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-5-800x450.jpg" alt="iPad cũ dễ gặp tình trạng bị thay linh kiện bên trong" width="800" height="450"></figure><p style="text-align:center;">iPad cũ dễ gặp tình trạng bị thay linh kiện bên trong</p><h3><strong>3. Kinh nghiệm chọn mua iPad cũ đúng chuẩn</strong></h3><p>Đầu tiên, bạn phải xác định nhu cầu sử dụng nhằm phục cho những mục đích gì. Nếu mục đích mua iPad là để chơi game điều đầu tiên bạn cần quan tâm là cấu hình của máy có đủ đáp ứng thể loại game mà bạn chơi hay không. Những game có đồ họa chi tiết phức tạp sẽ yêu cầu cao về cấu hình, hệ điều hành tối thiểu của thiết bị.</p><p>Cần chọn nơi bán uy tín nhất và có chính sách bảo hành rõ ràng. Điều này đặc biệt cần thiết vì rủi ro sau khi mua máy cũ cao hơn rất nhiều khi mua máy mới chính hãng. Bạn nên tìm hiểu kỹ đơn vị, cá nhân bán sản phẩm và những cam kết, hỗ trợ sau bán tại nơi bán đó</p><figure class="image" style="height:auto;"><img style="aspect-ratio:800/480;" src="https://cdn.tgdd.vn/News/1474739/co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-6-800x480.jpg" alt="Những kinh nghiệm quan trọng khi chọn mua iPad cũ" width="800" height="480"></figure><p style="text-align:center;">Những kinh nghiệm quan trọng khi chọn mua iPad cũ</p><p>Kiểm tra xem dung lượng pin ban đầu theo thiết kế của nhà sản xuất là bao nhiêu để so sánh với pin máy cũ xem có đúng không. Bạn cũng nên sử dụng các phần mềm để kiểm tra chất lượng của pin, độ chai của pin để tính phương án thay mới nếu cần thiết.</p><p>Cần lưu ý về độ nhạy của màn hình cảm ứng bằng cách di chuyển ngón tay khắp màn hình và dùng thử bàn phím ảo trên máy. Nếu cảm ứng hoạt động nhanh và ổn định thì hoàn toàn có thể yên tâm sử dụng.</p><p>Kiểm tra hình thức của máy, xem cấu hình của máy, các bộ phận, các chức năng có hoạt động bình thường không. Bên cạnh đó, Apple là hãng có bảo mật rất cao, các sản phẩm đều sử dụng tài khoản iCloud để đăng nhập và đồng bộ hóa, bạn cần kiểm tra lại tài khoản iCloud của chủ cũ đã thoát hoàn toàn chưa, tránh trường hợp bị khóa máy, hay khóa iCloud.</p>	1	https://cdn.tgdd.vn/News/1474739/co-nen-mua-ipad-cu-kinh-nghiem-chon-mua-ipad-dung-4-800x533.jpg	iPad là sản phẩm máy tính bảng của Apple - đây là một trong những dòng tablet bán chạy nhất thế giới. Bởi nó không chỉ sở hữu thiết kế tuyệt đẹp, 	\N	2024-08-12 18:30:25.774	2024-08-12 18:30:25.774	\N
\.


--
-- Data for Name: AttributeValues; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."AttributeValues" (id, value, slug, hex_color, attribute_id) FROM stdin;
1	32GB	32GB	\N	1
2	64GB	64GB	\N	1
3	128GB	128GB	\N	1
4	256GB	256GB	\N	1
5	512GB	512GB	\N	1
6	1TB	1TB	\N	1
7	2TB	2TB	\N	1
8	Đen	den	#0f0f0f	2
9	Trắng	trang	#ffffff	2
10	Vàng	vang	#e1f224	2
11	Xanh dương	xanh-duong	#09aded	2
12	Xanh lá	xanh-la	#09ed09	2
13	Đỏ	do	#ed1809	2
14	Xám	xam	#808080	2
15	Bạc	bac	#C0C0C0	2
16	Hồng	hong	#ff69b4	2
17	Trắng vàng	trang-vang	#F5F5DC	2
18	Tím	tim	#CCA8E0	2
19	USB-C	USB-C	\N	3
20	Lightning	Lightning	\N	3
21	Vàng hồng	vang-hong	#B76E79	2
22	99%	99%	\N	4
23	100%	100%	\N	4
24	98%	98%	\N	4
25	97%	97%	\N	4
26	96%	96%	\N	4
27	95%	95%	\N	4
28	Titan	titan	#878681	2
\.


--
-- Data for Name: Attributes; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Attributes" (id, name, style, key) FROM stdin;
1	Dung lượng	RECTANGLE	capacity
2	Màu sắc	COLOR	color
3	Kiểu sạc	RECTANGLE	chargerType
4	Độ mới	RECTANGLE	new
\.


--
-- Data for Name: Brand; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Brand" (id, name, slug, "createdAt", "updatedAt", logo) FROM stdin;
1	Apple	apple	2024-07-21 17:45:43.176	2024-07-21 17:45:43.176	\N
\.


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Cart" (id, token, item_count, total_price, note, customer_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Category" (id, title, slug, description, image, published, meta_data) FROM stdin;
1	iPad Pro	ipad-pro	\N	https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconIpadPro.png?alt=media&token=4052c08e-e870-4156-b6de-75a9c05416fc	t	\N
2	iPad Air	ipad-air		https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconIpadPro.png?alt=media&token=4052c08e-e870-4156-b6de-75a9c05416fc	t	\N
3	iPad Gen	ipad-gen		https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconIpadGen.png?alt=media&token=e5145f9e-7abe-4380-933e-d4f187df6a21	t	\N
4	iPad Mini	ipad-mini		https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconMini.png?alt=media&token=779aa86f-e21c-42db-98a3-ec320f556e82	t	\N
5	Phụ kiện	phu-kien		https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconphukien.png?alt=media&token=1d1499e7-9c72-43b3-85a7-acaa3435d763	t	\N
6	Iphone	iphone		https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iphone.png?alt=media&token=1181b109-a032-448f-a77a-351abd0bbe97	t	\N
7	ipad cũ	ipad-cu	\N	https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconIpadPro.png?alt=media&token=4052c08e-e870-4156-b6de-75a9c05416fc	t	\N
8	iPad New	ipad-new	\N	https://firebasestorage.googleapis.com/v0/b/tpmobile-9e980.appspot.com/o/iconIpadGen.png?alt=media&token=e5145f9e-7abe-4380-933e-d4f187df6a21	t	\N
\.


--
-- Data for Name: CategoryArticle; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."CategoryArticle" (id, title, description, image, slug, published, meta_data) FROM stdin;
1	Công nghệ	\N	\N	cong-nghe	f	\N
2	Tin tức mới	\N	\N	tin-tuc-moi	f	\N
\.


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Customer" (id, email, password, name, phone, gender, birthday, created_at, updated_at, provider, provider_id) FROM stdin;
\.


--
-- Data for Name: File; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."File" (id, id_root, url, format, created_at, name, folder_id, size) FROM stdin;
\.


--
-- Data for Name: Folder; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Folder" (id, name, parent_id, created_at) FROM stdin;
\.


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Location" (id, name, type, code, parent_code) FROM stdin;
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Order" (id, token, code, total_price, temp_price, ship_price, discount, note, status, promotions, customer_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Page; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Page" (id, title, slug, content_html, meta_data, created_at, updated_at, status) FROM stdin;
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Payment" (id, order_id, method, transaction_id, amount, status, payment_date) FROM stdin;
\.


--
-- Data for Name: Permission; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Permission" (id, name) FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Product" (id, title, slug, description_html, available, status, created_at, updated_at, published_at, barcode, short_description, meta_data, price, compare_at_price, price_max, price_min, brand_id, category_id, meta_tags, related) FROM stdin;
25	iPad mini 6 Wifi Like New	ipad-mini-6-wifi-like-new	<h2 style="text-align:justify;">iPad mini 6 Wifi Like New tại TP Mobile</h2><h3 style="text-align:justify;">Cấu hình mạnh mẽ hơn, đa nhiệm tốt hơn</h3><p style="text-align:justify;">iPad mini 6 có sức mạnh vượt trội khi so với thế hệ tiền nhiệm, sử dụng chip xử lý Apple A15 Bionic 6 nhân mang đến hiệu năng mạnh mẽ hơn và tiết kiệm khoảng 15% năng lượng so với A14 Bionic.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg" alt="Chip xử lý Apple A15 Bionic - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hiện tại dung lượng RAM vẫn chưa được Apple tiết lộ, theo một số tin đồn thì máy sẽ có dung lượng <a href="https://www.thegioididong.com/may-tinh-bang-ram-4gb">RAM 4 GB</a>&nbsp;giúp khả năng đa nhiệm tốt hơn, điều hành đa tác vụ trên iPad mini 6 sẽ luôn được trơn tru, cho bạn mở nhiều cửa sổ ứng dụng, chạy các phần mềm thiết kế đồ họa hay thử sức chỉnh sửa video chất lượng cao một cách dễ dàng.</p><p style="text-align:justify;">Bộ nhớ trong 64 GB thoải mái cho nhu cầu cơ bản, lưu trữ các dữ liệu cá nhân với danh sách nhạc yêu thích, hình ảnh và video các khoảnh khắc đáng nhớ của bạn cùng người thân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg" alt="Dung lượng bộ nhớ - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với khả năng xử lý đồ họa nhanh hơn tới 80%, iPad mini 6 giúp bạn đắm mình vào bất cứ điều gì bạn làm. Trải nghiệm AR, chơi các trò chơi đồ họa cao hay các tác vụ 3D đều sẽ được xử lý mượt mà.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg" alt="Khả năng xử lý đồ họa mượt mà - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết bị chạy hệ điều hành iPadOS 15 tập trung về tiện ích, tận dụng tối đa nhất không gian màn hình của iPad, giao diện trực quan hơn, đa nhiệm thông minh hơn và bảo mật tốt hơn cho người dùng cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg" alt="Hệ điều hành iPadOS 15 - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình lớn hơn, sử dụng thích hơn</h3><p style="text-align:justify;">Trang bị kích thước màn hình 8.3 inch lớn hơn so với các phiên bản iPad mini&nbsp;trước, nhưng iPad mini 6 vẫn rất gọn gàng vì viền màn hình của máy đã được thiết kế mỏng đều bốn cạnh, thiết bị vẫn rất tiện để mang theo giải trí, làm việc mọi nơi, mọi lúc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg" alt="Màn hình 8.3 inch sắc nét - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Tấm nền IPS LCD với các lớp tinh thể lỏng tái tạo màu sắc tốt và tạo góc nhìn rộng hơn, độ sáng cao hỗ trợ gam màu P3 cùng công nghệ True Tone giúp người dùng dễ dàng sử dụng iPad mini trong nhiều môi trường ánh sáng (từ trong nhà đến ngoài trời, ở những khu vực ánh sáng gắt).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg" alt="Trang bị tấm nền IPS LCD - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-cong-nghe-man-hinh-true-tone-992705">True Tone là gì? Có trên những thiết bị nào?</a></p><p style="text-align:justify;">Độ dày máy 6.3 mm cùng các cạnh viền mỏng hơn, giúp máy trở nên tinh tế hơn. Nút nguồn tích hợp Touch ID ở cạnh trên máy giúp truy cập thiết bị nhanh hơn, bảo mật riêng tư tốt hơn cho người dùng.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif" alt="Touch ID - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hỗ trợ bút Apple Pencil 2&nbsp;có thể gắn từ tính và sạc không dây vô cùng tiện lợi, hỗ trợ ghi chú nhanh hay thỏa mãn đam mê thiết kế trên màn hình iPad mini.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg" alt="Thao tác nhanh chóng với Apple Pencil - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad mini 6 trang bị kết nối WiFi 6 cho tốc độ giao tiếp kết nối cực nhanh và ổn định, truyền tải dữ liệu tốc độ cao không tốn nhiều thời gian chờ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg" alt="Hỗ trợ kết nối Wifi 6 hiện đại - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Phiên bản này Apple cho người dùng đến 4 gam màu thời thượng để lựa chọn gồm Xám, Hồng, Tím và Trắng phù hợp cho nhiều cá nhân với độ tuổi, phong cách khác nhau.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg" alt="Có nhiều màu sắc để lựa chọn - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Quay phim, chụp ảnh sắc nét, video call chất lượng cao</h3><p style="text-align:justify;">Dù không phải là tính năng chính trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhưng Apple vẫn đầu tư khá tốt cho hệ thống camera của iPad mini 6 với camera mặt trước và sau đều đạt độ phân giải 12 MP.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg" alt="Bộ đôi camera ấn tượng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau góc nhìn rộng hỗ trợ quay phim 4K, Full HD với chất lượng tương phản tốt, hỗ trợ chạm lấy nét, Slow Motion, Time Lapse, Panorama,... để bạn thực hiện những bức ảnh nghệ thuật và thu về những đoạn video rõ ràng, chân thật cho kho lưu trữ kỷ niệm của cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg" alt="Camera sau hỗ trợ nhiều tính năng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera trước quay video có thể quay video Full HD giúp các cuộc gọi video sắc nét hơn khi trò chuyện với người thân từ xa, thực hiện các buổi học hay họp trực tuyến qua mạng xã hội thật tiện lợi, thoải mái.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg" alt="Camera trước 12 MP - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hơn nữa camera trước còn hỗ trợ tính năng Center Stage giúp cuộc gọi trở lên hấp dẫn hơn khi bạn có thể di chuyển trong quanh khung hình, máy ảnh sẽ tự động xoay để giữ bạn luôn ở trung tâm khung hình.</p><h3 style="text-align:justify;">Dung lượng pin tốt đáp ứng nhu cầu sử dụng suốt ngày dài</h3><p style="text-align:justify;">iPad mini 6 có dung lượng pin 19.3 Wh cho thời lượng sử dụng tốt, đảm bảo đáp ứng nhu cầu sử dụng thiết bị tần suất cao suốt ngày dài.</p><p style="text-align:justify;">Đặc biệt, ở phiên bản này, Apple cải tiến cổng sạc sang Type-C giúp iPad mini 6 kết nối dễ dàng hơn với nhiều phụ kiện ngoại vi để bạn thực hiện các liên kết giao tiếp dữ liệu và kết nối giải trí thêm linh hoạt, tiện lợi.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg" alt="Cổng USB-C cải tiến - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Các tín đồ trái táo khuyết ắt hẳn sẽ ít nhiều thích thú với phiên bản mới của iPad mini, với một thiết kế mới của dòng iPad mini, cấu hình khỏe, tích hợp các tiện ích thông minh, hiện đại đáp ứng nhu cầu giải trí và làm việc thực tế của nhiều đối tượng người dùng.</p>	t	1	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	\N	\N	iPad mini 6 Wifi Like New Với sự thành công của các thế hệ iPad mini trước iPad mini 6 là sản phẩm kế nhiệm mới với nhiều tính năng hiện kèm nhiều sự nâng cấp đáng chú ý dành cho người dùng trong năm nay. Nếu bạn đang có nhu cầu mua cho mình một chiếc máy tính bảng iPad để phục vụ cho nhu cầu sử dụng thì iPad Mini 6 sẽ là sự lựa chọn hoàn hảo cho bạn vào thời điểm này cho nhu cầu sử dụng tablet kích thước vừa phải.	{"meta_title": "iPad mini 6 Wifi Like New hàng đẹp"}	9490000	0	11990000	9490000	1	4	\N	{}
26	iPad mini 6 LTE Like New	ipad-mini-6-lte-like-new	<h2 style="text-align:justify;">iPad mini 6 LTE Like New tại TP Mobile</h2><h3 style="text-align:justify;">Cấu hình mạnh mẽ hơn, đa nhiệm tốt hơn</h3><p style="text-align:justify;">iPad mini 6 có sức mạnh vượt trội khi so với thế hệ tiền nhiệm, sử dụng chip xử lý Apple A15 Bionic 6 nhân mang đến hiệu năng mạnh mẽ hơn và tiết kiệm khoảng 15% năng lượng so với A14 Bionic.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg" alt="Chip xử lý Apple A15 Bionic - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hiện tại dung lượng RAM vẫn chưa được Apple tiết lộ, theo một số tin đồn thì máy sẽ có dung lượng <a href="https://www.thegioididong.com/may-tinh-bang-ram-4gb">RAM 4 GB</a>&nbsp;giúp khả năng đa nhiệm tốt hơn, điều hành đa tác vụ trên iPad mini 6 sẽ luôn được trơn tru, cho bạn mở nhiều cửa sổ ứng dụng, chạy các phần mềm thiết kế đồ họa hay thử sức chỉnh sửa video chất lượng cao một cách dễ dàng.</p><p style="text-align:justify;">Bộ nhớ trong 64 GB thoải mái cho nhu cầu cơ bản, lưu trữ các dữ liệu cá nhân với danh sách nhạc yêu thích, hình ảnh và video các khoảnh khắc đáng nhớ của bạn cùng người thân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg" alt="Dung lượng bộ nhớ - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với khả năng xử lý đồ họa nhanh hơn tới 80%, iPad mini 6 giúp bạn đắm mình vào bất cứ điều gì bạn làm. Trải nghiệm AR, chơi các trò chơi đồ họa cao hay các tác vụ 3D đều sẽ được xử lý mượt mà.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg" alt="Khả năng xử lý đồ họa mượt mà - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết bị chạy hệ điều hành iPadOS 15 tập trung về tiện ích, tận dụng tối đa nhất không gian màn hình của iPad, giao diện trực quan hơn, đa nhiệm thông minh hơn và bảo mật tốt hơn cho người dùng cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg" alt="Hệ điều hành iPadOS 15 - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình lớn hơn, sử dụng thích hơn</h3><p style="text-align:justify;">Trang bị kích thước màn hình 8.3 inch lớn hơn so với các phiên bản iPad mini&nbsp;trước, nhưng iPad mini 6 vẫn rất gọn gàng vì viền màn hình của máy đã được thiết kế mỏng đều bốn cạnh, thiết bị vẫn rất tiện để mang theo giải trí, làm việc mọi nơi, mọi lúc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg" alt="Màn hình 8.3 inch sắc nét - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Tấm nền IPS LCD với các lớp tinh thể lỏng tái tạo màu sắc tốt và tạo góc nhìn rộng hơn, độ sáng cao hỗ trợ gam màu P3 cùng công nghệ True Tone giúp người dùng dễ dàng sử dụng iPad mini trong nhiều môi trường ánh sáng (từ trong nhà đến ngoài trời, ở những khu vực ánh sáng gắt).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg" alt="Trang bị tấm nền IPS LCD - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-cong-nghe-man-hinh-true-tone-992705">True Tone là gì? Có trên những thiết bị nào?</a></p><p style="text-align:justify;">Độ dày máy 6.3 mm cùng các cạnh viền mỏng hơn, giúp máy trở nên tinh tế hơn. Nút nguồn tích hợp Touch ID ở cạnh trên máy giúp truy cập thiết bị nhanh hơn, bảo mật riêng tư tốt hơn cho người dùng.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif" alt="Touch ID - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hỗ trợ bút Apple Pencil 2&nbsp;có thể gắn từ tính và sạc không dây vô cùng tiện lợi, hỗ trợ ghi chú nhanh hay thỏa mãn đam mê thiết kế trên màn hình iPad mini.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg" alt="Thao tác nhanh chóng với Apple Pencil - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad mini 6 trang bị kết nối WiFi 6 cho tốc độ giao tiếp kết nối cực nhanh và ổn định, truyền tải dữ liệu tốc độ cao không tốn nhiều thời gian chờ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg" alt="Hỗ trợ kết nối Wifi 6 hiện đại - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Phiên bản này Apple cho người dùng đến 4 gam màu thời thượng để lựa chọn gồm Xám, Hồng, Tím và Trắng phù hợp cho nhiều cá nhân với độ tuổi, phong cách khác nhau.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg" alt="Có nhiều màu sắc để lựa chọn - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Quay phim, chụp ảnh sắc nét, video call chất lượng cao</h3><p style="text-align:justify;">Dù không phải là tính năng chính trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhưng Apple vẫn đầu tư khá tốt cho hệ thống camera của iPad mini 6 với camera mặt trước và sau đều đạt độ phân giải 12 MP.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg" alt="Bộ đôi camera ấn tượng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau góc nhìn rộng hỗ trợ quay phim 4K, Full HD với chất lượng tương phản tốt, hỗ trợ chạm lấy nét, Slow Motion, Time Lapse, Panorama,... để bạn thực hiện những bức ảnh nghệ thuật và thu về những đoạn video rõ ràng, chân thật cho kho lưu trữ kỷ niệm của cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg" alt="Camera sau hỗ trợ nhiều tính năng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera trước quay video có thể quay video Full HD giúp các cuộc gọi video sắc nét hơn khi trò chuyện với người thân từ xa, thực hiện các buổi học hay họp trực tuyến qua mạng xã hội thật tiện lợi, thoải mái.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg" alt="Camera trước 12 MP - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hơn nữa camera trước còn hỗ trợ tính năng Center Stage giúp cuộc gọi trở lên hấp dẫn hơn khi bạn có thể di chuyển trong quanh khung hình, máy ảnh sẽ tự động xoay để giữ bạn luôn ở trung tâm khung hình.</p><h3 style="text-align:justify;">Dung lượng pin tốt đáp ứng nhu cầu sử dụng suốt ngày dài</h3><p style="text-align:justify;">iPad mini 6 có dung lượng pin 19.3 Wh cho thời lượng sử dụng tốt, đảm bảo đáp ứng nhu cầu sử dụng thiết bị tần suất cao suốt ngày dài.</p><p style="text-align:justify;">Đặc biệt, ở phiên bản này, Apple cải tiến cổng sạc sang Type-C giúp iPad mini 6 kết nối dễ dàng hơn với nhiều phụ kiện ngoại vi để bạn thực hiện các liên kết giao tiếp dữ liệu và kết nối giải trí thêm linh hoạt, tiện lợi.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg" alt="Cổng USB-C cải tiến - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Các tín đồ trái táo khuyết ắt hẳn sẽ ít nhiều thích thú với phiên bản mới của iPad mini, với một thiết kế mới của dòng iPad mini, cấu hình khỏe, tích hợp các tiện ích thông minh, hiện đại đáp ứng nhu cầu giải trí và làm việc thực tế của nhiều đối tượng người dùng.</p>	t	1	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	\N	\N	iPad mini 6 LTE Like New Với sự thành công của các thế hệ iPad mini trước iPad mini 6 là sản phẩm kế nhiệm mới với nhiều tính năng hiện kèm nhiều sự nâng cấp đáng chú ý dành cho người dùng trong năm nay. Nếu bạn đang có nhu cầu mua cho mình một chiếc máy tính bảng iPad để phục vụ cho nhu cầu sử dụng thì iPad Mini 6 sẽ là sự lựa chọn hoàn hảo cho bạn vào thời điểm này cho nhu cầu sử dụng tablet kích thước vừa phải.	{"meta_title": "iPad mini 6 Wifi Like New hàng đẹp"}	11490000	0	11490000	0	1	4	\N	{}
27	iPad Pro 11 inch 2018 Wifi Like New	ipad-pro-11-inch-2018-wifi-like-new	<h2>iPad Pro 11 inch 2018 Wifi Like New tại TP Mobile</h2><h3>Thiết kế đẳng cấp</h3><p>iPad Pro 11 inch 64GB Wifi (2018)&nbsp;sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.</p><p>Nút Home trên thế hệ mới đã được loại bỏ, các thao tác về lại màn hình chính, mở thanh thông báo, mở đa nhiệm, bảng điều khiển,... đều có thể sử dụng dễ dàng thông qua các thao tác kéo vuốt thả trên màn hình chính.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg" alt="Thiết kế tinh tế trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p>&nbsp;</p><h3>Màn hình siêu sắc nét</h3><p>Công nghệ màn hình&nbsp;Liquid&nbsp;Retina với độ phân giải 2388 x 1668 pixels trên chiếc&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> 11 inch có khả&nbsp;năng hiển thị sắc nét đến từng chi tiết nhỏ, màu sắc có độ sâu và chân thật.&nbsp;Xem phim, chơi game,... đều cho trải nghiệm tuyệt vời nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg" alt="Màn hình sắc nét trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Vi xử lý mạnh mẽ</h3><p>Vi xử lý&nbsp;<strong>Apple A12X Bionic</strong>&nbsp;mạnh mẽ kết hợp cùng&nbsp;<strong>4GB RAM </strong>và <strong>hệ điều hành IOS 12</strong> giúp<strong> iPad Pro 11 inch 64GB Wifi (2018)</strong> có thể chiến mượt mà các tựa game nặng nhất hiện tại và chạy trơn tru các ứng dụng đồ hoạ.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg"><img style="aspect-ratio:563/733;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg" alt="Điểm hiệu năng Antutu Benchmark trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="563" height="733"></a></figure><p>Với&nbsp;Apple A12X Bionic là trung tâm xử lý,&nbsp;iPad Pro 11 inch 64GB Wifi (2018)&nbsp;ngoài giải trí còn đáp ứng tốt nhu cầu xử lý công việc hằng ngày của bạn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg" alt="Cấu hình mạnh mẽ trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>FaceID&nbsp;đầu tiên trên&nbsp;Ipad</h3><p>Công nghệ bảo mật bằng khuôn mặt tiên tiến lần đầu tiên xuất hiện trên&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> Pro 11 inch 64GB Wifi (2018)&nbsp;với cụm&nbsp;cảm biến <strong>FaceID&nbsp;thông minh </strong>có thể nhận diện khi bạn xoay ngang hay xoay dọc.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg" alt="Công nghệ Face ID trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Camera TrueDepth&nbsp;sắc nét</h3><p><strong>Công nghệ Smart HDR</strong> giúp nâng cao chất lượng ảnh chụp cùng nhiều công nghệ khác như chụp chân dung xóa phông, tạo Animoji, Memoji, quay video 4K,... đều được trang bị trên cả <strong>camera trước 7MP</strong> và <strong>camera sau 12MP</strong> trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro">iPad Pro</a> 2018 cho chất lượng ảnh tươi sáng và sắc nét.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg" alt="Camera trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Apple Pencil sáng tạo mọi lúc, mọi nơi&nbsp;</h3><p>Apple Pencil&nbsp;thế hệ 2 đã được cải tiến lớn và liền mạch hơn cho cảm giác cầm nắm thật sự tốt. Đặc biệt, <strong>Apple pencil thế hệ 2</strong> đã có thể sạc không dây với&nbsp;iPad Pro 2018&nbsp;(không cần phải sạc qua cổng lightning như thế hệ trước). Chỉ cần để hít vào cạnh iPad là quá trình sạc được kích hoạt (sản phẩm không tặng kèm bút).</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg" alt="Apple pen thế 2 trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p><strong>Lưu ý: iPad Pro 11 inch 2018 không hỗ trợ kết nối với Apple Pencil thế hệ 1.</strong></p><h3>Kết nối USB-C đa năng</h3><p>Cổng kết nối <strong>USB Type C hiện đại</strong>, ngoài sử dụng để sạc cho máy còn có khả sạc cho iPhone, kết nối với các thiết bị ngoại vi như máy in, máy ảnh, ổ cứng,... và tốc độ truyền dữ liệu cũng được cải thiện đáng kể so với cổng Lightning thế hệ trước. Ngoài ra, bên trong&nbsp;iPad Pro&nbsp;2018&nbsp;cũng được trang bị nhiều nam châm để kết nối với bàn phím Smart Keyboard, tăng khả năng nhập liệu.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg" alt="Cổng kết nối USB C đa chức năng trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>&nbsp;<br>Thời lượng pin 10 giờ</h3><p>Với dung lượng pin&nbsp;30.4 Wh bạn có thể thoải mái sử dụng làm việc, xem phim,...&nbsp;lên đến 10 giờ, nhưng nếu bạn chỉ thỉnh thoảng xử lý công việc hay xem đoạn clip thì thời gian sử dụng lên đến gần 2 ngày. Thật tiện lợi để bạn có thể luôn luôn mang theo bên mình đi du lịch hay làm việc.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg" alt="Dung lượng pin trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure>	t	1	2024-07-23 14:22:25.641	2024-07-23 14:22:25.641	\N	\N	iPad mini 6 LTE Like New Với sự thành công của các thế hệ iPad mini trước iPad mini 6 là sản phẩm kế nhiệm mới với nhiều tính năng hiện kèm nhiều sự nâng cấp đáng chú ý dành cho người dùng trong năm nay. Nếu bạn đang có nhu cầu mua cho mình một chiếc máy tính bảng iPad để phục vụ cho nhu cầu sử dụng thì iPad Mini 6 sẽ là sự lựa chọn hoàn hảo cho bạn vào thời điểm này cho nhu cầu sử dụng tablet kích thước vừa phải.	{}	10990000	0	11990000	10990000	1	1	\N	{}
28	iPad Pro 11 inch 2018 LTE Like New	ipad-pro-11-inch-2018-lte-like-new	<h2>iPad Pro 11 inch 2018 LTE Like New tại TP Mobile</h2><h3>Thiết kế đẳng cấp</h3><p>iPad Pro 11 inch 2018 LTE Like New&nbsp;sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.</p><p>Nút Home trên thế hệ mới đã được loại bỏ, các thao tác về lại màn hình chính, mở thanh thông báo, mở đa nhiệm, bảng điều khiển,... đều có thể sử dụng dễ dàng thông qua các thao tác kéo vuốt thả trên màn hình chính.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg" alt="Thiết kế tinh tế trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p>&nbsp;</p><h3>Màn hình siêu sắc nét</h3><p>Công nghệ màn hình&nbsp;Liquid&nbsp;Retina với độ phân giải 2388 x 1668 pixels trên chiếc&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> 11 inch có khả&nbsp;năng hiển thị sắc nét đến từng chi tiết nhỏ, màu sắc có độ sâu và chân thật.&nbsp;Xem phim, chơi game,... đều cho trải nghiệm tuyệt vời nhất.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg" alt="Màn hình sắc nét trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Vi xử lý mạnh mẽ</h3><p>Vi xử lý&nbsp;<strong>Apple A12X Bionic</strong>&nbsp;mạnh mẽ kết hợp cùng&nbsp;<strong>4GB RAM </strong>và <strong>hệ điều hành IOS 12</strong> giúp<strong> iPad Pro 11 inch 64GB Wifi (2018)</strong> có thể chiến mượt mà các tựa game nặng nhất hiện tại và chạy trơn tru các ứng dụng đồ hoạ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg"><img style="aspect-ratio:563/733;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg" alt="Điểm hiệu năng Antutu Benchmark trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="563" height="733"></a></figure><p>Với&nbsp;Apple A12X Bionic là trung tâm xử lý,&nbsp;iPad Pro 11 inch 64GB Wifi (2018)&nbsp;ngoài giải trí còn đáp ứng tốt nhu cầu xử lý công việc hằng ngày của bạn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg" alt="Cấu hình mạnh mẽ trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>FaceID&nbsp;đầu tiên trên&nbsp;Ipad</h3><p>Công nghệ bảo mật bằng khuôn mặt tiên tiến lần đầu tiên xuất hiện trên&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> Pro 11 inch 64GB Wifi (2018)&nbsp;với cụm&nbsp;cảm biến <strong>FaceID&nbsp;thông minh </strong>có thể nhận diện khi bạn xoay ngang hay xoay dọc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg" alt="Công nghệ Face ID trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Camera TrueDepth&nbsp;sắc nét</h3><p><strong>Công nghệ Smart HDR</strong> giúp nâng cao chất lượng ảnh chụp cùng nhiều công nghệ khác như chụp chân dung xóa phông, tạo Animoji, Memoji, quay video 4K,... đều được trang bị trên cả <strong>camera trước 7MP</strong> và <strong>camera sau 12MP</strong> trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro">iPad Pro</a> 2018 cho chất lượng ảnh tươi sáng và sắc nét.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg" alt="Camera trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Apple Pencil sáng tạo mọi lúc, mọi nơi&nbsp;</h3><p>Apple Pencil&nbsp;thế hệ 2 đã được cải tiến lớn và liền mạch hơn cho cảm giác cầm nắm thật sự tốt. Đặc biệt, <strong>Apple pencil thế hệ 2</strong> đã có thể sạc không dây với&nbsp;iPad Pro 2018&nbsp;(không cần phải sạc qua cổng lightning như thế hệ trước). Chỉ cần để hít vào cạnh iPad là quá trình sạc được kích hoạt (sản phẩm không tặng kèm bút).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg" alt="Apple pen thế 2 trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p><strong>Lưu ý: iPad Pro 11 inch 2018 không hỗ trợ kết nối với Apple Pencil thế hệ 1.</strong></p><h3>Kết nối USB-C đa năng</h3><p>Cổng kết nối <strong>USB Type C hiện đại</strong>, ngoài sử dụng để sạc cho máy còn có khả sạc cho iPhone, kết nối với các thiết bị ngoại vi như máy in, máy ảnh, ổ cứng,... và tốc độ truyền dữ liệu cũng được cải thiện đáng kể so với cổng Lightning thế hệ trước. Ngoài ra, bên trong&nbsp;iPad Pro&nbsp;2018&nbsp;cũng được trang bị nhiều nam châm để kết nối với bàn phím Smart Keyboard, tăng khả năng nhập liệu.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg" alt="Cổng kết nối USB C đa chức năng trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>&nbsp;<br>Thời lượng pin 10 giờ</h3><p>Với dung lượng pin&nbsp;30.4 Wh bạn có thể thoải mái sử dụng làm việc, xem phim,...&nbsp;lên đến 10 giờ, nhưng nếu bạn chỉ thỉnh thoảng xử lý công việc hay xem đoạn clip thì thời gian sử dụng lên đến gần 2 ngày. Thật tiện lợi để bạn có thể luôn luôn mang theo bên mình đi du lịch hay làm việc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg" alt="Dung lượng pin trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure>	t	1	2024-07-23 14:24:51.539	2024-07-23 14:24:51.539	\N	\N	iPad Pro 11 inch 2018 LTE Like New sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh đã khiến máy trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.	{}	10990000	0	11990000	10990000	1	1	\N	{}
29	iPad Pro 12.9 inch 2018 Wifi Like New	ipad-pro-129-inch-2018-wifi-like-new	<h2>iPad Pro 12.9 inch 2018 Wifi Like New tại TP Mobile</h2><h3>Thiết kế đẳng cấp</h3><p>iPad Pro 11 inch 64GB Wifi (2018)&nbsp;sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.</p><p>Nút Home trên thế hệ mới đã được loại bỏ, các thao tác về lại màn hình chính, mở thanh thông báo, mở đa nhiệm, bảng điều khiển,... đều có thể sử dụng dễ dàng thông qua các thao tác kéo vuốt thả trên màn hình chính.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg" alt="Thiết kế tinh tế trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p>&nbsp;</p><h3>Màn hình siêu sắc nét</h3><p>Công nghệ màn hình&nbsp;Liquid&nbsp;Retina với độ phân giải 2388 x 1668 pixels trên chiếc&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> 11 inch có khả&nbsp;năng hiển thị sắc nét đến từng chi tiết nhỏ, màu sắc có độ sâu và chân thật.&nbsp;Xem phim, chơi game,... đều cho trải nghiệm tuyệt vời nhất.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg" alt="Màn hình sắc nét trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Vi xử lý mạnh mẽ</h3><p>Vi xử lý&nbsp;<strong>Apple A12X Bionic</strong>&nbsp;mạnh mẽ kết hợp cùng&nbsp;<strong>4GB RAM </strong>và <strong>hệ điều hành IOS 12</strong> giúp<strong> iPad Pro 11 inch 64GB Wifi (2018)</strong> có thể chiến mượt mà các tựa game nặng nhất hiện tại và chạy trơn tru các ứng dụng đồ hoạ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg"><img style="aspect-ratio:563/733;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg" alt="Điểm hiệu năng Antutu Benchmark trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="563" height="733"></a></figure><p>Với&nbsp;Apple A12X Bionic là trung tâm xử lý,&nbsp;iPad Pro 11 inch 64GB Wifi (2018)&nbsp;ngoài giải trí còn đáp ứng tốt nhu cầu xử lý công việc hằng ngày của bạn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg" alt="Cấu hình mạnh mẽ trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>FaceID&nbsp;đầu tiên trên&nbsp;Ipad</h3><p>Công nghệ bảo mật bằng khuôn mặt tiên tiến lần đầu tiên xuất hiện trên&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> Pro 11 inch 64GB Wifi (2018)&nbsp;với cụm&nbsp;cảm biến <strong>FaceID&nbsp;thông minh </strong>có thể nhận diện khi bạn xoay ngang hay xoay dọc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg" alt="Công nghệ Face ID trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Camera TrueDepth&nbsp;sắc nét</h3><p><strong>Công nghệ Smart HDR</strong> giúp nâng cao chất lượng ảnh chụp cùng nhiều công nghệ khác như chụp chân dung xóa phông, tạo Animoji, Memoji, quay video 4K,... đều được trang bị trên cả <strong>camera trước 7MP</strong> và <strong>camera sau 12MP</strong> trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro">iPad Pro</a> 2018 cho chất lượng ảnh tươi sáng và sắc nét.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg" alt="Camera trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Apple Pencil sáng tạo mọi lúc, mọi nơi&nbsp;</h3><p>Apple Pencil&nbsp;thế hệ 2 đã được cải tiến lớn và liền mạch hơn cho cảm giác cầm nắm thật sự tốt. Đặc biệt, <strong>Apple pencil thế hệ 2</strong> đã có thể sạc không dây với&nbsp;iPad Pro 2018&nbsp;(không cần phải sạc qua cổng lightning như thế hệ trước). Chỉ cần để hít vào cạnh iPad là quá trình sạc được kích hoạt (sản phẩm không tặng kèm bút).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg" alt="Apple pen thế 2 trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p><strong>Lưu ý: iPad Pro 11 inch 2018 không hỗ trợ kết nối với Apple Pencil thế hệ 1.</strong></p><h3>Kết nối USB-C đa năng</h3><p>Cổng kết nối <strong>USB Type C hiện đại</strong>, ngoài sử dụng để sạc cho máy còn có khả sạc cho iPhone, kết nối với các thiết bị ngoại vi như máy in, máy ảnh, ổ cứng,... và tốc độ truyền dữ liệu cũng được cải thiện đáng kể so với cổng Lightning thế hệ trước. Ngoài ra, bên trong&nbsp;iPad Pro&nbsp;2018&nbsp;cũng được trang bị nhiều nam châm để kết nối với bàn phím Smart Keyboard, tăng khả năng nhập liệu.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg" alt="Cổng kết nối USB C đa chức năng trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>&nbsp;<br>Thời lượng pin 10 giờ</h3><p>Với dung lượng pin&nbsp;30.4 Wh bạn có thể thoải mái sử dụng làm việc, xem phim,...&nbsp;lên đến 10 giờ, nhưng nếu bạn chỉ thỉnh thoảng xử lý công việc hay xem đoạn clip thì thời gian sử dụng lên đến gần 2 ngày. Thật tiện lợi để bạn có thể luôn luôn mang theo bên mình đi du lịch hay làm việc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-pin.jpg" alt="Dung lượng pin trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure>	t	1	2024-07-24 15:45:35.01	2024-07-24 15:45:35.01	\N	\N	iPad Pro 12.9 inch 2018 Wifi Like New New tại TP Mobile Thiết kế đẳng cấp iPad Pro 12.9 inch sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.	{}	11490000	0	12990000	11490000	1	1	\N	{}
30	iPad Pro 12.9 inch 2018 LTE Like New	ipad-pro-129-inch-2018-lte-like-new	<h2>iPad Pro 12.9 inch 2018 LTE Like New tại TP Mobile</h2><h3>Thiết kế đẳng cấp</h3><p>iPad Pro 11 inch 64GB Wifi (2018)&nbsp;sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.</p><p>Nút Home trên thế hệ mới đã được loại bỏ, các thao tác về lại màn hình chính, mở thanh thông báo, mở đa nhiệm, bảng điều khiển,... đều có thể sử dụng dễ dàng thông qua các thao tác kéo vuốt thả trên màn hình chính.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-thietke.jpg" alt="Thiết kế tinh tế trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p>&nbsp;</p><h3>Màn hình siêu sắc nét</h3><p>Công nghệ màn hình&nbsp;Liquid&nbsp;Retina với độ phân giải 2388 x 1668 pixels trên chiếc&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> 11 inch có khả&nbsp;năng hiển thị sắc nét đến từng chi tiết nhỏ, màu sắc có độ sâu và chân thật.&nbsp;Xem phim, chơi game,... đều cho trải nghiệm tuyệt vời nhất.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-manhinh.jpg" alt="Màn hình sắc nét trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Vi xử lý mạnh mẽ</h3><p>Vi xử lý&nbsp;<strong>Apple A12X Bionic</strong>&nbsp;mạnh mẽ kết hợp cùng&nbsp;<strong>4GB RAM </strong>và <strong>hệ điều hành IOS 12</strong> giúp<strong> iPad Pro 11 inch 64GB Wifi (2018)</strong> có thể chiến mượt mà các tựa game nặng nhất hiện tại và chạy trơn tru các ứng dụng đồ hoạ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg"><img style="aspect-ratio:563/733;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-tgdd-.jpg" alt="Điểm hiệu năng Antutu Benchmark trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="563" height="733"></a></figure><p>Với&nbsp;Apple A12X Bionic là trung tâm xử lý,&nbsp;iPad Pro 11 inch 64GB Wifi (2018)&nbsp;ngoài giải trí còn đáp ứng tốt nhu cầu xử lý công việc hằng ngày của bạn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-dmx-cauhinh.jpg" alt="Cấu hình mạnh mẽ trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>FaceID&nbsp;đầu tiên trên&nbsp;Ipad</h3><p>Công nghệ bảo mật bằng khuôn mặt tiên tiến lần đầu tiên xuất hiện trên&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> Pro 11 inch 64GB Wifi (2018)&nbsp;với cụm&nbsp;cảm biến <strong>FaceID&nbsp;thông minh </strong>có thể nhận diện khi bạn xoay ngang hay xoay dọc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-faceid.jpg" alt="Công nghệ Face ID trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Camera TrueDepth&nbsp;sắc nét</h3><p><strong>Công nghệ Smart HDR</strong> giúp nâng cao chất lượng ảnh chụp cùng nhiều công nghệ khác như chụp chân dung xóa phông, tạo Animoji, Memoji, quay video 4K,... đều được trang bị trên cả <strong>camera trước 7MP</strong> và <strong>camera sau 12MP</strong> trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro">iPad Pro</a> 2018 cho chất lượng ảnh tươi sáng và sắc nét.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-camera.jpg" alt="Camera trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>Apple Pencil sáng tạo mọi lúc, mọi nơi&nbsp;</h3><p>Apple Pencil&nbsp;thế hệ 2 đã được cải tiến lớn và liền mạch hơn cho cảm giác cầm nắm thật sự tốt. Đặc biệt, <strong>Apple pencil thế hệ 2</strong> đã có thể sạc không dây với&nbsp;iPad Pro 2018&nbsp;(không cần phải sạc qua cổng lightning như thế hệ trước). Chỉ cần để hít vào cạnh iPad là quá trình sạc được kích hoạt (sản phẩm không tặng kèm bút).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-applepen.jpg" alt="Apple pen thế 2 trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><p><strong>Lưu ý: iPad Pro 11 inch 2018 không hỗ trợ kết nối với Apple Pencil thế hệ 1.</strong></p><h3>Kết nối USB-C đa năng</h3><p>Cổng kết nối <strong>USB Type C hiện đại</strong>, ngoài sử dụng để sạc cho máy còn có khả sạc cho iPhone, kết nối với các thiết bị ngoại vi như máy in, máy ảnh, ổ cứng,... và tốc độ truyền dữ liệu cũng được cải thiện đáng kể so với cổng Lightning thế hệ trước. Ngoài ra, bên trong&nbsp;iPad Pro&nbsp;2018&nbsp;cũng được trang bị nhiều nam châm để kết nối với bàn phím Smart Keyboard, tăng khả năng nhập liệu.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg"><img style="aspect-ratio:800/500;" src="https://cdn.tgdd.vn/Products/Images/522/195067/ipad-pro-11-inch-2018-64gb-wifi-content-33397-tgdd-usb.jpg" alt="Cổng kết nối USB C đa chức năng trên Máy tính bảng iPad Pro 11 inch 64GB Wifi (2018)" width="800" height="500"></a></figure><h3>&nbsp;</h3><p>&nbsp;</p>	t	1	2024-07-24 15:47:03.556	2024-07-24 15:47:03.556	\N	\N	iPad Pro 12.9 inch 2018 LTE Like New tại TP Mobile Thiết kế đẳng cấp iPad Pro 12.9 inch sở hữu ngoại hình hoàn toàn mới, viền màn hình được thu hẹp hơn, 4 cạnh được vát mạnh&nbsp;đã khiến máy&nbsp;trở thành một trong những chiếc máy tính bảng đẹp nhất, đẳng cấp nhất hiện tại.	{}	12190000	0	13490000	12190000	1	1	\N	{}
31	iPad Pro 2020 11 inch Wifi New Seal CPO 	ipad-pro-2020-11-inch-wifi-new-seal-cpo	<h2>iPad Pro 2020 11 inch New Seal CPO tại TP Mobile</h2><p><a href="https://www.apple.com/vn/">Apple</a> chính thức ra mắt thế hệ<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;v</a>ào giữa tháng 03/2020, được đánh giá là mẫu iPad mạnh nhất tính đến thời điểm hiện tại và có tiềm năng vượt trội hơn hầu hết laptop Windows trên thị trường hiện nay nhờ trang bị chip A12Z Bionic đạt tốc độ xử lý vượt trội hơn kết hợp bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. Các nâng cấp mới đáng chú ý bao gồm cảm biến, cụm camera mới với cảm biến quét LIDAR cho cảm ứng chiều sâu và AR, và bàn phím mới cho phép dựng iPad lên mặt phẳng đáy và có tích hợp trackpad. Thời lượng pin lên đến 10 tiếng, hỗ trợ mạng LTE.</p><p><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/ipad-pro-11-2020.jpg?1584672256390" alt="" width="600" height="600"></p><h3 style="text-align:center;"><strong>CÔNG NGHỆ HIỂN THỊ LIQUID RETINA</strong></h3><p><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_0.jpg?1584611013085" alt="" width="1076" height="717"></p><p>Công nghệ hiển thị tiên tiến Liquid Retina trên<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong></a>&nbsp;không chỉ đẹp và ấn tượng, mà còn trang bị các đặc tính công nghệ xuất sắc. Sự kết hợp cùng các công nghệ ProMotion, True Tone và độ chính xác màu sắc hàng đầu thị trường, khiến mọi thứ trông sống động và mãn nhãn hơn khiến đây trở thành chiếc màn hình di động tân tiến nhất thế giới.</p><h3 style="text-align:center;"><strong>CAMERA CHUYÊN NGHIỆP</strong></h3><p><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_1.jpg?1584611040033" alt="" width="1076" height="717"></p><p>Cụm camera kết hợp với màn hình rộng, hiệu suất cao và các cảm biến căn chỉnh chi tiết vốn đã là thế mạnh độc đáo của iPad nói chung.&nbsp;<strong>iPad Pro 11-inch 2020&nbsp;</strong>không những thế còn được trang bị các camera góc rộng và camera góc cực rộng mới, hỗ trợ người dùng căn hình hoàn hảo với cả ảnh và video. Cùng với mic chất lượng phòng thu và 4 speaker,&nbsp;<a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong>&nbsp;</a>có thể được xem như một khung quay dựng phim đa máy ảnh lý tưởng.</p><h3 style="text-align:center;"><strong>LIDAR SCANNER</strong></h3><p>LiDAR (Light Detection and Ranging) được sử dụng để xác định khoảng cách bằng cách đo đạc khoảng cách ánh sáng tiếp cận đối tượng và phản xạ lại. Tính năng này được NASA áp dụng cho nhiệm vụ kế tiếp đáp xuống sao Hỏa, nhưng giờ đây nó đã xuất hiện trên&nbsp;<strong>iP</strong><a href="https://anhphibantao.com/"><strong>ad Pro 11-inch 2020</strong></a>.</p><p>Bộ quét LiDAR được thiết kế tùy biến sử dụng thời gian trực tiếp bay để đo đạc ánh sáng phản xạ lại từ khoảng cách lên đến 5m, kể cả trong nhà hay ngoài trời. Bộ quét này xử lý đến cấp độ photon với tốc độ nano giây, mở ra những tiềm năng hấp dẫn đối với tương tác thực tế ảo (AR) và các công nghệ liên quan.</p><p>LiDAR Scanner làm việc với các camera chuyên nghiệp, cảm biến chuyển động và framework trên hệ điều hành iPadOS nhằm đo chiều sâu. Sự kết hợp với các phần mềm, phần cứng và những cải tiến bất ngờ này biến iPad Pro trở thành thiết bị xuất sắc nhất thế giới về AR.</p><figure class="table"><table><tbody><tr><td><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_10.jpg?1584612668388" alt="" width="652" height="493"></td><td><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_4.jpg?1584612635666" alt="" width="652" height="493"></td><td><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_5.jpg?1584612688894" alt="" width="652" height="493"></td></tr><tr><td><h4 style="text-align:center;"><strong>AR</strong></h4><p>Trên&nbsp;<strong>iPad Pro 11-inch 2020</strong>, ứng dụng AR trở nên chân thực hơn. Giờ đây bạn có thể đặt một vật thể AR ngay lập tức. Việc khớp vật thể thực tế cho phép vật thể AR đi xuyên qua từ phía trước và ở ngay sau cấu trúc thế giới thực. Tính năng ghi lại chuyển động và khớp người chính xác hơn bao giờ hết.</p></td><td><h4 style="text-align:center;"><strong>QUAY VÀ SỬA</strong></h4><p>Hệ thống camera chuyên nghiệp tăng tính linh động trên iPad Pro.&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;cho phép bạn quay, sửa, chia sẻ video 4K. Bạn có thể quay one shot góc rộng bằng camera Ultra Wide hay sử dụng Markup để thiết kế lại ngay tại chỗ. Bạn cũng có thể in chữ ký ra hoặc sao lại bằng Apple Pencil rồi gửi lại chỉ bằng một chạm.</p></td><td><h4 style="text-align:center;"><strong>CAMERA TRUEDEPTH</strong></h4><p>Camera trước TrueDepth cho phép sử dụng Face ID, là tính năng xác nhận khuôn mặt an toàn nhất thế giới trên tablet và cả trên máy tính; đồng nghĩa bạn có thể trò chuyện với bạn bè bằng FaceTime, chụp ảnh Portrait, hay biến những cuộc đối thại trên Messages trở nên vui ngộn với Animoji.</p></td></tr></tbody></table></figure><h3 style="text-align:center;"><strong>CHIP A12Z BIONIC</strong></h3><p><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_6.jpg?1584612746472" alt="" width="1076" height="717"></p><p>Với chip A12Z Bionic, iPad Pro đạt được tốc độ xử lý vượt trội hơn nhiều PC laptop trên thị trường hiện nay. Tốc độ này cho phép bạn xử lý mọi thứ nhanh chóng và mượt mà. Kết hợp với bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. A12Z Bionic được thiết kế để làm việc với những ứng dụng chuyên nghiệp hay yêu cầu công việc cao. GPU 8 nhân mang lại hiệu suất mượt mà đối với các yêu cầu chỉnh sửa video 4K, thiết kế 3D, AR. augmented reality. Cấu trúc kiểm soát nhiệt tăng cường đồng nghĩa giới hạn hiệu suất mở rộng và thời gian chịu đựng lâu hơn, đáp ứng nhu cầu công việc chuyên nghiệp. Neural Engine do Apple thiết kế kết nối machine learning sẵn ngay trên thiết bị cho thế hệ kế tiếp của các ứng dụng chuyên nghiệp.</p><p>iPadOS được thiết kế để củng cố sức mạnh và hiệu suất trên iPad Pro. Phần cứng siêu nhanh và phần mềm mạnh mẽ được thiết kế nhằm khiến mỗi tương tác đều diễn ra với tốc độ cao và mượt mà, cho phép xử lý nhiều ứng dụng cùng lúc và di chuyển giữa các không gian nhanh chóng và không tốn nhiều công sức.</p><h3 style="text-align:center;"><strong>LINH HOẠT</strong></h3><p><img style="height:auto;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_9.jpg?1584611440955" alt="" width="1076" height="717"></p><p><a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong></a>&nbsp;mỏng – nhẹ – bền – hoàn hảo cùng bạn đi bất cứ đâu, với thời lượng sử dụng lên đến 10 tiếng.</p>	t	1	2024-07-24 16:06:26.654	2024-07-24 16:09:10.373	\N	\N	iPad Pro 2020 11 inch New Seal CPO tại TP Mobile mua ngay hôm nay để nhận giá ưu đãi	{}	15290000	17290000	0	0	1	1	\N	{}
63	iPad Air 6 13 inch Wifi New Seal	ipad-air-6-13-inch-wifi-new-seal	<h2 style="text-align:justify;"><strong>So sánh&nbsp;iPad Air 6 M2 13 inch Wifi &nbsp;và iPad Air 5</strong></h2><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 13 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>13 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p style="text-align:justify;">Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3 style="text-align:justify;"><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-1.jpg" alt="Cấu hình iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-2.jpg" alt="Thiết kế iPad Air 6 M2 11 inch" width="810" height="456"></p><p style="text-align:justify;">Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3 style="text-align:justify;"><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p style="text-align:justify;">Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-3.jpg" alt="Tính năng iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p style="text-align:justify;">iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-4.jpg" alt="Pin iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p style="text-align:justify;">Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-5.jpg" alt="Camera iPad Air 6 M2 11 inch" width="810" height="456"></p>	t	1	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	\N	\N		{}	20990000	0	28990000	0	1	2	\N	{}
64	iPad Air 6 13 inch LTE New Seal	ipad-air-6-13-inch-lte-new-seal	<h2 style="text-align:justify;"><strong>So sánh&nbsp;iPad Air 6 M2 13 inch LTE và iPad Air 5</strong></h2><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 13 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>13 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p style="text-align:justify;">Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3 style="text-align:justify;"><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-1.jpg" alt="Cấu hình iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-2.jpg" alt="Thiết kế iPad Air 6 M2 11 inch" width="810" height="456"></p><p style="text-align:justify;">Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3 style="text-align:justify;"><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p style="text-align:justify;">Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-3.jpg" alt="Tính năng iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p style="text-align:justify;">iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-4.jpg" alt="Pin iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p style="text-align:justify;">Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-5.jpg" alt="Camera iPad Air 6 M2 11 inch" width="810" height="456"></p>	t	1	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	\N	\N		{}	22990000	0	31990000	0	1	2	\N	{}
32	iPad Pro 2020 11 inch Wifi Like New	ipad-pro-2020-11-inch-wifi-like-new	<h2>iPad Pro 2020 11 inch Wifi Like New tại TP Mobile</h2><p><a href="https://www.apple.com/vn/">Apple</a> chính thức ra mắt thế hệ<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;v</a>ào giữa tháng 03/2020, được đánh giá là mẫu iPad mạnh nhất tính đến thời điểm hiện tại và có tiềm năng vượt trội hơn hầu hết laptop Windows trên thị trường hiện nay nhờ trang bị chip A12Z Bionic đạt tốc độ xử lý vượt trội hơn kết hợp bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. Các nâng cấp mới đáng chú ý bao gồm cảm biến, cụm camera mới với cảm biến quét LIDAR cho cảm ứng chiều sâu và AR, và bàn phím mới cho phép dựng iPad lên mặt phẳng đáy và có tích hợp trackpad. Thời lượng pin lên đến 10 tiếng, hỗ trợ mạng LTE.</p><figure class="image" style="height:auto;"><img style="aspect-ratio:600/600;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/ipad-pro-11-2020.jpg?1584672256390" alt="" width="600" height="600"></figure><h3 style="text-align:center;"><strong>CÔNG NGHỆ HIỂN THỊ LIQUID RETINA</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_0.jpg?1584611013085" alt="" width="1076" height="717"></figure><p>Công nghệ hiển thị tiên tiến Liquid Retina trên<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong></a>&nbsp;không chỉ đẹp và ấn tượng, mà còn trang bị các đặc tính công nghệ xuất sắc. Sự kết hợp cùng các công nghệ ProMotion, True Tone và độ chính xác màu sắc hàng đầu thị trường, khiến mọi thứ trông sống động và mãn nhãn hơn khiến đây trở thành chiếc màn hình di động tân tiến nhất thế giới.</p><h3 style="text-align:center;"><strong>CAMERA CHUYÊN NGHIỆP</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_1.jpg?1584611040033" alt="" width="1076" height="717"></figure><p>Cụm camera kết hợp với màn hình rộng, hiệu suất cao và các cảm biến căn chỉnh chi tiết vốn đã là thế mạnh độc đáo của iPad nói chung.&nbsp;<strong>iPad Pro 11-inch 2020&nbsp;</strong>không những thế còn được trang bị các camera góc rộng và camera góc cực rộng mới, hỗ trợ người dùng căn hình hoàn hảo với cả ảnh và video. Cùng với mic chất lượng phòng thu và 4 speaker,&nbsp;<a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong>&nbsp;</a>có thể được xem như một khung quay dựng phim đa máy ảnh lý tưởng.</p><h3 style="text-align:center;"><strong>LIDAR SCANNER</strong></h3><p>LiDAR (Light Detection and Ranging) được sử dụng để xác định khoảng cách bằng cách đo đạc khoảng cách ánh sáng tiếp cận đối tượng và phản xạ lại. Tính năng này được NASA áp dụng cho nhiệm vụ kế tiếp đáp xuống sao Hỏa, nhưng giờ đây nó đã xuất hiện trên&nbsp;<strong>iP</strong><a href="https://anhphibantao.com/"><strong>ad Pro 11-inch 2020</strong></a>.</p><p>Bộ quét LiDAR được thiết kế tùy biến sử dụng thời gian trực tiếp bay để đo đạc ánh sáng phản xạ lại từ khoảng cách lên đến 5m, kể cả trong nhà hay ngoài trời. Bộ quét này xử lý đến cấp độ photon với tốc độ nano giây, mở ra những tiềm năng hấp dẫn đối với tương tác thực tế ảo (AR) và các công nghệ liên quan.</p><p>LiDAR Scanner làm việc với các camera chuyên nghiệp, cảm biến chuyển động và framework trên hệ điều hành iPadOS nhằm đo chiều sâu. Sự kết hợp với các phần mềm, phần cứng và những cải tiến bất ngờ này biến iPad Pro trở thành thiết bị xuất sắc nhất thế giới về AR.</p><figure class="table"><table><tbody><tr><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_10.jpg?1584612668388" alt="" width="652" height="493"></figure></td><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_4.jpg?1584612635666" alt="" width="652" height="493"></figure></td><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_5.jpg?1584612688894" alt="" width="652" height="493"></figure></td></tr><tr><td><h4 style="text-align:center;"><strong>AR</strong></h4><p>Trên&nbsp;<strong>iPad Pro 11-inch 2020</strong>, ứng dụng AR trở nên chân thực hơn. Giờ đây bạn có thể đặt một vật thể AR ngay lập tức. Việc khớp vật thể thực tế cho phép vật thể AR đi xuyên qua từ phía trước và ở ngay sau cấu trúc thế giới thực. Tính năng ghi lại chuyển động và khớp người chính xác hơn bao giờ hết.</p></td><td><h4 style="text-align:center;"><strong>QUAY VÀ SỬA</strong></h4><p>Hệ thống camera chuyên nghiệp tăng tính linh động trên iPad Pro.&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;cho phép bạn quay, sửa, chia sẻ video 4K. Bạn có thể quay one shot góc rộng bằng camera Ultra Wide hay sử dụng Markup để thiết kế lại ngay tại chỗ. Bạn cũng có thể in chữ ký ra hoặc sao lại bằng Apple Pencil rồi gửi lại chỉ bằng một chạm.</p></td><td><h4 style="text-align:center;"><strong>CAMERA TRUEDEPTH</strong></h4><p>Camera trước TrueDepth cho phép sử dụng Face ID, là tính năng xác nhận khuôn mặt an toàn nhất thế giới trên tablet và cả trên máy tính; đồng nghĩa bạn có thể trò chuyện với bạn bè bằng FaceTime, chụp ảnh Portrait, hay biến những cuộc đối thại trên Messages trở nên vui ngộn với Animoji.</p></td></tr></tbody></table></figure><h3 style="text-align:center;"><strong>CHIP A12Z BIONIC</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_6.jpg?1584612746472" alt="" width="1076" height="717"></figure><p>Với chip A12Z Bionic, iPad Pro đạt được tốc độ xử lý vượt trội hơn nhiều PC laptop trên thị trường hiện nay. Tốc độ này cho phép bạn xử lý mọi thứ nhanh chóng và mượt mà. Kết hợp với bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. A12Z Bionic được thiết kế để làm việc với những ứng dụng chuyên nghiệp hay yêu cầu công việc cao. GPU 8 nhân mang lại hiệu suất mượt mà đối với các yêu cầu chỉnh sửa video 4K, thiết kế 3D, AR. augmented reality. Cấu trúc kiểm soát nhiệt tăng cường đồng nghĩa giới hạn hiệu suất mở rộng và thời gian chịu đựng lâu hơn, đáp ứng nhu cầu công việc chuyên nghiệp. Neural Engine do Apple thiết kế kết nối machine learning sẵn ngay trên thiết bị cho thế hệ kế tiếp của các ứng dụng chuyên nghiệp.</p><p>iPadOS được thiết kế để củng cố sức mạnh và hiệu suất trên iPad Pro. Phần cứng siêu nhanh và phần mềm mạnh mẽ được thiết kế nhằm khiến mỗi tương tác đều diễn ra với tốc độ cao và mượt mà, cho phép xử lý nhiều ứng dụng cùng lúc và di chuyển giữa các không gian nhanh chóng và không tốn nhiều công sức.</p><h3 style="text-align:center;"><strong>LINH HOẠT</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_9.jpg?1584611440955" alt="" width="1076" height="717"></figure><p><a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong></a>&nbsp;mỏng – nhẹ – bền – hoàn hảo cùng bạn đi bất cứ đâu, với thời lượng sử dụng lên đến 10 tiếng.</p>	t	1	2024-07-24 16:13:21.133	2024-07-24 16:15:38.32	\N	\N	iPad Pro 2020 11 inch Wifi Like New tại TP Mobile mua ngay hôm nay để nhận giá ưu đãi	{}	13490000	0	14490000	13490000	1	1	\N	{}
11	iPad Gen 10 10.9 inch 2022 LTE New Seal	ipad-gen-10-109-inch-2022-lte-new-seal	<h3 style="text-align:justify;">Nhà Apple đã chính thức cho ra mắt những mẫu iPad series mới vào tháng 10/2022. Trong đó <a href="https://www.thegioididong.com/may-tinh-bang/ipad-10-wifi-cellular-64gb">iPad Gen 10 Cellular</a>&nbsp;được xem là cái tên khá nổi trội khi sở hữu mức giá bán dễ tiếp cận nhưng lại được trang bị cấu hình khá tốt, có những điểm nổi bật có thể kể đến như: Apple A14 Bionic, hệ điều hành iPadOS 17, thay đổi về mặt thiết kế và kích thước màn hình lớn 10.9 inch.</h3><h3 style="text-align:justify;">Thiết kế đem đến sự trẻ trung hiện đại</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-10">iPad Gen 10</a> mang trong mình nét đặc trưng vốn có của nhiều thế hệ <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> trước đây. Vẫn là mặt lưng và bộ khung được làm liền mạch với nhau đi cùng vật liệu hoàn thiện là kim loại, điều này mang lại cho máy một diện mạo sang trọng và đẳng cấp cũng như làm tăng thêm độ bền bỉ cho thiết bị.</p><p style="text-align:justify;">Năm nay nhà Apple mang đến cho chúng ta 4 phiên bản màu sắc trẻ trung đầy vẻ cá tính. Khác với những tone màu trước đây thường thấy trên những dòng iPad Air, màu sắc trên iPad thế hệ thứ 10 sẽ được làm đậm và có phần nổi trội hơn rất nhiều.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg" alt="Thiết kế trẻ trung - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Một sự cải tiến đáng kể về phần thiết kế so với mẫu <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 9</a> vào năm ngoái là phần viền màn hình giờ đây đã được làm đều ở 4 cạnh, mang lại không gian hiển thị rộng rãi cũng như cảm giác khi sử dụng trở nên dễ chịu.</p><h3 style="text-align:justify;">Không gian hiển thị rộng rãi</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-9-inch">iPad gen 10</a> được trang bị màn hình kích thước lớn với 10.9 inch nên phần lớn nội dung sẽ được hiển thị nhiều hơn trên cùng một khung hình, ngoài ra máy còn có thể đáp ứng tốt cho những tác vụ vẽ vời hay hỗ trợ dùng nhiều ứng dụng trên cùng một màn hình được dễ dàng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> được tích hợp công nghệ màn hình Retina IPS LCD độc quyền đến từ nhà Apple nên hình ảnh mang lại sẽ có độ chân thực cao, nội dung tái hiện trong trẻo cùng khả năng phản ánh màu sắc một cách chuẩn xác.</p><p style="text-align:justify;">Độ phân giải màn hình cũng là một lợi thế lớn của iPad 10 so với những đối thủ trong phân khúc khi máy hỗ trợ hiển thị hình ảnh chuẩn 1640 x 2360 Pixels. Tuy Apple không công bố chính xác chuẩn màn hình này là gì nhưng thông qua con số thì ta có thể ước chừng máy có thể nằm trong khoảng 2K.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với những bạn đang làm những công việc về sáng tạo hình ảnh hay thời trang thì đây chắc hẳn là một sự lựa chọn hết sức phù hợp, sẽ tuyệt vời hơn nếu dùng chung iPad 10 với <a href="https://www.thegioididong.com/phu-kien-thong-minh/but-cam-ung-apple-pencil-1-mk0c2">Apple Pencil</a>&nbsp;để có thể thực hiện các tác vụ viết ghi chú hay phác thảo nội dung một cách nhanh chóng và tiện lợi.</p><h3 style="text-align:justify;">Hiệu năng xử lý tốt nhiều tác vụ</h3><p style="text-align:justify;">Với con chip Apple A14 Bionic được trang bị bên trong thì phần lớn các nhu cầu sử dụng hàng ngày máy hoàn toàn có thể xử lý dễ dàng, chip hoạt động với 6 nhân hiệu suất và mức xung nhịp tối đa có thể đạt được là 3.1 GHz nên iPad 10 còn có thể thực hiện các công việc khó khăn hơn như chỉnh sửa video, thiết kế hình ảnh hay chơi game đồ họa cao.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg" alt="Hiệu năng mạnh mẽ - Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Bên cạnh việc nâng cấp phần cứng so với thế hệ trước thì lần này nhà Apple còn bổ sung thêm cho máy hệ điều hành iPadOS 17 tiên tiến. Điều này sẽ giúp cho thiết bị có thể tối ưu được hiệu suất và năng lượng tốt hơn, thực hiện các công việc thường ngày được nhanh chóng thông qua nhiều tính năng mới thú vị và tiện ích hơn.</p><h3 style="text-align:justify;">Hỗ trợ quay - chụp chất lượng cao</h3><p style="text-align:justify;">Bố trí ở phần mặt lưng sẽ là camera đơn với độ phân giải 12 MP, nó giúp người dùng có thể lưu giữ những khung cảnh đẹp được sắc nét nhờ độ chi tiết khá cao. Bên cạnh đó thì máy cũng có thể thu lại những thước phim chất lượng cao nhờ chuẩn video tối đa được hỗ trợ là 4K - tốc độ khung hình 60.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg" alt="Quay video chất lượng cao - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Ở phần màn hình sẽ được trang bị camera selfie 12 MP, được hỗ trợ thêm tính năng thu phóng khung hình để tự động điều chỉnh sao cho chủ thể có thể xuất hiện ở vị trí gần trung tâm nhất, phù hợp cho những bạn đang làm các công việc thiên về sáng tạo nội dung thông qua video.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg" alt="Camera trước chất lượng -  iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Có thể thấy iPad 10 là sự lựa chọn khá tối ưu khi máy có một mức giá bán hấp dẫn nhưng lại được trang bị bộ thông số rất tốt, đây được xem là sự lựa chọn lý tưởng dành cho những bạn đang là học sinh - sinh viên hay người dùng đang làm các công việc thiên về thiết kế.</p>	t	1	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	\N	\N	iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.	{}	12990000	0	16990000	12990000	1	3	\N	{}
12	iPad Gen 10 10.9 inch 2022 Wifi Like New	ipad-gen-10-109-inch-2022-wifi-like-new	<h3 style="text-align:justify;">Nhà Apple đã chính thức cho ra mắt những mẫu iPad series mới vào tháng 10/2022. Trong đó <a href="https://www.thegioididong.com/may-tinh-bang/ipad-10-wifi-cellular-64gb">iPad Gen 10 Cellular</a>&nbsp;được xem là cái tên khá nổi trội khi sở hữu mức giá bán dễ tiếp cận nhưng lại được trang bị cấu hình khá tốt, có những điểm nổi bật có thể kể đến như: Apple A14 Bionic, hệ điều hành iPadOS 17, thay đổi về mặt thiết kế và kích thước màn hình lớn 10.9 inch.</h3><h3 style="text-align:justify;">Thiết kế đem đến sự trẻ trung hiện đại</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-10">iPad Gen 10</a> mang trong mình nét đặc trưng vốn có của nhiều thế hệ <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> trước đây. Vẫn là mặt lưng và bộ khung được làm liền mạch với nhau đi cùng vật liệu hoàn thiện là kim loại, điều này mang lại cho máy một diện mạo sang trọng và đẳng cấp cũng như làm tăng thêm độ bền bỉ cho thiết bị.</p><p style="text-align:justify;">Năm nay nhà Apple mang đến cho chúng ta 4 phiên bản màu sắc trẻ trung đầy vẻ cá tính. Khác với những tone màu trước đây thường thấy trên những dòng iPad Air, màu sắc trên iPad thế hệ thứ 10 sẽ được làm đậm và có phần nổi trội hơn rất nhiều.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg" alt="Thiết kế trẻ trung - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Một sự cải tiến đáng kể về phần thiết kế so với mẫu <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 9</a> vào năm ngoái là phần viền màn hình giờ đây đã được làm đều ở 4 cạnh, mang lại không gian hiển thị rộng rãi cũng như cảm giác khi sử dụng trở nên dễ chịu.</p><h3 style="text-align:justify;">Không gian hiển thị rộng rãi</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-9-inch">iPad gen 10</a> được trang bị màn hình kích thước lớn với 10.9 inch nên phần lớn nội dung sẽ được hiển thị nhiều hơn trên cùng một khung hình, ngoài ra máy còn có thể đáp ứng tốt cho những tác vụ vẽ vời hay hỗ trợ dùng nhiều ứng dụng trên cùng một màn hình được dễ dàng hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> được tích hợp công nghệ màn hình Retina IPS LCD độc quyền đến từ nhà Apple nên hình ảnh mang lại sẽ có độ chân thực cao, nội dung tái hiện trong trẻo cùng khả năng phản ánh màu sắc một cách chuẩn xác.</p><p style="text-align:justify;">Độ phân giải màn hình cũng là một lợi thế lớn của iPad 10 so với những đối thủ trong phân khúc khi máy hỗ trợ hiển thị hình ảnh chuẩn 1640 x 2360 Pixels. Tuy Apple không công bố chính xác chuẩn màn hình này là gì nhưng thông qua con số thì ta có thể ước chừng máy có thể nằm trong khoảng 2K.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với những bạn đang làm những công việc về sáng tạo hình ảnh hay thời trang thì đây chắc hẳn là một sự lựa chọn hết sức phù hợp, sẽ tuyệt vời hơn nếu dùng chung iPad 10 với <a href="https://www.thegioididong.com/phu-kien-thong-minh/but-cam-ung-apple-pencil-1-mk0c2">Apple Pencil</a>&nbsp;để có thể thực hiện các tác vụ viết ghi chú hay phác thảo nội dung một cách nhanh chóng và tiện lợi.</p><h3 style="text-align:justify;">Hiệu năng xử lý tốt nhiều tác vụ</h3><p style="text-align:justify;">Với con chip Apple A14 Bionic được trang bị bên trong thì phần lớn các nhu cầu sử dụng hàng ngày máy hoàn toàn có thể xử lý dễ dàng, chip hoạt động với 6 nhân hiệu suất và mức xung nhịp tối đa có thể đạt được là 3.1 GHz nên iPad 10 còn có thể thực hiện các công việc khó khăn hơn như chỉnh sửa video, thiết kế hình ảnh hay chơi game đồ họa cao.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg" alt="Hiệu năng mạnh mẽ - Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Bên cạnh việc nâng cấp phần cứng so với thế hệ trước thì lần này nhà Apple còn bổ sung thêm cho máy hệ điều hành iPadOS 17 tiên tiến. Điều này sẽ giúp cho thiết bị có thể tối ưu được hiệu suất và năng lượng tốt hơn, thực hiện các công việc thường ngày được nhanh chóng thông qua nhiều tính năng mới thú vị và tiện ích hơn.</p><h3 style="text-align:justify;">Hỗ trợ quay - chụp chất lượng cao</h3><p style="text-align:justify;">Bố trí ở phần mặt lưng sẽ là camera đơn với độ phân giải 12 MP, nó giúp người dùng có thể lưu giữ những khung cảnh đẹp được sắc nét nhờ độ chi tiết khá cao. Bên cạnh đó thì máy cũng có thể thu lại những thước phim chất lượng cao nhờ chuẩn video tối đa được hỗ trợ là 4K - tốc độ khung hình 60.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg" alt="Quay video chất lượng cao - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Ở phần màn hình sẽ được trang bị camera selfie 12 MP, được hỗ trợ thêm tính năng thu phóng khung hình để tự động điều chỉnh sao cho chủ thể có thể xuất hiện ở vị trí gần trung tâm nhất, phù hợp cho những bạn đang làm các công việc thiên về sáng tạo nội dung thông qua video.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg" alt="Camera trước chất lượng -  iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Có thể thấy iPad 10 là sự lựa chọn khá tối ưu khi máy có một mức giá bán hấp dẫn nhưng lại được trang bị bộ thông số rất tốt, đây được xem là sự lựa chọn lý tưởng dành cho những bạn đang là học sinh - sinh viên hay người dùng đang làm các công việc thiên về thiết kế.</p>	t	1	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	\N	\N	iPad Gen 10 like new là phiên bản iPad thế hệ thứ 10 của Apple mua ngay taij TP Mobile	{}	8790000	0	10990000	8790000	1	3	\N	{}
14	iPad Gen 10 10.9 inch 2022 LTE Like New	ipad-gen-10-109-inch-2022-lte-like-new	<h3 style="text-align:justify;">Nhà Apple đã chính thức cho ra mắt những mẫu iPad series mới vào tháng 10/2022. Trong đó <a href="http://localhost:3000/san-pham/ipad-gen-10-109-inch-2022-wifi">iPad Gen 10 Cellular</a>&nbsp;được xem là cái tên khá nổi trội khi sở hữu mức giá bán dễ tiếp cận nhưng lại được trang bị cấu hình khá tốt, có những điểm nổi bật có thể kể đến như: Apple A14 Bionic, hệ điều hành iPadOS 17, thay đổi về mặt thiết kế và kích thước màn hình lớn 10.9 inch.</h3><h3 style="text-align:justify;">Thiết kế đem đến sự trẻ trung hiện đại</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-10">iPad Gen 10</a> mang trong mình nét đặc trưng vốn có của nhiều thế hệ <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> trước đây. Vẫn là mặt lưng và bộ khung được làm liền mạch với nhau đi cùng vật liệu hoàn thiện là kim loại, điều này mang lại cho máy một diện mạo sang trọng và đẳng cấp cũng như làm tăng thêm độ bền bỉ cho thiết bị.</p><p style="text-align:justify;">Năm nay nhà Apple mang đến cho chúng ta 4 phiên bản màu sắc trẻ trung đầy vẻ cá tính. Khác với những tone màu trước đây thường thấy trên những dòng iPad Air, màu sắc trên iPad thế hệ thứ 10 sẽ được làm đậm và có phần nổi trội hơn rất nhiều.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg" alt="Thiết kế trẻ trung - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Một sự cải tiến đáng kể về phần thiết kế so với mẫu <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 9</a> vào năm ngoái là phần viền màn hình giờ đây đã được làm đều ở 4 cạnh, mang lại không gian hiển thị rộng rãi cũng như cảm giác khi sử dụng trở nên dễ chịu.</p><h3 style="text-align:justify;">Không gian hiển thị rộng rãi</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-9-inch">iPad gen 10</a> được trang bị màn hình kích thước lớn với 10.9 inch nên phần lớn nội dung sẽ được hiển thị nhiều hơn trên cùng một khung hình, ngoài ra máy còn có thể đáp ứng tốt cho những tác vụ vẽ vời hay hỗ trợ dùng nhiều ứng dụng trên cùng một màn hình được dễ dàng hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> được tích hợp công nghệ màn hình Retina IPS LCD độc quyền đến từ nhà Apple nên hình ảnh mang lại sẽ có độ chân thực cao, nội dung tái hiện trong trẻo cùng khả năng phản ánh màu sắc một cách chuẩn xác.</p><p style="text-align:justify;">Độ phân giải màn hình cũng là một lợi thế lớn của iPad 10 so với những đối thủ trong phân khúc khi máy hỗ trợ hiển thị hình ảnh chuẩn 1640 x 2360 Pixels. Tuy Apple không công bố chính xác chuẩn màn hình này là gì nhưng thông qua con số thì ta có thể ước chừng máy có thể nằm trong khoảng 2K.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với những bạn đang làm những công việc về sáng tạo hình ảnh hay thời trang thì đây chắc hẳn là một sự lựa chọn hết sức phù hợp, sẽ tuyệt vời hơn nếu dùng chung iPad 10 với <a href="https://www.thegioididong.com/phu-kien-thong-minh/but-cam-ung-apple-pencil-1-mk0c2">Apple Pencil</a>&nbsp;để có thể thực hiện các tác vụ viết ghi chú hay phác thảo nội dung một cách nhanh chóng và tiện lợi.</p><h3 style="text-align:justify;">Hiệu năng xử lý tốt nhiều tác vụ</h3><p style="text-align:justify;">Với con chip Apple A14 Bionic được trang bị bên trong thì phần lớn các nhu cầu sử dụng hàng ngày máy hoàn toàn có thể xử lý dễ dàng, chip hoạt động với 6 nhân hiệu suất và mức xung nhịp tối đa có thể đạt được là 3.1 GHz nên iPad 10 còn có thể thực hiện các công việc khó khăn hơn như chỉnh sửa video, thiết kế hình ảnh hay chơi game đồ họa cao.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg" alt="Hiệu năng mạnh mẽ - Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Bên cạnh việc nâng cấp phần cứng so với thế hệ trước thì lần này nhà Apple còn bổ sung thêm cho máy hệ điều hành iPadOS 17 tiên tiến. Điều này sẽ giúp cho thiết bị có thể tối ưu được hiệu suất và năng lượng tốt hơn, thực hiện các công việc thường ngày được nhanh chóng thông qua nhiều tính năng mới thú vị và tiện ích hơn.</p><h3 style="text-align:justify;">Hỗ trợ quay - chụp chất lượng cao</h3><p style="text-align:justify;">Bố trí ở phần mặt lưng sẽ là camera đơn với độ phân giải 12 MP, nó giúp người dùng có thể lưu giữ những khung cảnh đẹp được sắc nét nhờ độ chi tiết khá cao. Bên cạnh đó thì máy cũng có thể thu lại những thước phim chất lượng cao nhờ chuẩn video tối đa được hỗ trợ là 4K - tốc độ khung hình 60.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg" alt="Quay video chất lượng cao - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Ở phần màn hình sẽ được trang bị camera selfie 12 MP, được hỗ trợ thêm tính năng thu phóng khung hình để tự động điều chỉnh sao cho chủ thể có thể xuất hiện ở vị trí gần trung tâm nhất, phù hợp cho những bạn đang làm các công việc thiên về sáng tạo nội dung thông qua video.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg" alt="Camera trước chất lượng -  iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Có thể thấy iPad 10 là sự lựa chọn khá tối ưu khi máy có một mức giá bán hấp dẫn nhưng lại được trang bị bộ thông số rất tốt, đây được xem là sự lựa chọn lý tưởng dành cho những bạn đang là học sinh - sinh viên hay người dùng đang làm các công việc thiên về thiết kế.</p>	t	1	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	\N	\N	iPad Gen 10 like new LTE là phiên bản iPad thế hệ thứ 10 của Apple mua ngay taij TP Mobile	{}	0	0	0	0	1	3	\N	{}
15	iPad Gen 9 10.2 inch 2021 WiFi New Seal	ipad-gen-9-102-inch-2021-wifi-new-seal	<h3 style="text-align:justify;">Sau thành công của&nbsp;iPad 8,&nbsp;<a href="https://www.thegioididong.com/apple">Apple</a>&nbsp;đã cho ra mắt <a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-9">iPad Gen 9</a>&nbsp;- phiên bản tiếp theo của dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 10.2</a>, về cơ bản nó kế thừa những điểm mạnh từ các phiên bản trước đó và được cải tiến thêm hiệu suất, trải nghiệm người dùng nhằm giúp nhu cầu sử dụng giải trí và làm việc tiện lợi, linh hoạt hơn.</h3><h3 style="text-align:justify;">Thiết kế quen thuộc của dòng iPad</h3><p style="text-align:justify;">iPad 9 sở hữu&nbsp;hình dạng chữ nhật kèm viền trên dưới quen thuộc, có 2 màu sắc chính để bạn lựa chọn là xám thanh lịch và màu bạc thời thượng cho bạn tùy chọn theo sở thích của mình.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg" alt="Kiểu dáng thanh lịch, sang trọng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Vỏ ngoài bằng aluminum sáng bóng, bền bỉ, chịu lực và tản nhiệt tốt, bảo vệ toàn diện các linh kiện bên trong và tăng tính thẩm mỹ cho sản phẩm.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg" alt="Vỏ ngoài tối giản bền bỉ - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết kế nút Home ở giữa viền dưới của màn hình cho bạn thao tác nhanh khi cần. Cảm biến vân tay Touch ID được tích hợp ở trong phím Home, cho bạn mở khóa một cách nhanh chóng và an toàn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg" alt="Cảm biến vân tay - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình hiển thị rõ ràng</h3><p style="text-align:justify;">Nổi bật với kích thước màn hình lên đến 10.2 inch cho khu vực hiển thị các nội dung rộng rãi hơn, người dùng có thể theo dõi các chương trình giải trí, xử lý các văn bản tiện lợi hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg" alt="Màn hình 10.2 inch sắc nét - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Sử dụng màn hình Retina có độ tương phản cao, độ phân giải 1620 x 2160 Pixels tái hiện hình ảnh một cách sinh động. Hơn nữa, bề mặt màn hình có lớp phủ oleophobic hạn chế bám vân tay, giữ cho màn hình luôn sạch sẽ, nhìn rõ hơn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg" alt="Màn hình Retina với độ phân giải cao - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Ngoài ra <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này còn hỗ trợ công nghệ True Tone, các cảm biến xung quanh sẽ nhận biết ánh sáng, màu sắc xung quanh giúp hệ thống tinh chỉnh độ sáng theo nhiệt độ màu phù hợp với môi trường đang sử dụng giúp hình ảnh hiển thị tự nhiên, xem thoải mái trong mọi điều kiện.</p><p style="text-align:justify;">Cùng với trải nghiệm hình ảnh tuyệt vời thì iPad 9 còn được trang bị loa stereo cực hay, khiến cho mọi trải nghiệm của bạn trên chiếc máy tính bảng này trở nên trọn vẹn hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg" alt="Được trang bị loa Stereo - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">FaceTime chất lượng cao&nbsp;</h3><p style="text-align:justify;">Camera Ultra Wide phía trước có độ phân giải 12 MP có góc nhìn rộng đến 122°, cho bạn chụp ảnh HDR, quay video Full HD với tốc độ khung hình tới 60 fps, hỗ trợ quay video tua nhanh thời gian (Time‑lapse).</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg" alt="Camera Ultra Wide 12 MP - Camera Ultra Wide" width="1020" height="570"></a></figure><p style="text-align:justify;">Công nghệ&nbsp;Center Stage ở camera trước sẽ đảm bảo bạn luôn hiện diện đầy nổi bật trong cuộc gọi video, khi bạn thay đổi vị trí thì khung hình sẽ tự động di chuyển, zoom theo để giữ bạn trong tầm nhìn, nếu có người khác tham gia, ống kính phát hiện và tự thu nhỏ để đưa họ vào màn hình, giúp trải nghiệm gọi video được tối ưu hơn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg" alt="Công nghệ Center Stage - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau độ phân giải&nbsp;8 MP, có khả năng&nbsp;zoom kỹ thuật số 5x, hỗ trợ chụp toàn cảnh Panorama và chụp ảnh HDR. Công nghệ ổn định hình ảnh tự động giúp bạn tạo ra những bức hình từ phong cảnh đến hình chân dung đều trở nên đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg" alt="Camera sau 8 MP - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> hỗ trợ quay video chất lượng Full HD và có thể zoom 3x, ngoài ra còn có thể quay video chuyển động chậm, video tua nhanh thời gian.&nbsp;Bên cạnh đó, hệ thống camera sau đa năng cũng cho phép bạn quét tài liệu và trải nghiệm các ứng dụng AR linh hoạt.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-10.jpg" alt="Hỗ trợ nhiều tính năng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Trang bị cấu hình mạnh mẽ</h3><p style="text-align:justify;">Máy được tích hợp con chip Apple A13 Bionic 6 nhân cho hiệu suất cao đến 20% so với thế hệ trước bao gồm&nbsp;CPU, GPU đến Neural Engine. Kết hợp cùng RAM 3 GB thì với hiệu năng này iPad Gen 9 64GB sẽ mang đến những trải nghiệm trò chơi sống động, mượt mà và có độ chi tiết cao, các tác vụ 3D cũng sẽ được xử lý một cách nhanh chóng nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-11.jpg" alt="Chip Apple A13 Bionic 6 nhân - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Về khả năng kết nối iPad 9 hỗ trợ Wi-Fi 802.11 a/b/g/n/ac và Bluetooth v4.2 cung cấp đường truyền kết nối không dây ổn định cho bạn ghép nối và sử dụng cùng các thiết bị khác một cách dễ dàng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-12.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-12.jpg" alt="Đường truyền ổn định - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Máy có bộ nhớ trong 64 GB&nbsp;cho người dùng có nhu cầu ghi lại nhiều video, hình ảnh, trò chơi hơn. Hỗ trợ&nbsp;iCloud - dịch vụ lưu trữ đám mây cho trường hợp bạn cần thêm không gian lưu trữ dữ liệu.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-13.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-13.jpg" alt="Dung lượng bộ nhớ - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết lập iPadOS 15 với khả năng đa nhiệm ấn tượng,&nbsp;bố cục widget trực quan cho màn hình chính và ghi chú Quick Note trên toàn hệ thống, thư viện ứng dụng phong phú cho bạn dễ dàng cá nhân hóa trải nghiệm phù hợp với nhu cầu của mình.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-14.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-14.jpg" alt="iPadOS đa nhiệm ổn định - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Hệ điều hành này còn cung cấp thêm nhiều tính năng khác như ứng dụng dịch với khả năng tự động, chế độ xem trực diện, tính năng Live Text nhận dạng văn bản bên trong ảnh và Focus lọc thông báo dựa vào hoạt động bạn đang làm,...&nbsp;</p><p style="text-align:justify;">Tương thích với <a href="https://www.thegioididong.com/phu-kien-thong-minh/but-cam-ung-apple-pencil-1-mk0c2">Apple Pencil 1</a>&nbsp;và&nbsp;bàn phím thông minh của hãng, cho bạn biến máy tính bảng thành tập vẽ, hoặc sử dụng như một chiếc laptop thực thụ, bạn có thể làm việc giải trí với iPad 9 mọi lúc mọi nơi.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-15.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-15.jpg" alt="Tương thích với Apple Pencil 1 - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure>	t	1	2024-07-23 13:10:23.652	2024-07-23 13:10:23.652	\N	\N	iPad 10.2 inch 2021 vẫn mang thiết kế đặc trưng bởi sự mỏng và nhẹ, giúp người dùng dễ thao tác, cầm nắm trong hàng giờ liền mà không hề cảm thấy bị mỏi hay khó chịu. Thiết kế nguyên khối đã là nét đặc trưng của dòng sản phẩm iPad giúp mang lại vẻ sang trọng khi sử dụng tên tay.	{}	6990000	0	9990000	6990000	1	3	\N	{}
16	iPad Gen 9 10.2 inch 2021 LTE New Seal	ipad-gen-9-102-inch-2021-lte-new-seal	<h3 style="text-align:justify;">Sau thành công của&nbsp;iPad 8,&nbsp;<a href="https://www.thegioididong.com/apple">Apple</a>&nbsp;đã cho ra mắt <a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-9">iPad Gen 9</a>&nbsp;- phiên bản tiếp theo của dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 10.2</a>, về cơ bản nó kế thừa những điểm mạnh từ các phiên bản trước đó và được cải tiến thêm hiệu suất, trải nghiệm người dùng nhằm giúp nhu cầu sử dụng giải trí và làm việc tiện lợi, linh hoạt hơn.</h3><h3 style="text-align:justify;">Thiết kế quen thuộc của dòng iPad</h3><p style="text-align:justify;">iPad 9 sở hữu&nbsp;hình dạng chữ nhật kèm viền trên dưới quen thuộc, có 2 màu sắc chính để bạn lựa chọn là xám thanh lịch và màu bạc thời thượng cho bạn tùy chọn theo sở thích của mình.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg" alt="Kiểu dáng thanh lịch, sang trọng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Vỏ ngoài bằng aluminum sáng bóng, bền bỉ, chịu lực và tản nhiệt tốt, bảo vệ toàn diện các linh kiện bên trong và tăng tính thẩm mỹ cho sản phẩm.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg" alt="Vỏ ngoài tối giản bền bỉ - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết kế nút Home ở giữa viền dưới của màn hình cho bạn thao tác nhanh khi cần. Cảm biến vân tay Touch ID được tích hợp ở trong phím Home, cho bạn mở khóa một cách nhanh chóng và an toàn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg" alt="Cảm biến vân tay - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình hiển thị rõ ràng</h3><p style="text-align:justify;">Nổi bật với kích thước màn hình lên đến 10.2 inch cho khu vực hiển thị các nội dung rộng rãi hơn, người dùng có thể theo dõi các chương trình giải trí, xử lý các văn bản tiện lợi hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg" alt="Màn hình 10.2 inch sắc nét - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Sử dụng màn hình Retina có độ tương phản cao, độ phân giải 1620 x 2160 Pixels tái hiện hình ảnh một cách sinh động. Hơn nữa, bề mặt màn hình có lớp phủ oleophobic hạn chế bám vân tay, giữ cho màn hình luôn sạch sẽ, nhìn rõ hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg" alt="Màn hình Retina với độ phân giải cao - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Ngoài ra <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này còn hỗ trợ công nghệ True Tone, các cảm biến xung quanh sẽ nhận biết ánh sáng, màu sắc xung quanh giúp hệ thống tinh chỉnh độ sáng theo nhiệt độ màu phù hợp với môi trường đang sử dụng giúp hình ảnh hiển thị tự nhiên, xem thoải mái trong mọi điều kiện.</p><p style="text-align:justify;">Cùng với trải nghiệm hình ảnh tuyệt vời thì iPad 9 còn được trang bị loa stereo cực hay, khiến cho mọi trải nghiệm của bạn trên chiếc máy tính bảng này trở nên trọn vẹn hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg" alt="Được trang bị loa Stereo - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">FaceTime chất lượng cao&nbsp;</h3><p style="text-align:justify;">Camera Ultra Wide phía trước có độ phân giải 12 MP có góc nhìn rộng đến 122°, cho bạn chụp ảnh HDR, quay video Full HD với tốc độ khung hình tới 60 fps, hỗ trợ quay video tua nhanh thời gian (Time‑lapse).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg" alt="Camera Ultra Wide 12 MP - Camera Ultra Wide" width="1020" height="570"></a></figure><p style="text-align:justify;">Công nghệ&nbsp;Center Stage ở camera trước sẽ đảm bảo bạn luôn hiện diện đầy nổi bật trong cuộc gọi video, khi bạn thay đổi vị trí thì khung hình sẽ tự động di chuyển, zoom theo để giữ bạn trong tầm nhìn, nếu có người khác tham gia, ống kính phát hiện và tự thu nhỏ để đưa họ vào màn hình, giúp trải nghiệm gọi video được tối ưu hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg" alt="Công nghệ Center Stage - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau độ phân giải&nbsp;8 MP, có khả năng&nbsp;zoom kỹ thuật số 5x, hỗ trợ chụp toàn cảnh Panorama và chụp ảnh HDR. Công nghệ ổn định hình ảnh tự động giúp bạn tạo ra những bức hình từ phong cảnh đến hình chân dung đều trở nên đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg" alt="Camera sau 8 MP - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> hỗ trợ quay video chất lượng Full HD và có thể zoom 3x, ngoài ra còn có thể quay video chuyển động chậm, video tua nhanh thời gian.&nbsp;Bên cạnh đó, hệ thống camera sau đa năng cũng cho phép bạn quét tài liệu và trải nghiệm các ứng dụng AR linh hoạt.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-10.jpg" alt="Hỗ trợ nhiều tính năng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Trang bị cấu hình mạnh mẽ</h3><p style="text-align:justify;">Máy được tích hợp con chip Apple A13 Bionic 6 nhân cho hiệu suất cao đến 20% so với thế hệ trước bao gồm&nbsp;CPU, GPU đến Neural Engine. Kết hợp cùng RAM 3 GB thì với hiệu năng này iPad Gen 9 64GB sẽ mang đến những trải nghiệm trò chơi sống động, mượt mà và có độ chi tiết cao, các tác vụ 3D cũng sẽ được xử lý một cách nhanh chóng nhất.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-11.jpg" alt="Chip Apple A13 Bionic 6 nhân - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure>	t	1	2024-07-23 13:12:58.852	2024-07-23 13:12:58.852	\N	\N	iPad 10.2 inch 2021 vẫn mang thiết kế đặc trưng bởi sự mỏng và nhẹ, giúp người dùng dễ thao tác, cầm nắm trong hàng giờ liền mà không hề cảm thấy bị mỏi hay khó chịu. Thiết kế nguyên khối đã là nét đặc trưng của dòng sản phẩm iPad giúp mang lại vẻ sang trọng khi sử dụng tên tay.	{}	0	0	0	0	1	3	\N	{}
17	iPad Gen 9 10.2 inch 2021 Wifi Like New	ipad-gen-9-102-inch-2021-wifi-like-new	<h2>iPad Gen 9 10.2 inch 2021 Wifi Like New</h2><h3 style="text-align:justify;">Sau thành công của&nbsp;iPad 8,&nbsp;<a href="https://www.thegioididong.com/apple">Apple</a>&nbsp;đã cho ra mắt <a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-9">iPad Gen 9</a>&nbsp;- phiên bản tiếp theo của dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 10.2</a>, về cơ bản nó kế thừa những điểm mạnh từ các phiên bản trước đó và được cải tiến thêm hiệu suất, trải nghiệm người dùng nhằm giúp nhu cầu sử dụng giải trí và làm việc tiện lợi, linh hoạt hơn.</h3><h3 style="text-align:justify;">Thiết kế quen thuộc của dòng iPad</h3><p style="text-align:justify;">iPad 9 sở hữu&nbsp;hình dạng chữ nhật kèm viền trên dưới quen thuộc, có 2 màu sắc chính để bạn lựa chọn là xám thanh lịch và màu bạc thời thượng cho bạn tùy chọn theo sở thích của mình.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg" alt="Kiểu dáng thanh lịch, sang trọng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Vỏ ngoài bằng aluminum sáng bóng, bền bỉ, chịu lực và tản nhiệt tốt, bảo vệ toàn diện các linh kiện bên trong và tăng tính thẩm mỹ cho sản phẩm.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg" alt="Vỏ ngoài tối giản bền bỉ - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết kế nút Home ở giữa viền dưới của màn hình cho bạn thao tác nhanh khi cần. Cảm biến vân tay Touch ID được tích hợp ở trong phím Home, cho bạn mở khóa một cách nhanh chóng và an toàn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg" alt="Cảm biến vân tay - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình hiển thị rõ ràng</h3><p style="text-align:justify;">Nổi bật với kích thước màn hình lên đến 10.2 inch cho khu vực hiển thị các nội dung rộng rãi hơn, người dùng có thể theo dõi các chương trình giải trí, xử lý các văn bản tiện lợi hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg" alt="Màn hình 10.2 inch sắc nét - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Sử dụng màn hình Retina có độ tương phản cao, độ phân giải 1620 x 2160 Pixels tái hiện hình ảnh một cách sinh động. Hơn nữa, bề mặt màn hình có lớp phủ oleophobic hạn chế bám vân tay, giữ cho màn hình luôn sạch sẽ, nhìn rõ hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg" alt="Màn hình Retina với độ phân giải cao - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Ngoài ra <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này còn hỗ trợ công nghệ True Tone, các cảm biến xung quanh sẽ nhận biết ánh sáng, màu sắc xung quanh giúp hệ thống tinh chỉnh độ sáng theo nhiệt độ màu phù hợp với môi trường đang sử dụng giúp hình ảnh hiển thị tự nhiên, xem thoải mái trong mọi điều kiện.</p><p style="text-align:justify;">Cùng với trải nghiệm hình ảnh tuyệt vời thì iPad 9 còn được trang bị loa stereo cực hay, khiến cho mọi trải nghiệm của bạn trên chiếc máy tính bảng này trở nên trọn vẹn hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg" alt="Được trang bị loa Stereo - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">FaceTime chất lượng cao&nbsp;</h3><p style="text-align:justify;">Camera Ultra Wide phía trước có độ phân giải 12 MP có góc nhìn rộng đến 122°, cho bạn chụp ảnh HDR, quay video Full HD với tốc độ khung hình tới 60 fps, hỗ trợ quay video tua nhanh thời gian (Time‑lapse).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg" alt="Camera Ultra Wide 12 MP - Camera Ultra Wide" width="1020" height="570"></a></figure><p style="text-align:justify;">Công nghệ&nbsp;Center Stage ở camera trước sẽ đảm bảo bạn luôn hiện diện đầy nổi bật trong cuộc gọi video, khi bạn thay đổi vị trí thì khung hình sẽ tự động di chuyển, zoom theo để giữ bạn trong tầm nhìn, nếu có người khác tham gia, ống kính phát hiện và tự thu nhỏ để đưa họ vào màn hình, giúp trải nghiệm gọi video được tối ưu hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg" alt="Công nghệ Center Stage - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau độ phân giải&nbsp;8 MP, có khả năng&nbsp;zoom kỹ thuật số 5x, hỗ trợ chụp toàn cảnh Panorama và chụp ảnh HDR. Công nghệ ổn định hình ảnh tự động giúp bạn tạo ra những bức hình từ phong cảnh đến hình chân dung đều trở nên đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg" alt="Camera sau 8 MP - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure>	t	1	2024-07-23 13:17:33.448	2024-07-23 13:17:33.448	\N	\N	iPad Gen 9 10.2 inch 2021 Wifi Like New vẫn mang thiết kế đặc trưng bởi sự mỏng và nhẹ, giúp người dùng dễ thao tác, cầm nắm trong hàng giờ liền mà không hề cảm thấy bị mỏi hay khó chịu. Thiết kế nguyên khối đã là nét đặc trưng của dòng sản phẩm iPad giúp mang lại vẻ sang trọng khi sử dụng tên tay.	{}	5790000	0	7990000	5790000	1	3	\N	{}
18	iPad Gen 9 10.2 inch 2021 LTE Like New	ipad-gen-9-102-inch-2021-lte-like-new	<h2>iPad Gen 9 10.2 inch 2021 LTE Like New</h2><h3 style="text-align:justify;">Sau thành công của&nbsp;iPad 8,&nbsp;<a href="https://www.thegioididong.com/apple">Apple</a>&nbsp;đã cho ra mắt <a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-9">iPad Gen 9</a>&nbsp;- phiên bản tiếp theo của dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 10.2</a>, về cơ bản nó kế thừa những điểm mạnh từ các phiên bản trước đó và được cải tiến thêm hiệu suất, trải nghiệm người dùng nhằm giúp nhu cầu sử dụng giải trí và làm việc tiện lợi, linh hoạt hơn.</h3><h3 style="text-align:justify;">Thiết kế quen thuộc của dòng iPad</h3><p style="text-align:justify;">iPad 9 sở hữu&nbsp;hình dạng chữ nhật kèm viền trên dưới quen thuộc, có 2 màu sắc chính để bạn lựa chọn là xám thanh lịch và màu bạc thời thượng cho bạn tùy chọn theo sở thích của mình.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-1.jpg" alt="Kiểu dáng thanh lịch, sang trọng - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Vỏ ngoài bằng aluminum sáng bóng, bền bỉ, chịu lực và tản nhiệt tốt, bảo vệ toàn diện các linh kiện bên trong và tăng tính thẩm mỹ cho sản phẩm.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-2.jpg" alt="Vỏ ngoài tối giản bền bỉ - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết kế nút Home ở giữa viền dưới của màn hình cho bạn thao tác nhanh khi cần. Cảm biến vân tay Touch ID được tích hợp ở trong phím Home, cho bạn mở khóa một cách nhanh chóng và an toàn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-3.jpg" alt="Cảm biến vân tay - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình hiển thị rõ ràng</h3><p style="text-align:justify;">Nổi bật với kích thước màn hình lên đến 10.2 inch cho khu vực hiển thị các nội dung rộng rãi hơn, người dùng có thể theo dõi các chương trình giải trí, xử lý các văn bản tiện lợi hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-4.jpg" alt="Màn hình 10.2 inch sắc nét - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Sử dụng màn hình Retina có độ tương phản cao, độ phân giải 1620 x 2160 Pixels tái hiện hình ảnh một cách sinh động. Hơn nữa, bề mặt màn hình có lớp phủ oleophobic hạn chế bám vân tay, giữ cho màn hình luôn sạch sẽ, nhìn rõ hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-5.jpg" alt="Màn hình Retina với độ phân giải cao - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Ngoài ra <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a>&nbsp;này còn hỗ trợ công nghệ True Tone, các cảm biến xung quanh sẽ nhận biết ánh sáng, màu sắc xung quanh giúp hệ thống tinh chỉnh độ sáng theo nhiệt độ màu phù hợp với môi trường đang sử dụng giúp hình ảnh hiển thị tự nhiên, xem thoải mái trong mọi điều kiện.</p><p style="text-align:justify;">Cùng với trải nghiệm hình ảnh tuyệt vời thì iPad 9 còn được trang bị loa stereo cực hay, khiến cho mọi trải nghiệm của bạn trên chiếc máy tính bảng này trở nên trọn vẹn hơn.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-6.jpg" alt="Được trang bị loa Stereo - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><h3 style="text-align:justify;">FaceTime chất lượng cao&nbsp;</h3><p style="text-align:justify;">Camera Ultra Wide phía trước có độ phân giải 12 MP có góc nhìn rộng đến 122°, cho bạn chụp ảnh HDR, quay video Full HD với tốc độ khung hình tới 60 fps, hỗ trợ quay video tua nhanh thời gian (Time‑lapse).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-7.jpg" alt="Camera Ultra Wide 12 MP - Camera Ultra Wide" width="1020" height="570"></a></figure><p style="text-align:justify;">Công nghệ&nbsp;Center Stage ở camera trước sẽ đảm bảo bạn luôn hiện diện đầy nổi bật trong cuộc gọi video, khi bạn thay đổi vị trí thì khung hình sẽ tự động di chuyển, zoom theo để giữ bạn trong tầm nhìn, nếu có người khác tham gia, ống kính phát hiện và tự thu nhỏ để đưa họ vào màn hình, giúp trải nghiệm gọi video được tối ưu hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-8.jpg" alt="Công nghệ Center Stage - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau độ phân giải&nbsp;8 MP, có khả năng&nbsp;zoom kỹ thuật số 5x, hỗ trợ chụp toàn cảnh Panorama và chụp ảnh HDR. Công nghệ ổn định hình ảnh tự động giúp bạn tạo ra những bức hình từ phong cảnh đến hình chân dung đều trở nên đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-9.jpg" alt="Camera sau 8 MP - iPad 9 WiFi 64GB " width="1020" height="570"></a></figure>	t	1	2024-07-23 13:19:56.822	2024-07-23 13:19:56.822	\N	\N	iPad Gen 9 10.2 inch 2021 Wifi Like New vẫn mang thiết kế đặc trưng bởi sự mỏng và nhẹ, giúp người dùng dễ thao tác, cầm nắm trong hàng giờ liền mà không hề cảm thấy bị mỏi hay khó chịu. Thiết kế nguyên khối đã là nét đặc trưng của dòng sản phẩm iPad giúp mang lại vẻ sang trọng khi sử dụng tên tay.	{}	0	0	0	0	1	3	\N	{}
19	iPad Air 5 10.9 inch 2022 WIFI New Seal	ipad-air-5-109-inch-2022-wifi-new-seal	<h2 style="text-align:justify;"><strong>iPad Air 5 được nâng cấp gì so với iPad Air 4?</strong></h2><p style="text-align:justify;">So với thế hệ iPad Air 4 hồi năm 2020 thì chiếc iPad Air 2022 được mong đợi sẽ có nhiều cải tiến, trong đó nổi bật là màn hình, vi xử lý, dung lượng pin, bộ nhớ trong. Dưới đây là bảng so sánh thông số kỹ thuật dự kiến của iPad Air 2020 và 2022 bạn có thể tham khảo:</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 5</strong></td><td><strong>iPad Air 4</strong></td></tr><tr><td><strong>Màn hình</strong></td><td>IPS Led-backlit Multi-Touch 10.9 inch</td><td>IPS LCD 10.9 inch</td></tr><tr><td><strong>Chip xử lý</strong></td><td><span style="color:rgb(255,0,0);"><strong>Apple M1</strong></span></td><td>A14 Bionic</td></tr><tr><td><strong>Dung lượng RAM</strong></td><td><span style="color:rgb(255,0,0);"><strong>8GB</strong></span></td><td>4GB</td></tr><tr><td><strong>Bộ nhớ trong</strong></td><td><span style="color:rgb(0,0,0);">64GB </span>(bản tiêu chuẩn)</td><td>64GB (bản tiêu chuẩn)</td></tr><tr><td><strong>Thời lượng pin</strong></td><td><span style="color:rgb(0,0,0);">10 giờ</span></td><td>10 giờ</td></tr><tr><td><strong>Hỗ trợ 5G</strong></td><td>Có</td><td>Có</td></tr><tr><td><strong>Camera</strong></td><td>12MP</td><td><span style="color:rgb(0,0,0);">12MP</span></td></tr></tbody></table></figure><h3 style="text-align:justify;">Sức mạnh từ con chip M1</h3><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg" alt="Sức mạnh từ con chip M1 - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Apple M1 8 nhân là vi xử lý do chính Apple nghiên cứu và sản xuất. Con chip này đã được chứng minh sức mạnh qua nhiều dòng sản phẩm và bây giờ đã xuất hiện trên iPad Air 5 M1 WiFi 64 GB. Với 8 nhân CPU, vi xử lý này sẽ giúp thiết bị có thể hoạt động ổn định cùng với <a href="https://www.thegioididong.com/may-tinh-bang-ram-8gb">RAM 8 GB</a>.&nbsp;</p><h3 style="text-align:justify;">Thiết kế sang trọng</h3><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg" alt="Thiết kế sang trọng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad Air 5 M1 WiFi 64 GB có thiết kế phẳng ở 4 cạnh, mặt sau được làm từ nhôm với nhiều màu sắc tươi trẻ. Đặc biệt, năm nay Apple đã bổ sung màu tím cho dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a>, màu sắc này sẽ gây ấn tượng mạnh khi chúng ta cầm máy sử dụng. Màn hình của máy cũng được làm phẳng với kích thước 10.9 inch.</p><h3 style="text-align:justify;">Tính năng đặc biệt</h3><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg" alt="Nhiều tính năng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Chiếc <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> này&nbsp;có nhiều tính năng đặc biệt: Kết nối Apple Pencil 2, Kết nối bàn phím rời, Micro kép, Mở khóa bằng vân tay, Nam châm và sạc cho Apple Pencil.<br>&nbsp;</p>	t	1	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	\N	\N	Mỗi khi một chiếc iPad mới vừa ra lò như một cơn chấn động thật sự bùng nổ. Đến năm 2022, chúng ta lại tiếp tục bùng nổ với chiếc iPad mới mang tên iPad Air 5 với nhiều cải tiến đáng giá.	{}	12990000	0	16990000	12990000	1	2	\N	{}
20	iPad Air 5 10.9 inch 2022 LTE New Seal	ipad-air-5-109-inch-2022-lte-new-seal	<h2 style="text-align:justify;"><strong>iPad Air 5 được nâng cấp gì so với iPad Air 4?</strong></h2><p style="text-align:justify;">So với thế hệ iPad Air 4 hồi năm 2020 thì chiếc iPad Air 2022 được mong đợi sẽ có nhiều cải tiến, trong đó nổi bật là màn hình, vi xử lý, dung lượng pin, bộ nhớ trong. Dưới đây là bảng so sánh thông số kỹ thuật dự kiến của iPad Air 2020 và 2022 bạn có thể tham khảo:</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 5</strong></td><td><strong>iPad Air 4</strong></td></tr><tr><td><strong>Màn hình</strong></td><td>IPS Led-backlit Multi-Touch 10.9 inch</td><td>IPS LCD 10.9 inch</td></tr><tr><td><strong>Chip xử lý</strong></td><td><span style="color:rgb(255,0,0);"><strong>Apple M1</strong></span></td><td>A14 Bionic</td></tr><tr><td><strong>Dung lượng RAM</strong></td><td><span style="color:rgb(255,0,0);"><strong>8GB</strong></span></td><td>4GB</td></tr><tr><td><strong>Bộ nhớ trong</strong></td><td><span style="color:rgb(0,0,0);">64GB </span>(bản tiêu chuẩn)</td><td>64GB (bản tiêu chuẩn)</td></tr><tr><td><strong>Thời lượng pin</strong></td><td><span style="color:rgb(0,0,0);">10 giờ</span></td><td>10 giờ</td></tr><tr><td><strong>Hỗ trợ 5G</strong></td><td>Có</td><td>Có</td></tr><tr><td><strong>Camera</strong></td><td>12MP</td><td><span style="color:rgb(0,0,0);">12MP</span></td></tr></tbody></table></figure><h3 style="text-align:justify;">Sức mạnh từ con chip M1</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg" alt="Sức mạnh từ con chip M1 - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Apple M1 8 nhân là vi xử lý do chính Apple nghiên cứu và sản xuất. Con chip này đã được chứng minh sức mạnh qua nhiều dòng sản phẩm và bây giờ đã xuất hiện trên iPad Air 5 M1 WiFi 64 GB. Với 8 nhân CPU, vi xử lý này sẽ giúp thiết bị có thể hoạt động ổn định cùng với <a href="https://www.thegioididong.com/may-tinh-bang-ram-8gb">RAM 8 GB</a>.&nbsp;</p><h3 style="text-align:justify;">Thiết kế sang trọng</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg" alt="Thiết kế sang trọng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad Air 5 M1 WiFi 64 GB có thiết kế phẳng ở 4 cạnh, mặt sau được làm từ nhôm với nhiều màu sắc tươi trẻ. Đặc biệt, năm nay Apple đã bổ sung màu tím cho dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a>, màu sắc này sẽ gây ấn tượng mạnh khi chúng ta cầm máy sử dụng. Màn hình của máy cũng được làm phẳng với kích thước 10.9 inch.</p><h3 style="text-align:justify;">Tính năng đặc biệt</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg" alt="Nhiều tính năng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Chiếc <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> này&nbsp;có nhiều tính năng đặc biệt: Kết nối Apple Pencil 2, Kết nối bàn phím rời, Micro kép, Mở khóa bằng vân tay, Nam châm và sạc cho Apple Pencil.</p>	t	1	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	\N	\N	iPad Air 5 10.9 inch 2022 LTE New Seal Mỗi khi một chiếc iPad mới vừa ra lò như một cơn chấn động thật sự bùng nổ. Đến năm 2022, chúng ta lại tiếp tục bùng nổ với chiếc iPad mới mang tên iPad Air 5 với nhiều cải tiến đáng giá.	{}	15990000	0	15990000	0	1	2	\N	{}
21	iPad Air 5 10.9 inch 2022 Wifi Like New	ipad-air-5-109-inch-2022-wifi-like-new	<h2 style="text-align:justify;"><strong>iPad Air 5 10.9 inch 2022 Wifi Like New</strong></h2><h2 style="text-align:justify;">iPad Air 5 được nâng cấp gì so với iPad Air 4?</h2><p style="text-align:justify;">So với thế hệ iPad Air 4 hồi năm 2020 thì chiếc iPad Air 2022 được mong đợi sẽ có nhiều cải tiến, trong đó nổi bật là màn hình, vi xử lý, dung lượng pin, bộ nhớ trong. Dưới đây là bảng so sánh thông số kỹ thuật dự kiến của iPad Air 2020 và 2022 bạn có thể tham khảo:</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 5</strong></td><td><strong>iPad Air 4</strong></td></tr><tr><td><strong>Màn hình</strong></td><td>IPS Led-backlit Multi-Touch 10.9 inch</td><td>IPS LCD 10.9 inch</td></tr><tr><td><strong>Chip xử lý</strong></td><td><span style="color:rgb(255,0,0);"><strong>Apple M1</strong></span></td><td>A14 Bionic</td></tr><tr><td><strong>Dung lượng RAM</strong></td><td><span style="color:rgb(255,0,0);"><strong>8GB</strong></span></td><td>4GB</td></tr><tr><td><strong>Bộ nhớ trong</strong></td><td><span style="color:rgb(0,0,0);">64GB </span>(bản tiêu chuẩn)</td><td>64GB (bản tiêu chuẩn)</td></tr><tr><td><strong>Thời lượng pin</strong></td><td><span style="color:rgb(0,0,0);">10 giờ</span></td><td>10 giờ</td></tr><tr><td><strong>Hỗ trợ 5G</strong></td><td>Có</td><td>Có</td></tr><tr><td><strong>Camera</strong></td><td>12MP</td><td><span style="color:rgb(0,0,0);">12MP</span></td></tr></tbody></table></figure><h3 style="text-align:justify;">Sức mạnh từ con chip M1</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg" alt="Sức mạnh từ con chip M1 - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Apple M1 8 nhân là vi xử lý do chính Apple nghiên cứu và sản xuất. Con chip này đã được chứng minh sức mạnh qua nhiều dòng sản phẩm và bây giờ đã xuất hiện trên iPad Air 5 M1 WiFi 64 GB. Với 8 nhân CPU, vi xử lý này sẽ giúp thiết bị có thể hoạt động ổn định cùng với <a href="https://www.thegioididong.com/may-tinh-bang-ram-8gb">RAM 8 GB</a>.&nbsp;</p><h3 style="text-align:justify;">Thiết kế sang trọng</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg" alt="Thiết kế sang trọng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad Air 5 M1 WiFi 64 GB có thiết kế phẳng ở 4 cạnh, mặt sau được làm từ nhôm với nhiều màu sắc tươi trẻ. Đặc biệt, năm nay Apple đã bổ sung màu tím cho dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a>, màu sắc này sẽ gây ấn tượng mạnh khi chúng ta cầm máy sử dụng. Màn hình của máy cũng được làm phẳng với kích thước 10.9 inch.</p><h3 style="text-align:justify;">Tính năng đặc biệt</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg" alt="Nhiều tính năng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Chiếc <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> này&nbsp;có nhiều tính năng đặc biệt: Kết nối Apple Pencil 2, Kết nối bàn phím rời, Micro kép, Mở khóa bằng vân tay, Nam châm và sạc cho Apple Pencil.</p>	t	1	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	\N	\N	iPad Air 5 10.9 inch 2022 Wifi Like New Mỗi khi một chiếc iPad mới vừa ra lò như một cơn chấn động thật sự bùng nổ. Đến năm 2022, chúng ta lại tiếp tục bùng nổ với chiếc iPad mới mang tên iPad Air 5 với nhiều cải tiến đáng giá.	{}	11490000	0	14490000	11490000	1	2	\N	{}
22	iPad Air 5 10.9 inch 2022 LTE Like New	ipad-air-5-109-inch-2022-lte-like-new	<h2 style="text-align:justify;"><strong>iPad Air 5 10.9 inch 2022 Wifi Like New</strong></h2><h2 style="text-align:justify;">iPad Air 5 được nâng cấp gì so với iPad Air 4?</h2><p style="text-align:justify;">So với thế hệ iPad Air 4 hồi năm 2020 thì chiếc iPad Air 2022 được mong đợi sẽ có nhiều cải tiến, trong đó nổi bật là màn hình, vi xử lý, dung lượng pin, bộ nhớ trong. Dưới đây là bảng so sánh thông số kỹ thuật dự kiến của iPad Air 2020 và 2022 bạn có thể tham khảo:</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 5</strong></td><td><strong>iPad Air 4</strong></td></tr><tr><td><strong>Màn hình</strong></td><td>IPS Led-backlit Multi-Touch 10.9 inch</td><td>IPS LCD 10.9 inch</td></tr><tr><td><strong>Chip xử lý</strong></td><td><span style="color:rgb(255,0,0);"><strong>Apple M1</strong></span></td><td>A14 Bionic</td></tr><tr><td><strong>Dung lượng RAM</strong></td><td><span style="color:rgb(255,0,0);"><strong>8GB</strong></span></td><td>4GB</td></tr><tr><td><strong>Bộ nhớ trong</strong></td><td><span style="color:rgb(0,0,0);">64GB </span>(bản tiêu chuẩn)</td><td>64GB (bản tiêu chuẩn)</td></tr><tr><td><strong>Thời lượng pin</strong></td><td><span style="color:rgb(0,0,0);">10 giờ</span></td><td>10 giờ</td></tr><tr><td><strong>Hỗ trợ 5G</strong></td><td>Có</td><td>Có</td></tr><tr><td><strong>Camera</strong></td><td>12MP</td><td><span style="color:rgb(0,0,0);">12MP</span></td></tr></tbody></table></figure><h3 style="text-align:justify;">Sức mạnh từ con chip M1</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044254.jpeg" alt="Sức mạnh từ con chip M1 - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Apple M1 8 nhân là vi xử lý do chính Apple nghiên cứu và sản xuất. Con chip này đã được chứng minh sức mạnh qua nhiều dòng sản phẩm và bây giờ đã xuất hiện trên iPad Air 5 M1 WiFi 64 GB. Với 8 nhân CPU, vi xử lý này sẽ giúp thiết bị có thể hoạt động ổn định cùng với <a href="https://www.thegioididong.com/may-tinh-bang-ram-8gb">RAM 8 GB</a>.&nbsp;</p><h3 style="text-align:justify;">Thiết kế sang trọng</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044250.jpeg" alt="Thiết kế sang trọng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad Air 5 M1 WiFi 64 GB có thiết kế phẳng ở 4 cạnh, mặt sau được làm từ nhôm với nhiều màu sắc tươi trẻ. Đặc biệt, năm nay Apple đã bổ sung màu tím cho dòng <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a>, màu sắc này sẽ gây ấn tượng mạnh khi chúng ta cầm máy sử dụng. Màn hình của máy cũng được làm phẳng với kích thước 10.9 inch.</p><h3 style="text-align:justify;">Tính năng đặc biệt</h3><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248096/ipad-air-5-150322-044252.jpeg" alt="Nhiều tính năng - iPad Air 5 M1 Wifi 64 GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Chiếc <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> này&nbsp;có nhiều tính năng đặc biệt: Kết nối Apple Pencil 2, Kết nối bàn phím rời, Micro kép, Mở khóa bằng vân tay, Nam châm và sạc cho Apple Pencil.</p>	t	1	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	\N	\N	iPad Air 5 10.9 inch 2022 Wifi Like New Mỗi khi một chiếc iPad mới vừa ra lò như một cơn chấn động thật sự bùng nổ. Đến năm 2022, chúng ta lại tiếp tục bùng nổ với chiếc iPad mới mang tên iPad Air 5 với nhiều cải tiến đáng giá.	{}	12990000	0	16490000	12990000	1	2	\N	{}
23	iPad mini 6 WiFi New Seal	ipad-mini-6-wifi-new-seal	<h3 style="text-align:justify;">Cấu hình mạnh mẽ hơn, đa nhiệm tốt hơn</h3><p style="text-align:justify;">iPad mini 6 có sức mạnh vượt trội khi so với thế hệ tiền nhiệm, sử dụng chip xử lý Apple A15 Bionic 6 nhân mang đến hiệu năng mạnh mẽ hơn và tiết kiệm khoảng 15% năng lượng so với A14 Bionic.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg" alt="Chip xử lý Apple A15 Bionic - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hiện tại dung lượng RAM vẫn chưa được Apple tiết lộ, theo một số tin đồn thì máy sẽ có dung lượng <a href="https://www.thegioididong.com/may-tinh-bang-ram-4gb">RAM 4 GB</a>&nbsp;giúp khả năng đa nhiệm tốt hơn, điều hành đa tác vụ trên iPad mini 6 sẽ luôn được trơn tru, cho bạn mở nhiều cửa sổ ứng dụng, chạy các phần mềm thiết kế đồ họa hay thử sức chỉnh sửa video chất lượng cao một cách dễ dàng.</p><p style="text-align:justify;">Bộ nhớ trong 64 GB thoải mái cho nhu cầu cơ bản, lưu trữ các dữ liệu cá nhân với danh sách nhạc yêu thích, hình ảnh và video các khoảnh khắc đáng nhớ của bạn cùng người thân.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg" alt="Dung lượng bộ nhớ - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với khả năng xử lý đồ họa nhanh hơn tới 80%, iPad mini 6 giúp bạn đắm mình vào bất cứ điều gì bạn làm. Trải nghiệm AR, chơi các trò chơi đồ họa cao hay các tác vụ 3D đều sẽ được xử lý mượt mà.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg" alt="Khả năng xử lý đồ họa mượt mà - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết bị chạy hệ điều hành iPadOS 15 tập trung về tiện ích, tận dụng tối đa nhất không gian màn hình của iPad, giao diện trực quan hơn, đa nhiệm thông minh hơn và bảo mật tốt hơn cho người dùng cá nhân.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg" alt="Hệ điều hành iPadOS 15 - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình lớn hơn, sử dụng thích hơn</h3><p style="text-align:justify;">Trang bị kích thước màn hình 8.3 inch lớn hơn so với các phiên bản iPad mini&nbsp;trước, nhưng iPad mini 6 vẫn rất gọn gàng vì viền màn hình của máy đã được thiết kế mỏng đều bốn cạnh, thiết bị vẫn rất tiện để mang theo giải trí, làm việc mọi nơi, mọi lúc.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg" alt="Màn hình 8.3 inch sắc nét - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Tấm nền IPS LCD với các lớp tinh thể lỏng tái tạo màu sắc tốt và tạo góc nhìn rộng hơn, độ sáng cao hỗ trợ gam màu P3 cùng công nghệ True Tone giúp người dùng dễ dàng sử dụng iPad mini trong nhiều môi trường ánh sáng (từ trong nhà đến ngoài trời, ở những khu vực ánh sáng gắt).</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg" alt="Trang bị tấm nền IPS LCD - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-cong-nghe-man-hinh-true-tone-992705">True Tone là gì? Có trên những thiết bị nào?</a></p><p style="text-align:justify;">Độ dày máy 6.3 mm cùng các cạnh viền mỏng hơn, giúp máy trở nên tinh tế hơn. Nút nguồn tích hợp Touch ID ở cạnh trên máy giúp truy cập thiết bị nhanh hơn, bảo mật riêng tư tốt hơn cho người dùng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif" alt="Touch ID - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hỗ trợ bút Apple Pencil 2&nbsp;có thể gắn từ tính và sạc không dây vô cùng tiện lợi, hỗ trợ ghi chú nhanh hay thỏa mãn đam mê thiết kế trên màn hình iPad mini.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg" alt="Thao tác nhanh chóng với Apple Pencil - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad mini 6 trang bị kết nối WiFi 6 cho tốc độ giao tiếp kết nối cực nhanh và ổn định, truyền tải dữ liệu tốc độ cao không tốn nhiều thời gian chờ.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg" alt="Hỗ trợ kết nối Wifi 6 hiện đại - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Phiên bản này Apple cho người dùng đến 4 gam màu thời thượng để lựa chọn gồm Xám, Hồng, Tím và Trắng phù hợp cho nhiều cá nhân với độ tuổi, phong cách khác nhau.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg" alt="Có nhiều màu sắc để lựa chọn - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Quay phim, chụp ảnh sắc nét, video call chất lượng cao</h3><p style="text-align:justify;">Dù không phải là tính năng chính trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhưng Apple vẫn đầu tư khá tốt cho hệ thống camera của iPad mini 6 với camera mặt trước và sau đều đạt độ phân giải 12 MP.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg" alt="Bộ đôi camera ấn tượng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau góc nhìn rộng hỗ trợ quay phim 4K, Full HD với chất lượng tương phản tốt, hỗ trợ chạm lấy nét, Slow Motion, Time Lapse, Panorama,... để bạn thực hiện những bức ảnh nghệ thuật và thu về những đoạn video rõ ràng, chân thật cho kho lưu trữ kỷ niệm của cá nhân.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg" alt="Camera sau hỗ trợ nhiều tính năng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera trước quay video có thể quay video Full HD giúp các cuộc gọi video sắc nét hơn khi trò chuyện với người thân từ xa, thực hiện các buổi học hay họp trực tuyến qua mạng xã hội thật tiện lợi, thoải mái.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg" alt="Camera trước 12 MP - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hơn nữa camera trước còn hỗ trợ tính năng Center Stage giúp cuộc gọi trở lên hấp dẫn hơn khi bạn có thể di chuyển trong quanh khung hình, máy ảnh sẽ tự động xoay để giữ bạn luôn ở trung tâm khung hình.</p><h3 style="text-align:justify;">Dung lượng pin tốt đáp ứng nhu cầu sử dụng suốt ngày dài</h3><p style="text-align:justify;">iPad mini 6 có dung lượng pin 19.3 Wh cho thời lượng sử dụng tốt, đảm bảo đáp ứng nhu cầu sử dụng thiết bị tần suất cao suốt ngày dài.</p><p style="text-align:justify;">Đặc biệt, ở phiên bản này, Apple cải tiến cổng sạc sang Type-C giúp iPad mini 6 kết nối dễ dàng hơn với nhiều phụ kiện ngoại vi để bạn thực hiện các liên kết giao tiếp dữ liệu và kết nối giải trí thêm linh hoạt, tiện lợi.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg" alt="Cổng USB-C cải tiến - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Các tín đồ trái táo khuyết ắt hẳn sẽ ít nhiều thích thú với phiên bản mới của iPad mini, với một thiết kế mới của dòng iPad mini, cấu hình khỏe, tích hợp các tiện ích thông minh, hiện đại đáp ứng nhu cầu giải trí và làm việc thực tế của nhiều đối tượng người dùng.</p>	t	1	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	\N	\N	Với sự thành công của các thế hệ iPad mini trước iPad mini 6 là sản phẩm kế nhiệm mới với nhiều tính năng hiện kèm nhiều sự nâng cấp đáng chú ý dành cho người dùng trong năm nay. Nếu bạn đang có nhu cầu mua cho mình một chiếc máy tính bảng iPad để phục vụ cho nhu cầu sử dụng thì iPad Mini 6 sẽ là sự lựa chọn hoàn hảo cho bạn vào thời điểm này cho nhu cầu sử dụng tablet kích thước vừa phải.	{"meta_title": "iPad mini 6 WiFi New Seal hàng đẹp chính hãng"}	11490000	0	15990000	11490000	1	4	\N	{}
24	iPad mini 6 LTE New Seal	ipad-mini-6-lte-new-seal	<h2 style="text-align:justify;">iPad mini 6 LTE New Seal tại TP Mobile</h2><h3 style="text-align:justify;">Cấu hình mạnh mẽ hơn, đa nhiệm tốt hơn</h3><p style="text-align:justify;">iPad mini 6 có sức mạnh vượt trội khi so với thế hệ tiền nhiệm, sử dụng chip xử lý Apple A15 Bionic 6 nhân mang đến hiệu năng mạnh mẽ hơn và tiết kiệm khoảng 15% năng lượng so với A14 Bionic.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-2.jpg" alt="Chip xử lý Apple A15 Bionic - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hiện tại dung lượng RAM vẫn chưa được Apple tiết lộ, theo một số tin đồn thì máy sẽ có dung lượng <a href="https://www.thegioididong.com/may-tinh-bang-ram-4gb">RAM 4 GB</a>&nbsp;giúp khả năng đa nhiệm tốt hơn, điều hành đa tác vụ trên iPad mini 6 sẽ luôn được trơn tru, cho bạn mở nhiều cửa sổ ứng dụng, chạy các phần mềm thiết kế đồ họa hay thử sức chỉnh sửa video chất lượng cao một cách dễ dàng.</p><p style="text-align:justify;">Bộ nhớ trong 64 GB thoải mái cho nhu cầu cơ bản, lưu trữ các dữ liệu cá nhân với danh sách nhạc yêu thích, hình ảnh và video các khoảnh khắc đáng nhớ của bạn cùng người thân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-3.jpg" alt="Dung lượng bộ nhớ - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với khả năng xử lý đồ họa nhanh hơn tới 80%, iPad mini 6 giúp bạn đắm mình vào bất cứ điều gì bạn làm. Trải nghiệm AR, chơi các trò chơi đồ họa cao hay các tác vụ 3D đều sẽ được xử lý mượt mà.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-4.jpg" alt="Khả năng xử lý đồ họa mượt mà - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Thiết bị chạy hệ điều hành iPadOS 15 tập trung về tiện ích, tận dụng tối đa nhất không gian màn hình của iPad, giao diện trực quan hơn, đa nhiệm thông minh hơn và bảo mật tốt hơn cho người dùng cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-17.jpg" alt="Hệ điều hành iPadOS 15 - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Màn hình lớn hơn, sử dụng thích hơn</h3><p style="text-align:justify;">Trang bị kích thước màn hình 8.3 inch lớn hơn so với các phiên bản iPad mini&nbsp;trước, nhưng iPad mini 6 vẫn rất gọn gàng vì viền màn hình của máy đã được thiết kế mỏng đều bốn cạnh, thiết bị vẫn rất tiện để mang theo giải trí, làm việc mọi nơi, mọi lúc.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-6.jpg" alt="Màn hình 8.3 inch sắc nét - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Tấm nền IPS LCD với các lớp tinh thể lỏng tái tạo màu sắc tốt và tạo góc nhìn rộng hơn, độ sáng cao hỗ trợ gam màu P3 cùng công nghệ True Tone giúp người dùng dễ dàng sử dụng iPad mini trong nhiều môi trường ánh sáng (từ trong nhà đến ngoài trời, ở những khu vực ánh sáng gắt).</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-7.jpg" alt="Trang bị tấm nền IPS LCD - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-cong-nghe-man-hinh-true-tone-992705">True Tone là gì? Có trên những thiết bị nào?</a></p><p style="text-align:justify;">Độ dày máy 6.3 mm cùng các cạnh viền mỏng hơn, giúp máy trở nên tinh tế hơn. Nút nguồn tích hợp Touch ID ở cạnh trên máy giúp truy cập thiết bị nhanh hơn, bảo mật riêng tư tốt hơn cho người dùng.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-8.gif" alt="Touch ID - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hỗ trợ bút Apple Pencil 2&nbsp;có thể gắn từ tính và sạc không dây vô cùng tiện lợi, hỗ trợ ghi chú nhanh hay thỏa mãn đam mê thiết kế trên màn hình iPad mini.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-9.jpg" alt="Thao tác nhanh chóng với Apple Pencil - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">iPad mini 6 trang bị kết nối WiFi 6 cho tốc độ giao tiếp kết nối cực nhanh và ổn định, truyền tải dữ liệu tốc độ cao không tốn nhiều thời gian chờ.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-10.jpg" alt="Hỗ trợ kết nối Wifi 6 hiện đại - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Phiên bản này Apple cho người dùng đến 4 gam màu thời thượng để lựa chọn gồm Xám, Hồng, Tím và Trắng phù hợp cho nhiều cá nhân với độ tuổi, phong cách khác nhau.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-11.jpg" alt="Có nhiều màu sắc để lựa chọn - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><h3 style="text-align:justify;">Quay phim, chụp ảnh sắc nét, video call chất lượng cao</h3><p style="text-align:justify;">Dù không phải là tính năng chính trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhưng Apple vẫn đầu tư khá tốt cho hệ thống camera của iPad mini 6 với camera mặt trước và sau đều đạt độ phân giải 12 MP.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-13.jpg" alt="Bộ đôi camera ấn tượng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera sau góc nhìn rộng hỗ trợ quay phim 4K, Full HD với chất lượng tương phản tốt, hỗ trợ chạm lấy nét, Slow Motion, Time Lapse, Panorama,... để bạn thực hiện những bức ảnh nghệ thuật và thu về những đoạn video rõ ràng, chân thật cho kho lưu trữ kỷ niệm của cá nhân.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-14.jpg" alt="Camera sau hỗ trợ nhiều tính năng - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Camera trước quay video có thể quay video Full HD giúp các cuộc gọi video sắc nét hơn khi trò chuyện với người thân từ xa, thực hiện các buổi học hay họp trực tuyến qua mạng xã hội thật tiện lợi, thoải mái.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-12.jpg" alt="Camera trước 12 MP - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Hơn nữa camera trước còn hỗ trợ tính năng Center Stage giúp cuộc gọi trở lên hấp dẫn hơn khi bạn có thể di chuyển trong quanh khung hình, máy ảnh sẽ tự động xoay để giữ bạn luôn ở trung tâm khung hình.</p><h3 style="text-align:justify;">Dung lượng pin tốt đáp ứng nhu cầu sử dụng suốt ngày dài</h3><p style="text-align:justify;">iPad mini 6 có dung lượng pin 19.3 Wh cho thời lượng sử dụng tốt, đảm bảo đáp ứng nhu cầu sử dụng thiết bị tần suất cao suốt ngày dài.</p><p style="text-align:justify;">Đặc biệt, ở phiên bản này, Apple cải tiến cổng sạc sang Type-C giúp iPad mini 6 kết nối dễ dàng hơn với nhiều phụ kiện ngoại vi để bạn thực hiện các liên kết giao tiếp dữ liệu và kết nối giải trí thêm linh hoạt, tiện lợi.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/248091/ipad-mini-6-16.jpg" alt="Cổng USB-C cải tiến - iPad mini 6 WiFi 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Các tín đồ trái táo khuyết ắt hẳn sẽ ít nhiều thích thú với phiên bản mới của iPad mini, với một thiết kế mới của dòng iPad mini, cấu hình khỏe, tích hợp các tiện ích thông minh, hiện đại đáp ứng nhu cầu giải trí và làm việc thực tế của nhiều đối tượng người dùng.</p>	t	1	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	\N	\N	iPad mini 6 LTE New Seal Với sự thành công của các thế hệ iPad mini trước iPad mini 6 là sản phẩm kế nhiệm mới với nhiều tính năng hiện kèm nhiều sự nâng cấp đáng chú ý dành cho người dùng trong năm nay. Nếu bạn đang có nhu cầu mua cho mình một chiếc máy tính bảng iPad để phục vụ cho nhu cầu sử dụng thì iPad Mini 6 sẽ là sự lựa chọn hoàn hảo cho bạn vào thời điểm này cho nhu cầu sử dụng tablet kích thước vừa phải.	{"meta_title": "iPad mini 6 LTE New Seal hàng đẹp chính hãng"}	14990000	0	14990000	0	1	4	\N	{}
61	iPad Air 6 11 inch Wifi New Seal	ipad-air-6-11-inch-wifi-new-seal	<h2 style="text-align:justify;"><strong>So sánh&nbsp;iPad Air 6 M2 11 inch Wifi và iPad Air 5</strong></h2><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 11 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>11 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p style="text-align:justify;">Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3 style="text-align:justify;"><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-1.jpg" alt="Cấu hình iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-2.jpg" alt="Thiết kế iPad Air 6 M2 11 inch" width="810" height="456"></p><p style="text-align:justify;">Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3 style="text-align:justify;"><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p style="text-align:justify;">Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-3.jpg" alt="Tính năng iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p style="text-align:justify;">iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-4.jpg" alt="Pin iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p style="text-align:justify;">Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-5.jpg" alt="Camera iPad Air 6 M2 11 inch" width="810" height="456"></p>	t	1	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	\N	\N		{}	16490000	0	23990000	0	1	2	\N	{}
62	iPad Air 6 11 inch LTE New Seal	ipad-air-6-11-inch-lte-new-seal	<h2 style="text-align:justify;"><strong>So sánh&nbsp;iPad Air 6 M2 11 inch LTE &nbsp;và iPad Air 5</strong></h2><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> là mẫu iPad Air thế hệ thứ 6 được trình làng năm 2026. Vậy so với sản phẩm cùng phiên bản cũng như thế hệ trước đó, sản phẩm có gì giống và khác, cùng tìm hiểu sau đây.</p><figure class="table"><table><tbody><tr><td>&nbsp;</td><td><strong>iPad Air 6 M2 11 inch</strong></td><td><strong>iPad Air 5 M1 10.9 inch</strong></td></tr><tr><td>Màu sắc</td><td>Xám không gian, Ánh sao, Tím, Xanh dương</td><td>Xám không gian, Ánh sao, Hồng, Tím, Xanh dương</td></tr><tr><td>Trọng lượng</td><td>462g</td><td>462g</td></tr><tr><td>Màn hình</td><td><p>11 inch&nbsp;Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td><td><p>10.9 inch Liquid Retina</p><p>Dải màu rộng P3</p><p>True Tone</p><p>Lớp phủ chống phản chiếu</p></td></tr><tr><td>CPU</td><td><p><strong>Chip M2</strong></p><p><strong>CPU 8 lõi -&nbsp;GPU 10 lõi</strong></p><p><strong>Neural Engine 16 lõi</strong></p></td><td><p>Chip M1</p><p>CPU 8 lõi -&nbsp;GPU 8 lõi</p><p>Neural Engine 16 lõi</p></td></tr><tr><td>GPU</td><td><strong>GPU 10 lõi</strong></td><td>GPU 8 lõi</td></tr><tr><td>RAM</td><td>RAM 8GB</td><td>RAM 8GB</td></tr><tr><td>ROM</td><td><strong>128GB -&nbsp;256GB -&nbsp;512GB -&nbsp;1TB</strong></td><td>64GB -&nbsp;256GB</td></tr><tr><td>Camera trước</td><td>Camera&nbsp;trước Ultra&nbsp;Wide&nbsp;12MP<br>trên cạnh&nbsp;ngang</td><td>Camera trước Ultra Wide 12MP</td></tr><tr><td>Camera sau</td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td><td><p>Camera Wide 12MP</p><p>Quay&nbsp;video 4K</p></td></tr><tr><td>Bảo mật</td><td>Touch ID ở nút nguồn</td><td>Touch ID ở nút nguồn</td></tr><tr><td>Loa và Âm thanh</td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td><td><p>Loa stereo ở cạnh trên và cạnh dưới</p><p>Hai micrô</p></td></tr><tr><td>Wifi - Di động</td><td><p><strong>Wi-Fi 6E</strong></p><p><strong>Mạng di động 5G</strong></p></td><td><p>Wi-Fi 6</p><p>Mạng di động 5G</p></td></tr><tr><td>Kết nối phụ kiện</td><td><p>Hỗ trợ Apple Pencil Pro</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p></td><td><p>Hỗ trợ Apple Pencil&nbsp;(thế hệ thứ 2)</p><p>Hỗ trợ Apple Pencil (USB‑C)</p><p>Hỗ trợ Magic Keyboard</p><p>Hỗ trợ Smart Keyboard Folio</p></td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Air 6 M2 11 inch – Thiết kế cao cấp, hiệu năng bền bỉ</strong></h2><p style="text-align:justify;">Máy tính bảng iPad Air 6 M2 11 inch là sản phẩm iPad Air 2024 hoạt động trên con chip M2 vượt trội. Cùng với đó mẫu iPad còn sở hữu nhiều tính năng tối ưu cho quá trình sử dụng.</p><h3 style="text-align:justify;"><strong>Cấu hình từ chip M2, RAM 8GB</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được cấu hình phần cứng từ con chip M2, con chip với đồ họa nhanh hơn 25%, CPU nhanh hơn 15% và băng thông bộ nhớ lớn hơn 50% so với thế hệ trước đó. Cụ thể con chip M2 với 10 lõi CPU và 8 lõi CPU giúp tối ưu hiệu năng sử dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-1.jpg" alt="Cấu hình iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Thiết kế khung viền vuông cùng màn hình 11 inch</strong></h3><p style="text-align:justify;"><strong>iPad Air 6 M2 11 inch Wifi</strong> được trang bị khung viền vuông quen thuộc sang trọng cùng với góc cạnh bo cong thoải mái sử dụng. Cùng với đó, máy có nhiều màu sắc vintage cho người dùng lựa chọn như tím, xanh da trời, ánh sao.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-2.jpg" alt="Thiết kế iPad Air 6 M2 11 inch" width="810" height="456"></p><p style="text-align:justify;">Máy được trang bị một màn hình Liquid Retina kích thước 11 inch với lớp phủ chống phản chiếu giúp mang lại khả năng hiển thị tốt trong nhiều điều kiện ánh sáng. Cùng với đó, màn hình với dải màu P3 giúp mang lại hình ảnh hiển thị sống động.</p><h3 style="text-align:justify;"><strong>Magic Keyboard và Apple Pencil và agic Keyboard sử dụng tiện lợi</strong></h3><p style="text-align:justify;">Máy tính bảng <strong>iPad Air 6 M2 11 inch Wifi 128GB</strong> có thể sử dụng kết hợp với nhiều phụ kiện giúp tối ưu cho quá trình sử dụng của người dùng. Theo đó, iPad có thể sử dụng với Apple Pencil để mang lại khả năng ghi chú cũng như sáng tạo cá nhân dễ dàng và nhanh chóng. Cùng với đó, iPad có thể sử dụng với Magic Keyboard để sử dụng iPad như một chiếc laptop mini đầy tiện dụng.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-3.jpg" alt="Tính năng iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Pin 28,93 watt giờ&nbsp;cho thời gian sử dụng vượt trội</strong></h3><p style="text-align:justify;">iPad Air 6 M2 11 inch sở hữu viên pin lithium-polymer với dung lượng 28,93 watt giờ có thể sạc lại. Viên pin lipo này mang lại thời gian lướt web có thể lên đến 10 giờ.. Tuy nhiên, thời lượng sử dụng thực tế của iPad Air 6 M2 11 inch sẽ phụ thuộc vào nhiều yếu tố khác như mức âm lượng, số tác vụ hoạt động,…</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-4.jpg" alt="Pin iPad Air 6 M2 11 inch" width="810" height="456"></p><h3 style="text-align:justify;"><strong>Camera siêu rộng 12MP, FaceTime rõ nét</strong></h3><p style="text-align:justify;">Tablet iPad Air 6 M2 11 inch được trang bị camera trước với góc chụp siêu rộng ở độ phân giải 12MP. Ống kính mang lại khả năng gọi FaceTime ở độ phân giải cao giúp người dùng nhìn được rõ nét người đối diện.</p><p style="text-align:justify;"><img style="height:auto;" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/tablet/apple/Air/Gen-6/ipad-air-6-m2-11-inch-5.jpg" alt="Camera iPad Air 6 M2 11 inch" width="810" height="456"></p>	t	1	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	\N	\N		{}	19990000	0	23990000	0	1	2	\N	{}
10	iPad Gen 10 10.9 inch 2022 Wifi New Seal	ipad-gen-10-109-inch-2022-wifi	<h3 style="text-align:justify;">Nhà Apple đã chính thức cho ra mắt những mẫu iPad series mới vào tháng 10/2022. Trong đó <a href="https://www.thegioididong.com/may-tinh-bang/ipad-10-wifi-cellular-64gb">iPad Gen 10 Cellular</a>&nbsp;được xem là cái tên khá nổi trội khi sở hữu mức giá bán dễ tiếp cận nhưng lại được trang bị cấu hình khá tốt, có những điểm nổi bật có thể kể đến như: Apple A14 Bionic, hệ điều hành iPadOS 17, thay đổi về mặt thiết kế và kích thước màn hình lớn 10.9 inch.</h3><h3 style="text-align:justify;">Thiết kế đem đến sự trẻ trung hiện đại</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-gen-10">iPad Gen 10</a> mang trong mình nét đặc trưng vốn có của nhiều thế hệ <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> trước đây. Vẫn là mặt lưng và bộ khung được làm liền mạch với nhau đi cùng vật liệu hoàn thiện là kim loại, điều này mang lại cho máy một diện mạo sang trọng và đẳng cấp cũng như làm tăng thêm độ bền bỉ cho thiết bị.</p><p style="text-align:justify;">Năm nay nhà Apple mang đến cho chúng ta 4 phiên bản màu sắc trẻ trung đầy vẻ cá tính. Khác với những tone màu trước đây thường thấy trên những dòng iPad Air, màu sắc trên iPad thế hệ thứ 10 sẽ được làm đậm và có phần nổi trội hơn rất nhiều.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111632.jpg" alt="Thiết kế trẻ trung - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Một sự cải tiến đáng kể về phần thiết kế so với mẫu <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-2-inch">iPad 9</a> vào năm ngoái là phần viền màn hình giờ đây đã được làm đều ở 4 cạnh, mang lại không gian hiển thị rộng rãi cũng như cảm giác khi sử dụng trở nên dễ chịu.</p><h3 style="text-align:justify;">Không gian hiển thị rộng rãi</h3><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-10-9-inch">iPad gen 10</a> được trang bị màn hình kích thước lớn với 10.9 inch nên phần lớn nội dung sẽ được hiển thị nhiều hơn trên cùng một khung hình, ngoài ra máy còn có thể đáp ứng tốt cho những tác vụ vẽ vời hay hỗ trợ dùng nhiều ứng dụng trên cùng một màn hình được dễ dàng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111637.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang">Máy tính bảng</a> được tích hợp công nghệ màn hình Retina IPS LCD độc quyền đến từ nhà Apple nên hình ảnh mang lại sẽ có độ chân thực cao, nội dung tái hiện trong trẻo cùng khả năng phản ánh màu sắc một cách chuẩn xác.</p><p style="text-align:justify;">Độ phân giải màn hình cũng là một lợi thế lớn của iPad 10 so với những đối thủ trong phân khúc khi máy hỗ trợ hiển thị hình ảnh chuẩn 1640 x 2360 Pixels. Tuy Apple không công bố chính xác chuẩn màn hình này là gì nhưng thông qua con số thì ta có thể ước chừng máy có thể nằm trong khoảng 2K.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111647.jpg" alt="Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Với những bạn đang làm những công việc về sáng tạo hình ảnh hay thời trang thì đây chắc hẳn là một sự lựa chọn hết sức phù hợp, sẽ tuyệt vời hơn nếu dùng chung iPad 10 với <a href="https://www.thegioididong.com/phu-kien-thong-minh/but-cam-ung-apple-pencil-1-mk0c2">Apple Pencil</a>&nbsp;để có thể thực hiện các tác vụ viết ghi chú hay phác thảo nội dung một cách nhanh chóng và tiện lợi.</p><h3 style="text-align:justify;">Hiệu năng xử lý tốt nhiều tác vụ</h3><p style="text-align:justify;">Với con chip Apple A14 Bionic được trang bị bên trong thì phần lớn các nhu cầu sử dụng hàng ngày máy hoàn toàn có thể xử lý dễ dàng, chip hoạt động với 6 nhân hiệu suất và mức xung nhịp tối đa có thể đạt được là 3.1 GHz nên iPad 10 còn có thể thực hiện các công việc khó khăn hơn như chỉnh sửa video, thiết kế hình ảnh hay chơi game đồ họa cao.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111640.jpg" alt="Hiệu năng mạnh mẽ - Màn hình kích thước lớn - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Bên cạnh việc nâng cấp phần cứng so với thế hệ trước thì lần này nhà Apple còn bổ sung thêm cho máy hệ điều hành iPadOS 17 tiên tiến. Điều này sẽ giúp cho thiết bị có thể tối ưu được hiệu suất và năng lượng tốt hơn, thực hiện các công việc thường ngày được nhanh chóng thông qua nhiều tính năng mới thú vị và tiện ích hơn.</p><h3 style="text-align:justify;">Hỗ trợ quay - chụp chất lượng cao</h3><p style="text-align:justify;">Bố trí ở phần mặt lưng sẽ là camera đơn với độ phân giải 12 MP, nó giúp người dùng có thể lưu giữ những khung cảnh đẹp được sắc nét nhờ độ chi tiết khá cao. Bên cạnh đó thì máy cũng có thể thu lại những thước phim chất lượng cao nhờ chuẩn video tối đa được hỗ trợ là 4K - tốc độ khung hình 60.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111642.jpg" alt="Quay video chất lượng cao - iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Ở phần màn hình sẽ được trang bị camera selfie 12 MP, được hỗ trợ thêm tính năng thu phóng khung hình để tự động điều chỉnh sao cho chủ thể có thể xuất hiện ở vị trí gần trung tâm nhất, phù hợp cho những bạn đang làm các công việc thiên về sáng tạo nội dung thông qua video.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/295453/ipad-10-wifi-cellular-64gb-281022-111644.jpg" alt="Camera trước chất lượng -  iPad 10 WiFi Cellular 64GB" width="1020" height="570"></a></figure><p style="text-align:justify;">Có thể thấy iPad 10 là sự lựa chọn khá tối ưu khi máy có một mức giá bán hấp dẫn nhưng lại được trang bị bộ thông số rất tốt, đây được xem là sự lựa chọn lý tưởng dành cho những bạn đang là học sinh - sinh viên hay người dùng đang làm các công việc thiên về thiết kế.</p>	t	1	2024-07-22 17:52:19.795	2024-07-27 09:54:56.222	\N	\N	iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo.	{"meta_title": "iPad Gen 10 10.9 inch 2022 Wifi giá tốt, có góp 0%", "meta_description": "iPad Gen 10 là phiên bản iPad thế hệ thứ 10 của Apple, trang bị màn hình Liquid Retina 10.9 inch với độ phân giải cao 1640 x 2360 pixels, mang lại hình ảnh sắc nét và sống động. Thiết bị sử dụng chip Apple A14 Bionic mạnh mẽ, giúp xử lý mượt mà các tác vụ từ công việc đến giải trí. Camera sau 12MP với khẩu độ ƒ/1.8 cho khả năng chụp ảnh ấn tượng, trong khi camera trước 12MP Ultra Wide với góc nhìn 122° và khẩu độ ƒ/2.4 hỗ trợ cuộc gọi video và selfie chất lượng cao. Với dung lượng RAM 4GB và bộ nhớ trong 256GB, iPad Gen 10 cung cấp không gian lưu trữ rộng rãi và hiệu suất ổn định. Pin 28.6 Wh (~7587 mAh) đảm bảo thời lượng sử dụng lâu dài. Thiết bị chạy hệ điều hành iPadOS 17 và hỗ trợ Apple Pencil (thế hệ thứ 1) và Magic Keyboard Folio, mang lại trải nghiệm người dùng linh hoạt và sáng tạo."}	9390000	0	12990000	9390000	1	3	\N	{}
34	iPad Pro 2020 11 inch LTE Like New	ipad-pro-2020-11-inch-lte-like-new	<h2>iPad Pro 2020 11 inch Wifi Like New tại TP Mobile</h2><p><a href="https://www.apple.com/vn/">Apple</a> chính thức ra mắt thế hệ<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;v</a>ào giữa tháng 03/2020, được đánh giá là mẫu iPad mạnh nhất tính đến thời điểm hiện tại và có tiềm năng vượt trội hơn hầu hết laptop Windows trên thị trường hiện nay nhờ trang bị chip A12Z Bionic đạt tốc độ xử lý vượt trội hơn kết hợp bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. Các nâng cấp mới đáng chú ý bao gồm cảm biến, cụm camera mới với cảm biến quét LIDAR cho cảm ứng chiều sâu và AR, và bàn phím mới cho phép dựng iPad lên mặt phẳng đáy và có tích hợp trackpad. Thời lượng pin lên đến 10 tiếng, hỗ trợ mạng LTE.</p><figure class="image" style="height:auto;"><img style="aspect-ratio:600/600;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/ipad-pro-11-2020.jpg?1584672256390" alt="" width="600" height="600"></figure><h3 style="text-align:center;"><strong>CÔNG NGHỆ HIỂN THỊ LIQUID RETINA</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_0.jpg?1584611013085" alt="" width="1076" height="717"></figure><p>Công nghệ hiển thị tiên tiến Liquid Retina trên<a href="https://anhphibantao.com/">&nbsp;<strong>iPad Pro 11-inch 2020</strong></a>&nbsp;không chỉ đẹp và ấn tượng, mà còn trang bị các đặc tính công nghệ xuất sắc. Sự kết hợp cùng các công nghệ ProMotion, True Tone và độ chính xác màu sắc hàng đầu thị trường, khiến mọi thứ trông sống động và mãn nhãn hơn khiến đây trở thành chiếc màn hình di động tân tiến nhất thế giới.</p><h3 style="text-align:center;"><strong>CAMERA CHUYÊN NGHIỆP</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_1.jpg?1584611040033" alt="" width="1076" height="717"></figure><p>Cụm camera kết hợp với màn hình rộng, hiệu suất cao và các cảm biến căn chỉnh chi tiết vốn đã là thế mạnh độc đáo của iPad nói chung.&nbsp;<strong>iPad Pro 11-inch 2020&nbsp;</strong>không những thế còn được trang bị các camera góc rộng và camera góc cực rộng mới, hỗ trợ người dùng căn hình hoàn hảo với cả ảnh và video. Cùng với mic chất lượng phòng thu và 4 speaker,&nbsp;<a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong>&nbsp;</a>có thể được xem như một khung quay dựng phim đa máy ảnh lý tưởng.</p><h3 style="text-align:center;"><strong>LIDAR SCANNER</strong></h3><p>LiDAR (Light Detection and Ranging) được sử dụng để xác định khoảng cách bằng cách đo đạc khoảng cách ánh sáng tiếp cận đối tượng và phản xạ lại. Tính năng này được NASA áp dụng cho nhiệm vụ kế tiếp đáp xuống sao Hỏa, nhưng giờ đây nó đã xuất hiện trên&nbsp;<strong>iP</strong><a href="https://anhphibantao.com/"><strong>ad Pro 11-inch 2020</strong></a>.</p><p>Bộ quét LiDAR được thiết kế tùy biến sử dụng thời gian trực tiếp bay để đo đạc ánh sáng phản xạ lại từ khoảng cách lên đến 5m, kể cả trong nhà hay ngoài trời. Bộ quét này xử lý đến cấp độ photon với tốc độ nano giây, mở ra những tiềm năng hấp dẫn đối với tương tác thực tế ảo (AR) và các công nghệ liên quan.</p><p>LiDAR Scanner làm việc với các camera chuyên nghiệp, cảm biến chuyển động và framework trên hệ điều hành iPadOS nhằm đo chiều sâu. Sự kết hợp với các phần mềm, phần cứng và những cải tiến bất ngờ này biến iPad Pro trở thành thiết bị xuất sắc nhất thế giới về AR.</p><figure class="table"><table><tbody><tr><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_10.jpg?1584612668388" alt="" width="652" height="493"></figure></td><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_4.jpg?1584612635666" alt="" width="652" height="493"></figure></td><td><figure class="image" style="height:auto;"><img style="aspect-ratio:652/493;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_5.jpg?1584612688894" alt="" width="652" height="493"></figure></td></tr><tr><td><h4 style="text-align:center;"><strong>AR</strong></h4><p>Trên&nbsp;<strong>iPad Pro 11-inch 2020</strong>, ứng dụng AR trở nên chân thực hơn. Giờ đây bạn có thể đặt một vật thể AR ngay lập tức. Việc khớp vật thể thực tế cho phép vật thể AR đi xuyên qua từ phía trước và ở ngay sau cấu trúc thế giới thực. Tính năng ghi lại chuyển động và khớp người chính xác hơn bao giờ hết.</p></td><td><h4 style="text-align:center;"><strong>QUAY VÀ SỬA</strong></h4><p>Hệ thống camera chuyên nghiệp tăng tính linh động trên iPad Pro.&nbsp;<strong>iPad Pro 11-inch 2020</strong>&nbsp;cho phép bạn quay, sửa, chia sẻ video 4K. Bạn có thể quay one shot góc rộng bằng camera Ultra Wide hay sử dụng Markup để thiết kế lại ngay tại chỗ. Bạn cũng có thể in chữ ký ra hoặc sao lại bằng Apple Pencil rồi gửi lại chỉ bằng một chạm.</p></td><td><h4 style="text-align:center;"><strong>CAMERA TRUEDEPTH</strong></h4><p>Camera trước TrueDepth cho phép sử dụng Face ID, là tính năng xác nhận khuôn mặt an toàn nhất thế giới trên tablet và cả trên máy tính; đồng nghĩa bạn có thể trò chuyện với bạn bè bằng FaceTime, chụp ảnh Portrait, hay biến những cuộc đối thại trên Messages trở nên vui ngộn với Animoji.</p></td></tr></tbody></table></figure><h3 style="text-align:center;"><strong>CHIP A12Z BIONIC</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_6.jpg?1584612746472" alt="" width="1076" height="717"></figure><p>Với chip A12Z Bionic, iPad Pro đạt được tốc độ xử lý vượt trội hơn nhiều PC laptop trên thị trường hiện nay. Tốc độ này cho phép bạn xử lý mọi thứ nhanh chóng và mượt mà. Kết hợp với bộ xử lý đồ họa 8 nhân tăng cường hiệu suất mà các ứng dụng và trò chơi thường yêu cầu. A12Z Bionic được thiết kế để làm việc với những ứng dụng chuyên nghiệp hay yêu cầu công việc cao. GPU 8 nhân mang lại hiệu suất mượt mà đối với các yêu cầu chỉnh sửa video 4K, thiết kế 3D, AR. augmented reality. Cấu trúc kiểm soát nhiệt tăng cường đồng nghĩa giới hạn hiệu suất mở rộng và thời gian chịu đựng lâu hơn, đáp ứng nhu cầu công việc chuyên nghiệp. Neural Engine do Apple thiết kế kết nối machine learning sẵn ngay trên thiết bị cho thế hệ kế tiếp của các ứng dụng chuyên nghiệp.</p><p>iPadOS được thiết kế để củng cố sức mạnh và hiệu suất trên iPad Pro. Phần cứng siêu nhanh và phần mềm mạnh mẽ được thiết kế nhằm khiến mỗi tương tác đều diễn ra với tốc độ cao và mượt mà, cho phép xử lý nhiều ứng dụng cùng lúc và di chuyển giữa các không gian nhanh chóng và không tốn nhiều công sức.</p><h3 style="text-align:center;"><strong>LINH HOẠT</strong></h3><figure class="image" style="height:auto;"><img style="aspect-ratio:1076/717;" src="https://zshop.vn/images/companies/1/untitled%20folder%201/pro11_9.jpg?1584611440955" alt="" width="1076" height="717"></figure><p><a href="https://anhphibantao.com/"><strong>iPad Pro 11-inch 2020</strong></a>&nbsp;mỏng – nhẹ – bền – hoàn hảo cùng bạn đi bất cứ đâu, với thời lượng sử dụng lên đến 10 tiếng.</p>	t	1	2024-08-03 07:50:34.676	2024-08-03 07:50:34.676	\N			{}	14490000	0	15390000	14490000	1	1	\N	{}
41	iPad Pro 2020 12.9 inch LTE Like New	ipad-pro-2020-129-inch-lte-like-new	<h3>iPad Pro 2020 12.9 inch LTE &nbsp;Like New TẠI TP Mobile</h3><h3>Màn hình tuyệt đẹp, nhiều công nghệ tích hợp</h3><p>iPad Pro 12.9 inch 2020 có một thiết kế khá vuông vức với viền màn hình 4 cạnh không quá dày và đều nhau, giúp cho trải nghiệm cầm nắm dễ dàng, giúp cho tổng thể mặt trước của iPad hài hòa và đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.jpg"><img style="aspect-ratio:800/487;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.jpg" alt="mặt trước iPad Pro 12.9 2020" width="800" height="487"></a></figure><p>Tổng thể chiếc máy có khối lượng chỉ 471 g và mỏng 5.9 mm so với kích thước 12.9 inch thì điều đó cho thấy iPad Pro 12.9 inch 2020 rất mỏng nhẹ, gọn gàng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-4.jpg"><img style="aspect-ratio:800/451;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-4.jpg" alt="Trên tay kích thước iPad Pro 12.9 2020" width="800" height="451"></a></figure><p>Thật khó lòng khi tìm ra khuyết điểm về màn hình của iPad Pro 12.9 inch 2020, với kích thước 12.9 inch cùng với độ phân giải 2048 x 2732 pixels giúp cho máy hiển thị vô cùng sắc nét và không gian làm việc lớn.&nbsp;</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-ve-cac-loai-do-phan-giai-man-hinh-1196142">Tìm hiểu về các loại độ phân giải màn hình</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-6.jpg"><img style="aspect-ratio:800/451;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-6.jpg" alt="kích thước màn hình iPad Pro 12.9 2020" width="800" height="451"></a></figure><p>Máy sử dụng công nghệ màn hình Liquid Retina Display với các công nghệ hỗ trợ như Pro Motion và True Tone, giúp màu sắc được thể hiện một cách tự nhiên, trung thực và sống động.</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/man-hinh-retina-la-gi-905780">Màn hình Retina là gì?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg"><img style="aspect-ratio:800/400;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg" alt="màn hình hiển thị trên iPad Pro 12.9 2020" width="800" height="400"></a></figure><h3>Hiệu năng mạnh mẽ với chip CPU A12Z với 8 nhân đồ họa</h3><p>iPad Pro 12.9 inch 2020 được trang bị bộ vi xử lý Apple A12Z Bionic mạnh mẽ hơn người tiền nhiệm, giúp cho thao tác sử dụng những phần mềm đồ họa như Photoshop, illustrator mượt mà và phản hồi nhanh chóng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-5.jpg"><img style="aspect-ratio:800/456;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-5.jpg" alt="Cấu hình iPad Pro 2020" width="800" height="456"></a></figure><p>Với việc có thể kết nối với bàn phím, chuột không dây và con trỏ chuột được làm mới, giúp người dùng thao tác và sử dụng một cách dễ dàng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-3.jpg"><img style="aspect-ratio:800/487;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-3.jpg" alt="iPad Pro 12.9 2020 kết nối bàn phím" width="800" height="487"></a></figure><p>Hơn thế nữa, bộ vi xử lý A12Z với 8 nhân đồ hoạ thì máy có thể chiến hầu hết các tựa game hiện có trên thị trường như PUBG, Liên Quân, Asphalt 9,... với mức thiết lập đồ họa cao nhất với tốc độ khung hình ổn định trong suốt quá trình chơi.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-7.jpg"><img style="aspect-ratio:800/456;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-7.jpg" alt="chơi game với iPad Pro 12.9 2020" width="800" height="456"></a></figure><p>Bằng việc tích hợp sẵn <a href="https://www.thegioididong.com/may-tinh-bang-rom-128gb">bộ nhớ trong 128 GB</a> giúp cho người dùng có nhiều không gian lưu trữ hơn, làm được nhiều việc hơn trên chiếc iPad Pro 12.9 inch 2020. Đây là mức dung lượng hoàn hảo cho tùy chọn cơ bản nhất của chiếc máy.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-9.jpg"><img style="aspect-ratio:800/400;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-9.jpg" alt="Bộ nhớ trên iPad Pro 12.9 2020" width="800" height="400"></a></figure><h3>Cụm camera "Pro", nâng tầm trải nghiệm AR</h3><p>Apple thật sự ưu ái khi tích hợp cho chiếc máy này với 2 camera sau, 1 camera chính 12 MP và 1 camera góc siêu rộng 125 độ 10 MP, cùng với đó là camera selfie 7 MP hỗ trợ công nghệ TrueDepth. Giúp bạn hoàn toàn có thể chụp ra những bức ảnh ưng ý nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-10.jpg"><img style="aspect-ratio:800/501;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-10.jpg" alt="Cụm camera trên iPad Pro 12.9 2020" width="800" height="501"></a></figure><p>Việc quay video, chụp ảnh và chỉnh sửa trực tiếp một cách chuyên nghiệp để gửi đi khách hàng, đối tác chỉ với một thiết bị duy nhất đã không còn là điều xa vời với người dùng iPad Pro 2020.</p><p>Hơn thế nữa, iPad Pro 12.9 inch 2020 còn được tích hợp thêm cảm biến Lidar đo chiều sâu, giúp hỗ trợ những ứng dụng AR nhận diện bối cảnh một cách chính xác nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-11.jpg"><img style="aspect-ratio:800/450;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-11.jpg" alt="Lidar hỗ trợ AR trên iPad Pro 12.9 2020" width="800" height="450"></a></figure><p>Cảm biến này cực kì hữu ích đặc biệt trong các lĩnh vực thiết kế, thi công bởi người dùng có thể "ướm" thử các mô hình 3D của thiết kế lên thực tế và quan sát nhiều góc độ một cách trực quan nhất bằng công nghệ thực tại ảo AR.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.gif"><img style="aspect-ratio:480/270;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.gif" alt="Cảm biến Lidar hỗ trợ AR mượt mà trên iPad Pro 12.9 2020" width="480" height="270"></a></figure><p>Nhìn chung, <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">Apple</a> đã định vị iPad rất rõ ràng hướng tới việc ngày càng mang lại nhiều trải nghiệm làm việc, giải trí mạnh mẽ hơn cho người dùng chuyên nghiệp. Ở hiện tại, iPad Pro 2020 chắc chắn là thiết bị rất đáng xuống tiền để sử dụng như một thiết bị làm việc hỗ trợ để xử lý các công việc gấp khi du lịch, ra ngoài hay là công cụ rất "ngầu" dùng để giao tiếp với đối tác.</p>	t	1	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	\N	\N		{}	15990000	0	16490000	0	1	1	\N	{}
42	iPad Pro M1 2021 11 inch Wifi New Seal CPO	ipad-pro-m1-2021-11-inch-wifi-new-seal-cpo	<h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p><a href="https://anhphibantao.com/san-pham/ipad-pro-m1-2021-cpo-11-inch-nguyen-seal-ban-wifi-chinh-hang-apple/">iPad Pro M1&nbsp;11 inch Wifi 128GB</a> (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 13:43:27.35	2024-08-03 13:45:28.056	\N	\N		{}	16790000	17790000	16790000	16790000	1	1	\N	{}
43	iPad Pro M1 2021 11 inch Wifi Like New	ipad-pro-m1-2021-11-inch-wifi-like-new	<h2 style="text-align:center;">iPad Pro M1 2021 11 inch Wifi Like New Tại TP Mobile</h2><h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p><a href="https://anhphibantao.com/san-pham/ipad-pro-m1-2021-cpo-11-inch-nguyen-seal-ban-wifi-chinh-hang-apple/">iPad Pro M1&nbsp;11 inch Wifi 128GB</a> (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	\N	\N		{}	15490000	0	19490000	15490000	1	1	\N	{}
44	iPad Pro M1 2021 11 inch LTE Like New	ipad-pro-m1-2021-11-inch-lte-like-new	<h2 style="text-align:center;">iPad Pro M1 2021 11 inch LTE Like New Tại TP Mobile</h2><h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p><a href="https://anhphibantao.com/san-pham/ipad-pro-m1-2021-cpo-11-inch-nguyen-seal-ban-wifi-chinh-hang-apple/">iPad Pro M1&nbsp;11 inch Wifi 128GB</a> (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	\N	\N		{"meta_description": "iPad Pro M1 2021 11 inch LTE Like New Tại TP Mobile  Sở hữu diện mạo sang trọng, vuông vức  iPad Pro M1 11 inch Wifi 128GB (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g"}	16490000	0	20490000	16490000	1	1	\N	{}
45	iPad Pro M1 2021 11 inch LTE New Seal CPO	ipad-pro-m1-2021-11-inch-lte-new-seal-cpo	<h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p><a href="https://anhphibantao.com/san-pham/ipad-pro-m1-2021-cpo-11-inch-nguyen-seal-ban-wifi-chinh-hang-apple/">iPad Pro M1&nbsp;11 inch Wifi 128GB</a> (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 13:53:18.944	2024-08-03 13:53:18.944	\N	\N		{"meta_description": "iPad Pro M1 2021 11 inch LTE Like New Tại TP Mobile  Sở hữu diện mạo sang trọng, vuông vức  iPad Pro M1 11 inch Wifi 128GB (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g"}	19990000	21990000	19990000	19990000	1	1	\N	{}
40	iPad Pro 2020 12.9 inch Wifi Like New	ipad-pro-2020-129-inch-wifi-like-new	<h3>iPad Pro 2020 12.9 inch Wifi Like New TẠI TP Mobile</h3><h3>Màn hình tuyệt đẹp, nhiều công nghệ tích hợp</h3><p>iPad Pro 12.9 inch 2020 có một thiết kế khá vuông vức với viền màn hình 4 cạnh không quá dày và đều nhau, giúp cho trải nghiệm cầm nắm dễ dàng, giúp cho tổng thể mặt trước của iPad hài hòa và đẹp mắt hơn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.jpg"><img style="aspect-ratio:800/487;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.jpg" alt="mặt trước iPad Pro 12.9 2020" width="800" height="487"></a></figure><p>Tổng thể chiếc máy có khối lượng chỉ 471 g và mỏng 5.9 mm so với kích thước 12.9 inch thì điều đó cho thấy iPad Pro 12.9 inch 2020 rất mỏng nhẹ, gọn gàng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-4.jpg"><img style="aspect-ratio:800/451;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-4.jpg" alt="Trên tay kích thước iPad Pro 12.9 2020" width="800" height="451"></a></figure><p>Thật khó lòng khi tìm ra khuyết điểm về màn hình của iPad Pro 12.9 inch 2020, với kích thước 12.9 inch cùng với độ phân giải 2048 x 2732 pixels giúp cho máy hiển thị vô cùng sắc nét và không gian làm việc lớn.&nbsp;</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/tim-hieu-ve-cac-loai-do-phan-giai-man-hinh-1196142">Tìm hiểu về các loại độ phân giải màn hình</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-6.jpg"><img style="aspect-ratio:800/451;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-6.jpg" alt="kích thước màn hình iPad Pro 12.9 2020" width="800" height="451"></a></figure><p>Máy sử dụng công nghệ màn hình Liquid Retina Display với các công nghệ hỗ trợ như Pro Motion và True Tone, giúp màu sắc được thể hiện một cách tự nhiên, trung thực và sống động.</p><p>Xem thêm:&nbsp;<a href="https://www.thegioididong.com/hoi-dap/man-hinh-retina-la-gi-905780">Màn hình Retina là gì?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg"><img style="aspect-ratio:800/400;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-8.jpg" alt="màn hình hiển thị trên iPad Pro 12.9 2020" width="800" height="400"></a></figure><h3>Hiệu năng mạnh mẽ với chip CPU A12Z với 8 nhân đồ họa</h3><p>iPad Pro 12.9 inch 2020 được trang bị bộ vi xử lý Apple A12Z Bionic mạnh mẽ hơn người tiền nhiệm, giúp cho thao tác sử dụng những phần mềm đồ họa như Photoshop, illustrator mượt mà và phản hồi nhanh chóng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-5.jpg"><img style="aspect-ratio:800/456;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-5.jpg" alt="Cấu hình iPad Pro 2020" width="800" height="456"></a></figure><p>Với việc có thể kết nối với bàn phím, chuột không dây và con trỏ chuột được làm mới, giúp người dùng thao tác và sử dụng một cách dễ dàng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-3.jpg"><img style="aspect-ratio:800/487;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-3.jpg" alt="iPad Pro 12.9 2020 kết nối bàn phím" width="800" height="487"></a></figure><p>Hơn thế nữa, bộ vi xử lý A12Z với 8 nhân đồ hoạ thì máy có thể chiến hầu hết các tựa game hiện có trên thị trường như PUBG, Liên Quân, Asphalt 9,... với mức thiết lập đồ họa cao nhất với tốc độ khung hình ổn định trong suốt quá trình chơi.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-7.jpg"><img style="aspect-ratio:800/456;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-7.jpg" alt="chơi game với iPad Pro 12.9 2020" width="800" height="456"></a></figure><p>Bằng việc tích hợp sẵn <a href="https://www.thegioididong.com/may-tinh-bang-rom-128gb">bộ nhớ trong 128 GB</a> giúp cho người dùng có nhiều không gian lưu trữ hơn, làm được nhiều việc hơn trên chiếc iPad Pro 12.9 inch 2020. Đây là mức dung lượng hoàn hảo cho tùy chọn cơ bản nhất của chiếc máy.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-9.jpg"><img style="aspect-ratio:800/400;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-9.jpg" alt="Bộ nhớ trên iPad Pro 12.9 2020" width="800" height="400"></a></figure><h3>Cụm camera "Pro", nâng tầm trải nghiệm AR</h3><p>Apple thật sự ưu ái khi tích hợp cho chiếc máy này với 2 camera sau, 1 camera chính 12 MP và 1 camera góc siêu rộng 125 độ 10 MP, cùng với đó là camera selfie 7 MP hỗ trợ công nghệ TrueDepth. Giúp bạn hoàn toàn có thể chụp ra những bức ảnh ưng ý nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-10.jpg"><img style="aspect-ratio:800/501;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-10.jpg" alt="Cụm camera trên iPad Pro 12.9 2020" width="800" height="501"></a></figure><p>Việc quay video, chụp ảnh và chỉnh sửa trực tiếp một cách chuyên nghiệp để gửi đi khách hàng, đối tác chỉ với một thiết bị duy nhất đã không còn là điều xa vời với người dùng iPad Pro 2020.</p><p>Hơn thế nữa, iPad Pro 12.9 inch 2020 còn được tích hợp thêm cảm biến Lidar đo chiều sâu, giúp hỗ trợ những ứng dụng AR nhận diện bối cảnh một cách chính xác nhất.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-11.jpg"><img style="aspect-ratio:800/450;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020-11.jpg" alt="Lidar hỗ trợ AR trên iPad Pro 12.9 2020" width="800" height="450"></a></figure><p>Cảm biến này cực kì hữu ích đặc biệt trong các lĩnh vực thiết kế, thi công bởi người dùng có thể "ướm" thử các mô hình 3D của thiết kế lên thực tế và quan sát nhiều góc độ một cách trực quan nhất bằng công nghệ thực tại ảo AR.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.gif"><img style="aspect-ratio:480/270;" src="https://cdn.tgdd.vn/Products/Images/522/221775/ipad-pro-12-9-inch-wifi-128gb-2020.gif" alt="Cảm biến Lidar hỗ trợ AR mượt mà trên iPad Pro 12.9 2020" width="480" height="270"></a></figure><p>Nhìn chung, <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">Apple</a> đã định vị iPad rất rõ ràng hướng tới việc ngày càng mang lại nhiều trải nghiệm làm việc, giải trí mạnh mẽ hơn cho người dùng chuyên nghiệp. Ở hiện tại, iPad Pro 2020 chắc chắn là thiết bị rất đáng xuống tiền để sử dụng như một thiết bị làm việc hỗ trợ để xử lý các công việc gấp khi du lịch, ra ngoài hay là công cụ rất "ngầu" dùng để giao tiếp với đối tác.</p>	t	1	2024-08-03 13:31:05.908	2024-08-03 13:38:36.519	\N	\N		{"meta_description": "iPad Pro 2020 12.9 inch Wifi Like New TẠI TP Mobile iPad Pro 12.9 inch 2020 có một thiết kế khá vuông vức với viền màn hình 4 cạnh không quá dày và đều nhau, giúp cho trải nghiệm cầm nắm dễ dàng,"}	14990000	0	15990000	0	1	1	\N	{}
47	iPad Pro M1 2021 12.9 inch Wifi Like New	ipad-pro-m1-2021-129-inch-wifi-like-new	<h2 style="text-align:center;">iPad Pro M1 2021 12.9 inch Wifi Like New</h2><h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p>iPad Pro M1 2021 12.9 inch Wifi Like New được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	\N	\N		{}	17990000	0	21990000	17990000	1	1	\N	{}
48	iPad Pro M1 2021 12.9 inch LTE Like New	ipad-pro-m1-2021-129-inch-lte-like-new	<h2 style="text-align:center;">iPad Pro M1 2021 11 inch LTE Like New Tại TP Mobile</h2><h2 style="text-align:center;"><strong>Sở hữu diện mạo sang trọng, vuông vức</strong></h2><p><a href="https://anhphibantao.com/san-pham/ipad-pro-m1-2021-cpo-11-inch-nguyen-seal-ban-wifi-chinh-hang-apple/">iPad Pro M1&nbsp;11 inch Wifi 128GB</a> (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g cho tổng thể gọn nhẹ giúp người dùng cảm thấy thoải mái, dễ chịu hơn mỗi khi cầm nắm sử dụng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-04.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-04.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Sở hữu diện mạo sang trọng, gia công rắn chắc bằng khung nhôm" width="800" height="533"></a></p><p>Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng tương tự như iPhone 12 series, cụm camera nằm trong mô-đun hình vuông quen thuộc kết hợp với những màu sắc độc quyền,… bằng cách nào đó, các sản phẩm của Apple đều toát lên sự chú ý của mọi người tiêu dùng.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-02.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-02.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Được thiết kế nguyên khối liền lạc, vuông vức, sang trọng" width="800" height="533"></a></p><h3 style="text-align:center;"><strong>Tận hưởng trải nghiệm ngắm nhìn chưa từng có</strong></h3><p>Màn hình Liquid Retina trang bị trên iPad Pro 11 inch 2021 hỗ trợ dải màu rộng P3, True Tone và có độ sáng lên đến 600 nits mang đến bạn những trải nghiệm hình ảnh tuyệt đẹp, khiến cho mọi chi tiết hiển thị trên máy luôn sáng và sống động nhất.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-01.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-01.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Trang bị màn hình Liquid Retina " width="800" height="533"></a></p><p>Máy sở hữu một màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision, mang đến cho bạn những nội dung với chất lượng hình ảnh cao, tạo cảm giác chân thật, iPad Pro M1 11 inch 2021 sẽ khiến bạn đắm chìm như trong rạp chiếu phim cho cảm nhận đến từ mọi phía đều tuyệt vời.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-07.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-07.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Màn hình có kích thước 11 inch kết hợp với công nghệ hình ảnh đỉnh cao ​​Dolby Vision" width="800" height="533"></a></p><h2 style="text-align:center;"><strong>Ứng dụng con chip mạnh mẽ từ&nbsp;MacBook</strong></h2><p>Lần đầu tiên,&nbsp;iPad Pro&nbsp;11 inch 2021 tự hào sở hữu cấu hình khủng với con chip Apple M1 được trang bị trên&nbsp;MacBook M1&nbsp;và có khá nhiều người tin dùng đã cho đánh giá tích cực về hiệu năng vượt trội của bộ vi xử lý này.</p><p><a href="https://www.thegioididong.com/images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg"><img style="height:auto;" src="https://cdn.tgdd.vn/Products/Images/522/237695/ipad-pro-m1-11-inch-wifi-128gb-2021-15.jpg" alt="iPad Pro M1 11 inch WiFi 128GB (2021) | Cấu hình khủng với con chip Apple M1 được trang bị" width="800" height="533"></a></p><p>Sự xuất hiện mang tính đột phá của chip Apple M1 đã đưa&nbsp;iPad Pro M1&nbsp;lên một tầm cao mới. Chipset mang lại hiệu năng CPU nhanh hơn tới 50% so với A12Z Bionic, hiệu suất GPU nhanh hơn tới 40% giúp&nbsp;<a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>&nbsp;nhà Apple vươn lên vị trí dẫn đầu trong các thiết bị cùng loại.</p><p>Giờ đây, người dùng có thể thả ga chiến đấu trên các tựa game nặng có đồ họa cao hay dễ dàng hơn trong việc chỉnh sửa các video độ phân giải lớn cũng như là xử lý các tác vụ trên máy được trơn tru, mượt mà nhất.</p>	t	1	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	\N	\N		{"meta_description": "iPad Pro M1 2021 12.9 inch LTE Like New Tại TP Mobile  Sở hữu diện mạo sang trọng, vuông vức  iPad Pro M1 11 inch Wifi 128GB (2021) được gia công rắn chắc bằng khung nhôm, trọng lượng chỉ 466 g"}	18990000	0	23490000	18990000	1	1	\N	{}
49	iPad Pro M2 2022 11 inch Wifi New Seal	ipad-pro-m2-2022-11-inch-wifi-new-seal	<h2 style="text-align:justify;"><strong>So sánh iPad Pro 2022 và iPad Pro 2021</strong></h2><p style="text-align:justify;">Ra mắt với nhiều cải tiến và hiệu năng mạnh mẽ,&nbsp;iPad Pro 2022&nbsp;mang đến nhiều trải nghiệm thú vị cho người dùng. Vậy sản phẩm này có gì khác so với thế hệ trước. Xem bảng so sánh chi tiết sau đây nhé!</p><figure class="table"><table><tbody><tr><td><strong>Tiêu chí</strong></td><td><strong>iPad Pro 2022 11 inch</strong></td><td><strong>iPad Pro 2021 11 inch</strong></td></tr><tr><td><strong>Màu sắc</strong></td><td>Silver, Space Gray</td><td>Silver, Space Gray</td></tr><tr><td><strong>Màn hình</strong></td><td>11 inch</td><td>11 inch</td></tr><tr><td><strong>Độ phân giải</strong></td><td>2388x1668 pixel</td><td>2388x1668 pixel</td></tr><tr><td><strong>Tần số quét</strong></td><td>120Hz</td><td>120Hz</td></tr><tr><td><strong>RAM</strong></td><td>8GB, 16GB</td><td>8GB, 16GB</td></tr><tr><td><strong>Bộ nhớ lưu trữ</strong></td><td>128GB<br>256GB<br>512GB<br>1TB<br>2TB</td><td>128GB<br>256GB<br>512GB<br>1TB<br>2TB</td></tr><tr><td><strong>Trọng lượng</strong></td><td>470gram</td><td>468gram</td></tr><tr><td><strong>Camera</strong></td><td>12MP + 10MP</td><td>12MP+10MP</td></tr><tr><td><strong>Chip</strong></td><td>Apple M2</td><td>Apple M1</td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Pro 11 inch 2022 M2 Wifi 128GB&nbsp;- Nâng cấp lớn hơn, trải nghiệm hiện đại hơn</strong></h2><p style="text-align:justify;">Sự thay đổi lớn về thiết kế và cấu hình chính là những yếu tố giúp cho <strong>iPad Pro 2022</strong> chiếc máy tính bảng mới nhất từ Apple - hứa hẹn sẽ là một trong những mẫu máy tính bảng cực kỳ hấp dẫn trong năm 2022.</p><h3 style="text-align:justify;"><strong>Thiết kế sang trọng, hiện đại</strong></h3><p style="text-align:justify;">Thiết kế của mặt sau iPad và các chi tiết khác được làm từ chất liệu cao cấp. Bên cạnh đó, cụm camera và cảm biến Lidar được đặt nhau. Các thao tác sử dụng như dùng Apple Pencil vẽ, sáng tạo dễ dàng hơn với chế độ ngang và khi dùng với Magic Keyboard.</p><p style="text-align:justify;">&nbsp;</p><h3 style="text-align:justify;"><strong>Công nghệ Mini LED cho hình ảnh cao cấp</strong></h3><p style="text-align:justify;">Một trong những nâng cấp lớn - và cũng là nâng cấp đáng chú ý trên đời iPad Pro M2 mới của Apple - chính là sự hiện diện của công nghệ Mini LED. Nếu bạn chưa biết, Mini LED chính là công nghệ do Apple phát triển và dự kiến sẽ đưa lên các dòng thiết bị iPad và MacBook của hãng - mà iPad Pro 11 inch đời 2022 là một trong những thiết bị đầu tiên áp dụng công nghệ này.</p><p style="text-align:justify;">Tất nhiên, chất lượng màu sắc và độ phân giải mà Mini LED mang đến sẽ tốt hơn rất nhiều so với tấm nền LCD trước đó (vốn xuất hiện trên iPad Pro 11 inch từ 2021 trở xuống). Vì vậy đây được xem là nâng cấp lớn đầu tiên mà iPad Pro 2022 có được.</p><p><br><strong>Camera chuyên nghiệp hỗ trợ quay phim</strong></p><p style="text-align:justify;">Nâng cấp kế tiếp xuất hiện trên iPad Pro thế hệ mới chính là hệ thống camera - và cũng là nâng cấp đáng chú ý không kém nếu bạn yêu thích điện ảnh. iPad Pro M2 (2022) sẽ trang bị hệ thống camera: camera chính 12 MP, camera góc siêu rộng 10 MP với khả năng chụp góc siêu rộng và cảm biến LiDAR; cùng với đèn flash kép phục vụ chụp ảnh đêm. Tính năng như HDR vẫn hiện diện trên chiếc iPad Pro mới này.</p><p style="text-align:justify;">Và đặc biệt, khả năng làm phim của iPad Pro 11 inch 2022 cho phép người dùng . Từ tính năng quay phim ProRes chỉnh sửa chuyên nghiệp, cho đến công nghệ HDR và khả năng ghi hình chất lượng đến 4K, đây sẽ là chiếc máy tính bảng hỗ trợ tối ưu công việc sáng tạo nội dung vốn đang phổ biến hiện nay.</p>	t	1	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	\N	\N		{"meta_description": "mua iPad Pro M2 2022 11 inch Wifi New Seal Giá tốt lại TP Mobile"}	20490000	0	22490000	0	1	1	\N	{}
50	iPad Pro M2 2022 11 inch LTE New Seal	ipad-pro-m2-2022-11-inch-lte-new-seal	<h2 style="text-align:justify;"><strong>So sánh iPad Pro 2022 và iPad Pro 2021</strong></h2><p style="text-align:justify;">Ra mắt với nhiều cải tiến và hiệu năng mạnh mẽ,&nbsp;iPad Pro 2022&nbsp;mang đến nhiều trải nghiệm thú vị cho người dùng. Vậy sản phẩm này có gì khác so với thế hệ trước. Xem bảng so sánh chi tiết sau đây nhé!</p><figure class="table"><table><tbody><tr><td><strong>Tiêu chí</strong></td><td><strong>iPad Pro 2022 11 inch</strong></td><td><strong>iPad Pro 2021 11 inch</strong></td></tr><tr><td><strong>Màu sắc</strong></td><td>Silver, Space Gray</td><td>Silver, Space Gray</td></tr><tr><td><strong>Màn hình</strong></td><td>11 inch</td><td>11 inch</td></tr><tr><td><strong>Độ phân giải</strong></td><td>2388x1668 pixel</td><td>2388x1668 pixel</td></tr><tr><td><strong>Tần số quét</strong></td><td>120Hz</td><td>120Hz</td></tr><tr><td><strong>RAM</strong></td><td>8GB, 16GB</td><td>8GB, 16GB</td></tr><tr><td><strong>Bộ nhớ lưu trữ</strong></td><td>128GB<br>256GB<br>512GB<br>1TB<br>2TB</td><td>128GB<br>256GB<br>512GB<br>1TB<br>2TB</td></tr><tr><td><strong>Trọng lượng</strong></td><td>470gram</td><td>468gram</td></tr><tr><td><strong>Camera</strong></td><td>12MP + 10MP</td><td>12MP+10MP</td></tr><tr><td><strong>Chip</strong></td><td>Apple M2</td><td>Apple M1</td></tr></tbody></table></figure><h2 style="text-align:justify;"><strong>iPad Pro 11 inch 2022 M2 Wifi 128GB&nbsp;- Nâng cấp lớn hơn, trải nghiệm hiện đại hơn</strong></h2><p style="text-align:justify;">Sự thay đổi lớn về thiết kế và cấu hình chính là những yếu tố giúp cho <strong>iPad Pro 2022</strong> chiếc máy tính bảng mới nhất từ Apple - hứa hẹn sẽ là một trong những mẫu máy tính bảng cực kỳ hấp dẫn trong năm 2022.</p><h3 style="text-align:justify;"><strong>Thiết kế sang trọng, hiện đại</strong></h3><p style="text-align:justify;">Thiết kế của mặt sau iPad và các chi tiết khác được làm từ chất liệu cao cấp. Bên cạnh đó, cụm camera và cảm biến Lidar được đặt nhau. Các thao tác sử dụng như dùng Apple Pencil vẽ, sáng tạo dễ dàng hơn với chế độ ngang và khi dùng với Magic Keyboard.</p><p style="text-align:justify;">&nbsp;</p><h3 style="text-align:justify;"><strong>Công nghệ Mini LED cho hình ảnh cao cấp</strong></h3><p style="text-align:justify;">Một trong những nâng cấp lớn - và cũng là nâng cấp đáng chú ý trên đời iPad Pro M2 mới của Apple - chính là sự hiện diện của công nghệ Mini LED. Nếu bạn chưa biết, Mini LED chính là công nghệ do Apple phát triển và dự kiến sẽ đưa lên các dòng thiết bị iPad và MacBook của hãng - mà iPad Pro 11 inch đời 2022 là một trong những thiết bị đầu tiên áp dụng công nghệ này.</p><p style="text-align:justify;">Tất nhiên, chất lượng màu sắc và độ phân giải mà Mini LED mang đến sẽ tốt hơn rất nhiều so với tấm nền LCD trước đó (vốn xuất hiện trên iPad Pro 11 inch từ 2021 trở xuống). Vì vậy đây được xem là nâng cấp lớn đầu tiên mà iPad Pro 2022 có được.</p><p><br><strong>Camera chuyên nghiệp hỗ trợ quay phim</strong></p><p style="text-align:justify;">Nâng cấp kế tiếp xuất hiện trên iPad Pro thế hệ mới chính là hệ thống camera - và cũng là nâng cấp đáng chú ý không kém nếu bạn yêu thích điện ảnh. iPad Pro M2 (2022) sẽ trang bị hệ thống camera: camera chính 12 MP, camera góc siêu rộng 10 MP với khả năng chụp góc siêu rộng và cảm biến LiDAR; cùng với đèn flash kép phục vụ chụp ảnh đêm. Tính năng như HDR vẫn hiện diện trên chiếc iPad Pro mới này.</p><p style="text-align:justify;">Và đặc biệt, khả năng làm phim của iPad Pro 11 inch 2022 cho phép người dùng . Từ tính năng quay phim ProRes chỉnh sửa chuyên nghiệp, cho đến công nghệ HDR và khả năng ghi hình chất lượng đến 4K, đây sẽ là chiếc máy tính bảng hỗ trợ tối ưu công việc sáng tạo nội dung vốn đang phổ biến hiện nay.</p>	t	1	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	\N	\N		{"meta_description": "mua iPad Pro M2 2022 11 inchmua iPad Pro M2 2022 11 inch LTE New Seal Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	22990000	0	26490000	0	1	1	\N	{}
51	iPad Pro M2 2022 11 inch Wifi Like New	ipad-pro-m2-2022-11-inch-wifi-like-new	<h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	\N	\N		{"meta_description": "iPad Pro M2 2022 11 inch Wifi Like New Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	17290000	0	21990000	0	1	1	\N	{}
52	iPad Pro M2 2022 11 inch LTE Like New	ipad-pro-m2-2022-11-inch-lte-like-new	<h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	\N	\N		{"meta_description": "iPad Pro M2 2022 11 inch LTE Like New Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	18990000	0	23990000	0	1	1	\N	{}
53	iPad Pro M2 2022 12.9 inch Wifi New Seal	ipad-pro-m2-2022-129-inch-wifi-new-seal	<h3 style="text-align:center;">iPad Pro M2 2022 12.9 inch Wifi New Seal tại TP Mobile</h3><h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 2022 12.9 inch Wifi New Seal có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	\N	\N		{"meta_description": "iPad Pro M2 2022 11 inch LTE Like New Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	24990000	0	31990000	0	1	1	\N	{}
54	iPad Pro M2 2022 12.9 inch LTE New Seal	ipad-pro-m2-2022-129-inch-lte-new-seal	<h3 style="text-align:center;">iPad Pro M2 2022 12.9 inch LTE New Seal tại TP Mobile</h3><h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 2022 12.9 inch Wifi New Seal có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	\N	\N		{}	26490000	0	34990000	0	1	1	\N	{}
55	iPad Pro M2 2022 12.9 inch Wifi Like New	ipad-pro-m2-2022-129-inch-wifi-like-new	<h3 style="text-align:center;">iPad Pro M2 2022 12.9 inch Wifi Like New tại TP Mobile giá rẻ nhất thị trường</h3><h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 2022 12.9 inch Wifi New Seal có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	\N	\N		{}	20490000	0	24490000	0	1	1	\N	{}
56	iPad Pro M2 2022 12.9 inch LTE Like New	ipad-pro-m2-2022-129-inch-lte-like-new	<h3 style="text-align:center;">iPad Pro M2 2022 12.9 inch Wifi Like New tại TP Mobile giá rẻ nhất thị trường</h3><h3>Thiết kế tinh tế - dẫn đầu xu thế</h3><p>iPad Pro M2 2022 12.9 inch Wifi New Seal có một diện mạo cao cấp với mặt lưng làm từ kim loại chắc chắn, đi kèm với độ mỏng chỉ 5.9 mm giúp cho tổng thể thiết bị thêm phần sang trọng. Dường như Apple đang rất nỗ lực để biến thiết bị của hãng trở nên ngày càng thanh mảnh, chắc hẳn trên thị trường tablet hiện tại chưa có cái tên nào có thể vượt qua độ mỏng của iPad Pro M2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053252.jpg" alt="Thiết kế sang trọng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nhìn chung thì iPad Pro M2 không có quá nhiều sự đổi mới về thiết kế so với thế hệ tiền nhiệm, vẫn sẽ là kiểu hoàn thiện vuông vức ở các cạnh và hai mặt, nổi bật nhờ tone màu chủ đạo là xám và bạc để phù hợp cho cả nam và nữ hay bất kỳ lứa tuổi nào.</p><p>Bên cạnh hai sự lựa chọn về màu sắc thì năm nay hãng cũng sẽ phát hành hai phiên bản với chuẩn kết nối mạng có đôi chút khác nhau là WiFi và WiFi Cellular. Điểm khác biệt mà ta có thể phân biệt hai loại này nằm ở phần anten, trên phiên bản WiFi thì dãy này chỉ dừng lại ở phần cụm camera chứ không chạy dài đến phần cạnh bên như WiFi Cellular.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-241022-014908.jpg" alt="Đặc điểm nhận dạng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><h3>Hiệu năng bứt phá mọi giới hạn</h3><p>Sau rất nhiều hoài nghi về sự xuất hiện của Apple M2 trên thế hệ iPad 2022 thì giờ đây nó cũng đã thực sự có mặt trên máy tính bảng iPad Pro mới nhất. Qua lần ra mắt này cho thấy Apple luôn cố gắng để biến những điều tưởng chừng như không thể thành hiện thực trên dòng sản phẩm của mình, điều này có thể minh chứng qua sự xuất hiện của Apple M2 lên trên một chiếc máy tính bảng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053255.jpg" alt="Hiệu năng mạnh mẽ - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bộ vi xử lý này có tận 8 lõi CPU và 10 lõi GPU giúp mang lại hiệu suất vượt trội hơn so với thế hệ Apple M1 trước đó, như hãng có đề cập đến thì Apple M2 có hiệu suất nhanh hơn 15% và khả năng xử lý đồ họa tốt hơn 35% đối với M1. Vậy nên người dùng có thể an tâm sử dụng <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a> để dùng cho hầu hết mọi tác vụ kể cả đồ họa nâng cao 3D.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053257.jpg" alt="Xử lý công việc nhanh chóng - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Máy tính bảng này có tới 8 GB RAM nên phần lớn những tác vụ đa nhiệm thì iPad Pro M2 đều có thể xử lý dễ dàng. Ngoài ra bộ nhớ RAM lớn còn hỗ trợ tốt cho việc chơi những tựa game có đồ họa cao, điều này đảm bảo mỗi trận đấu rank hay chơi game cùng bạn bè không bị gián đoạn bởi những hiện tượng như giật lag.</p><p>iPad Pro M2 được hỗ trợ hệ điều hành iPadOS 16 giúp mang lại giao diện đẹp mắt hơn, có thêm nhiều tùy chọn cài đặt về giao hiện hay nâng cao khả năng bảo mật. Điều này sẽ trở nên cực kỳ hữu ích bởi nó mang lại cho người dùng sự an tâm về việc bảo mật thông tin cũng như tối ưu được công việc thông qua nhiều tính năng hay ho.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053259.jpg" alt="Xử lý công việc hiệu quả - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Không chỉ đem tới kết nối mạng ổn định hơn mà lần này Apple còn hướng tới việc nâng cao tốc độ truyền tải internet vượt trội, bởi iPad Pro M2 là <a href="https://www.thegioididong.com/may-tinh-bang-5g">máy tính bảng 5G</a> và được hỗ trợ chuẩn WiFi 6E nên việc tải lên hay tải xuống dữ liệu thông qua chuẩn kết nối này là cực kỳ nhanh chóng.</p><h3>Nâng cao trải nghiệm nghe - nhìn</h3><p>iPad Pro M2 ở phiên bản này sẽ có màn hình kích thước 11 inch, đủ để bạn có thể thỏa thích vẽ vời hay xem phim được to rõ hơn. Ngoài ra màn hình lớn còn đáp ứng tốt cho việc sử dụng đồng thời nhiều app cùng lúc thông qua tính năng Stage Manager có trên iPadOS 16.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053307.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Nếu cảm thấy đây vẫn là kích thước màn hình chưa làm bạn thỏa mãn thì người dùng có thể quan tâm đến phiên bản <a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m2-12-9-inch">iPad Pro M2 12.9 inch WiFi 128GB</a>, đây có thể coi như một màn hình gần như tương đồng với một chiếc <a href="https://www.thegioididong.com/laptop">laptop</a> trên thị trường.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053300.jpg" alt="Màn hình kích thước lớn - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Ở phiên bản iPad Pro M2 11 inch thì màn hình sẽ được sử dụng tấm nền Liquid Retina, vì được chính Apple nghiên cứu và phát triển nên màn hình sẽ tương thích với thiết bị tốt hơn, cho ra độ tương phản cao, hình ảnh phản ánh gần đúng với thực tế thông qua độ chính xác về màu cao, mọi nội dung từ việc xem phim hay chơi game đều mang lại cho người dùng trải nghiệm chân thực.</p><p>Xem thêm: <a href="https://www.thegioididong.com/hoi-dap/cung-tim-hieu-ve-man-hinh-liquid-retina-tren-iphon-1125106">Màn hình Liquid Retina là gì? Có gì đặc biệt? Có trên thiết bị nào?</a></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/294104/ipad-pro-m2-11-inch-231022-053303.jpg" alt="Tấm nền cao cấp - iPad Pro M2 11 inch WiFi 128GB" width="1020" height="570"></a></figure><p>Bên cạnh đó thì <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-pro-m2">iPad Pro M2</a> còn được hỗ trợ đầy đủ các công nghệ màn hình như: Dải màu rộng P3, True Tone và ProMotion, đây chắc hẳn là những gì mà mọi nhà thiết kế cực kỳ quan tâm và ưa chuộng, bởi nó giúp người dùng có thể sử dụng máy tính bảng như một thiết bị để tham chiếu màu sắc sau khi thiết kế, làm việc trên máy tính bảng cũng sẽ cảm thấy an tâm hơn mà không sợ bị sai lệch về màu sắc quá nhiều.</p>	t	1	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	\N	\N		{}	21990000	0	26490000	0	1	1	\N	{}
57	iPad Pro M4 11 inch Wifi New Seal	ipad-pro-m4-11-inch-wifi-new-seal	<figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-1.jpg"><img style="aspect-ratio:1960/1091;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-1.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Tồng Quan" width="1960" height="1091"></a></figure><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-2.jpg"><img style="aspect-ratio:1960/5402;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-2.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Thông Số Kỹ Thuật" width="1960" height="5402"></a></figure><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-3.jpg"><img style="aspect-ratio:1960/775;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-3.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Lý Do Dùng iPad" width="1960" height="775"></a></figure><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-4.jpg"><img style="aspect-ratio:1960/4043;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-4.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - So Sánh" width="1960" height="4043"></a></figure><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-5.jpg"><img style="aspect-ratio:1960/2289;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-5.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Phụ Kiện" width="1960" height="2289"></a></figure><p style="text-align:justify;"><strong>Đặc điểm nổi bật của iPad Pro M4 256GB</strong><br>• Hiệu năng vượt trội với chip Apple M4 9 nhân CPU.<br>• Camera trước đặt ở cạnh dài, tiện lợi cho video call và selfie.<br>• Màn hình Ultra Retina XDR 11 inch, độ phân giải 1668 x 2420 Pixels.<br>• Thời lượng pin 10 tiếng, thoải mái sử dụng cả ngày.<br>• Hỗ trợ Apple Pencil Pro với nhiều tính năng mới.</p><h3 style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m4-11-inch-wifi-256gb">iPad Pro M4 256GB</a>, dòng máy tính bảng cao cấp nhất năm 2024, nổi bật với hiệu năng vượt trội nhờ chip Apple M4 9 nhân CPU, màn hình Ultra Retina XDR sắc nét và camera trước đặt ở cạnh dài tiện lợi. Với thiết kế mỏng nhẹ và thời lượng pin ấn tượng, iPad Pro M4 256GB hứa hẹn là lựa chọn hoàn hảo cho người dùng yêu thích công nghệ.</h3><h3 style="text-align:justify;">Thiết kế mỏng nhẹ, cao cấp hơn</h3><p style="text-align:justify;">Khung viền của iPad Pro M4 256GB được thiết kế phẳng và vuông vức, không chỉ mang lại cảm giác chắc chắn và bền bỉ cho người dùng khi cầm trên tay mà còn tạo điểm nhấn thiết kế, phản ánh sự chuyên nghiệp và sang trọng.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-khung-vien.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-khung-vien.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Khung viền" width="1020" height="570"></a></figure><p style="text-align:justify;">Các góc trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> được làm bo tròn nhẹ nhàng, giúp việc cầm nắm thoải mái hơn, đặc biệt khi bạn dùng máy trong thời gian dài. Thân máy bằng nhôm nguyên khối không chỉ tạo ra một bề ngoài mượt mà mà còn góp phần vào độ bền và cảm giác cao cấp của iPad.</p><p style="text-align:justify;">Về độ mỏng và khối lượng, iPad Pro M4 256GB tỏa sáng với 5.3 mm độ dày và nặng chỉ 444 g, được cho là một trong những chiếc máy tính bảng mỏng nhẹ nhất hiện nay. Điều này chứng tỏ Apple luôn chú trọng vào việc tối ưu hóa kích thước để mang lại sự thoải mái nhất cho người dùng đi kèm với phần hiệu năng mạnh mẽ của máy.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-do-mong.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-do-mong.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Độ mỏng" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/phu-kien-thong-minh/apple-pencil-pro">Apple Pencil Pro</a> khi kết hợp với iPad Pro M4 256GB tạo nên một công cụ sáng tạo tiên tiến với nhiều tính năng ưu việt. Công nghệ phản hồi xúc giác cho phép người dùng tận hưởng trải nghiệm vẽ và ghi chú chân thực, với mỗi cử động được tái tạo một cách sinh động. Không chỉ vậy, tính năng tìm kiếm trong ứng dụng Tìm giúp người dùng dễ dàng định vị bút khi cần thiết, mang lại sự an tâm tối đa.</p><p style="text-align:justify;"><i>Lưu ý: Bút Apple Pencil Pro và Magic Keyboard là phụ kiện được mua riêng.</i></p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-pencil.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-pencil.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Phụ kiện hỗ trợ" width="1020" height="570"></a></figure>	t	1	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	\N	\N		{}	25990000	0	30990000	0	1	1	\N	{}
58	iPad Pro M4 11 inch LTE New Seal	ipad-pro-m4-11-inch-lte-new-seal	<figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-1.jpg"><img style="aspect-ratio:1960/1091;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-1.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Tồng Quan" width="1960" height="1091"></a></figure><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-2.jpg"><img style="aspect-ratio:1960/5402;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-2.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Thông Số Kỹ Thuật" width="1960" height="5402"></a></figure><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-3.jpg"><img style="aspect-ratio:1960/775;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-3.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Lý Do Dùng iPad" width="1960" height="775"></a></figure><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-4.jpg"><img style="aspect-ratio:1960/4043;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-4.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - So Sánh" width="1960" height="4043"></a></figure><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-5.jpg"><img style="aspect-ratio:1960/2289;" src="https://cdn.tgdd.vn/Products/Images/522/325513/s16/ipad-pro-m4-11-inch-wifi-256gb-5.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Phụ Kiện" width="1960" height="2289"></a></figure><p style="text-align:justify;"><strong>Đặc điểm nổi bật của iPad Pro M4 256GB</strong><br>• Hiệu năng vượt trội với chip Apple M4 9 nhân CPU.<br>• Camera trước đặt ở cạnh dài, tiện lợi cho video call và selfie.<br>• Màn hình Ultra Retina XDR 11 inch, độ phân giải 1668 x 2420 Pixels.<br>• Thời lượng pin 10 tiếng, thoải mái sử dụng cả ngày.<br>• Hỗ trợ Apple Pencil Pro với nhiều tính năng mới.</p><h3 style="text-align:justify;"><a href="https://www.thegioididong.com/may-tinh-bang/ipad-pro-m4-11-inch-wifi-256gb">iPad Pro M4 256GB</a>, dòng máy tính bảng cao cấp nhất năm 2024, nổi bật với hiệu năng vượt trội nhờ chip Apple M4 9 nhân CPU, màn hình Ultra Retina XDR sắc nét và camera trước đặt ở cạnh dài tiện lợi. Với thiết kế mỏng nhẹ và thời lượng pin ấn tượng, iPad Pro M4 256GB hứa hẹn là lựa chọn hoàn hảo cho người dùng yêu thích công nghệ.</h3><h3 style="text-align:justify;">Thiết kế mỏng nhẹ, cao cấp hơn</h3><p style="text-align:justify;">Khung viền của iPad Pro M4 256GB được thiết kế phẳng và vuông vức, không chỉ mang lại cảm giác chắc chắn và bền bỉ cho người dùng khi cầm trên tay mà còn tạo điểm nhấn thiết kế, phản ánh sự chuyên nghiệp và sang trọng.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-khung-vien.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-khung-vien.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Khung viền" width="1020" height="570"></a></figure><p style="text-align:justify;">Các góc trên <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad">iPad</a> được làm bo tròn nhẹ nhàng, giúp việc cầm nắm thoải mái hơn, đặc biệt khi bạn dùng máy trong thời gian dài. Thân máy bằng nhôm nguyên khối không chỉ tạo ra một bề ngoài mượt mà mà còn góp phần vào độ bền và cảm giác cao cấp của iPad.</p><p style="text-align:justify;">Về độ mỏng và khối lượng, iPad Pro M4 256GB tỏa sáng với 5.3 mm độ dày và nặng chỉ 444 g, được cho là một trong những chiếc máy tính bảng mỏng nhẹ nhất hiện nay. Điều này chứng tỏ Apple luôn chú trọng vào việc tối ưu hóa kích thước để mang lại sự thoải mái nhất cho người dùng đi kèm với phần hiệu năng mạnh mẽ của máy.</p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-do-mong.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-do-mong.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Độ mỏng" width="1020" height="570"></a></figure><p style="text-align:justify;"><a href="https://www.thegioididong.com/phu-kien-thong-minh/apple-pencil-pro">Apple Pencil Pro</a> khi kết hợp với iPad Pro M4 256GB tạo nên một công cụ sáng tạo tiên tiến với nhiều tính năng ưu việt. Công nghệ phản hồi xúc giác cho phép người dùng tận hưởng trải nghiệm vẽ và ghi chú chân thực, với mỗi cử động được tái tạo một cách sinh động. Không chỉ vậy, tính năng tìm kiếm trong ứng dụng Tìm giúp người dùng dễ dàng định vị bút khi cần thiết, mang lại sự an tâm tối đa.</p><p style="text-align:justify;"><i>Lưu ý: Bút Apple Pencil Pro và Magic Keyboard là phụ kiện được mua riêng.</i></p><figure class="image" style="height:auto;"><a href="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-pencil.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/325513/ipad-pro-m4-11-inch-wifi-256gb-pencil.jpg" alt="iPad Pro M4 11 inch WiFi 256GB - Phụ kiện hỗ trợ" width="1020" height="570"></a></figure>	t	1	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	\N	\N		{"meta_description": "iPad Pro M4 11 inch LTE New Seal Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	32990000	0	37990000	0	1	1	\N	{}
59	iPad Air 4 10.9 inch Wifi Like New	ipad-air-4-109-inch-wifi-like-new	<h3 style="text-align:center;">iPad Air 4 10.9 inch Wifi Like New tại TP Mobile</h3><h3>Chip mạnh hàng đầu cho trải nghiệm hoàn hảo</h3><p>Apple trang bị cho <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a> 4 chip A14 Bionic 6 nhân. Số lượng bóng bán dẫn đạt 11.8 tỷ cao hơn 40% so với A13 Bionic (8.5 tỷ). Có thể thấy số lượng bóng bán dẫn càng lớn thì chip càng mạnh và tiết kiệm năng lượng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg" alt="Trang bị chip A14 mạnh hàng đầu của Apple | iPad Air 2020" width="800" height="533"></a></figure><p>A14 Bionic có 6 lõi chip, trong đó 2 lõi hiệu suất cao cho tác vụ phức tạp và 4 lõi còn lại cho các tác vụ thông thường.</p><p>Bên cạnh đó, bộ xử lý đồ hoạ GPU 4 lõi mang lại hiệu suất tối đa, nhanh hơn 30% so với thế hệ trước hứa hẹn iPad Air có thể chơi các trò chơi phức tạp đòi hỏi độ phân giải cao, video 4K,...</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg" alt="Chơi game hay nặng hay xem video 4K đều mượt mà | iPad Air 2020" width="800" height="533"></a></figure><p>A14 Bionic mang đến tốc độ xử lý vượt trội, nhanh chóng hơn cùng với khả năng xử lý đa nhiệm mượt mà cũng như <a href="https://www.thegioididong.com/may-tinh-bang-rom-64gb">bộ nhớ trong 64 GB</a> cho bạn không gian lưu trữ hình ảnh, video,...</p><h3>Tinh tế trong thiết kế cùng nhiều màu sắc đi kèm</h3><p>iPad Air 4 64GB có kiểu dáng mới tương tự iPad Pro 2020 nhưng có kích thước nhỏ hơn và dày chỉ 6.1 mm, khối lượng đạt 460 g dễ dàng mang theo bên mình mọi lúc mọi nơi. Thiết kế này giúp tương thích với bàn phím Apple Smart Keyboard Folio, Magic Keyboard của iPad Pro 11 inch và hỗ trợ bút Apple Pencil 2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg" alt="Bàn phím Apple Smart Keyboard Folio | iPad Air 2020" width="1020" height="570"></a></figure><p>Thiết kế trong iPad Air 4 vuông vắn hơn nếu so với những dòng iPad trước, các góc cạnh được bo tròn nhẹ nhàng tạo cảm giác mềm mại hơn cho tổng thể.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg" alt="Góc cạnh bo tròn cho cảm giác mềm mại  | iPad Air 2020" width="800" height="533"></a></figure><p>iPad Air 2020 được thiết kế nguyên khối đẳng cấp cùng nhiều màu sắc trẻ trung cho bạn có nhiều sự lựa chọn hơn như: bạc, xám, vàng hồng, xanh lá và xanh dương.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg" alt="Đa màu sắc tăng thêm sự lựa chọn | iPad Air 2020" width="800" height="533"></a></figure><p>Nút Home truyền thống được loại bỏ trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>, tạo không gian hiển thị rộng hơn và tích hợp cảm biến vân tay Touch ID trên nút nguồn đặt ở phía trên của thân máy. Đồng thời, iPad Air trở thành sản phẩm đầu tiên của Apple tích hợp tính năng nhận diện vân tay vào chung với nút nguồn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg" alt="Touch ID tích hợp nút nguồn mở khoá nhanh chóng | iPad Air 2020" width="800" height="533"></a></figure><h3>Màn hình rộng, không gian hiển thị tuyệt vời</h3><p>iPad Air 2020 sử dụng công nghệ Liquid Retina và có độ phân giải 1640 x 2360 Pixels giúp iPad Air hiển thị hình ảnh sắc nét, màu sắc chân thật hơn. Từ đó, bạn có thể tận hưởng trọn vẹn những thước phim bom tấn ấn tượng hay chơi game phải gọi là "bao mướt".&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg" alt="Màn hình đạt chuẩn Liquid Retina | iPad Air 2020" width="800" height="533"></a></figure><p>Màn hình của iPad Air có hỗ trợ dải màu rộng DCI-P3 với tính năng True-Tone cho khả năng tái tạo màu sắc chính xác hỗ trợ ưu việt cho công việc đồ họa. Hơn nữa, có lớp phủ chống lóa bề mặt, độ sáng cao giúp luôn hiển thị tốt trong nhiều điều kiện ánh sáng khác nhau, ngoài trời cũng không thành vấn đề.</p>	t	1	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	\N	\N		{"meta_description": "iPad Air 4 10.9 inch Wifi Like New Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	9490000	0	11990000	9490000	1	2	\N	{}
60	iPad Air 4 10.9 inch LTE Like New	ipad-air-4-109-inch-lte-like-new	<h3 style="text-align:center;">iPad Air 4 10.9 inch LTE Like New tại TP Mobile</h3><h3>Chip mạnh hàng đầu cho trải nghiệm hoàn hảo</h3><p>Apple trang bị cho <a href="https://www.thegioididong.com/may-tinh-bang-apple-ipad-air">iPad Air</a> 4 chip A14 Bionic 6 nhân. Số lượng bóng bán dẫn đạt 11.8 tỷ cao hơn 40% so với A13 Bionic (8.5 tỷ). Có thể thấy số lượng bóng bán dẫn càng lớn thì chip càng mạnh và tiết kiệm năng lượng hơn.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183320-033337.jpg" alt="Trang bị chip A14 mạnh hàng đầu của Apple | iPad Air 2020" width="800" height="533"></a></figure><p>A14 Bionic có 6 lõi chip, trong đó 2 lõi hiệu suất cao cho tác vụ phức tạp và 4 lõi còn lại cho các tác vụ thông thường.</p><p>Bên cạnh đó, bộ xử lý đồ hoạ GPU 4 lõi mang lại hiệu suất tối đa, nhanh hơn 30% so với thế hệ trước hứa hẹn iPad Air có thể chơi các trò chơi phức tạp đòi hỏi độ phân giải cao, video 4K,...</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-181220-051239.jpg" alt="Chơi game hay nặng hay xem video 4K đều mượt mà | iPad Air 2020" width="800" height="533"></a></figure><p>A14 Bionic mang đến tốc độ xử lý vượt trội, nhanh chóng hơn cùng với khả năng xử lý đa nhiệm mượt mà cũng như <a href="https://www.thegioididong.com/may-tinh-bang-rom-64gb">bộ nhớ trong 64 GB</a> cho bạn không gian lưu trữ hình ảnh, video,...</p><h3>Tinh tế trong thiết kế cùng nhiều màu sắc đi kèm</h3><p>iPad Air 4 64GB có kiểu dáng mới tương tự iPad Pro 2020 nhưng có kích thước nhỏ hơn và dày chỉ 6.1 mm, khối lượng đạt 460 g dễ dàng mang theo bên mình mọi lúc mọi nơi. Thiết kế này giúp tương thích với bàn phím Apple Smart Keyboard Folio, Magic Keyboard của iPad Pro 11 inch và hỗ trợ bút Apple Pencil 2.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg"><img style="aspect-ratio:1020/570;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-241221-094319.jpg" alt="Bàn phím Apple Smart Keyboard Folio | iPad Air 2020" width="1020" height="570"></a></figure><p>Thiết kế trong iPad Air 4 vuông vắn hơn nếu so với những dòng iPad trước, các góc cạnh được bo tròn nhẹ nhàng tạo cảm giác mềm mại hơn cho tổng thể.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-182620-032617.jpg" alt="Góc cạnh bo tròn cho cảm giác mềm mại  | iPad Air 2020" width="800" height="533"></a></figure><p>iPad Air 2020 được thiết kế nguyên khối đẳng cấp cùng nhiều màu sắc trẻ trung cho bạn có nhiều sự lựa chọn hơn như: bạc, xám, vàng hồng, xanh lá và xanh dương.</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185420-035411.jpg" alt="Đa màu sắc tăng thêm sự lựa chọn | iPad Air 2020" width="800" height="533"></a></figure><p>Nút Home truyền thống được loại bỏ trên <a href="https://www.thegioididong.com/may-tinh-bang">máy tính bảng</a>, tạo không gian hiển thị rộng hơn và tích hợp cảm biến vân tay Touch ID trên nút nguồn đặt ở phía trên của thân máy. Đồng thời, iPad Air trở thành sản phẩm đầu tiên của Apple tích hợp tính năng nhận diện vân tay vào chung với nút nguồn.&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-185820-035805.jpg" alt="Touch ID tích hợp nút nguồn mở khoá nhanh chóng | iPad Air 2020" width="800" height="533"></a></figure><h3>Màn hình rộng, không gian hiển thị tuyệt vời</h3><p>iPad Air 2020 sử dụng công nghệ Liquid Retina và có độ phân giải 1640 x 2360 Pixels giúp iPad Air hiển thị hình ảnh sắc nét, màu sắc chân thật hơn. Từ đó, bạn có thể tận hưởng trọn vẹn những thước phim bom tấn ấn tượng hay chơi game phải gọi là "bao mướt".&nbsp;</p><figure class="image" style="height:auto !important;"><a href="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg"><img style="aspect-ratio:800/533;" src="https://cdn.tgdd.vn/Products/Images/522/228808/ipad-air-4-wifi-64gb-2020-183220-053216.jpg" alt="Màn hình đạt chuẩn Liquid Retina | iPad Air 2020" width="800" height="533"></a></figure><p>Màn hình của iPad Air có hỗ trợ dải màu rộng DCI-P3 với tính năng True-Tone cho khả năng tái tạo màu sắc chính xác hỗ trợ ưu việt cho công việc đồ họa. Hơn nữa, có lớp phủ chống lóa bề mặt, độ sáng cao giúp luôn hiển thị tốt trong nhiều điều kiện ánh sáng khác nhau, ngoài trời cũng không thành vấn đề.</p>	t	1	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	\N	\N		{"meta_description": "iPad Air 4 10.9 inch LTE Like New Giá tốt lại TP Mobile Wifi New Seal Giá tốt lại TP Mobile"}	10490000	0	12490000	10490000	1	2	\N	{}
68	iPhone 12 Mini Quốc Tế Like New	iphone-12-mini-quoc-te-like-new	<p style="text-align:justify;"><span style="color:rgb(255,0,0);"><strong>iPhone 12 Mini 64GB cũ</strong></span><strong>&nbsp;</strong>là model sở hữu thiết kế nhỏ gọn, cấu hình cấu hình mạnh và đi kèm mức giá phải chăng. Đặc biệt model này tại Táo Zin là hàng mới lên đến 99%, nguyên zin, đầy đủ áp suất và được bảo hành lên đến 12 tháng.&nbsp;</p><p style="text-align:center;"><img src="https://taozinsaigon.com/files_upload/product/04_2022/danh-gia-iphone-12-mini-may.jpg" alt="danh-gia-iphone-12-mini-may" width="768" height="512"></p><p style="text-align:center;"><i>iPhone 12 Mini 64GB cũ&nbsp;tại Táo Zin là hàng mới lên đến 99%, nguyên zin, đầy đủ áp suất và được bảo hành lên đến 12 tháng.&nbsp;</i></p><p style="text-align:justify;"><strong>Đánh giá thiết kế iPhone 12 Mini 64GB cũ</strong></p><p style="text-align:justify;"><strong>Thiết kế iPhone 12 Mini 64GB</strong> được lấy cảm hứng từ ngôn ngữ thiết kế của iPhone 5 trước đó, cạnh viền được vát phẳng mang đến sự nam tính và mạnh mẽ cho điện thoại. Ngoài ra Apple còn mang đến nhiều tùy chọn màu sắc để người dùng có nhiều sự lựa chọn.</p><p style="text-align:center;"><img src="https://taozinsaigon.com/files_upload/product/04_2022/danh-gia-iphone-12-mini-thiet-ke.jpg" alt="danh-gia-iphone-12-mini-thiet-ke" width="768" height="512"></p><p style="text-align:center;"><i>Thiết kế iPhone 12 Mini 64GB được lấy cảm hứng từ ngôn ngữ thiết kế của iPhone 5 trước đó.</i></p><p style="text-align:justify;">Mặt lưng được hoàn thiện từ kim loại kết hợp với 2 mặt kính bóng bẩy nhưng không kém phần cứng cáp. Nổi bật trên mặt lưng chính là mô-đun camera hình vuông quen thuộc, tạo điểm nhấn cho điện thoại.&nbsp;</p><p style="text-align:justify;"><strong>Đánh giá màn hình iPhone 12 Mini 64GB cũ</strong></p><p style="text-align:justify;">iPhone 12 Mini cũ được trang bị màn hình 5.4 inch, tích hợp tấm nền OLED cao cấp tương tự như các model iPhone 12 Pro hay Pro Max. Dù thiết kế giá rẻ nhưng 12 Mini vẫn mang đến trải nghiệm màn hình chất lượng với màu sắc tươi tắn, hình ảnh chân thật.</p><p style="text-align:justify;">Không những vậy, với độ sáng tốt kết hợp với công nghệ True Tone đã mang đến khả năng hiển thị tuyệt vời cho iPhone 12 Mini ngay cả trong cả khi ngoài trời. Mặt trước màn hình tích hợp tai thỏ giúp diện tích hiển thị mở rộng thêm một ít.&nbsp;</p><p style="text-align:justify;"><strong>Đánh giá cấu hình iPhone 12 Mini 64GB cũ</strong></p><p style="text-align:justify;">Apple đã trang bị cho iPhone 12 Mini cũ chip xử lý A14 Bionic, con chip được sản xuất&nbsp; trên tiến trình 5nm. Hiệu năng mang lại trên A14 Bionic vô cùng ấn tượng, đáp ứng tốt toàn bộ các tác vụ nặng khá mượt mà và ổn định. Thanh RAM 4GB và ROM 64GB đáp ứng tốt nhu cầu sử dụng của người dùng.&nbsp;</p><p style="text-align:center;"><img src="https://taozinsaigon.com/files_upload/product/04_2022/danh-gia-iphone-12-mini-cau-hinh.jpg" alt="danh-gia-iphone-12-mini-cau-hinh" width="768" height="512"></p><p style="text-align:center;"><i>Apple đã trang bị cho iPhone 12 Mini cũ chip xử lý A14 Bionic, con chip được sản xuất&nbsp; trên tiến trình 5nm.&nbsp;</i></p><p style="text-align:justify;">Model này được trang bị viên pin 2227 mAh hỗ trợ sạc nhanh giúp kéo dài thời gian sử dụng và rút ngắn thời gian nạp năng lượng pin. Face ID mang đến nhiều cải thiện cho tốc độ mở khóa nhanh và chính xác hơn so với các thế hệ tiền nhiệm.</p><p style="text-align:justify;"><strong>Đánh giá camera iPhone 12 Mini 64GB cũ</strong></p><p style="text-align:justify;"><strong>iPhone 12 Mini 64GB cũ </strong>được trang bị hệ thống camera kép ở mặt sau và được đặt trong một mô-đun hình vuông có độ phân giải 12MP. Với cụm camera này sẽ giúp nâng cao chất lượng hình ảnh. Tính năng chụp đêm Night mode còn mang đến cho người dùng trải nghiệm hình ảnh trong điều kiện thiếu sáng một cách hoàn hảo.</p><p style="text-align:center;"><img src="https://taozinsaigon.com/files_upload/product/04_2022/danh-gia-iphone-12-mini-camera.jpg" alt="danh-gia-iphone-12-mini-camera" width="768" height="512"></p><p style="text-align:center;"><i>iPhone 12 Mini 64GB cũ được trang bị hệ thống camera kép ở mặt sau và được đặt trong một mô-đun hình vuông có độ phân giải 12MP.&nbsp;</i></p>	t	1	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	\N	\N		{}	5999000	0	6999000	5999000	1	6	\N	{}
69	iPhone 12 Quốc Tế Like New	iphone-12-quoc-te-like-new	<p style="text-align:justify;">Công nghệ màn hình hiển thị Super Retina XDR OLED được xem là điểm nâng cấp đáng đồng tiền bát gạo nhất trên iPhone 12 series cũ so với đời trước. Trong quá khứ, những thiết bị trong dòng iPhone 11 chỉ dùng tấm nền IPS LCD mà thôi.</p><p style="text-align:justify;">Hơn thế nữa, toàn bộ model của dòng sản phẩm đều được trang bị kết nối 5G cùng với công nghệ sạc không dây MagSafe hiện đại, đầy tiện lợi. Ngoài ra, các thiết bị còn sử dụng công nghệ hình ảnh Dolby Vision 4K tiên tiến, giúp nâng chất lượng trải nghiệm về hình ảnh của người dùng lên một tầm cao mới.</p><h2 style="text-align:justify;"><strong>2. iPhone 12 cũ có các loại hàng nào?</strong></h2><p style="text-align:justify;">Để có thể lựa chọn được cho mình một sản phẩm máy cũ giá rẻ ưng ý nhất cho bản thân lại phù hợp với túi tiền thì người dùng nên lưu ý rằng hiện nay trên thị trường có vô vàn những loại iPhone 12 cũ khác nhau. Vì thế, chúng ta hoàn toàn có thể sở hữu những chiếc máy vẫn còn chất lượng và hình thức như mới với giá tốt, chế độ bảo hành đầy đủ nếu như nắm kỹ những thông tin quan trọng.</p><p style="text-align:justify;">Sau đây chính là cách để người dùng và các đại lý kinh doanh phân loại điện thoại thuộc dòng iPhone 12 cũ:</p><h3 style="text-align:justify;"><strong>2.1. iPhone 12 cũ VN/A chính hãng Apple</strong></h3><p style="text-align:justify;">Các chiếc iPhone 12 cũ này là hàng chính hãng từ được Apple phân phối chính thức dành riêng cho thị trường người dùng Việt Nam. Toàn bộ các thiết bị này đều mang đuôi VN/A ở phần mã số máy, đúng với thị trường nước ta.</p>	t	1	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	\N	\N		{}	7599000	0	9799001	7399000	1	6	\N	{}
70	iPhone 12 Pro Quốc Tế Like New	iphone-12-pro-quoc-te-like-new	<p style="text-align:justify;">Smartphone được trang bị màn hình OLED kích thước 6.1 inch cùng công nghệ True Tone độc đáo, mang đến trải nghiệm tuyệt vời. Tần số quét màn hình lên đến 120Hz cho khả năng hiển thị sắc nét, sống động đến từng chi tiết.</p><p style="text-align:justify;"><strong>Đánh giá cấu hình iPhone 12 Pro 128GB cũ</strong></p><p style="text-align:justify;"><strong>iPhone 12 Pro 128GB cũ </strong>được trang bị con chip A14 Bionic sản xuất trên tiến trình 5nm đem đến hiệu năng vượt trội hơn hẳn so với thế hệ trước đó. Đi kèm là thanh RAM 4GB, ROM 128GB giúp người dùng dễ dàng lưu trữ nhiều thông tin, hình ảnh.&nbsp;</p><p style="text-align:center;"><img src="https://taozinsaigon.com/files_upload/product/05_2022/danh-gia-iphone-12-pro-camera.jpg" alt="danh-gia-iphone-12-pro-camera" width="768" height="512"></p><p style="text-align:center;"><i>iPhone 12 Pro 128GB cũ được trang bị con chip A14 Bionic sản xuất trên tiến trình 5nm.</i></p><p style="text-align:justify;">Ngoài ra, việc trang bị chipset cao cấp cùng tiến trình sản xuất 5nm giúp iPhone 12 Pro tiết kiệm dung lượng pin một cách đáng kể. Từ đó giúp viên pin 2815 mAh có tích hợp sạc nhanh sẽ giúp kéo dài thời gian hoạt động và rút ngắn thời gian sạc.&nbsp;</p>	t	1	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	\N	\N		{}	9499000	0	10699000	9499000	1	6	\N	{}
71	iPhone 12 Pro Max Quốc Tế Like New	iphone-12-pro-max-quoc-te-like-new	<h2 style="text-align:justify;"><strong>iPhone 12 Pro Max 128GB Cũ: Cấu hình mạnh mẽ, camera ấn tượng, thiết kế sang trọng bậc nhất&nbsp;</strong></h2><p style="text-align:justify;"><span style="background-color:rgb(255,255,255);color:rgb(51,51,51);">Nhìn tổng thể, </span><strong>iPhone 12 Pro Max 128GB cũ</strong><span style="background-color:rgb(255,255,255);color:rgb(51,51,51);"> sở hữu thiết tương đồng với “người anh em” </span>iPhone 11 Pro Max cũ<span style="background-color:rgb(255,255,255);color:rgb(51,51,51);">. Màn hình tai thỏ ở mặt trước tích hợp camera selfie, mặt sau trang bị cụm camera hình vuông tích hợp 3 ống kính. Tuy nhiên phần khung viền máy đã được tinh chỉnh có phần vuông vức hơn, tạo sự mới lạ và thu hút người dùng.</span></p>	t	1	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	\N	\N		{}	12199000	0	13399000	12199000	1	6	\N	{}
72	iPhone 13 Pro Max Quốc Tế Like New	iphone-13-pro-max-quoc-te-like-new	<h2 style="text-align:justify;"><strong>iPhone 13 Pro Max 128GB Cũ Like New 99%: Siêu phẩm Apple 2021, hàng đã qua sử dụng có đáng tiền?&nbsp;</strong></h2><p style="text-align:justify;">Siêu phẩm mới từ Apple được mong đợi nhất trong nửa cuối năm 2021, <strong>iPhone 13 Pro Max 128GB cũ</strong> với hàng loạt nâng cấp từ màn hình ProMotion 120Hz, bộ vi xử lý A15 Bionic cho hiệu năng không đối thủ, thời lượng pin vượt trội và bộ 3 camera chuyên nghiệp được nâng cấp mạnh mẽ.</p><p style="text-align:justify;">&nbsp;</p><p style="text-align:justify;">Mặt lưng iPhone 13 Pro Max là mặt lưng kính được phủ một lớp oleophobic giúp hạn chế bám bụi bẩn và vân tay, logo quả táo khuyết đặt ở chính giữa và khung viền bằng thép không gỉ sang trọng.</p><h2 style="text-align:justify;"><strong>Không gian màn hình IP 13 Pro Max cũ lớn, đáp ứng mọi nhu cầu giải trí người dùng</strong></h2><p style="text-align:justify;">Được trang bị màn hình kích thước 6.7 inch cùng độ phân giải 1284 x 2778 Pixels, <strong>iPhone 13 Pro Max 128GB cũ</strong> sử dụng tấm nền OLED cùng công nghệ Super Retina XDR cho khả năng tiết kiệm năng lượng vượt trội nhưng vẫn đảm bảo hiển thị sắc nét sống động chân thực.</p>	t	1	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	\N	\N		{}	15699000	0	16899000	15699000	1	6	\N	{}
73	iPhone 13 Pro Quốc Tế Like New	iphone-13-pro-quoc-te-like-new	<h2 style="text-align:justify;"><strong>iPhone 13 Pro 128GB cũ​ có thông số cấu hình bậc nhất</strong></h2><p style="text-align:justify;">Không chỉ nâng cấp cho ngoại hình iPhone 13 Pro 128GB cũ, Apple còn trang bị cho dòng smartphone này những thông số cấu hình cực khủng. Đó là màn hình OLED 61 inches độ phân giải&nbsp;1170x2532px với công nghệ ProMotion, giúp nâng tần số quét của máy lên đến 120Hz.</p><p style="text-align:justify;">Hiệu năng của&nbsp;<strong>iPhone 13 Pro 128GB cũ</strong> được cung cấp bởi con chip Apple A15 Bionic cực mạnh. Đây là dòng chip 6 nhân hoạt động trên tiến trình 5nm mới nhất do Apple sản xuất, là con chip có hiệu năng khủng bậc nhất ở thời điểm hiện tại.</p><p style="text-align:justify;">Hiệu năng của con chip này được đánh giá là mạnh mẽ hơn 20 - 40% so với các dòng chip cũ trên các dòng iPhone 12, iPhone 11... Do đó mà người dùng&nbsp;<strong>iPhone 13 Pro 128GB cũ</strong> hoàn toàn có thể yên tâm thao tác tất cả các tác vụ.</p><p style="text-align:justify;">Về màn hình,&nbsp;iPhone 13 Pro 128GB cũ được trang bị màn hình OLED 6.1 inch, công nghệ Super Retina XDR và tần số quét lên đến 120Hz. Độ sáng màn hình&nbsp;iPhone 13 Pro 128GB cũ có thể đạt đến 1200nits cho 1 số dạng video HDR và 1000nits cho tất cả các tác vụ.</p><p style="text-align:justify;">Các công nghệ này giúp cho người dùng dễ dàng thao tác dưới trời nắng gắt, hay bất kỳ điều kiện thời tiết nào. Do đó mà&nbsp;iPhone 13 Pro 128GB cũ hiện là dòng iPhone được săn đón nhiều nhất, được cả giới trẻ, dân văn phòng, hay các doanh nhân lựa chọn.</p><h2 style="text-align:justify;"><strong>iPhone 13 Pro 128GB cũ có cụm camera chất lượng cao</strong></h2><p style="text-align:justify;">Về khả năng chụp ảnh,&nbsp;<strong>iPhone 13 Pro 128GB cũ</strong> năm nay bất ngờ được nâng cấp đồng bộ so với cụm camera của&nbsp;"trùm cuối"&nbsp;iPhone 13 Pro Max. Đó là cụm 3 camera với 1 cảm biến Tele 3x mới:</p><p style="text-align:justify;">Camera góc rộng&nbsp;12 MP, khẩu độ f/1.5, OIS chống rung quang;</p><p style="text-align:justify;">Camera chụp xa 12 MP, khẩu độ f/2.8, OIS chống rung quang, zoom quang 3x;</p><p style="text-align:justify;">Camera góc siêu rộng 12 MP, khẩu độ f/1.8, chụp góc 120˚;</p><p style="text-align:justify;">Máy quét TOF 3D LiDAR đo độ sâu chính xác</p>	t	1	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	\N	\N		{}	13399000	0	15599000	15.399	1	6	\N	{}
74	iPhone 14 Pro Quốc Tế Like New	iphone-14-pro-quoc-te-like-new		t	1	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	\N	\N		{}	16999000	0	20199000	16999000	1	6	\N	{}
75	iPhone 14 Quốc Tế Like New	iphone-14-quoc-te-like-new		t	1	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	\N	\N		{}	12499000	0	12699000	12499000	1	6	\N	{}
76	iPhone 14 Plus Quốc Tế Like New	iphone-14-plus-quoc-te-like-new		t	1	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	\N	\N		{}	13499000	0	13699000	13499000	1	6	\N	{}
77	iPhone 14 Pro Max Quốc Tế Like New	iphone-14-pro-max-quoc-te-like-new		t	1	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	\N	\N		{}	19999000	0	23199000	19999000	1	6	\N	{}
78	iPhone 15 Pro Max 512GB Like New	iphone-15-pro-max-512gb-like-new		t	1	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	\N	\N		{}	24899000	0	27999000	24899000	1	6	\N	{}
79	iPhone 15 Pro Like New	iphone-15-pro-like-new		t	1	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	\N	\N		{}	20499000	0	23499000	20499000	1	6	\N	{}
80	Tai nghe Bluetooth Airpods 2 có dây	tai-nghe-bluetooth-airpods-2-co-day		t	1	2024-08-04 16:18:17.359	2024-08-04 16:18:17.359	\N	\N		{}	2690000	0	0	0	1	5	\N	{}
81	Smart Keyboard Folio iPad Pro (2021/2022) 12.9" Chính Hãng	smart-keyboard-folio-ipad-pro-20212022-129-chinh-hang		t	1	2024-08-04 16:19:15.903	2024-08-04 16:19:15.903	\N	\N		{}	3499000	0	0	0	1	5	\N	{}
82	Smart Keyboard Folio iPad Air 10.9 inch / iPad Pro 11 Chính Hãng	smart-keyboard-folio-ipad-air-109-inch-ipad-pro-11-chinh-hang		t	1	2024-08-04 16:21:07.33	2024-08-04 16:21:07.33	\N	\N		{}	3499000	0	0	0	1	7	\N	{}
83	Bàn phím Apple Magic Keyboard iPad Pro 13 M4 Chính Hãng	ban-phim-apple-magic-keyboard-ipad-pro-13-m4-chinh-hang		t	1	2024-08-04 16:21:53.987	2024-08-04 16:21:53.987	\N	\N		{}	9790000	0	0	0	1	5	\N	{}
85	Bút Apple Pencil 1 New Seal	but-apple-pencil-1-new-seal		t	1	2024-08-04 16:26:06.029	2024-08-07 18:44:41.506	\N	\N		{}	1699000	0	0	0	1	5	\N	{}
84	Tai Nghe Airpods Pro 2023 MagSafe Chính Hãng VN/A	tai-nghe-airpods-pro-2023-magsafe-chinh-hang-vna	<p><strong>Đặc điểm nổi bật</strong></p><p><span style="background-color:transparent;color:rgb(0,0,0);"><strong>I. Giới Thiệu</strong></span></p><p>&nbsp;</p><p><span style="background-color:transparent;color:rgb(0,0,0);">Tai nghe AirPods Pro 2023 là phiên bản tiếp theo của dòng sản phẩm nổi tiếng của Apple, với hứa hẹn mang đến những cải tiến đáng kể về hiệu suất, thiết kế và tính năng, tạo ra sự chú ý lớn từ phía người tiêu dùng.</span></p><p>&nbsp;</p><p><span style="background-color:transparent;color:rgb(0,0,0);"><strong>II. Thiết Kế và Công Nghệ</strong></span></p><p>&nbsp;</p><p><span style="background-color:transparent;color:rgb(0,0,0);">Tai nghe AirPods Pro 2023 tiếp tục theo đuổi thiết kế thông minh và hiện đại, với công nghệ chống ồn cao cấp và khả năng chống nước IPX7, phù hợp với người dùng sành điệu và năng động. Thiết kế thoải mái, chắc chắn và khả năng kết nối nhanh chóng tạo ra trải nghiệm nghe nhạc và cuộc gọi tuyệt vời.</span></p><p>&nbsp;</p><p><span style="background-color:transparent;color:rgb(0,0,0);"><strong>III. Hiệu Suất Âm Thanh và Chất Lượng Đàm Thoại</strong></span></p><p>&nbsp;</p><p><span style="background-color:transparent;color:rgb(0,0,0);">AirPods Pro 2023 tiếp tục cải thiện chất lượng âm thanh với chip H2, với âm bass sâu và âm trung/cao sắc nét. Công nghệ chống ồn hiện đại giúp tập trung tuyệt đối vào âm nhạc hoặc cuộc gọi, mang đến trải nghiệm lắng nghe đỉnh cao. Điều khiển cảm ứng thông minh trên tai nghe cho phép người dùng dễ dàng thao tác và điều chỉnh âm lượng, chấp nhận cuộc gọi hoặc chuyển bài hát một cách thuận lợi.</span></p>	t	1	2024-08-04 16:24:49.258	2024-08-07 18:44:49.223	\N	\N		{}	5550000	0	0	0	1	5	\N	{}
65	iPad mini 5 Wifi New Seal	ipad-mini-5-wifi-new-seal	<h3 style="text-align:justify;"><strong>Màn hình 7.9 inch rộng rãi, </strong><span style="color:rgb(0,0,0);"><strong>tấm nền IPS</strong></span><strong> LCD, hỗ trợ Apple Pencil</strong></h3><p style="text-align:justify;"><strong>iPad Mini 5</strong> được trang bị màn hình 7.9 inch với độ phân giải 1536 x 2048. Với mật độ điểm ảnh 324 ppi, máy mang đến cho người dùng không gian trải nghiệm thoải mái, rộng lớn, sắc nét. Nhờ vào tấm nền IPS LCD mà hình ảnh trên máy thể hiện rất trung thực, hình ảnh nổi khối, độ sáng cao cũng như góc nhìn tuyệt đối.</p><p style="text-align:justify;">&nbsp;</p><p style="text-align:justify;">Song song với khả năng hiển thị tốt cùng không gian rộng rãi, màn hình trên iPad Mini 5 hứa hẹn cũng mang đến cho người dùng rất nhiều tính năng hữu ích như True Tone, dải màu <span style="color:rgb(0,0,0);">DCI-P3</span>.</p><p style="text-align:justify;">Đặc biệt hơn, bạn sẽ có một chiếc máy tính bảng hỗ trợ Apple Pencil. Với chiếc bút Stylus này, bạn có thể thực hiện rất nhiều thao tác thú vị như vẽ, viết, thiết kế, cũng như là ghi chú công việc. Bên cạnh đó, máy tính bảng cũng hỗ trợ kết nối với vỏ bàn phím thông minh của hãng. Nhìn chung, với hai phụ kiện này, cùng màn hình rộng rãi, iPad Mini 5 thật sự là công cụ đắc lực cho công việc và giải trí.</p>	t	1	2024-08-03 15:25:07.176	2024-08-07 18:45:20.547	\N	\N		{}	5490000	0	7490000	5490000	1	4	\N	{}
\.


--
-- Data for Name: ProductAttributes; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductAttributes" (id, product_id, attribute_id, "position") FROM stdin;
1	10	2	1
2	10	1	2
3	11	2	1
4	11	1	2
5	12	2	1
6	12	1	2
7	14	2	1
8	14	1	2
9	15	2	1
10	15	1	2
11	16	2	1
12	16	1	2
13	17	2	1
14	17	1	2
15	18	2	1
16	18	1	2
17	19	2	1
18	19	1	2
19	20	2	1
20	20	1	2
21	21	2	1
22	21	1	2
23	22	2	1
24	22	1	2
25	23	2	1
26	23	1	2
27	24	2	1
28	24	1	2
29	25	2	1
30	25	1	2
31	26	2	1
32	26	1	2
33	27	2	1
34	27	1	2
35	28	2	1
36	28	1	2
37	29	2	1
38	29	1	2
39	30	2	1
40	30	1	2
41	31	2	1
42	31	1	2
43	32	2	1
44	32	1	2
46	34	1	2
47	34	2	1
48	40	1	2
49	40	2	1
50	41	1	2
51	41	2	1
52	42	1	2
53	42	2	1
54	43	1	2
55	43	2	1
56	44	1	2
57	44	2	1
58	45	1	2
59	45	2	1
62	47	1	2
63	47	2	1
64	48	1	2
65	48	2	1
66	49	1	2
67	49	2	1
68	50	1	2
69	50	2	1
70	51	1	2
71	51	2	1
72	52	1	2
73	52	2	1
74	53	1	2
75	53	2	1
76	54	1	2
77	54	2	1
78	55	1	2
79	55	2	1
80	56	1	2
81	56	2	1
82	57	1	2
83	57	2	1
84	58	1	2
85	58	2	1
86	59	1	2
87	59	2	1
88	60	1	2
89	60	2	1
90	61	1	2
91	61	2	1
92	62	1	2
93	62	2	1
94	63	1	2
95	63	2	1
96	64	1	2
97	64	2	1
98	65	1	2
99	65	2	1
100	68	4	3
101	68	1	2
102	68	2	1
103	69	4	3
104	69	1	2
105	69	2	1
106	70	4	3
107	70	1	2
108	70	2	1
109	71	4	3
110	71	1	2
111	71	2	1
112	72	4	3
113	72	1	2
114	72	2	1
115	73	4	3
116	73	1	2
117	73	2	1
118	74	4	3
119	74	1	2
120	74	2	1
121	75	4	3
122	75	1	2
123	75	2	1
124	76	4	3
125	76	1	2
126	76	2	1
127	77	4	3
128	77	1	2
129	77	2	1
130	78	4	3
131	78	1	2
132	78	2	1
133	79	4	3
134	79	1	2
135	79	2	1
136	80	3	2
137	80	2	1
138	81	2	1
139	82	2	1
140	83	2	1
141	84	3	2
142	84	2	1
143	85	2	1
\.


--
-- Data for Name: ProductCategories; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductCategories" (id, priority, category_id, product_id) FROM stdin;
1	\N	3	10
2	\N	8	10
3	\N	8	11
4	\N	7	12
6	\N	7	14
7	\N	8	15
8	\N	8	16
9	\N	7	17
10	\N	7	18
11	\N	8	19
12	\N	8	20
13	\N	7	21
14	\N	7	22
15	\N	8	23
16	\N	8	24
17	\N	7	25
18	\N	7	26
19	\N	7	27
20	\N	7	28
21	\N	7	29
22	\N	7	30
23	\N	8	31
24	\N	7	32
25	\N	7	34
26	\N	7	40
27	\N	7	41
28	\N	8	42
29	\N	7	43
30	\N	7	44
31	\N	8	45
33	\N	7	47
34	\N	7	48
35	\N	8	49
36	\N	8	50
37	\N	7	51
38	\N	7	52
39	\N	8	53
40	\N	8	54
41	\N	7	55
42	\N	7	56
43	\N	8	57
44	\N	8	58
45	\N	7	59
46	\N	7	60
47	\N	8	61
48	\N	8	62
49	\N	8	63
50	\N	8	64
51	\N	8	65
\.


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductImage" (id, url, alt_text, "position", is_featured, product_id) FROM stdin;
8	https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vnaggf.png	\N	2	f	10
9	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnah_d_.png	\N	3	f	10
10	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/_/b_ccc.png	\N	4	f	10
11	https://cdn2.cellphones.com.vn/358x/media/catalog/product/h/_/h_ngff.png	\N	1	t	11
12	https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vnaggf.png	\N	2	f	11
13	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnah_d_.png	\N	3	f	11
14	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/_/b_ccc.png	\N	4	f	11
15	https://cdn2.cellphones.com.vn/358x/media/catalog/product/h/_/h_ngff.png	\N	1	t	12
16	https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vnaggf.png	\N	2	f	12
17	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnah_d_.png	\N	3	f	12
18	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/_/b_ccc.png	\N	4	f	12
19	https://cdn2.cellphones.com.vn/358x/media/catalog/product/h/_/h_ngff.png	\N	1	t	14
20	https://cdn2.cellphones.com.vn/358x/media/catalog/product/v/n/vnaggf.png	\N	2	f	14
21	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/n/xnah_d_.png	\N	3	f	14
22	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/_/b_ccc.png	\N	4	f	14
23	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/_/x_mmas_1.png	\N	1	t	15
24	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/c/bcjjcc_1.png	\N	2	f	15
25	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/_/x_mmas_1.png	\N	1	t	16
26	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/c/bcjjcc_1.png	\N	2	f	16
27	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/c/bcjjcc_1.png	\N	1	t	17
28	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/_/x_mmas_1.png	\N	2	f	17
29	https://cdn2.cellphones.com.vn/358x/media/catalog/product/b/c/bcjjcc_1.png	\N	1	t	18
30	https://cdn2.cellphones.com.vn/358x/media/catalog/product/x/_/x_mmas_1.png	\N	2	f	18
31	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	\N	1	t	19
32	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	2	f	19
33	https://cdn2.cellphones.com.vn/358x/media/catalog/product/5/_/5_158_4.jpg	\N	3	f	19
34	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	4	f	19
35	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	\N	1	t	20
36	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	2	f	20
37	https://cdn2.cellphones.com.vn/358x/media/catalog/product/5/_/5_158_4.jpg	\N	3	f	20
38	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	4	f	20
39	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	\N	1	t	21
40	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	2	f	21
41	https://cdn2.cellphones.com.vn/358x/media/catalog/product/5/_/5_158_4.jpg	\N	3	f	21
42	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	4	f	21
43	https://cdn2.cellphones.com.vn/358x/media/catalog/product/7/_/7_87_3.jpg	\N	1	t	22
44	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	2	f	22
45	https://cdn2.cellphones.com.vn/358x/media/catalog/product/5/_/5_158_4.jpg	\N	3	f	22
46	https://cdn2.cellphones.com.vn/x/media/catalog/product/9/_/9_44_1.jpg	\N	4	f	22
47	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png	\N	1	t	23
48	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	\N	2	f	23
49	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png	\N	3	f	23
50	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png	\N	4	f	23
51	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png	\N	1	t	24
52	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	\N	2	f	24
53	https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_246_1.jpg	\N	3	f	24
54	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png	\N	4	f	24
55	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png	\N	1	t	25
56	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	\N	2	f	25
57	https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_246_1.jpg	\N	3	f	25
58	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png	\N	4	f	25
59	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-4_1.png	\N	1	t	26
60	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-3_1.png	\N	2	f	26
61	https://cdn2.cellphones.com.vn/358x/media/catalog/product/2/_/2_246_1.jpg	\N	3	f	26
62	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-mini-6-2_1.png	\N	4	f	26
63	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro2018_3_1_1.jpg	\N	1	t	27
64	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro20181_3_1_1.jpg	\N	2	f	27
65	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_5_1.jpg	\N	3	f	27
66	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro2018_3_1_1.jpg	\N	1	t	28
67	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro20181_3_1_1.jpg	\N	2	f	28
68	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_5_1.jpg	\N	3	f	28
69	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro2018_3_1_1.jpg	\N	1	t	29
70	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro20181_3_1_1.jpg	\N	2	f	29
7	https://cdn2.cellphones.com.vn/358x/media/catalog/product/h/_/h_ngff.png	123123	1	t	10
132	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-pro-m4-11-inch.png	\N	2	f	58
71	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_5_1.jpg	\N	3	f	29
72	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro2018_3_1_1.jpg	\N	1	t	30
73	https://cdn2.cellphones.com.vn/x/media/catalog/product/p/r/pro20181_3_1_1.jpg	\N	2	f	30
74	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_mtem2ll_a_12_9_ipad_pro_late_1441843_5_1.jpg	\N	3	f	30
75	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_2.png	\N	1	t	31
76	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_.png	\N	2	f	31
77	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_.png	\N	1	t	32
78	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_2.png	\N	2	f	32
82	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_.png	\N	1	t	34
83	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_11_2020_wifi_2.png	\N	2	f	34
84	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_12.9_2020_wifi_256gb__2.png	\N	1	t	40
85	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_12.9_2020_wifi_256gb_2_2.png	\N	2	f	40
86	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-pro-12-9-2020-wifi-128-gb-8_2.jpg	\N	3	f	40
87	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_12.9_2020_wifi_256gb__2.png	\N	1	t	41
88	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad_pro_12.9_2020_wifi_256gb_2_2.png	\N	2	f	41
89	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-pro-12-9-2020-wifi-128-gb-8_2.jpg	\N	3	f	41
90	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	42
91	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	42
92	https://anhphibantao.com/wp-content/uploads/2022/04/ipad-pro-m1-11-inch-3.png	\N	3	f	42
93	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	43
94	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	43
95	https://anhphibantao.com/wp-content/uploads/2022/04/ipad-pro-m1-11-inch-3.png	\N	3	f	43
96	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	44
97	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	44
98	https://anhphibantao.com/wp-content/uploads/2022/04/ipad-pro-m1-11-inch-3.png	\N	3	f	44
99	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	45
100	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	45
101	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	47
102	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	47
103	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple_ipad_pro_2021_silver_11_1-_tejar.jpg	\N	1	t	48
104	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2021-11inch-grey_2.jpg	\N	2	f	48
105	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	1	t	49
106	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	49
107	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	3	f	49
108	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	1	t	50
109	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	50
110	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	3	f	50
111	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	1	t	51
112	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	51
113	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	3	f	51
114	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	1	t	52
115	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	52
116	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	3	f	52
117	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	1	t	53
118	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	53
119	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	3	f	53
120	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	1	t	54
121	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	54
122	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	3	f	54
123	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	1	t	55
124	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	55
125	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	3	f	55
126	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-2022-11-inch-m2.png	\N	1	t	56
127	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-wifi-silver-202210-01.jpg	\N	2	f	56
128	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-pro-13-select-202210.png	\N	3	f	56
129	https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_100_1_2__1.png	\N	1	t	57
130	https://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/ipad-pro-m4-11-inch.png	\N	2	f	57
131	https://cdn2.cellphones.com.vn/358x/media/catalog/product/f/r/frame_100_1_2__1.png	\N	1	t	58
133	https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_228.jpg	\N	1	t	59
134	https://cdn2.cellphones.com.vn/x/media/catalog/product/4/_/4_189.jpg	\N	2	f	59
135	https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_160.jpg	\N	3	f	59
136	https://cdn2.cellphones.com.vn/x/media/catalog/product/3/_/3_228.jpg	\N	1	t	60
137	https://cdn2.cellphones.com.vn/x/media/catalog/product/4/_/4_189.jpg	\N	2	f	60
138	https://cdn2.cellphones.com.vn/x/media/catalog/product/5/_/5_160.jpg	\N	3	f	60
139	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb.jpg	\N	1	t	61
140	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb_2_.jpg	\N	2	f	61
141	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb.jpg	\N	1	t	62
142	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb_2_.jpg	\N	2	f	62
143	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb.jpg	\N	1	t	63
144	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb_2_.jpg	\N	2	f	63
145	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb.jpg	\N	1	t	64
146	https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-6-m2-11-inch-1tb_2_.jpg	\N	2	f	64
147	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb-1.jpg	\N	1	t	65
148	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb.jpg	\N	2	f	65
149	https://cdn2.cellphones.com.vn/x/media/catalog/product/a/p/apple-ipad-mini-5-wifi-64-gb-2.jpg	\N	3	f	65
150	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mini_trang.jpg	\N	1	t	68
151	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mini_do.jpg	\N	2	f	68
152	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mini_den.jpg	\N	3	f	68
153	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mini_xanh.jpg	\N	4	f	68
154	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mau_trang_1.jpg	\N	1	t	69
155	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mau_do_2.jpg	\N	2	f	69
156	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mau_mint_1.jpg	\N	3	f	69
157	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_mau_xanh_1.jpg	\N	4	f	69
158	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_mau_den.jpg	\N	1	t	70
159	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_mau_trang.jpg	\N	2	f	70
160	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_mau_vang.jpg	\N	3	f	70
161	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_mau_xanh.jpg	\N	4	f	70
162	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_max_mau_xanh_1.jpg	\N	1	t	71
163	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_max_mau_vang_1.jpg	\N	2	f	71
164	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_max_mau_trang_1.jpg	\N	3	f	71
165	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_12_pro_max_mau_den_1.jpg	\N	4	f	71
166	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_den_3.jpg	\N	1	t	72
167	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_xanh_2.jpg	\N	2	f	72
168	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_vang_1.jpg	\N	3	f	72
169	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_trang_2.jpg	\N	4	f	72
170	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_trang_2.jpg	\N	1	t	73
171	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_vang_1.jpg	\N	2	f	73
172	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_xanh_2.jpg	\N	3	f	73
173	https://taozinsaigon.com/files_upload/product/06_2022/thumbs/600_iphone_13_pro_max_mau_den_3.jpg	\N	4	f	73
174	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_tim_4.png	\N	1	t	74
175	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_trang_4.png	\N	2	f	74
176	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_vang_4.png	\N	3	f	74
177	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_tim_4.png	\N	4	f	74
178	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_trang_3.png	\N	1	t	75
179	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_xanh_3.png	\N	2	f	75
180	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_tim_3.png	\N	3	f	75
181	https://taozinsaigon.com/files_upload/product/03_2023/thumbs/600_iphone_14_mau_vang_taozinsaigon_2.jpg	\N	4	f	75
182	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_plus_tim_2.png	\N	1	t	76
183	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_plus_xanh_2.png	\N	2	f	76
184	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_plus_do_2.png	\N	3	f	76
185	https://taozinsaigon.com/files_upload/product/03_2023/thumbs/600_iphone_14_plus_mau_vang_taozinsaigon.jpg	\N	4	f	76
186	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_max_tim_3.png	\N	1	t	77
187	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_max_xam_3.png	\N	2	f	77
188	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_max_vang_3.png	\N	3	f	77
189	https://taozinsaigon.com/files_upload/product/09_2022/thumbs/600_iphone_14_pro_max_trang_3.png	\N	4	f	77
190	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_black_4.png	\N	1	t	78
191	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_wwhite_4.png	\N	2	f	78
192	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_bluepng_4.png	\N	3	f	78
193	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_titan_4.png	\N	4	f	78
194	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_titan.png	\N	1	t	79
195	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_bluepng.png	\N	2	f	79
196	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_black.png	\N	3	f	79
197	https://taozinsaigon.com/files_upload/product/09_2023/thumbs/600_ava_ip15pr_wwhite.png	\N	4	f	79
198	https://taozinsaigon.com/files_upload/product/05_2022/thumbs/600_tai-nghe-iphone-airpods-2-cap-sac.jpg	\N	1	t	80
199	https://taozinsaigon.com/files_upload/product/06_2024/thumbs/600_ava10.png	\N	1	t	81
200	https://taozinsaigon.com/files_upload/product/06_2024/thumbs/600_ava8.jpg	\N	1	t	82
201	https://taozinsaigon.com/files_upload/product/06_2024/thumbs/600_ava6.png	\N	1	t	83
202	https://taozinsaigon.com/files_upload/product/04_2024/thumbs/600_photo_2024-04-29_17-13-05.jpg	\N	1	t	84
203	https://taozinsaigon.com/files_upload/product/03_2022/thumbs/600_but-apple.jpg	\N	1	t	85
\.


--
-- Data for Name: ProductOrder; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductOrder" (id, title, slug, category_title, category_id, vendor, barcode, line_price, price, price_original, line_price_original, variant_id, product_id, product_title, variant_title, variant_options, quantity, image, cart_id, order_id) FROM stdin;
\.


--
-- Data for Name: ProductSpecifications; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductSpecifications" (id, value, group_id, link) FROM stdin;
1	Retina IPS LCD	1	https://www.thegioididong.com/hoi-dap/man-hinh-retina-la-gi-905780
3	10.9 inches	3	\N
4	iPadOS 16	25	\N
5	Camera góc rộng: 12MP, ƒ/1.8	4	\N
6	Apple A14 Bionic 6 nhân	23	\N
8	4GB	19	\N
9	28.6 Wh (~ 7587 mAh)	6	\N
10	10.2 inches	3	\N
11	1620 x 2160 pixels	3	\N
12	Camera góc rộng: 8MP, ƒ/2.4	4	\N
13	1620 x 2160 pixels	2	\N
14	12 MP, ƒ/2.4	5	\N
15	Apple A13 Bionic 6 nhân	22	\N
16	2 nhân 2.65 GHz & 4 nhân 1.8 GHz	23	\N
17	Apple GPU 4 nhân	24	\N
18	3GB	19	\N
19	32.4 Wh (~ 8600 mAh)	6	\N
20	Liquid Retina	1	\N
21	2360 x 1640 pixel	2	\N
22	Apple M1 8 nhân	22	\N
23	Apple GPU 8 nhân	24	\N
24	8GB	19	\N
26	iPadOS 15	25	\N
27	8.3 inches	3	\N
28	Mini LED	1	\N
29	2266 x 1488 pixels	2	\N
30	Apple A15 Bionic 6 nhân	22	\N
31	2.93 GHz	23	\N
32	Apple GPU 5 nhân	24	\N
33	64GB	21	\N
34	19.3 Wh (~ 5175 mAh)	6	\N
35	USB Type-C	8	\N
36	11 inches	3	\N
37	1668 x 2388 pixel	2	\N
38	12 MP, f/1.8, 1/3", PDAF	4	\N
39	7 MP, f/2.2, 32mm	5	\N
40	Apple A12X Bionic	22	\N
41	Octa-core	23	\N
42	Apple GPU	24	\N
43	256 GB	21	\N
44	iOS	25	\N
45	12 MP góc rộng,khẩu độ f/1.8 10 MP góc siêu rộng, f/2.4	4	\N
46	7 MP khẩu độ f/2.2	5	\N
47	Apple A12Z Bionic	22	\N
48	 4 nhân 2.5GHz 4 nhân 1.6GHz	23	\N
49	6GB	19	\N
50	128GB	21	\N
51	Khoảng 7600 mAh	6	\N
52	Ultra Retina XDR	1	\N
53	Apple M4	22	\N
54	iPadOS 17	25	\N
55	2420x1668 pixel	2	\N
56	Apple A14 Bion	22	\N
57	1640 x 2360 pixels	2	\N
58	10.86 inches	3	\N
59	Ultra Wide 12MP trên cạnh ngang Khẩu độ ƒ/2.4	5	\N
60	Apple M2	22	\N
61	12.9 inches	3	\N
62	2732 x 2048 pixels	2	\N
\.


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."ProductVariant" (id, barcode, "position", compare_at_price, price, sku, title, updated_at, created_at, inventory_quantity, available, product_id, image_id, price_origin, sold_quantity) FROM stdin;
7	\N	1	0	12990000	IG11I2W-hong-256gb-1721669186011	Hồng / 256GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
8	\N	2	0	9390000	IG11I2W-vang-64gb-1721669186011	Vàng / 64GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
9	\N	3	0	12990000	IG11I2W-vang-256gb-1721669186011	Vàng / 256GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
10	\N	4	0	9390000	IG11I2W-xanh-duong-64gb-1721669186011	Xanh dương / 64GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
11	\N	5	0	12990000	IG11I2W-xanh-duong-256gb-1721669186011	Xanh dương / 256GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
12	\N	6	0	9390000	IG11I2W-bac-64gb-1721669186011	Bạc / 64GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
13	\N	7	0	12990000	IG11I2W-bac-256gb-1721669186011	Bạc / 256GB	2024-07-22 17:52:19.795	2024-07-22 17:52:19.795	1	t	10	\N	0	0
14	\N	0	0	12990000	IG11I2LNS-hong-64gb-1721738561047	Hồng / 64GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
15	\N	1	0	16990000	IG11I2LNS-hong-256gb-1721738561047	Hồng / 256GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
16	\N	2	0	12990000	IG11I2LNS-vang-64gb-1721738561047	Vàng / 64GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
17	\N	3	0	16990000	IG11I2LNS-vang-256gb-1721738561047	Vàng / 256GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
18	\N	4	0	12990000	IG11I2LNS-xanh-duong-64gb-1721738561047	Xanh dương / 64GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
19	\N	5	0	16990000	IG11I2LNS-xanh-duong-256gb-1721738561047	Xanh dương / 256GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
20	\N	6	0	12990000	IG11I2LNS-bac-64gb-1721738561047	Bạc / 64GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
21	\N	7	0	16990000	IG11I2LNS-bac-256gb-1721738561047	Bạc / 256GB	2024-07-23 12:43:14.014	2024-07-23 12:43:14.014	1	t	11	\N	0	0
22	\N	0	0	8790000	IG11I2WLN-hong-64gb-1721738787310	Hồng / 64GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
23	\N	1	0	10990000	IG11I2WLN-hong-256gb-1721738787310	Hồng / 256GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
24	\N	2	0	8790000	IG11I2WLN-vang-64gb-1721738787310	Vàng / 64GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
25	\N	3	0	10990000	IG11I2WLN-vang-256gb-1721738787310	Vàng / 256GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
26	\N	4	0	8790000	IG11I2WLN-xanh-duong-64gb-1721738787310	Xanh dương / 64GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
27	\N	5	0	10990000	IG11I2WLN-xanh-duong-256gb-1721738787310	Xanh dương / 256GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
28	\N	6	0	8790000	IG11I2WLN-bac-64gb-1721738787310	Bạc / 64GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
29	\N	7	0	10990000	IG11I2WLN-bac-256gb-1721738787310	Bạc / 256GB	2024-07-23 12:47:42.912	2024-07-23 12:47:42.912	1	t	12	\N	0	0
38	\N	0	0	0	IG11I2LLN-hong-64gb-1721739426107	Hồng / 64GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
39	\N	1	0	0	IG11I2LLN-hong-256gb-1721739426107	Hồng / 256GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
40	\N	2	0	0	IG11I2LLN-vang-64gb-1721739426107	Vàng / 64GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
41	\N	3	0	0	IG11I2LLN-vang-256gb-1721739426107	Vàng / 256GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
42	\N	4	0	0	IG11I2LLN-xanh-duong-64gb-1721739426107	Xanh dương / 64GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
43	\N	5	0	0	IG11I2LLN-xanh-duong-256gb-1721739426107	Xanh dương / 256GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
44	\N	6	0	0	IG11I2LLN-bac-64gb-1721739426107	Bạc / 64GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
45	\N	7	0	0	IG11I2LLN-bac-256gb-1721739426107	Bạc / 256GB	2024-07-23 12:57:37.7	2024-07-23 12:57:37.7	1	t	14	\N	0	0
46	\N	0	0	6990000	IG91I2WNS-xam-64gb-1721739939035	Xám / 64GB	2024-07-23 13:10:23.652	2024-07-23 13:10:23.652	1	t	15	\N	0	0
47	\N	1	0	9990000	IG91I2WNS-xam-256gb-1721739939035	Xám / 256GB	2024-07-23 13:10:23.652	2024-07-23 13:10:23.652	1	t	15	\N	0	0
48	\N	2	0	6990000	IG91I2WNS-bac-64gb-1721739939035	Bạc / 64GB	2024-07-23 13:10:23.652	2024-07-23 13:10:23.652	1	t	15	\N	0	0
49	\N	3	0	9989997	IG91I2WNS-bac-256gb-1721739939035	Bạc / 256GB	2024-07-23 13:10:23.652	2024-07-23 13:10:23.652	1	t	15	\N	0	0
50	\N	0	0	0	IG91I2LNS-xam-64gb-1721740336537	Xám / 64GB	2024-07-23 13:12:58.852	2024-07-23 13:12:58.852	1	t	16	\N	0	0
51	\N	1	0	0	IG91I2LNS-xam-256gb-1721740336537	Xám / 256GB	2024-07-23 13:12:58.852	2024-07-23 13:12:58.852	1	t	16	\N	0	0
52	\N	2	0	0	IG91I2LNS-bac-64gb-1721740336537	Bạc / 64GB	2024-07-23 13:12:58.852	2024-07-23 13:12:58.852	1	t	16	\N	0	0
53	\N	3	0	0	IG91I2LNS-bac-256gb-1721740336537	Bạc / 256GB	2024-07-23 13:12:58.852	2024-07-23 13:12:58.852	1	t	16	\N	0	0
54	\N	0	0	5790000	IG91I2WLN-xam-64gb-1721740605956	Xám / 64GB	2024-07-23 13:17:33.448	2024-07-23 13:17:33.448	1	t	17	\N	0	0
55	\N	1	0	7990000	IG91I2WLN-xam-256gb-1721740605956	Xám / 256GB	2024-07-23 13:17:33.448	2024-07-23 13:17:33.448	1	t	17	\N	0	0
56	\N	2	0	5790000	IG91I2WLN-bac-64gb-1721740605956	Bạc / 64GB	2024-07-23 13:17:33.448	2024-07-23 13:17:33.448	1	t	17	\N	0	0
57	\N	3	0	7990000	IG91I2WLN-bac-256gb-1721740605956	Bạc / 256GB	2024-07-23 13:17:33.448	2024-07-23 13:17:33.448	1	t	17	\N	0	0
58	\N	0	0	0	IG91I2LLN-xam-64gb-1721740757756	Xám / 64GB	2024-07-23 13:19:56.822	2024-07-23 13:19:56.822	1	t	18	\N	0	0
59	\N	1	0	0	IG91I2LLN-xam-256gb-1721740757756	Xám / 256GB	2024-07-23 13:19:56.822	2024-07-23 13:19:56.822	1	t	18	\N	0	0
60	\N	2	0	0	IG91I2LLN-bac-64gb-1721740757756	Bạc / 64GB	2024-07-23 13:19:56.822	2024-07-23 13:19:56.822	1	t	18	\N	0	0
61	\N	3	0	0	IG91I2LLN-bac-256gb-1721740757756	Bạc / 256GB	2024-07-23 13:19:56.822	2024-07-23 13:19:56.822	1	t	18	\N	0	0
62	\N	0	0	12990000	IA51I2WNS-hong-64gb-1721741862164	Hồng / 64GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
63	\N	1	0	16990000	IA51I2WNS-hong-256gb-1721741862164	Hồng / 256GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
64	\N	2	0	12990000	IA51I2WNS-tim-64gb-1721741862164	Tím / 64GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
65	\N	3	0	16990000	IA51I2WNS-tim-256gb-1721741862164	Tím / 256GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
66	\N	4	0	12990000	IA51I2WNS-trang-vang-64gb-1721741862164	Trắng vàng / 64GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
67	\N	5	0	16990000	IA51I2WNS-trang-vang-256gb-1721741862164	Trắng vàng / 256GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
68	\N	6	0	12990000	IA51I2WNS-xanh-duong-64gb-1721741862165	Xanh dương / 64GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
69	\N	7	0	16990000	IA51I2WNS-xanh-duong-256gb-1721741862165	Xanh dương / 256GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
70	\N	8	0	12990000	IA51I2WNS-xam-64gb-1721741862165	Xám / 64GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
71	\N	9	0	16990000	IA51I2WNS-xam-256gb-1721741862165	Xám / 256GB	2024-07-23 13:41:15.253	2024-07-23 13:41:15.253	1	t	19	\N	0	0
72	\N	0	0	15990000	IA51I2LNS-hong-64gb-1721742349113	Hồng / 64GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
73	\N	1	0	0	IA51I2LNS-hong-256gb-1721742349113	Hồng / 256GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
74	\N	2	0	15990000	IA51I2LNS-tim-64gb-1721742349113	Tím / 64GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
75	\N	3	0	0	IA51I2LNS-tim-256gb-1721742349113	Tím / 256GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
76	\N	4	0	15990000	IA51I2LNS-trang-vang-64gb-1721742349113	Trắng vàng / 64GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
77	\N	5	0	0	IA51I2LNS-trang-vang-256gb-1721742349113	Trắng vàng / 256GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
78	\N	6	0	15990000	IA51I2LNS-xanh-duong-64gb-1721742349113	Xanh dương / 64GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
79	\N	7	0	0	IA51I2LNS-xanh-duong-256gb-1721742349113	Xanh dương / 256GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
80	\N	8	0	15990000	IA51I2LNS-xam-64gb-1721742349113	Xám / 64GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
81	\N	9	0	0	IA51I2LNS-xam-256gb-1721742349113	Xám / 256GB	2024-07-23 13:47:54.757	2024-07-23 13:47:54.757	1	t	20	\N	0	0
82	\N	0	0	11490000	IA51I2WLN-hong-64gb-1721742598551	Hồng / 64GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
83	\N	1	0	14490000	IA51I2WLN-hong-256gb-1721742598551	Hồng / 256GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
84	\N	2	0	11490000	IA51I2WLN-tim-64gb-1721742598551	Tím / 64GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
85	\N	3	0	14490000	IA51I2WLN-tim-256gb-1721742598551	Tím / 256GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
86	\N	4	0	11490000	IA51I2WLN-trang-vang-64gb-1721742598551	Trắng vàng / 64GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
87	\N	5	0	14490000	IA51I2WLN-trang-vang-256gb-1721742598551	Trắng vàng / 256GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
88	\N	6	0	11490000	IA51I2WLN-xanh-duong-64gb-1721742598551	Xanh dương / 64GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
89	\N	7	0	14490000	IA51I2WLN-xanh-duong-256gb-1721742598552	Xanh dương / 256GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
90	\N	8	0	11490000	IA51I2WLN-xam-64gb-1721742598552	Xám / 64GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
91	\N	9	0	14490000	IA51I2WLN-xam-256gb-1721742598552	Xám / 256GB	2024-07-23 13:55:12.212	2024-07-23 13:55:12.212	1	t	21	\N	0	0
92	\N	0	0	12990000	IA51I2LLN-hong-64gb-1721743006943	Hồng / 64GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
93	\N	1	0	16490000	IA51I2LLN-hong-256gb-1721743006943	Hồng / 256GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
94	\N	2	0	12990000	IA51I2LLN-tim-64gb-1721743006943	Tím / 64GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
95	\N	3	0	16490000	IA51I2LLN-tim-256gb-1721743006943	Tím / 256GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
96	\N	4	0	12990000	IA51I2LLN-trang-vang-64gb-1721743006943	Trắng vàng / 64GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
97	\N	5	0	16490000	IA51I2LLN-trang-vang-256gb-1721743006943	Trắng vàng / 256GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
98	\N	6	0	12990000	IA51I2LLN-xanh-duong-64gb-1721743006943	Xanh dương / 64GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
99	\N	7	0	16490000	IA51I2LLN-xanh-duong-256gb-1721743006943	Xanh dương / 256GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
100	\N	8	0	12990000	IA51I2LLN-xam-64gb-1721743006943	Xám / 64GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
101	\N	9	0	16490000	IA51I2LLN-xam-256gb-1721743006943	Xám / 256GB	2024-07-23 13:57:37.347	2024-07-23 13:57:37.347	1	t	22	\N	0	0
102	\N	0	0	11490000	IM6WNS-trang-vang-64gb-1721743329908	Trắng vàng / 64GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
103	\N	1	0	15990000	IM6WNS-trang-vang-256gb-1721743329908	Trắng vàng / 256GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
104	\N	2	0	11490000	IM6WNS-tim-64gb-1721743329908	Tím / 64GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
105	\N	3	0	15990000	IM6WNS-tim-256gb-1721743329908	Tím / 256GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
106	\N	4	0	11490000	IM6WNS-xam-64gb-1721743329908	Xám / 64GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
107	\N	5	0	15990000	IM6WNS-xam-256gb-1721743329908	Xám / 256GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
108	\N	6	0	11490000	IM6WNS-hong-64gb-1721743329908	Hồng / 64GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
109	\N	7	0	15990000	IM6WNS-hong-256gb-1721743329908	Hồng / 256GB	2024-07-23 14:06:23.524	2024-07-23 14:06:23.524	1	t	23	\N	0	0
110	\N	0	0	14990000	IM6LNS-trang-vang-64gb-1721743679620	Trắng vàng / 64GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
111	\N	1	0	0	IM6LNS-trang-vang-256gb-1721743679620	Trắng vàng / 256GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
112	\N	2	0	14990000	IM6LNS-tim-64gb-1721743679620	Tím / 64GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
113	\N	3	0	0	IM6LNS-tim-256gb-1721743679620	Tím / 256GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
114	\N	4	0	14990000	IM6LNS-xam-64gb-1721743679620	Xám / 64GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
115	\N	5	0	0	IM6LNS-xam-256gb-1721743679620	Xám / 256GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
116	\N	6	0	14989999	IM6LNS-hong-64gb-1721743679620	Hồng / 64GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
117	\N	7	0	0	IM6LNS-hong-256gb-1721743679620	Hồng / 256GB	2024-07-23 14:09:09.519	2024-07-23 14:09:09.519	1	t	24	\N	0	0
118	\N	0	0	9490000	IM6WLN-trang-vang-64gb-1721743884148	Trắng vàng / 64GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
119	\N	1	0	11990000	IM6WLN-trang-vang-256gb-1721743884148	Trắng vàng / 256GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
120	\N	2	0	9490000	IM6WLN-tim-64gb-1721743884148	Tím / 64GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
121	\N	3	0	11990000	IM6WLN-tim-256gb-1721743884148	Tím / 256GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
122	\N	4	0	9490000	IM6WLN-xam-64gb-1721743884148	Xám / 64GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
123	\N	5	0	11990000	IM6WLN-xam-256gb-1721743884148	Xám / 256GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
124	\N	6	0	9490000	IM6WLN-hong-64gb-1721743884148	Hồng / 64GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
125	\N	7	0	11990000	IM6WLN-hong-256gb-1721743884148	Hồng / 256GB	2024-07-23 14:12:40.401	2024-07-23 14:12:40.401	1	t	25	\N	0	0
126	\N	0	0	11490000	IM6LLN-trang-vang-64gb-1721744033191	Trắng vàng / 64GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
127	\N	1	0	0	IM6LLN-trang-vang-256gb-1721744033191	Trắng vàng / 256GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
128	\N	2	0	11490000	IM6LLN-tim-64gb-1721744033191	Tím / 64GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
129	\N	3	0	0	IM6LLN-tim-256gb-1721744033191	Tím / 256GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
130	\N	4	0	11490000	IM6LLN-xam-64gb-1721744033191	Xám / 64GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
131	\N	5	0	0	IM6LLN-xam-256gb-1721744033191	Xám / 256GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
132	\N	6	0	11490000	IM6LLN-hong-64gb-1721744033191	Hồng / 64GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
133	\N	7	0	0	IM6LLN-hong-256gb-1721744033191	Hồng / 256GB	2024-07-23 14:14:48.972	2024-07-23 14:14:48.972	1	t	26	\N	0	0
134	\N	0	0	10990000	IP1I2WLN-xam-64gb-1721744330711	Xám / 64GB	2024-07-23 14:22:25.641	2024-07-23 14:22:25.641	1	t	27	\N	0	0
135	\N	1	0	11990000	IP1I2WLN-xam-256gb-1721744330711	Xám / 256GB	2024-07-23 14:22:25.641	2024-07-23 14:22:25.641	1	t	27	\N	0	0
136	\N	2	0	10990000	IP1I2WLN-bac-64gb-1721744330711	Bạc / 64GB	2024-07-23 14:22:25.641	2024-07-23 14:22:25.641	1	t	27	\N	0	0
137	\N	3	0	11990000	IP1I2WLN-bac-256gb-1721744330711	Bạc / 256GB	2024-07-23 14:22:25.641	2024-07-23 14:22:25.641	1	t	27	\N	0	0
138	\N	0	0	10990000	IP1I2LLN-xam-64gb-1721744640925	Xám / 64GB	2024-07-23 14:24:51.539	2024-07-23 14:24:51.539	1	t	28	\N	0	0
139	\N	1	0	11990000	IP1I2LLN-xam-256gb-1721744640925	Xám / 256GB	2024-07-23 14:24:51.539	2024-07-23 14:24:51.539	1	t	28	\N	0	0
140	\N	2	0	10990000	IP1I2LLN-bac-64gb-1721744640925	Bạc / 64GB	2024-07-23 14:24:51.539	2024-07-23 14:24:51.539	1	t	28	\N	0	0
141	\N	3	0	11990000	IP1I2LLN-bac-256gb-1721744640925	Bạc / 256GB	2024-07-23 14:24:51.539	2024-07-23 14:24:51.539	1	t	28	\N	0	0
142	\N	0	0	11490000	IP1I2WLN-xam-64gb-1721835899019	Xám / 64GB	2024-07-24 15:45:35.01	2024-07-24 15:45:35.01	1	t	29	\N	0	0
143	\N	1	0	12990000	IP1I2WLN-xam-256gb-1721835899019	Xám / 256GB	2024-07-24 15:45:35.01	2024-07-24 15:45:35.01	1	t	29	\N	0	0
144	\N	2	0	11490000	IP1I2WLN-bac-64gb-1721835899019	Bạc / 64GB	2024-07-24 15:45:35.01	2024-07-24 15:45:35.01	1	t	29	\N	0	0
145	\N	3	0	12990000	IP1I2WLN-bac-256gb-1721835899019	Bạc / 256GB	2024-07-24 15:45:35.01	2024-07-24 15:45:35.01	1	t	29	\N	0	0
146	\N	0	0	12190000	IP1I2LLN-xam-64gb-1721836007689	Xám / 64GB	2024-07-24 15:47:03.556	2024-07-24 15:47:03.556	1	t	30	\N	0	0
147	\N	1	0	13490000	IP1I2LLN-xam-256gb-1721836007689	Xám / 256GB	2024-07-24 15:47:03.556	2024-07-24 15:47:03.556	1	t	30	\N	0	0
148	\N	2	0	12190000	IP1I2LLN-bac-64gb-1721836007689	Bạc / 64GB	2024-07-24 15:47:03.556	2024-07-24 15:47:03.556	1	t	30	\N	0	0
149	\N	3	0	13490000	IP1I2LLN-bac-256gb-1721836007689	Bạc / 256GB	2024-07-24 15:47:03.556	2024-07-24 15:47:03.556	1	t	30	\N	0	0
150	\N	0	17290000	15290000	IP-bac-128gb-1721836971716	Bạc / 128GB	2024-07-24 16:06:26.654	2024-07-24 16:06:26.654	1	t	31	\N	0	0
151	\N	0	0	13490000	IP-bac-64gb-1721837541649	Bạc / 64GB	2024-07-24 16:15:21.978	2024-07-24 16:13:21.133	1	t	32	\N	0	0
153	\N	2	0	13490000	IP-xam-64gb-1721837541649	Xám / 64GB	2024-07-24 16:15:26.175	2024-07-24 16:13:21.133	1	t	32	\N	0	0
152	\N	1	0	14490000	IP-bac-256gb-1721837541649	Bạc / 256GB	2024-07-24 16:15:33.608	2024-07-24 16:13:21.133	1	t	32	\N	0	0
154	\N	3	0	14490000	IP-xam-256gb-1721837541650	Xám / 256GB	2024-07-24 16:15:38.223	2024-07-24 16:13:21.133	1	t	32	\N	0	0
6	\N	0	0	9390000	IG11I2W-hong-64gb-1721669186011	Hồng / 64GB	2024-07-27 09:54:56.006	2024-07-22 17:52:19.795	1	t	10	7	0	0
156	\N	0	0	14490000	IP1531722667215306	Bạc / 128GB	2024-08-03 07:50:34.676	2024-08-03 07:50:34.676	1	t	34	\N	0	0
157	\N	1	0	15390000	IP1541722667215306	Bạc / 256GB	2024-08-03 07:50:34.676	2024-08-03 07:50:34.676	1	t	34	\N	0	0
158	\N	2	0	14490000	IP1431722667215306	Xám / 128GB	2024-08-03 07:50:34.676	2024-08-03 07:50:34.676	1	t	34	\N	0	0
159	\N	3	0	15390000	IP1441722667215306	Xám / 256GB	2024-08-03 07:50:34.676	2024-08-03 07:50:34.676	1	t	34	\N	0	0
161	\N	1	0	15990000	IP1541722691602518	Bạc / 256GB	2024-08-03 13:38:11.828	2024-08-03 13:31:05.908	1	t	40	85	0	0
162	\N	2	0	0	IP1551722691602518	Bạc / 512GB	2024-08-03 13:38:19.84	2024-08-03 13:31:05.908	1	t	40	85	0	0
163	\N	3	0	14990000	IP1431722691602518	Xám / 128GB	2024-08-03 13:38:27.056	2024-08-03 13:31:05.908	1	t	40	84	0	0
164	\N	4	0	15990000	IP1441722691602518	Xám / 256GB	2024-08-03 13:38:31.719	2024-08-03 13:31:05.908	1	t	40	84	0	0
166	\N	0	0	15990000	IP1531722692250245	Bạc / 128GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
167	\N	1	0	16490000	IP1541722692250245	Bạc / 256GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
168	\N	2	0	0	IP1551722692250245	Bạc / 512GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
169	\N	3	0	15990000	IP1431722692250245	Xám / 128GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
170	\N	4	0	16490000	IP1441722692250245	Xám / 256GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
171	\N	5	0	0	IP1451722692250245	Xám / 512GB	2024-08-03 13:37:46.196	2024-08-03 13:37:46.196	1	t	41	\N	0	0
160	\N	0	0	14990000	IP1531722691602518	Bạc / 128GB	2024-08-03 13:38:05.908	2024-08-03 13:31:05.908	1	t	40	85	0	0
165	\N	5	0	0	IP1451722691602518	Xám / 512GB	2024-08-03 13:38:36.184	2024-08-03 13:31:05.908	1	t	40	84	0	0
172	\N	0	17790000	16790000	IP1531722692586205	Bạc / 128GB	2024-08-03 13:43:27.35	2024-08-03 13:43:27.35	1	t	42	\N	0	0
173	\N	1	17790000	16790000	IP1431722692586205	Xám / 128GB	2024-08-03 13:43:27.35	2024-08-03 13:43:27.35	1	t	42	\N	0	0
174	\N	0	0	15490000	IP1531722692875652	Bạc / 128GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
175	\N	1	0	16490000	IP1541722692875652	Bạc / 256GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
176	\N	2	0	17990000	IP1551722692875652	Bạc / 512GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
177	\N	3	0	19490000	IP1561722692875652	Bạc / 1TB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
178	\N	4	0	15490000	IP1431722692875652	Xám / 128GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
179	\N	5	0	16490000	IP1441722692875652	Xám / 256GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
180	\N	6	0	17990000	IP1451722692875652	Xám / 512GB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
181	\N	7	0	19490000	IP1461722692875652	Xám / 1TB	2024-08-03 13:48:23.426	2024-08-03 13:48:23.426	1	t	43	\N	0	0
182	\N	0	0	16490000	IP1531722693025302	Bạc / 128GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
183	\N	1	0	17990000	IP1541722693025302	Bạc / 256GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
184	\N	2	0	18990000	IP1551722693025302	Bạc / 512GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
185	\N	3	0	20490000	IP1561722693025302	Bạc / 1TB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
186	\N	4	0	16490000	IP1431722693025302	Xám / 128GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
187	\N	5	0	17990000	IP1441722693025302	Xám / 256GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
188	\N	6	0	18990000	IP1451722693025302	Xám / 512GB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
189	\N	7	0	20490000	IP1461722693025302	Xám / 1TB	2024-08-03 13:51:01.782	2024-08-03 13:51:01.782	1	t	44	\N	0	0
190	\N	0	21990000	19990000	IP1551722693177839	Bạc / 512GB	2024-08-03 13:53:18.944	2024-08-03 13:53:18.944	1	t	45	\N	0	0
191	\N	1	21990000	19990000	IP1451722693177839	Xám / 512GB	2024-08-03 13:53:18.944	2024-08-03 13:53:18.944	1	t	45	\N	0	0
200	\N	0	0	17990000	IP1531722693549060	Bạc / 128GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
201	\N	1	0	18990000	IP1541722693549060	Bạc / 256GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
202	\N	2	0	20490000	IP1551722693549060	Bạc / 512GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
203	\N	3	0	21990000	IP1561722693549060	Bạc / 1TB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
204	\N	4	0	17990000	IP1431722693549060	Xám / 128GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
205	\N	5	0	18990000	IP1441722693549060	Xám / 256GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
206	\N	6	0	20490000	IP1451722693549060	Xám / 512GB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
207	\N	7	0	21990000	IP1461722693549060	Xám / 1TB	2024-08-03 14:00:06.076	2024-08-03 14:00:06.076	1	t	47	\N	0	0
208	\N	0	0	18990000	IP1531722693656460	Bạc / 128GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
209	\N	1	0	19790000	IP1541722693656460	Bạc / 256GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
210	\N	2	0	21490000	IP1551722693656460	Bạc / 512GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
211	\N	3	0	23490000	IP1561722693656460	Bạc / 1TB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
212	\N	4	0	18990000	IP1431722693656460	Xám / 128GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
213	\N	5	0	19790000	IP1441722693656460	Xám / 256GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
214	\N	6	0	21490000	IP1451722693656460	Xám / 512GB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
215	\N	7	0	23490000	IP1461722693656460	Xám / 1TB	2024-08-03 14:01:29.994	2024-08-03 14:01:29.994	1	t	48	\N	0	0
216	\N	0	0	20490000	IP1531722693996185	Bạc / 128GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
217	\N	1	0	22490000	IP1541722693996185	Bạc / 256GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
218	\N	2	0	0	IP1551722693996185	Bạc / 512GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
219	\N	3	0	20490000	IP1431722693996185	Xám / 128GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
220	\N	4	0	22490000	IP1441722693996185	Xám / 256GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
221	\N	5	0	0	IP1451722693996185	Xám / 512GB	2024-08-03 14:06:52.143	2024-08-03 14:06:52.143	1	t	49	\N	0	0
222	\N	0	0	22990000	IP1531722694078815	Bạc / 128GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
223	\N	1	0	26490000	IP1541722694078815	Bạc / 256GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
224	\N	2	0	0	IP1551722694078815	Bạc / 512GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
225	\N	3	0	22990000	IP1431722694078815	Xám / 128GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
226	\N	4	0	26490000	IP1441722694078815	Xám / 256GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
227	\N	5	0	0	IP1451722694078815	Xám / 512GB	2024-08-03 14:08:18.096	2024-08-03 14:08:18.096	1	t	50	\N	0	0
228	\N	0	0	17290000	IP1531722694199835	Bạc / 128GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
229	\N	1	0	18990000	IP1541722694199835	Bạc / 256GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
230	\N	2	0	20490000	IP1551722694199835	Bạc / 512GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
231	\N	3	0	21990000	IP1561722694199835	Bạc / 1TB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
232	\N	4	0	0	IP1571722694199835	Bạc / 2TB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
233	\N	5	0	17290000	IP1431722694199835	Xám / 128GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
234	\N	6	0	18990000	IP1441722694199835	Xám / 256GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
235	\N	7	0	20490000	IP1451722694199835	Xám / 512GB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
236	\N	8	0	21990000	IP1461722694199835	Xám / 1TB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
237	\N	9	0	0	IP1471722694199835	Xám / 2TB	2024-08-03 14:10:26.464	2024-08-03 14:10:26.464	1	t	51	\N	0	0
238	\N	0	0	18990000	IP1531722694284282	Bạc / 128GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
239	\N	1	0	20990000	IP1541722694284282	Bạc / 256GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
240	\N	2	0	22490000	IP1551722694284282	Bạc / 512GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
241	\N	3	0	23990000	IP1561722694284282	Bạc / 1TB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
242	\N	4	0	0	IP1571722694284282	Bạc / 2TB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
243	\N	5	0	18990000	IP1431722694284282	Xám / 128GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
244	\N	6	0	20990000	IP1441722694284282	Xám / 256GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
245	\N	7	0	22490000	IP1451722694284282	Xám / 512GB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
246	\N	8	0	23990000	IP1461722694284282	Xám / 1TB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
247	\N	9	0	0	IP1471722694284282	Xám / 2TB	2024-08-03 14:12:06.692	2024-08-03 14:12:06.692	1	t	52	\N	0	0
248	\N	0	0	24990000	IP1531722694683357	Bạc / 128GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
249	\N	1	0	27990000	IP1541722694683357	Bạc / 256GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
250	\N	2	0	31990000	IP1551722694683357	Bạc / 512GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
251	\N	3	0	0	IP1561722694683357	Bạc / 1TB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
252	\N	4	0	0	IP1571722694683357	Bạc / 2TB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
253	\N	5	0	24990000	IP1431722694683357	Xám / 128GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
254	\N	6	0	27990000	IP1441722694683357	Xám / 256GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
255	\N	7	0	31990000	IP1451722694683357	Xám / 512GB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
256	\N	8	0	0	IP1461722694683357	Xám / 1TB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
257	\N	9	0	0	IP1471722694683357	Xám / 2TB	2024-08-03 14:18:27.566	2024-08-03 14:18:27.566	1	t	53	\N	0	0
258	\N	0	0	26490000	IP1531722695207879	Bạc / 128GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
259	\N	1	0	29490000	IP1541722695207879	Bạc / 256GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
260	\N	2	0	34990000	IP1551722695207879	Bạc / 512GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
261	\N	3	0	0	IP1561722695207879	Bạc / 1TB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
262	\N	4	0	0	IP1571722695207879	Bạc / 2TB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
263	\N	5	0	26490000	IP1431722695207879	Xám / 128GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
264	\N	6	0	29490000	IP1441722695207879	Xám / 256GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
265	\N	7	0	34990000	IP1451722695207879	Xám / 512GB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
266	\N	8	0	0	IP1461722695207879	Xám / 1TB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
267	\N	9	0	0	IP1471722695207879	Xám / 2TB	2024-08-03 14:27:10.967	2024-08-03 14:27:10.967	1	t	54	\N	0	0
268	\N	0	0	20490000	IP1531722695304280	Bạc / 128GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
269	\N	1	0	22490000	IP1541722695304280	Bạc / 256GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
270	\N	2	0	24490000	IP1551722695304280	Bạc / 512GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
271	\N	3	0	0	IP1561722695304280	Bạc / 1TB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
272	\N	4	0	0	IP1571722695304280	Bạc / 2TB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
273	\N	5	0	20490000	IP1431722695304280	Xám / 128GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
274	\N	6	0	22490000	IP1441722695304280	Xám / 256GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
275	\N	7	0	24490000	IP1451722695304280	Xám / 512GB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
276	\N	8	0	0	IP1461722695304280	Xám / 1TB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
277	\N	9	0	0	IP1471722695304280	Xám / 2TB	2024-08-03 14:28:45.441	2024-08-03 14:28:45.441	1	t	55	\N	0	0
278	\N	0	0	21990000	IP1531722695371560	Bạc / 128GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
279	\N	1	0	24490000	IP1541722695371560	Bạc / 256GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
280	\N	2	0	26490000	IP1551722695371560	Bạc / 512GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
281	\N	3	0	0	IP1561722695371560	Bạc / 1TB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
282	\N	4	0	0	IP1571722695371560	Bạc / 2TB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
283	\N	5	0	21990000	IP1431722695371560	Xám / 128GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
284	\N	6	0	24490000	IP1441722695371560	Xám / 256GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
285	\N	7	0	26490000	IP1451722695371560	Xám / 512GB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
286	\N	8	0	0	IP1461722695371560	Xám / 1TB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
287	\N	9	0	0	IP1471722695371560	Xám / 2TB	2024-08-03 14:29:52.204	2024-08-03 14:29:52.204	1	t	56	\N	0	0
288	\N	0	0	25990000	IP841722695558356	Đen / 256GB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
289	\N	1	0	30990000	IP851722695558356	Đen / 512GB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
290	\N	2	0	0	IP861722695558356	Đen / 1TB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
291	\N	3	0	0	IP871722695558356	Đen / 2TB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
292	\N	4	0	25990000	IP1541722695558356	Bạc / 256GB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
293	\N	5	0	30990000	IP1551722695558356	Bạc / 512GB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
294	\N	6	0	0	IP1561722695558356	Bạc / 1TB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
295	\N	7	0	0	IP1571722695558356	Bạc / 2TB	2024-08-03 14:35:12.132	2024-08-03 14:35:12.132	1	t	57	\N	0	0
296	\N	0	0	32990000	IP841722695829417	Đen / 256GB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
297	\N	1	0	37990000	IP851722695829417	Đen / 512GB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
298	\N	2	0	0	IP861722695829417	Đen / 1TB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
299	\N	3	0	0	IP871722695829417	Đen / 2TB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
300	\N	4	0	32990000	IP1541722695829417	Bạc / 256GB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
301	\N	5	0	37990000	IP1551722695829417	Bạc / 512GB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
302	\N	6	0	0	IP1561722695829417	Bạc / 1TB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
303	\N	7	0	0	IP1571722695829417	Bạc / 2TB	2024-08-03 14:37:49.873	2024-08-03 14:37:49.873	1	t	58	\N	0	0
304	\N	0	0	9490000	IP1421722696465091	Xám / 64GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
305	\N	1	0	11990000	IP1441722696465091	Xám / 256GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
306	\N	2	0	9490000	IP1221722696465091	Xanh lá / 64GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
307	\N	3	0	11990000	IP1241722696465091	Xanh lá / 256GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
308	\N	4	0	9490000	IP1121722696465091	Xanh dương / 64GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
309	\N	5	0	11990000	IP1141722696465091	Xanh dương / 256GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
310	\N	6	0	9490000	IP2121722696465091	Vàng hồng / 64GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
311	\N	7	0	11990000	IP2141722696465091	Vàng hồng / 256GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
312	\N	8	0	9490000	IP1521722696465091	Bạc / 64GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
313	\N	9	0	11990000	IP1541722696465091	Bạc / 256GB	2024-08-03 14:51:15.44	2024-08-03 14:51:15.44	1	t	59	\N	0	0
314	\N	0	0	10490000	IP1421722696729706	Xám / 64GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
315	\N	1	0	12490000	IP1441722696729706	Xám / 256GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
316	\N	2	0	10490000	IP1221722696729706	Xanh lá / 64GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
317	\N	3	0	12490000	IP1241722696729706	Xanh lá / 256GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
318	\N	4	0	10490000	IP1121722696729706	Xanh dương / 64GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
319	\N	5	0	12490000	IP1141722696729706	Xanh dương / 256GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
320	\N	6	0	10490000	IP2121722696729706	Vàng hồng / 64GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
321	\N	7	0	12490000	IP2141722696729706	Vàng hồng / 256GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
322	\N	8	0	10490000	IP1521722696729706	Bạc / 64GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
323	\N	9	0	12490000	IP1541722696729706	Bạc / 256GB	2024-08-03 14:57:19.45	2024-08-03 14:57:19.45	1	t	60	\N	0	0
324	\N	0	0	16490000	IP1431722697775516	Xám / 128GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
325	\N	1	0	18990000	IP1441722697775516	Xám / 256GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
326	\N	2	0	23990000	IP1451722697775516	Xám / 512GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
327	\N	3	0	0	IP1461722697775516	Xám / 1TB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
328	\N	4	0	16490000	IP1131722697775516	Xanh dương / 128GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
329	\N	5	0	18990000	IP1141722697775516	Xanh dương / 256GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
330	\N	6	0	23990000	IP1151722697775516	Xanh dương / 512GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
331	\N	7	0	0	IP1161722697775516	Xanh dương / 1TB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
332	\N	8	0	16490000	IP1731722697775516	Trắng vàng / 128GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
333	\N	9	0	18989999	IP1741722697775516	Trắng vàng / 256GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
334	\N	10	0	23990000	IP1751722697775516	Trắng vàng / 512GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
335	\N	11	0	0	IP1761722697775516	Trắng vàng / 1TB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
336	\N	12	0	16490000	IP1831722697775516	Tím / 128GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
337	\N	13	0	18990000	IP1841722697775516	Tím / 256GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
338	\N	14	0	23990000	IP1851722697775516	Tím / 512GB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
339	\N	15	0	0	IP1861722697775516	Tím / 1TB	2024-08-03 15:12:20.917	2024-08-03 15:12:20.917	1	t	61	\N	0	0
340	\N	0	0	19990000	IP1431722698076305	Xám / 128GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
341	\N	1	0	23990000	IP1441722698076305	Xám / 256GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
342	\N	2	0	0	IP1451722698076305	Xám / 512GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
343	\N	3	0	0	IP1461722698076305	Xám / 1TB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
344	\N	4	0	19990000	IP1131722698076305	Xanh dương / 128GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
345	\N	5	0	23990000	IP1141722698076305	Xanh dương / 256GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
346	\N	6	0	0	IP1151722698076305	Xanh dương / 512GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
347	\N	7	0	0	IP1161722698076305	Xanh dương / 1TB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
348	\N	8	0	19990000	IP1731722698076305	Trắng vàng / 128GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
349	\N	9	0	23990000	IP1741722698076305	Trắng vàng / 256GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
350	\N	10	0	0	IP1751722698076306	Trắng vàng / 512GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
351	\N	11	0	0	IP1761722698076306	Trắng vàng / 1TB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
352	\N	12	0	19990000	IP1831722698076306	Tím / 128GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
353	\N	13	0	23990000	IP1841722698076306	Tím / 256GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
354	\N	14	0	0	IP1851722698076306	Tím / 512GB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
355	\N	15	0	0	IP1861722698076306	Tím / 1TB	2024-08-03 15:15:44.832	2024-08-03 15:15:44.832	1	t	62	\N	0	0
356	\N	0	0	20990000	IP1431722698290236	Xám / 128GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
357	\N	1	0	23990000	IP1441722698290236	Xám / 256GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
358	\N	2	0	28990000	IP1451722698290236	Xám / 512GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
359	\N	3	0	0	IP1461722698290236	Xám / 1TB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
360	\N	4	0	20990000	IP1131722698290236	Xanh dương / 128GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
361	\N	5	0	23989999	IP1141722698290236	Xanh dương / 256GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
362	\N	6	0	28990000	IP1151722698290236	Xanh dương / 512GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
363	\N	7	0	0	IP1161722698290236	Xanh dương / 1TB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
364	\N	8	0	20990000	IP1731722698290236	Trắng vàng / 128GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
365	\N	9	0	23990000	IP1741722698290236	Trắng vàng / 256GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
366	\N	10	0	28990000	IP1751722698290236	Trắng vàng / 512GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
367	\N	11	0	0	IP1761722698290236	Trắng vàng / 1TB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
368	\N	12	0	20990000	IP1831722698290236	Tím / 128GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
369	\N	13	0	23990000	IP1841722698290236	Tím / 256GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
370	\N	14	0	28990000	IP1851722698290236	Tím / 512GB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
371	\N	15	0	0	IP1861722698290236	Tím / 1TB	2024-08-03 15:20:25.228	2024-08-03 15:20:25.228	1	t	63	\N	0	0
372	\N	0	0	22990000	IP1431722698477199	Xám / 128GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
373	\N	1	0	24990000	IP1441722698477199	Xám / 256GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
374	\N	2	0	31990000	IP1451722698477199	Xám / 512GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
375	\N	3	0	0	IP1461722698477199	Xám / 1TB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
376	\N	4	0	22990000	IP1131722698477199	Xanh dương / 128GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
377	\N	5	0	24990000	IP1141722698477199	Xanh dương / 256GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
378	\N	6	0	31990000	IP1151722698477199	Xanh dương / 512GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
379	\N	7	0	0	IP1161722698477199	Xanh dương / 1TB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
380	\N	8	0	22990000	IP1731722698477199	Trắng vàng / 128GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
381	\N	9	0	24990000	IP1741722698477199	Trắng vàng / 256GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
382	\N	10	0	31990000	IP1751722698477199	Trắng vàng / 512GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
383	\N	11	0	0	IP1761722698477199	Trắng vàng / 1TB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
384	\N	12	0	22990000	IP1831722698477199	Tím / 128GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
385	\N	13	0	24990000	IP1841722698477199	Tím / 256GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
386	\N	14	0	31990000	IP1851722698477199	Tím / 512GB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
387	\N	15	0	0	IP1861722698477199	Tím / 1TB	2024-08-03 15:22:17.533	2024-08-03 15:22:17.533	1	t	64	\N	0	0
392	\N	0	0	5999000	IP92221722784047635	Trắng / 64GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
393	\N	1	0	6999000	IP93221722784047635	Trắng / 128GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
394	\N	2	0	5999000	IP132221722784047635	Đỏ / 64GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
395	\N	3	0	6999000	IP133221722784047635	Đỏ / 128GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
388	\N	0	0	5490000	IP1521722698693603	Bạc / 64GB	2024-08-07 18:45:07.459	2024-08-03 15:25:07.176	1	t	65	149	0	0
390	\N	2	0	5490000	IP1421722698693603	Xám / 64GB	2024-08-07 18:45:16.87	2024-08-03 15:25:07.176	1	t	65	147	0	0
391	\N	3	0	7490000	IP1441722698693603	Xám / 256GB	2024-08-07 18:45:20.455	2024-08-03 15:25:07.176	1	t	65	147	0	0
396	\N	4	0	5999000	IP82221722784047635	Đen / 64GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
397	\N	5	0	6999000	IP83221722784047635	Đen / 128GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
398	\N	6	0	5999000	IP112221722784047635	Xanh dương / 64GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
399	\N	7	0	6999000	IP113221722784047635	Xanh dương / 128GB / 99%	2024-08-04 15:09:05.899	2024-08-04 15:09:05.899	1	t	68	\N	0	0
400	\N	0	0	7599000	IP82221722784647734	Đen / 64GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
401	\N	1	0	8599000	IP83221722784647734	Đen / 128GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
402	\N	2	0	9599000	IP84221722784647734	Đen / 256GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
403	\N	3	0	7399000	IP132221722784647734	Đỏ / 64GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
404	\N	4	0	8399000	IP133221722784647734	Đỏ / 128GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
405	\N	5	0	9399000	IP134221722784647734	Đỏ / 256GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
406	\N	6	0	7799000	IP112221722784647734	Xanh dương / 64GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
407	\N	7	0	8799000	IP113221722784647734	Xanh dương / 128GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
408	\N	8	0	9799000	IP114221722784647734	Xanh dương / 256GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
409	\N	9	0	7799000	IP92221722784647734	Trắng / 64GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
410	\N	10	0	8799000	IP93221722784647734	Trắng / 128GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
411	\N	11	0	9799000	IP94221722784647734	Trắng / 256GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
412	\N	12	0	7799000	IP122221722784647734	Xanh lá / 64GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
413	\N	13	0	8799000	IP123221722784647734	Xanh lá / 128GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
414	\N	14	0	9799001	IP124221722784647734	Xanh lá / 256GB / 99%	2024-08-04 15:20:58.737	2024-08-04 15:20:58.737	1	t	69	\N	0	0
415	\N	0	0	9499000	IP83221722785282142	Đen / 128GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
416	\N	1	0	10499000	IP84221722785282142	Đen / 256GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
417	\N	2	0	9699000	IP113221722785282142	Xanh dương / 128GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
418	\N	3	0	10699000	IP114221722785282142	Xanh dương / 256GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
419	\N	4	0	9699000	IP93221722785282142	Trắng / 128GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
420	\N	5	0	10699000	IP94221722785282142	Trắng / 256GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
421	\N	6	0	9699000	IP103221722785282142	Vàng / 128GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
422	\N	7	0	10699000	IP104221722785282142	Vàng / 256GB / 99%	2024-08-04 15:29:06.659	2024-08-04 15:29:06.659	1	t	70	\N	0	0
423	\N	0	0	12199000	IP83221722785464105	Đen / 128GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
424	\N	1	0	13199000	IP84221722785464105	Đen / 256GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
425	\N	2	0	12199000	IP113221722785464105	Xanh dương / 128GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
426	\N	3	0	13199000	IP114221722785464105	Xanh dương / 256GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
427	\N	4	0	12399000	IP93221722785464105	Trắng / 128GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
428	\N	5	0	13399000	IP94221722785464105	Trắng / 256GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
429	\N	6	0	12399000	IP103221722785464105	Vàng / 128GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
430	\N	7	0	13399000	IP104221722785464105	Vàng / 256GB / 99%	2024-08-04 15:32:26.067	2024-08-04 15:32:26.067	1	t	71	\N	0	0
431	\N	0	0	15699000	IP83221722785790245	Đen / 128GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
432	\N	1	0	16699000	IP84221722785790245	Đen / 256GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
433	\N	2	0	15899000	IP113221722785790245	Xanh dương / 128GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
434	\N	3	0	16899000	IP114221722785790245	Xanh dương / 256GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
435	\N	4	0	15899000	IP93221722785790245	Trắng / 128GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
436	\N	5	0	16899000	IP94221722785790245	Trắng / 256GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
437	\N	6	0	15899000	IP103221722785790245	Vàng / 128GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
438	\N	7	0	16899000	IP104221722785790245	Vàng / 256GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
439	\N	8	0	15899000	IP123221722785790245	Xanh lá / 128GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
440	\N	9	0	16899000	IP124221722785790245	Xanh lá / 256GB / 99%	2024-08-04 15:37:19.376	2024-08-04 15:37:19.376	1	t	72	\N	0	0
441	\N	0	0	13399000	IP83221722785925712	Đen / 128GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
442	\N	1	0	14399000	IP84221722785925712	Đen / 256GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
443	\N	2	0	15399000	IP85221722785925712	Đen / 512GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
444	\N	3	0	13399000	IP113221722785925712	Xanh dương / 128GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
445	\N	4	0	14399000	IP114221722785925712	Xanh dương / 256GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
446	\N	5	0	15.399	IP115221722785925712	Xanh dương / 512GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
447	\N	6	0	13599000	IP93221722785925712	Trắng / 128GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
448	\N	7	0	14599000	IP94221722785925712	Trắng / 256GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
449	\N	8	0	15599000	IP95221722785925712	Trắng / 512GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
450	\N	9	0	13399000	IP103221722785925712	Vàng / 128GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
451	\N	10	0	14399000	IP104221722785925712	Vàng / 256GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
452	\N	11	0	15399000	IP105221722785925712	Vàng / 512GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
453	\N	12	0	13399000	IP123221722785925712	Xanh lá / 128GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
454	\N	13	0	14399000	IP124221722785925712	Xanh lá / 256GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
455	\N	14	0	15399000	IP125221722785925712	Xanh lá / 512GB / 99%	2024-08-04 15:40:28.89	2024-08-04 15:40:28.89	1	t	73	\N	0	0
456	\N	0	0	16999000	IP183221722786415921	Tím / 128GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
457	\N	1	0	18499000	IP184221722786415921	Tím / 256GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
458	\N	2	0	19999000	IP185221722786415921	Tím / 512GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
459	\N	3	0	17199000	IP93221722786415921	Trắng / 128GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
460	\N	4	0	18699000	IP94221722786415921	Trắng / 256GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
461	\N	5	0	20199000	IP95221722786415921	Trắng / 512GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
462	\N	6	0	16999000	IP143221722786415921	Xám / 128GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
463	\N	7	0	18499000	IP144221722786415921	Xám / 256GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
464	\N	8	0	19999000	IP145221722786415921	Xám / 512GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
465	\N	9	0	17199000	IP103221722786415921	Vàng / 128GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
466	\N	10	0	18699000	IP104221722786415921	Vàng / 256GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
467	\N	11	0	20199000	IP105221722786415921	Vàng / 512GB / 99%	2024-08-04 15:50:10.956	2024-08-04 15:50:10.956	1	t	74	\N	0	0
468	\N	0	0	12499000	IP133221722786793843	Đỏ / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
469	\N	1	0	12499000	IP143221722786793843	Xám / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
470	\N	2	0	12499000	IP103221722786793843	Vàng / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
471	\N	3	0	12699000	IP183221722786793843	Tím / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
472	\N	4	0	12699000	IP113221722786793843	Xanh dương / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
473	\N	5	0	12699000	IP93221722786793843	Trắng / 128GB / 99%	2024-08-04 15:54:18.283	2024-08-04 15:54:18.283	1	t	75	\N	0	0
474	\N	0	0	13499000	IP133221722787103091	Đỏ / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
475	\N	1	0	13499000	IP143221722787103091	Xám / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
476	\N	2	0	13499000	IP103221722787103091	Vàng / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
477	\N	3	0	13699000	IP183221722787103091	Tím / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
478	\N	4	0	13699000	IP113221722787103091	Xanh dương / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
479	\N	5	0	13699000	IP93221722787103091	Trắng / 128GB / 99%	2024-08-04 15:58:48.755	2024-08-04 15:58:48.755	1	t	76	\N	0	0
480	\N	0	0	19999000	IP143221722787250238	Xám / 128GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
481	\N	1	0	21299000	IP144221722787250238	Xám / 256GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
482	\N	2	0	22799000	IP145221722787250238	Xám / 512GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
483	\N	3	0	20499000	IP103221722787250238	Vàng / 128GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
484	\N	4	0	21699000	IP104221722787250238	Vàng / 256GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
485	\N	5	0	23199000	IP105221722787250238	Vàng / 512GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
486	\N	6	0	20199000	IP183221722787250238	Tím / 128GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
487	\N	7	0	21499000	IP184221722787250238	Tím / 256GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
488	\N	8	0	22999000	IP185221722787250238	Tím / 512GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
489	\N	9	0	20499000	IP93221722787250238	Trắng / 128GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
490	\N	10	0	21699000	IP94221722787250238	Trắng / 256GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
491	\N	11	0	23199000	IP95221722787250238	Trắng / 512GB / 99%	2024-08-04 16:02:42.691	2024-08-04 16:02:42.691	1	t	77	\N	0	0
492	\N	0	0	24899000	IP84221722787844488	Đen / 256GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
493	\N	1	0	27499000	IP85221722787844488	Đen / 512GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
494	\N	2	0	24899000	IP114221722787844488	Xanh dương / 256GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
495	\N	3	0	27499000	IP115221722787844489	Xanh dương / 512GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
496	\N	4	0	25899000	IP94221722787844489	Trắng / 256GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
497	\N	5	0	27999000	IP95221722787844489	Trắng / 512GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
498	\N	6	0	25899000	IP284221722787844489	Titan / 256GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
499	\N	7	0	27999000	IP285221722787844489	Titan / 512GB / 99%	2024-08-04 16:11:38.463	2024-08-04 16:11:38.463	1	t	78	\N	0	0
500	\N	0	0	20499000	IP83221722788103762	Đen / 128GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
501	\N	1	0	21999000	IP84221722788103762	Đen / 256GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
502	\N	2	0	22999000	IP85221722788103762	Đen / 512GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
503	\N	3	0	20499000	IP113221722788103762	Xanh dương / 128GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
504	\N	4	0	21999000	IP114221722788103762	Xanh dương / 256GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
505	\N	5	0	22998999	IP115221722788103762	Xanh dương / 512GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
506	\N	6	0	20999000	IP93221722788103762	Trắng / 128GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
507	\N	7	0	22499000	IP94221722788103762	Trắng / 256GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
508	\N	8	0	23499000	IP95221722788103762	Trắng / 512GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
509	\N	9	0	20999000	IP283221722788103762	Titan / 128GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
510	\N	10	0	22499000	IP284221722788103762	Titan / 256GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
511	\N	11	0	23499000	IP285221722788103762	Titan / 512GB / 99%	2024-08-04 16:16:13.892	2024-08-04 16:16:13.892	1	t	79	\N	0	0
512	\N	0	0	2690000	TA9201722788287541	Trắng / Lightning	2024-08-04 16:18:17.359	2024-08-04 16:18:17.359	1	t	80	\N	0	0
513	\N	0	0	3499000	SM81722788347525	Đen	2024-08-04 16:19:15.903	2024-08-04 16:19:15.903	1	t	81	\N	0	0
514	\N	0	0	3499000	SM81722788458842	Đen	2024-08-04 16:21:07.33	2024-08-04 16:21:07.33	1	t	82	\N	0	0
515	\N	0	0	9790000	BÀ91722788499312	Trắng	2024-08-04 16:21:53.987	2024-08-04 16:21:53.987	1	t	83	\N	0	0
517	\N	0	0	1699000	BÚ91722788747259	Trắng	2024-08-07 18:44:41.285	2024-08-04 16:26:06.029	1	t	85	203	0	0
516	\N	0	0	5550000	TA9191722788593965	Trắng / USB-C	2024-08-07 18:44:49.04	2024-08-04 16:24:49.258	1	t	84	202	0	0
389	\N	1	0	7490000	IP1541722698693603	Bạc / 256GB	2024-08-07 18:45:11.345	2024-08-03 15:25:07.176	1	t	65	149	0	0
\.


--
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Question" (id, content, product_id, customer_id, email, phone, full_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Rating; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Rating" (id, rate, content, images, product_id, customer_id, like_count, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Role" (id, name, code, description) FROM stdin;
\.


--
-- Data for Name: RolePermission; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."RolePermission" (id, "roleId", "permissionId", type) FROM stdin;
\.


--
-- Data for Name: Setting; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Setting" (id, key, value, description, "createdAt", "updatedAt", access_control) FROM stdin;
\.


--
-- Data for Name: SettingHistory; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."SettingHistory" (id, setting_id, "oldValue", "newValue", "updatedBy", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Shipping; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Shipping" (id, order_id, address, province, district, ward, country, address_full, ship_date, tracking_number, phone, fullname, status, tracking_url, carrier, estimated_delivery_date, shipping_method, delivery_status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: SpecificationsGroup; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."SpecificationsGroup" (id, name, type_id) FROM stdin;
1	Công nghệ màn hình	3
2	Độ phân giải	3
3	Kích thước màn hình	3
4	Camera sau	4
5	Camera trước	4
6	Pin	5
7	Công nghệ sạc	5
8	Cổng sạc	5
9	Công nghệ NFC	6
10	Wi-Fi	6
11	Bluetooth	6
12	Cảm biến vân tay	7
13	Các loại cảm biến	7
14	Thời điểm ra mắt	8
15	Kích thước	9
16	Trọng lượng	9
17	Chất liệu mặt lưng	9
18	Chất liệu khung viền	9
19	Dung lượng RAM	2
20	Khe cắm thẻ nhớ	2
21	Bộ nhớ trong	2
22	Chipset	1
23	Loại CPU	1
24	GPU	1
25	Hệ điều hành	1
\.


--
-- Data for Name: SpecificationsType; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."SpecificationsType" (id, name) FROM stdin;
1	Hệ điều hành & CPU
2	RAM
3	Màn hình
4	Camera
5	Pin, Sạc
6	Kết nối
7	Tiện ích
8	Thông tin chung
9	Thiết kế & Trọng lượng
\.


--
-- Data for Name: Store; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Store" (id, name, phone, url_map, ward_id, district_id, province_id, detail_address) FROM stdin;
\.


--
-- Data for Name: Tags; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."Tags" (id, name, slug, description, published) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."User" (id, name, password, username, avt, created_at, updated_at, meta_data, email) FROM stdin;
\.


--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."UserRole" (id, "userId", "roleId") FROM stdin;
\.


--
-- Data for Name: _AttributeValuesToProductAttributes; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."_AttributeValuesToProductAttributes" ("A", "B") FROM stdin;
10	1
11	1
15	1
16	1
2	2
4	2
10	3
11	3
15	3
16	3
2	4
4	4
10	5
11	5
15	5
16	5
2	6
4	6
10	7
11	7
15	7
16	7
2	8
4	8
14	9
15	9
2	10
4	10
14	11
15	11
2	12
4	12
14	13
15	13
2	14
4	14
14	15
15	15
2	16
4	16
11	17
14	17
16	17
17	17
18	17
2	18
4	18
11	19
14	19
16	19
17	19
18	19
2	20
4	20
11	21
14	21
16	21
17	21
18	21
2	22
4	22
11	23
14	23
16	23
17	23
18	23
2	24
4	24
14	25
16	25
17	25
18	25
2	26
4	26
14	27
16	27
17	27
18	27
2	28
4	28
14	29
16	29
17	29
18	29
2	30
4	30
14	31
16	31
17	31
18	31
2	32
4	32
14	33
15	33
2	34
4	34
14	35
15	35
2	36
4	36
14	37
15	37
2	38
4	38
14	39
15	39
2	40
4	40
15	41
3	42
14	43
15	43
2	44
4	44
3	46
4	46
14	47
15	47
3	48
4	48
5	48
14	49
15	49
3	50
4	50
5	50
14	51
15	51
3	52
14	53
15	53
3	54
4	54
5	54
6	54
14	55
15	55
3	56
4	56
5	56
6	56
14	57
15	57
5	58
14	59
15	59
3	62
4	62
5	62
6	62
14	63
15	63
3	64
4	64
5	64
6	64
14	65
15	65
3	66
4	66
5	66
14	67
15	67
3	68
4	68
5	68
14	69
15	69
3	70
4	70
5	70
6	70
7	70
14	71
15	71
3	72
4	72
5	72
6	72
7	72
14	73
15	73
3	74
4	74
5	74
6	74
7	74
14	75
15	75
3	76
4	76
5	76
6	76
7	76
14	77
15	77
3	78
4	78
5	78
6	78
7	78
14	79
15	79
3	80
4	80
5	80
6	80
7	80
14	81
15	81
4	82
5	82
6	82
7	82
8	83
15	83
4	84
5	84
6	84
7	84
8	85
15	85
2	86
4	86
11	87
12	87
14	87
15	87
21	87
2	88
4	88
11	89
12	89
14	89
15	89
21	89
3	90
4	90
5	90
6	90
11	91
14	91
17	91
18	91
3	92
4	92
5	92
6	92
11	93
14	93
17	93
18	93
3	94
4	94
5	94
6	94
11	95
14	95
17	95
18	95
3	96
4	96
5	96
6	96
11	97
14	97
17	97
18	97
2	98
4	98
14	99
15	99
22	100
2	101
3	101
8	102
9	102
11	102
13	102
22	103
2	104
3	104
4	104
8	105
9	105
11	105
12	105
13	105
22	106
3	107
4	107
8	108
9	108
10	108
11	108
22	109
3	110
4	110
8	111
9	111
10	111
11	111
22	112
3	113
4	113
8	114
9	114
10	114
11	114
12	114
22	115
3	116
4	116
5	116
8	117
9	117
10	117
11	117
12	117
22	118
3	119
4	119
5	119
9	120
10	120
14	120
18	120
22	121
3	122
9	123
10	123
11	123
13	123
14	123
18	123
22	124
3	125
9	126
10	126
11	126
13	126
14	126
18	126
22	127
3	128
4	128
5	128
9	129
10	129
14	129
18	129
22	130
4	131
5	131
8	132
9	132
11	132
28	132
22	133
3	134
4	134
5	134
8	135
9	135
11	135
28	135
20	136
9	137
8	138
8	139
9	140
19	141
9	142
9	143
\.


--
-- Data for Name: _AttributeValuesToProductVariant; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."_AttributeValuesToProductVariant" ("A", "B") FROM stdin;
4	7
16	7
2	8
10	8
4	9
10	9
2	10
11	10
4	11
11	11
2	12
15	12
4	13
15	13
2	14
16	14
4	15
16	15
2	16
10	16
4	17
10	17
2	18
11	18
4	19
11	19
2	20
15	20
4	21
15	21
2	22
16	22
4	23
16	23
2	24
10	24
4	25
10	25
2	26
11	26
4	27
11	27
2	28
15	28
4	29
15	29
2	38
16	38
4	39
16	39
2	40
10	40
4	41
10	41
2	42
11	42
4	43
11	43
2	44
15	44
4	45
15	45
2	46
14	46
4	47
14	47
2	48
15	48
4	49
15	49
2	50
14	50
4	51
14	51
2	52
15	52
4	53
15	53
2	54
14	54
4	55
14	55
2	56
15	56
4	57
15	57
2	58
14	58
4	59
14	59
2	60
15	60
4	61
15	61
2	62
16	62
4	63
16	63
2	64
18	64
4	65
18	65
2	66
17	66
4	67
17	67
2	68
11	68
4	69
11	69
2	70
14	70
4	71
14	71
2	72
16	72
4	73
16	73
2	74
18	74
4	75
18	75
2	76
17	76
4	77
17	77
2	78
11	78
4	79
11	79
2	80
14	80
4	81
14	81
2	82
16	82
4	83
16	83
2	84
18	84
4	85
18	85
2	86
17	86
4	87
17	87
2	88
11	88
4	89
11	89
2	90
14	90
4	91
14	91
2	92
16	92
4	93
16	93
2	94
18	94
4	95
18	95
2	96
17	96
4	97
17	97
2	98
11	98
4	99
11	99
2	100
14	100
4	101
14	101
2	102
17	102
4	103
17	103
2	104
18	104
4	105
18	105
2	106
14	106
4	107
14	107
2	108
16	108
4	109
16	109
2	110
17	110
4	111
17	111
2	112
18	112
4	113
18	113
2	114
14	114
4	115
14	115
2	116
16	116
4	117
16	117
2	118
17	118
4	119
17	119
2	120
18	120
4	121
18	121
2	122
14	122
4	123
14	123
2	124
16	124
4	125
16	125
2	126
17	126
4	127
17	127
2	128
18	128
4	129
18	129
2	130
14	130
4	131
14	131
2	132
16	132
4	133
16	133
2	134
14	134
4	135
14	135
2	136
15	136
4	137
15	137
2	138
14	138
4	139
14	139
2	140
15	140
4	141
15	141
2	142
14	142
4	143
14	143
2	144
15	144
4	145
15	145
2	146
14	146
4	147
14	147
2	148
15	148
4	149
15	149
3	150
15	150
2	151
15	151
2	153
14	153
4	152
15	152
4	154
14	154
2	6
16	6
3	156
15	156
4	157
15	157
3	158
14	158
4	159
14	159
3	160
15	160
4	161
15	161
5	162
15	162
3	163
14	163
4	164
14	164
5	165
14	165
3	166
15	166
4	167
15	167
5	168
15	168
3	169
14	169
4	170
14	170
5	171
14	171
3	172
15	172
3	173
14	173
3	174
15	174
4	175
15	175
5	176
15	176
6	177
15	177
3	178
14	178
4	179
14	179
5	180
14	180
6	181
14	181
3	182
15	182
4	183
15	183
5	184
15	184
6	185
15	185
3	186
14	186
4	187
14	187
5	188
14	188
6	189
14	189
5	190
15	190
5	191
14	191
3	200
15	200
4	201
15	201
5	202
15	202
6	203
15	203
3	204
14	204
4	205
14	205
5	206
14	206
6	207
14	207
3	208
15	208
4	209
15	209
5	210
15	210
6	211
15	211
3	212
14	212
4	213
14	213
5	214
14	214
6	215
14	215
3	216
15	216
4	217
15	217
5	218
15	218
3	219
14	219
4	220
14	220
5	221
14	221
3	222
15	222
4	223
15	223
5	224
15	224
3	225
14	225
4	226
14	226
5	227
14	227
3	228
15	228
4	229
15	229
5	230
15	230
6	231
15	231
7	232
15	232
3	233
14	233
4	234
14	234
5	235
14	235
6	236
14	236
7	237
14	237
3	238
15	238
4	239
15	239
5	240
15	240
6	241
15	241
7	242
15	242
3	243
14	243
4	244
14	244
5	245
14	245
6	246
14	246
7	247
14	247
3	248
15	248
4	249
15	249
5	250
15	250
6	251
15	251
7	252
15	252
3	253
14	253
4	254
14	254
5	255
14	255
6	256
14	256
7	257
14	257
3	258
15	258
4	259
15	259
5	260
15	260
6	261
15	261
7	262
15	262
3	263
14	263
4	264
14	264
5	265
14	265
6	266
14	266
7	267
14	267
3	268
15	268
4	269
15	269
5	270
15	270
6	271
15	271
7	272
15	272
3	273
14	273
4	274
14	274
5	275
14	275
6	276
14	276
7	277
14	277
3	278
15	278
4	279
15	279
5	280
15	280
6	281
15	281
7	282
15	282
3	283
14	283
4	284
14	284
5	285
14	285
6	286
14	286
7	287
14	287
4	288
8	288
5	289
8	289
6	290
8	290
7	291
8	291
4	292
15	292
5	293
15	293
6	294
15	294
7	295
15	295
4	296
8	296
5	297
8	297
6	298
8	298
7	299
8	299
4	300
15	300
5	301
15	301
6	302
15	302
7	303
15	303
2	304
14	304
4	305
14	305
2	306
12	306
4	307
12	307
2	308
11	308
4	309
11	309
2	310
21	310
4	311
21	311
2	312
15	312
4	313
15	313
2	314
14	314
4	315
14	315
2	316
12	316
4	317
12	317
2	318
11	318
4	319
11	319
2	320
21	320
4	321
21	321
2	322
15	322
4	323
15	323
3	324
14	324
4	325
14	325
5	326
14	326
6	327
14	327
3	328
11	328
4	329
11	329
5	330
11	330
6	331
11	331
3	332
17	332
4	333
17	333
5	334
17	334
6	335
17	335
3	336
18	336
4	337
18	337
5	338
18	338
6	339
18	339
3	340
14	340
4	341
14	341
5	342
14	342
6	343
14	343
3	344
11	344
4	345
11	345
5	346
11	346
6	347
11	347
3	348
17	348
4	349
17	349
5	350
17	350
6	351
17	351
3	352
18	352
4	353
18	353
5	354
18	354
6	355
18	355
3	356
14	356
4	357
14	357
5	358
14	358
6	359
14	359
3	360
11	360
4	361
11	361
5	362
11	362
6	363
11	363
3	364
17	364
4	365
17	365
5	366
17	366
6	367
17	367
3	368
18	368
4	369
18	369
5	370
18	370
6	371
18	371
3	372
14	372
4	373
14	373
5	374
14	374
6	375
14	375
3	376
11	376
4	377
11	377
5	378
11	378
6	379
11	379
3	380
17	380
4	381
17	381
5	382
17	382
6	383
17	383
3	384
18	384
4	385
18	385
5	386
18	386
6	387
18	387
2	388
15	388
4	389
15	389
2	390
14	390
4	391
14	391
2	392
9	392
22	392
3	393
9	393
22	393
2	394
13	394
22	394
3	395
13	395
22	395
2	396
8	396
22	396
3	397
8	397
22	397
2	398
11	398
22	398
3	399
11	399
22	399
2	400
8	400
22	400
3	401
8	401
22	401
4	402
8	402
22	402
2	403
13	403
22	403
3	404
13	404
22	404
4	405
13	405
22	405
2	406
11	406
22	406
3	407
11	407
22	407
4	408
11	408
22	408
2	409
9	409
22	409
3	410
9	410
22	410
4	411
9	411
22	411
2	412
12	412
22	412
3	413
12	413
22	413
4	414
12	414
22	414
3	415
8	415
22	415
4	416
8	416
22	416
3	417
11	417
22	417
4	418
11	418
22	418
3	419
9	419
22	419
4	420
9	420
22	420
3	421
10	421
22	421
4	422
10	422
22	422
3	423
8	423
22	423
4	424
8	424
22	424
3	425
11	425
22	425
4	426
11	426
22	426
3	427
9	427
22	427
4	428
9	428
22	428
3	429
10	429
22	429
4	430
10	430
22	430
3	431
8	431
22	431
4	432
8	432
22	432
3	433
11	433
22	433
4	434
11	434
22	434
3	435
9	435
22	435
4	436
9	436
22	436
3	437
10	437
22	437
4	438
10	438
22	438
3	439
12	439
22	439
4	440
12	440
22	440
3	441
8	441
22	441
4	442
8	442
22	442
5	443
8	443
22	443
3	444
11	444
22	444
4	445
11	445
22	445
5	446
11	446
22	446
3	447
9	447
22	447
4	448
9	448
22	448
5	449
9	449
22	449
3	450
10	450
22	450
4	451
10	451
22	451
5	452
10	452
22	452
3	453
12	453
22	453
4	454
12	454
22	454
5	455
12	455
22	455
3	456
18	456
22	456
4	457
18	457
22	457
5	458
18	458
22	458
3	459
9	459
22	459
4	460
9	460
22	460
5	461
9	461
22	461
3	462
14	462
22	462
4	463
14	463
22	463
5	464
14	464
22	464
3	465
10	465
22	465
4	466
10	466
22	466
5	467
10	467
22	467
3	468
13	468
22	468
3	469
14	469
22	469
3	470
10	470
22	470
3	471
18	471
22	471
3	472
11	472
22	472
3	473
9	473
22	473
3	474
13	474
22	474
3	475
14	475
22	475
3	476
10	476
22	476
3	477
18	477
22	477
3	478
11	478
22	478
3	479
9	479
22	479
3	480
14	480
22	480
4	481
14	481
22	481
5	482
14	482
22	482
3	483
10	483
22	483
4	484
10	484
22	484
5	485
10	485
22	485
3	486
18	486
22	486
4	487
18	487
22	487
5	488
18	488
22	488
3	489
9	489
22	489
4	490
9	490
22	490
5	491
9	491
22	491
4	492
8	492
22	492
5	493
8	493
22	493
4	494
11	494
22	494
5	495
11	495
22	495
4	496
9	496
22	496
5	497
9	497
22	497
4	498
22	498
28	498
5	499
22	499
28	499
3	500
8	500
22	500
4	501
8	501
22	501
5	502
8	502
22	502
3	503
11	503
22	503
4	504
11	504
22	504
5	505
11	505
22	505
3	506
9	506
22	506
4	507
9	507
22	507
5	508
9	508
22	508
3	509
22	509
28	509
4	510
22	510
28	510
5	511
22	511
28	511
9	512
20	512
8	513
8	514
9	515
9	516
19	516
9	517
\.


--
-- Data for Name: _ProductToProductSpecifications; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."_ProductToProductSpecifications" ("A", "B") FROM stdin;
10	1
10	3
10	4
10	5
10	6
10	8
10	9
12	1
12	3
12	4
12	5
12	6
12	8
12	9
14	1
14	3
14	4
14	5
14	6
14	8
14	9
15	1
15	10
15	12
15	13
15	14
15	15
15	16
15	17
15	18
15	19
16	1
16	10
16	12
16	13
16	14
16	15
16	16
16	17
16	18
16	19
17	1
17	10
17	12
17	13
17	14
17	15
17	16
17	17
17	18
17	19
18	1
18	10
18	12
18	13
18	14
18	15
18	16
18	17
18	18
18	19
19	3
19	9
19	20
19	22
19	23
19	24
19	26
20	3
20	9
20	20
20	21
20	22
20	23
20	24
20	26
21	3
21	9
21	20
21	21
21	22
21	23
21	24
21	26
22	3
22	9
22	20
22	21
22	22
22	23
22	24
22	26
23	5
23	8
23	14
23	20
23	27
23	28
23	29
23	30
23	31
23	32
23	33
23	34
23	35
24	5
24	14
24	20
24	24
24	27
24	28
24	29
24	30
24	31
24	32
24	33
24	34
24	35
25	5
25	8
25	14
25	20
25	26
25	27
25	28
25	29
25	30
25	31
25	32
25	33
25	34
25	35
26	5
26	8
26	14
26	20
26	26
26	27
26	28
26	29
26	30
26	31
26	32
26	33
26	34
27	1
27	8
27	36
27	37
27	38
27	39
27	40
27	41
27	42
27	43
27	44
28	1
28	8
28	36
28	37
28	38
28	39
28	40
28	41
28	42
28	43
28	44
31	1
31	36
31	37
31	42
31	45
31	46
31	47
31	48
31	49
31	50
31	51
32	1
32	36
32	37
32	42
32	45
32	46
32	47
32	48
32	49
32	50
32	51
34	1
34	3
34	4
34	5
34	6
34	8
34	13
34	14
34	15
34	33
57	12
57	24
57	36
57	43
57	52
57	53
57	54
57	55
58	12
58	24
58	36
58	43
58	52
58	53
58	54
58	55
59	3
59	5
59	8
59	20
59	33
59	46
59	51
59	56
59	57
60	3
60	8
60	20
60	33
60	57
61	5
61	20
61	21
61	24
61	50
61	54
61	58
61	59
61	60
62	5
62	20
62	21
62	54
62	58
62	59
62	60
63	5
63	20
63	24
63	50
63	54
63	59
63	60
63	61
63	62
64	5
64	20
64	24
64	50
64	54
64	59
64	60
64	61
64	62
\.


--
-- Data for Name: _ProductToTags; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public."_ProductToTags" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
478e9a59-2aaf-4e4c-8e8e-977c3b81eabf	2abb930ac1677c872d6a4d0a64c12e0a6a057e87f5d7039aa40ffc3e928ffbfa	2024-07-17 17:11:53.415553+00	20240717171153_init	\N	\N	2024-07-17 17:11:53.181272+00	1
c3f8ceaf-831b-4da6-8032-8a9a2fb9f2aa	37d062c4106bf26b5859c60929aa12f4ceca513a7f45d8491f9ba4a8aefd2158	2024-08-11 18:07:36.795444+00	20240811180736_update	\N	\N	2024-08-11 18:07:36.751461+00	1
f69799d4-89f2-4ba5-b268-1a1fc5090b42	2dd152056db8c17fe833218e81dee9c6bda96169be6deac7bb3d4a1fde413e00	2024-07-18 16:52:00.782884+00	20240718165200_update	\N	\N	2024-07-18 16:52:00.700896+00	1
9ee2a211-bebc-43dd-b822-164691cc6665	6502df61c99964dadfe69832ae5f52a1de0a398459a8b2976d3a582d5ad83978	2024-07-21 16:50:45.435659+00	20240721165045_cate	\N	\N	2024-07-21 16:50:45.401652+00	1
48dd2d59-16ed-4af7-9ab7-49303dee8ef3	7ad93bd3c326bf281e467422e38b74fccce316e945b223037f61ab01f3a8bc18	2024-07-22 17:04:41.357258+00	20240722170441_fix	\N	\N	2024-07-22 17:04:41.337809+00	1
bb07dd1d-73cb-4e3e-9667-ad8f8a6aef31	cdacec08a614c7129a2e57d0a7898f3f880517ee4f1005927bd43434792f06a5	2024-07-22 17:30:55.603778+00	20240722173055_fix	\N	\N	2024-07-22 17:30:55.59795+00	1
6aa8c554-c085-4b4c-8bb6-157a54037370	27fe7d85f0522ff1b7c74080f3db93b3aae5eb12b12b27b840d7e4b6d1b95d0a	2024-07-23 13:27:40.915524+00	20240723132740_fix	\N	\N	2024-07-23 13:27:40.908372+00	1
fd63cd46-4263-4e46-b575-55bff22502dc	43aef43ab9f217c65b6cc2d277d3f1bae360fc4765cfd75fdc2ab1c567fb8236	2024-07-24 17:01:14.845589+00	20240724170114_fix	\N	\N	2024-07-24 17:01:14.836449+00	1
b2771b0f-0b47-4e14-9840-331942759c9e	30014d836054d74fd5c1a5ea8cae902e9c8d3006918efb028c96c1a7a89dd140	2024-07-27 08:04:58.489528+00	20240727080458_update	\N	\N	2024-07-27 08:04:58.434193+00	1
e91dd159-ad6a-4c82-b719-46385eb8ab53	9ca3ad821ce004e8241be7f0aa7a864b2ab01314564d201500bcd9eb120a6c42	2024-07-27 18:23:44.864488+00	20240727182344_update	\N	\N	2024-07-27 18:23:44.829359+00	1
c767c878-843c-4f50-9cb7-c41c563f79fa	d8645aa27b3c4465827b3eafb3fcdb785d4a1da47f907b2f8976769a4bbeacda	2024-07-28 14:24:50.654419+00	20240728142450_update	\N	\N	2024-07-28 14:24:50.649183+00	1
7600fbcf-c5be-44fc-9397-32b2c8749520	587b90eeb9d71fa248bac6e66e42665b124d2bd5c7d1b78973e5a369644ff803	2024-07-31 16:57:02.820978+00	20240731165702_remove	\N	\N	2024-07-31 16:57:02.79136+00	1
24af5a73-4e23-418f-9e00-b2ac54aceb0d	508f1bd63a15f61319410281846edd7f5d2fb6e1d9b5504acc2fa178706232b9	2024-08-03 08:43:56.279154+00	20240803084356_update	\N	\N	2024-08-03 08:43:56.272732+00	1
626ce8df-dff2-4d1d-a1b7-784614460354	ca306c215511a11ac531b08acac914f597362cf9c31a20d9c9f48ba6b22ac3b1	2024-08-04 17:24:23.051491+00	20240804172423_update	\N	\N	2024-08-04 17:24:23.040848+00	1
f3e9b58a-e6bf-4de8-b553-8d412985b9ac	4ea17541945d8c0347e3d7e7befd22cae93145ef4c2f47ba8e652ab89f3a2c0d	2024-08-10 15:42:14.500826+00	20240810154214_update	\N	\N	2024-08-10 15:42:14.473007+00	1
\.


--
-- Name: Address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Address_id_seq"', 1, false);


--
-- Name: Answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Answer_id_seq"', 1, false);


--
-- Name: Article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Article_id_seq"', 1, true);


--
-- Name: AttributeValues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."AttributeValues_id_seq"', 28, true);


--
-- Name: Attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Attributes_id_seq"', 4, true);


--
-- Name: Brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Brand_id_seq"', 1, true);


--
-- Name: Cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Cart_id_seq"', 1, false);


--
-- Name: CategoryArticle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."CategoryArticle_id_seq"', 3, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Category_id_seq"', 8, true);


--
-- Name: Customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Customer_id_seq"', 1, false);


--
-- Name: File_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."File_id_seq"', 1, false);


--
-- Name: Folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Folder_id_seq"', 1, false);


--
-- Name: Location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Location_id_seq"', 1, false);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Order_id_seq"', 14, true);


--
-- Name: Page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Page_id_seq"', 1, false);


--
-- Name: Payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Payment_id_seq"', 5, true);


--
-- Name: Permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Permission_id_seq"', 1, false);


--
-- Name: ProductAttributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductAttributes_id_seq"', 143, true);


--
-- Name: ProductCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductCategories_id_seq"', 51, true);


--
-- Name: ProductImage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductImage_id_seq"', 203, true);


--
-- Name: ProductOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductOrder_id_seq"', 14, true);


--
-- Name: ProductSpecifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductSpecifications_id_seq"', 62, true);


--
-- Name: ProductVariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."ProductVariant_id_seq"', 517, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Product_id_seq"', 85, true);


--
-- Name: Question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Question_id_seq"', 1, false);


--
-- Name: Rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Rating_id_seq"', 1, false);


--
-- Name: RolePermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."RolePermission_id_seq"', 1, false);


--
-- Name: Role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Role_id_seq"', 1, false);


--
-- Name: SettingHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."SettingHistory_id_seq"', 1, false);


--
-- Name: Setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Setting_id_seq"', 1, false);


--
-- Name: Shipping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Shipping_id_seq"', 5, true);


--
-- Name: SpecificationsGroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."SpecificationsGroup_id_seq"', 26, true);


--
-- Name: SpecificationsType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."SpecificationsType_id_seq"', 9, true);


--
-- Name: Store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Store_id_seq"', 1, false);


--
-- Name: Tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."Tags_id_seq"', 1, false);


--
-- Name: UserRole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."UserRole_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Address Address_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_pkey" PRIMARY KEY (id);


--
-- Name: Answer Answer_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_pkey" PRIMARY KEY (id);


--
-- Name: Article Article_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_pkey" PRIMARY KEY (id);


--
-- Name: AttributeValues AttributeValues_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."AttributeValues"
    ADD CONSTRAINT "AttributeValues_pkey" PRIMARY KEY (id);


--
-- Name: Attributes Attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Attributes"
    ADD CONSTRAINT "Attributes_pkey" PRIMARY KEY (id);


--
-- Name: Brand Brand_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);


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
-- Name: File File_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (id);


--
-- Name: Folder Folder_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Folder"
    ADD CONSTRAINT "Folder_pkey" PRIMARY KEY (id);


--
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: Page Page_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Page"
    ADD CONSTRAINT "Page_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: Permission Permission_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_pkey" PRIMARY KEY (id);


--
-- Name: ProductAttributes ProductAttributes_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductAttributes"
    ADD CONSTRAINT "ProductAttributes_pkey" PRIMARY KEY (id);


--
-- Name: ProductCategories ProductCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductCategories"
    ADD CONSTRAINT "ProductCategories_pkey" PRIMARY KEY (id);


--
-- Name: ProductImage ProductImage_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_pkey" PRIMARY KEY (id);


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
-- Name: Question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- Name: Rating Rating_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_pkey" PRIMARY KEY (id);


--
-- Name: RolePermission RolePermission_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_pkey" PRIMARY KEY (id);


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: SettingHistory SettingHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SettingHistory"
    ADD CONSTRAINT "SettingHistory_pkey" PRIMARY KEY (id);


--
-- Name: Setting Setting_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Setting"
    ADD CONSTRAINT "Setting_pkey" PRIMARY KEY (id);


--
-- Name: Shipping Shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Shipping"
    ADD CONSTRAINT "Shipping_pkey" PRIMARY KEY (id);


--
-- Name: SpecificationsGroup SpecificationsGroup_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsGroup"
    ADD CONSTRAINT "SpecificationsGroup_pkey" PRIMARY KEY (id);


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
-- Name: Tags Tags_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Tags"
    ADD CONSTRAINT "Tags_pkey" PRIMARY KEY (id);


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY (id);


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
-- Name: Address_phone_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Address_phone_key" ON public."Address" USING btree (phone);


--
-- Name: Article_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Article_slug_key" ON public."Article" USING btree (slug);


--
-- Name: Article_title_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Article_title_key" ON public."Article" USING btree (title);


--
-- Name: AttributeValues_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "AttributeValues_slug_key" ON public."AttributeValues" USING btree (slug);


--
-- Name: AttributeValues_value_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "AttributeValues_value_key" ON public."AttributeValues" USING btree (value);


--
-- Name: Attributes_key_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Attributes_key_key" ON public."Attributes" USING btree (key);


--
-- Name: Attributes_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Attributes_name_key" ON public."Attributes" USING btree (name);


--
-- Name: Brand_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Brand_name_key" ON public."Brand" USING btree (name);


--
-- Name: Brand_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Brand_slug_key" ON public."Brand" USING btree (slug);


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
-- Name: Customer_phone_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Customer_phone_key" ON public."Customer" USING btree (phone);


--
-- Name: Order_code_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Order_code_key" ON public."Order" USING btree (code);


--
-- Name: Order_token_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Order_token_key" ON public."Order" USING btree (token);


--
-- Name: Page_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Page_slug_key" ON public."Page" USING btree (slug);


--
-- Name: Page_title_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Page_title_key" ON public."Page" USING btree (title);


--
-- Name: Payment_order_id_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Payment_order_id_key" ON public."Payment" USING btree (order_id);


--
-- Name: Permission_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Permission_name_key" ON public."Permission" USING btree (name);


--
-- Name: ProductAttributes_product_id_attribute_id_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "ProductAttributes_product_id_attribute_id_key" ON public."ProductAttributes" USING btree (product_id, attribute_id);


--
-- Name: ProductCategories_product_id_category_id_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "ProductCategories_product_id_category_id_key" ON public."ProductCategories" USING btree (product_id, category_id);


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
-- Name: RolePermission_roleId_permissionId_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "RolePermission_roleId_permissionId_key" ON public."RolePermission" USING btree ("roleId", "permissionId");


--
-- Name: Role_code_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Role_code_key" ON public."Role" USING btree (code);


--
-- Name: Role_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);


--
-- Name: Setting_key_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Setting_key_key" ON public."Setting" USING btree (key);


--
-- Name: Shipping_order_id_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Shipping_order_id_key" ON public."Shipping" USING btree (order_id);


--
-- Name: SpecificationsGroup_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "SpecificationsGroup_name_key" ON public."SpecificationsGroup" USING btree (name);


--
-- Name: Tags_name_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Tags_name_key" ON public."Tags" USING btree (name);


--
-- Name: Tags_slug_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "Tags_slug_key" ON public."Tags" USING btree (slug);


--
-- Name: UserRole_userId_roleId_key; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "UserRole_userId_roleId_key" ON public."UserRole" USING btree ("userId", "roleId");


--
-- Name: _AttributeValuesToProductAttributes_AB_unique; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "_AttributeValuesToProductAttributes_AB_unique" ON public."_AttributeValuesToProductAttributes" USING btree ("A", "B");


--
-- Name: _AttributeValuesToProductAttributes_B_index; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE INDEX "_AttributeValuesToProductAttributes_B_index" ON public."_AttributeValuesToProductAttributes" USING btree ("B");


--
-- Name: _AttributeValuesToProductVariant_AB_unique; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "_AttributeValuesToProductVariant_AB_unique" ON public."_AttributeValuesToProductVariant" USING btree ("A", "B");


--
-- Name: _AttributeValuesToProductVariant_B_index; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE INDEX "_AttributeValuesToProductVariant_B_index" ON public."_AttributeValuesToProductVariant" USING btree ("B");


--
-- Name: _ProductToProductSpecifications_AB_unique; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "_ProductToProductSpecifications_AB_unique" ON public."_ProductToProductSpecifications" USING btree ("A", "B");


--
-- Name: _ProductToProductSpecifications_B_index; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE INDEX "_ProductToProductSpecifications_B_index" ON public."_ProductToProductSpecifications" USING btree ("B");


--
-- Name: _ProductToTags_AB_unique; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE UNIQUE INDEX "_ProductToTags_AB_unique" ON public."_ProductToTags" USING btree ("A", "B");


--
-- Name: _ProductToTags_B_index; Type: INDEX; Schema: public; Owner: tp_user
--

CREATE INDEX "_ProductToTags_B_index" ON public."_ProductToTags" USING btree ("B");


--
-- Name: Address Address_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Address Address_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_district_id_fkey" FOREIGN KEY (district_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Address Address_province_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_province_id_fkey" FOREIGN KEY (province_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Address Address_ward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT "Address_ward_id_fkey" FOREIGN KEY (ward_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Answer Answer_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_author_id_fkey" FOREIGN KEY (author_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Answer Answer_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Answer Answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_question_id_fkey" FOREIGN KEY (question_id) REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Article Article_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_author_id_fkey" FOREIGN KEY (author_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Article Article_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Article"
    ADD CONSTRAINT "Article_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."CategoryArticle"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AttributeValues AttributeValues_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."AttributeValues"
    ADD CONSTRAINT "AttributeValues_attribute_id_fkey" FOREIGN KEY (attribute_id) REFERENCES public."Attributes"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Cart Cart_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: File File_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_folder_id_fkey" FOREIGN KEY (folder_id) REFERENCES public."Folder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Folder Folder_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Folder"
    ADD CONSTRAINT "Folder_parent_id_fkey" FOREIGN KEY (parent_id) REFERENCES public."Folder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Payment Payment_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductAttributes ProductAttributes_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductAttributes"
    ADD CONSTRAINT "ProductAttributes_attribute_id_fkey" FOREIGN KEY (attribute_id) REFERENCES public."Attributes"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductAttributes ProductAttributes_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductAttributes"
    ADD CONSTRAINT "ProductAttributes_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductCategories ProductCategories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductCategories"
    ADD CONSTRAINT "ProductCategories_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductCategories ProductCategories_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductCategories"
    ADD CONSTRAINT "ProductCategories_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductImage ProductImage_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductOrder ProductOrder_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder"
    ADD CONSTRAINT "ProductOrder_cart_id_fkey" FOREIGN KEY (cart_id) REFERENCES public."Cart"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductOrder ProductOrder_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductOrder"
    ADD CONSTRAINT "ProductOrder_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductSpecifications ProductSpecifications_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductSpecifications"
    ADD CONSTRAINT "ProductSpecifications_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public."SpecificationsGroup"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_image_id_fkey" FOREIGN KEY (image_id) REFERENCES public."ProductImage"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ProductVariant ProductVariant_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES public."Brand"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Product Product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Question Question_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Question Question_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Rating Rating_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rating Rating_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RolePermission RolePermission_permissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES public."Permission"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RolePermission RolePermission_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SettingHistory SettingHistory_setting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SettingHistory"
    ADD CONSTRAINT "SettingHistory_setting_id_fkey" FOREIGN KEY (setting_id) REFERENCES public."Setting"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Shipping Shipping_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Shipping"
    ADD CONSTRAINT "Shipping_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpecificationsGroup SpecificationsGroup_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."SpecificationsGroup"
    ADD CONSTRAINT "SpecificationsGroup_type_id_fkey" FOREIGN KEY (type_id) REFERENCES public."SpecificationsType"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Store Store_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_district_id_fkey" FOREIGN KEY (district_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Store Store_province_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_province_id_fkey" FOREIGN KEY (province_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Store Store_ward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."Store"
    ADD CONSTRAINT "Store_ward_id_fkey" FOREIGN KEY (ward_id) REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserRole UserRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserRole UserRole_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: _AttributeValuesToProductAttributes _AttributeValuesToProductAttributes_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_AttributeValuesToProductAttributes"
    ADD CONSTRAINT "_AttributeValuesToProductAttributes_A_fkey" FOREIGN KEY ("A") REFERENCES public."AttributeValues"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AttributeValuesToProductAttributes _AttributeValuesToProductAttributes_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_AttributeValuesToProductAttributes"
    ADD CONSTRAINT "_AttributeValuesToProductAttributes_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductAttributes"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AttributeValuesToProductVariant _AttributeValuesToProductVariant_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_AttributeValuesToProductVariant"
    ADD CONSTRAINT "_AttributeValuesToProductVariant_A_fkey" FOREIGN KEY ("A") REFERENCES public."AttributeValues"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AttributeValuesToProductVariant _AttributeValuesToProductVariant_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_AttributeValuesToProductVariant"
    ADD CONSTRAINT "_AttributeValuesToProductVariant_B_fkey" FOREIGN KEY ("B") REFERENCES public."ProductVariant"(id) ON UPDATE CASCADE ON DELETE CASCADE;


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
-- Name: _ProductToTags _ProductToTags_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_ProductToTags"
    ADD CONSTRAINT "_ProductToTags_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToTags _ProductToTags_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public."_ProductToTags"
    ADD CONSTRAINT "_ProductToTags_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tags"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

