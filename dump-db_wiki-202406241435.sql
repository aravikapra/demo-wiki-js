--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-24 14:35:01

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 36441)
-- Name: analytics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 36804)
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 36803)
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."apiKeys_id_seq" OWNER TO postgres;

--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 257
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- TOC entry 222 (class 1259 OID 36461)
-- Name: assetData; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 36469)
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 36468)
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."assetFolders_id_seq" OWNER TO postgres;

--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 223
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- TOC entry 221 (class 1259 OID 36450)
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- TOC entry 220 (class 1259 OID 36449)
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assets_id_seq OWNER TO postgres;

--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- TOC entry 225 (class 1259 OID 36482)
-- Name: authentication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 36890)
-- Name: brute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 36818)
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 36492)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 36491)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 226
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 228 (class 1259 OID 36500)
-- Name: editors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 36509)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 36508)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.groups_id_seq OWNER TO postgres;

--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 229
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 231 (class 1259 OID 36518)
-- Name: locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 36527)
-- Name: loggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 36428)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 36427)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 215
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 218 (class 1259 OID 36435)
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 36434)
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_lock_index_seq OWNER TO postgres;

--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- TOC entry 233 (class 1259 OID 36536)
-- Name: navigation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 36544)
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 36652)
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 36651)
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNER TO postgres;

--
-- TOC entry 5192 (class 0 OID 0)
-- Dependencies: 251
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- TOC entry 234 (class 1259 OID 36543)
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."pageHistory_id_seq" OWNER TO postgres;

--
-- TOC entry 5193 (class 0 OID 0)
-- Dependencies: 234
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- TOC entry 237 (class 1259 OID 36556)
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 36555)
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."pageLinks_id_seq" OWNER TO postgres;

--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 236
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- TOC entry 254 (class 1259 OID 36669)
-- Name: pageTags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 36668)
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."pageTags_id_seq" OWNER TO postgres;

--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 253
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- TOC entry 240 (class 1259 OID 36573)
-- Name: pageTree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 36563)
-- Name: pages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 36562)
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_id_seq OWNER TO postgres;

--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 238
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- TOC entry 241 (class 1259 OID 36582)
-- Name: renderers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 36590)
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 36893)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 36598)
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 36605)
-- Name: storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 36615)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 36614)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 245
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 260 (class 1259 OID 36835)
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 36686)
-- Name: userGroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 36685)
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."userGroups_id_seq" OWNER TO postgres;

--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 255
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- TOC entry 248 (class 1259 OID 36626)
-- Name: userKeys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 36625)
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."userKeys_id_seq" OWNER TO postgres;

--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 247
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- TOC entry 250 (class 1259 OID 36635)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 36634)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 249
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4889 (class 2604 OID 36807)
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- TOC entry 4833 (class 2604 OID 36472)
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- TOC entry 4830 (class 2604 OID 36453)
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 36495)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4846 (class 2604 OID 36512)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 36431)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 36438)
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- TOC entry 4853 (class 2604 OID 36547)
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- TOC entry 4886 (class 2604 OID 36655)
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- TOC entry 4859 (class 2604 OID 36559)
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- TOC entry 4887 (class 2604 OID 36672)
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- TOC entry 4860 (class 2604 OID 36566)
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 36618)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 36689)
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- TOC entry 4871 (class 2604 OID 36629)
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- TOC entry 4872 (class 2604 OID 36638)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5134 (class 0 OID 36441)
-- Dependencies: 219
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":"","beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net"}
plausible	f	{"domain":"","plausibleJsSrc":"https://plausible.io/js/plausible.js"}
statcounter	f	{"projectId":"","securityToken":""}
umami	f	{"websiteID":"","url":""}
umami2	f	{"websiteID":"","url":""}
yandex	f	{"tagNumber":""}
\.


--
-- TOC entry 5173 (class 0 OID 36804)
-- Dependencies: 258
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5137 (class 0 OID 36461)
-- Dependencies: 222
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."assetData" (id, data) FROM stdin;
1	\\xffd8ffe000104a46494600010100000100010000ffdb00840009060710101012101012151615151010151516151515151510151617161615161515181d2820181a251b151521312125292b2e2e2e171f3338332c37282d2e2b010a0a0a0e0d0e1b10101b2b2520252b2d2b2d2d2d2d2b2f2d2d2d2d2d2b2d2b2d2d2d2d2f2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2dffc000110800a7012e03012200021101031101ffc4001c0001000203010101000000000000000000000506020304010708ffc40046100002010302030307070908020301000001020003041112210531510613410722617191a1d1141732819293e1152352536263b1c1d21642547282a2b2c243f035b3e233ffc4001a010100030101010000000000000000000000010203050406ffc4003211000201020305060602030100000000000001020311042151123141619114527181b1f0132232a1c1d105e11542f123ffda000c03010002110311003f00fb8c444011110044440111100444401111004444011110044440111100444401111004444011110044440111100444401111004444011110044440121fb59c7070fb3ad78c85c520a4a8214b6582ec4fae4c4a6f960ffe16f3fc94ff00fb12014ff9f9a3fe02afdea7c258bb35e5329df5adf5d0b67416747bc652ea4d4f35df0081b7d0f7ca4f909e05697697a6eade956d0f402f7b4d5f4643e74ea1b6703d93ec161d9eb2b75a8942da8d35aa3151529aaad418230c00dc618f3eb00f99fcfcd1ff000157ef53e13bbb3fe59695e5d50b5166e86b555a618d542173e2401bca0794eec03f0badf29b704da3b82a799b67ce4537cf35cfd127d477c67e83e4ab8cf0de20aa0da5b52bda386609469a97c6c2b52c0c819c640fa24f42201b7b55e5769585e56b36b57a8691405c54550da915f911b7d2c489f9f9a3fe06a7df27c24b7958f2742fd0de5a281748be728d85d201f44fef00e47c791f023e71e4cbb41656f5be49c4eda835377216ad5a285edaa67056a1619d04f5fa27d1c80fd01d9ae2e2f6d285daa1415a9870a4e4ae73b13e325273d9dbd3a48b4e92aa228c2aa001547ec81b013a2008888022220088880222200888802222008888022220088880222200888802222008888022257b8ef6b6dacaa0a55bbcd45030d2ba8609239e7d065a3094dda2aecace7182bc9d916195bf283c1eb5ef0db8b5a1a7bca8a81751d2bb3ab1c9f50338be71ec3ad4fb1f8c7ce3d875a9f63f19af66addc7d0cbb4d1efaea8f93db7929e3d4b3dd3a53ce33dddd3a671cb3a40ccbb7633b25c5edacb89d2b8ac4d6af6fa6d9be50efa1f455190c774f399771d3d12c5f38f61d6a7d8fc63e71ec3ad4fb1f8c766addc7d0769a3df5d51f2eafe4dfb49514a54b82eac30caf7b55958742a76336f65fc96717b5beb5b93dd2ad2b9a2ee52b79ddd861de0034ef94d431e399f4cf9c7b0eb53ec7e31f38f61d6a7ddfe31d96b771f41da68f7d75453bb6fd8de3b73c42e2bda5c32d076434d45dd4a7a40a68ade62ec3ce0c654ebf920e35518bbf72ccc49666ae59989e65895c933eb9f38f61d6a7d8fc63e71ec3ad5fbbfc63b2d6ee3e83b4d1efaea891ec1f0eb8b5e1f6f6f7473569a15621b58c6a6d2037880ba47d52c1994df9c6b0eb53eeff0018f9c6b0eb53eeff0018ecb5bb8fa0ed347bebaa2e398ccaff0003ed6db5e5434a8f79a82163a9748c02073cfa449dd532942507692b33584e33578bba33ccf66399501c66e00b8be14c35baae2906aa535221219d5749c966e44e36025a14e53ddedbdc8ad4aaa16bfb4b7bf7a972890e38cab1094e9d47a9a11d91428eec38c80ecc4283e8ce768b6e3d45e9bd47269f7750d270f8056a0c79a30486272318cc8f872d3dbdc3e2c35262240d6e3a1aa52a3491fbca8fff00929d4a61698dddfce033d07a489276f7f4aa53ef51c141ab2d9c01a490d9cf2c621d39249b5efdee11ab093b27effacafe275c4d54aa0650ca41040208dc10791066d9434112153b414dee1eda8d3ab55a9b2ad56a6abddd06619d2eecc016008255724646d26a008888022220088880222200888802222008888027cb7cae52c56b77eb4dc7d9607fed3ea53e75e57a9f996cff00b7557da14ff29eac13b578f9fa1e4c72bd09797aa3e6b1136d1b6a8f9d14ddf1cf423363d781b4ef1c135cf275fe4cb8fd455fbaa9fd31f932e3f5157ee9ff00a645d6a89d97a1c9247f24bfe92fb4fc268fc9973fa8abf7753fa659fe415bf54ff61fe121c96a8a4d4d6e4fa15ffc92ff00a4bed3f09e7e487fd25f69f84b0fc86b7eadfec3fc23e435bf56ff0061fe12bb6b5452f5347d0af7e487eabed3f09a2eac9a9804907271b67e12c75683a7d3465cf2d4acb9f564488e367641e963fc2593b85295eccb1f92b5fcf5c3f4a683dac4ff00d67d24549f39f26be6adc3756a63d818ff0039775af3898d77acfcbd11f478156a11f3f56775745a88d4db38652a704838230704729c14780520a88ef52a53a7a3453a8c0d35d3f47cd503563f6b337a569d095279a3394724cf44a9c64eed1c09c22ad3a959e8dc0415aa6a70d483b2b600f31b5000607883396af67991adda8156eeaa56a8c2a96fcebd4183519947d31bf878f849f569b54cbaaf35b9fd9696cfc8a3a107ff005eb7cbccaf5bb0b7af56bded7a5debae9a4abb1149772110f9c4963938cf84e1ecc707acf4116e469a2af5192960835353970d581f019d93dbd05c702735f5da514352a1c28c64e09392700003724920604b7686a2d2e5e56ba56d37feac556194a4b8efcb5bd9e7aee3a80959f283c42adb58d4ab46b352aa0aad2d2b4dcd5aac74d3a78a808c16237f09356b766a1c7775136ce5d4007d58277f4198717e1542ee9f73714c544d41b07230c37041041047513ce9df71e99269d99cfd99e102d2d9297f7ce6a566c96352b3f9d55893b9cb13f560784989a2da8ad34545ce9550065998e07566249f59337c92044440111100444401111004444011110044440128fe5669e6d29b7e8d75f7a38976953f2994f570f73fa3528b7fb80ffb4df0ced5a3e28c314af464b933e3d2fbe4aaaf9d729fb345bdee3f98942925c138d56b3667a3a72ca14ea1a8601cedb8de76b134dd4a4e28e1e1aa2a7554df03ed998ccf95ff006fefbf77f63ffd4f7fb7d7bfbbfb1f8ce5ff008fabcba9d6ff0023479f43ea44c929f1a3e502f7f77f60ff0054b0ff006caebf63ec9f8c8780aab4ea55ff0027456bd3fb3e8913e769dafbb2c07e6f7207d13e271d67d12635684a95b6b89be1f150af7d8be5f9293e50df7a0be8a87fe227ce38d9f3947ec93eff00c25ffca03e6e29af4a79f6b1f84f9e7183f9cf528fe73b18356a51f7c4e1e31df152f7c1166ec554d345bd350fb95659a9dd4a4f02afa6901fb4c7dff849aa3773918977ad2f13bb8656a31f02d14ae27651ad2b76f73252deb4c0dc9ca4f3a51a46d0a93b69b403a8195dbee13f28bb1abbc14e9a8763adc0a954ec9a7076d2013b637224bfcb90555a1beb6467c0190aa0e32c7c324ed3b04ab4a46b4ea4e93bacaebd7895bbf6eeeb53a0f56a251eedaa172ef9aaf9005335798006f8c8ccd34abb526b8ad4fbcee7bb54a41d9dbbdae4e01a61c9217703d3b996bc4f0a83cc4afc3cef7358e262959c7859e8f3bdf76f7adfc3957da95743429f7eef559817c842ba06f536c671b8037f11365f254a95d6925621405aac303cd00f98bd4e4824e7c049aeed756ac0ce319f1c74ccd152ca9b3f7857cec01a8641206e01c7310e1c08588f9b69a57b3e0b7be5cb869bcd96eae17cf60c7a81a7dd9339386fca89a86e3b9d3aff0034296b2746fbd42db16e5c84dfc4ac52e293d1a9ab438c3696642474d4a41132b1b54a34d2953184450aa37385030064f39a1e6b9d338aeb88253a94e9bedde6ad2c70172a32549f038dfea33b642715e082e57f38c4b2b07a47185a4c0e54e9cf9de9cf532f4d41bb4de4567b56f9779296f5c3825738cf32301bd233cc7a66f9a8ae570dd37c6debc4f2951099c67eb627f8995c893d6aca0e0b0cf4c899ea91bf2770e5e982badc1a81882a463048f1070263796acecefa7274f774c78286fa4fff00bfa32fb0afbfdfbfb6646d3d095ccf64322f71a9c2b15454a4a3725b9658fb79fa0ccabbb355a48870756b6219b01473073b1cf28f879e4f2236894a8e14649c0ebd2794dc30041c823208e444e3e2957cd1481c3543a07a01fa47d999db4d0280a3600003d425366d14f52d7cec673c33d9e190498b195fedc26ae1f723a53d5f65837f293ce644768935dadc2f5a157fe265e9bb4d3e6bd4a5457835c9fa1f0c9ecf04f67d29f307924f87767eeee13bca348baea2b90c8371cc60907c6464fa77930a99b575fd1aedfee443fc8cc3135654a9ed23d185a31ab5365e8ca69ec7f10ff0edf6a9ff0054b1ff0066af7f527ed27c65f8c91139aff90a8f82fbfece83fe2e93e2fedfa3e6f63d9cba156916a4428a94c9395d80604f8f49f49889e6ad5e555a723d386c2c70e9a8b79ea7ce3b7153376c3f469a0f713fce5078a1cd56fabf80975ed53eabcade8651ec55128f7c7355ff00cc7ddb4ede1d5a9c5724702b3bd79be6cdf6b73a40124edeea5592e3ce3eb324ed2b4e0d4779c9f37ea7d2d356825c97a16db4af26eceacaa58d4960b16942e58ed9e48d26db3e89136864ad08057ad4254156e2a2d56af54b2ad21de29455cad35c6c07524f533ba85e1a4b4ed1d89aab495aa39a8100cf8073bb7d5d24fa4f5e82310595491c8900913354edb8f5bc4a96f5970cf759595b92d38ef6cad70de2ac94ae2e5d99a8ab69a4a583e48d9887c6e0b1c6fd24d5b25760acf514138255501503a024e4fae753db536434caa95230570318f54c6dace9d3ce85c67d27dd9e526316b894a95a12bb8ab3f04f2b59783d5a5990b53898379a4063a032201b2bd43bb92c76d86ded9275afcd3081c0d6eda5554ec4e33ccc3f0aa455174e343eb520e195b39273e9c991f736352a576a9515b0be6d30ba594af3d441e4d991f3234bd1a8d704971def4b78ef7e6775bf1066aad48d3c685059c1054673b75ced314e3548d36aa15f42923569383838c8ea26346ceab5bb53a8569bb6a1941c949dbfd5892142dd51169a8f3554003d025be66673f849bcb8db27a6f77cf7f2dc6152f69a9009dc8ce0024e3ae04f68ddd3752eac3482413cb0473073ca715a5b55a4f58e15bbc7d4189c1518c0523a09a2a70f745551e787b8ef2b636cf8ec3a6408bbd0954a9bcb6b4fefc2dcc9bd427b991ea19aa6b6521517cc1e2cc7c71eefae63f27229b120977e7e82761eac49b996c2e2f4fbfe96fe8494c4b0ce3af2f4ce40e43ad3270a29839fd23cb9cc6d103546a99247d15ce7eb233171f0f2bb3be7b3933aea02b5764c864182093cb51e6275c9333034c1f01ec991130ad502a963e13856f2a780524efcf90965172ccab6912531267a662d2a58d550c8ebfdd197aab0f682276d5323ae1a058f86018dba4c954920019248000e649e404db789a6a545e8ee3d8c6636efa5d1ba321f61067d45f2b9f2d6b3b1d5f91aebf5157eeea7c26cb7bfbcb3cd3467a25b0c548d24f80386199f6d267cc3ca8d3c5dd36fd2a0bfed77f8ce7d0c5baf3d89455bdea74311845421b7193f7e0439ed4710ff0012feef84b1fe5fbbfd7bfbbe128665aa7ae54a9f7574473a75aa779f565a7b29c52e6adcaa54aaccb87241c60e06de1d4897d9f3eec0a66e1cf4a4def64f819f419c7c6a51ab64ad923b7fc6ca52a3793be6ff005f83e4dc65f55cd73d6ad4ff009112995db2cc7f698fbe5a6e6a65ddbab3b7b4932a355b627d04fba7660ad1f2fc1c28fcd393d5fe489b77c9fae4d591e5216cd394b05852e53e6ee7d65ac4e70f12c960b21387d2e52c9634a01296db0cf4134f05aa6e57bc7ac54b16d34d182f760120023996f5ceeb549df46d933ab4ae7ae067db22d99a426a29ebae5f9d4e3a574ef55a8537d22905d6edbb31233819f478cddc1ae9ea3565660c88f847c6356dbfa0e0ed99d15386d176d4c80b6304f2247438e736d4b352a146540e410e9fe10932ee74dab5b4f2d5df7b6fa5b222ec5055baab5c6c94c1a6307677e6ec7ae397b6762f122eacf493520cf9c4801b1cf4ccec786250434d0b6939d89ce33cf7e7e334dbf08d14c51151bbb1b69c0ce3a6a909348bce74e4ef7dd64bc38f999b71aa42953ab86c542028032c49f409d146f559b4618369d58208dbd734af0e02aa54cf9a89a517c17a9f649023c7c64abf1329ba7feabfad1797dfc8e4adc4a92554a2cde7b8254609ce39efe13b647d81aecce6ba2280df9bd249257f6b236324259a3235d5a8154b36c0024cf28560ea197911912338f79c16890da1db0e4782f88fae7942d877a8696569a29079e1ba0c4d1534e172b7cc91b9ba4a782e7032067d266f1222f6a2d6ad4e8e7217cf6f4e3909d97376aa7bb07cec671d04874f25a8da3af11891b617ccdde16fa0a700f5eb3ae93b300c0000fb712250717664a773653a4ab9d200c9c9c0e67a99b2705e5e04a8899c6724ced46c8ccab8b4937c45cc6a530db119df314a8aae4818cf399e77c4f645c9b1e198399999ade01cb58c8bbb69255e44ddf8c03e4bc7131735c7ef1fde73fce70b723ea3257b4e98bbabe92a7daa2454fa5a2ef08be4bd0f99acbe792e6fd4fbbd9d4d54a9b7e95346f6a83175694aa8d3569a38e8ea187bc4f9170ded55ed00152b12a00015807500780cee07a8cb25879473b0b8a1feaa6dff0046f8ce3cf03562ef1cfc0ec53c7d19ab4b2f1dc4cdff00612c6a64a2bd23fbb638fb2d91ecc496b4ec85aa6ec1aa1fdb6dbecae07b7338ec3b5f635b0056084ff76a0287da7cdf7c94bded2da52d8d40c7a282def1b7be536b13f47cdefdea59c309f5bd9fb7bfb1256d6b4e98c534551d1540fe13dba7d34ddba231f6026546f3b71e14697d6c7feabf19057dda0b9ac08672148c155f3411d36dc8f5996860aacb3965e26553f92a10568e7e0b221ab9c231fd93fc2562bfd06ff21964bf38a4ff00e5fe3b4af69ced3af51da127c99c6c2c6f28ae68e6b1b7e52c7c3edb94e7b1b4962b0b5e53e70faa3aec2de4cb3f7485b1bf80ea4ec04c2cade4c51b6071919c1c8f5c131b5f320e9de5d216cba36941abcdff00c8df45577ffdda587e5a55079c9a8282fcf00e3dd3753e1d4f63a47d2d5feaeb3cfc889e7e1986b24b60f32651268f4ba94a5c2de4bdf3355af19cdbb5775e4485037d78381a7d73a53891cd30d49d75f8f3d3b677c729e9e1498a4bb85a6410be048e5999718b834e912a32c761819c676ccb6696657ff394ad08ef6f8bcb4fd8afc56920627242fd2206409bbe5d4f47784e1719c9e92bdc3ed8a15a4d970e496c72079ef24b8d0a8d48d3a74f39c0f50f1909bb5cb4a8c14d4571e3cbfedcefb2baef175ec17c0e798eb37ad653c88f6c8da94cad05a74c63202ff9478cd4f62035244040539272779267b116f7db7f444d6601915c56b53622833302fcb4e73ed1ca4850a611428f01e32d63136913c38985cd5d0a5ba0265629f127ab49aae1b7ce91fc25e149cf32b29a59168145739d233307b6463a8a8ce319f1c4e5e0cd53b85353e96333aadddc8cb8c6fee9569c5bcc959a3d16ea14a81b1e63acca9520a30397f09b2245d93639ab59a31c91bf5f11ea9bf90fabdb3288bb62c69b7d78f3f19c9e5c80f09ba22403c3353cda660e201c75c48bbb592f5448fb94807cafb694f1744f5443fc47f29033ea1c6782d1ae73513240c06048207d52ab7bd95c7ffcdcfa9867de3e13af87c6525051964d1c7c4e0aaca6e71cd3772b313bee384d64e6b9f48dfddce7030236231ebda7be138cf38bb9e09c250fa95819699569db578a543cb0beadcfb4c96ae6528dc9c267355bfa4bfdecfab7904cece77258fd67dd3a68f0eaadfddc7af69494a30fa9d8985094fe94df82365e7120ea502ec71b9f5e794d5c3696ba98f599216fc049fa6df50f89937c3b83a53dd577ea7733c388c65270708e773a586c0d48cd4a4ac91aecacf949eb3b6995ada496b6b79c93b262aa114b1f09b52eea20a65e9fd360300ee3336d7b1350a8ce14104e3992394ec4b104e5892472f448ccd63b092be7ef233af74106719db27d1365bdea3a0a80ec7948e7e0ee5590be753649f1c749b1ec5d1d0a00555718f4f58cee5f629dad7cfdfa9d35388aeb5a6bbb1f70eb37d6baa6a0ea236e7239adeae9a95081ac8c2e3c04c2ad0d6a94ca1df05898bb27e1c1db3f1246deba32ebc003c3c3337d0ac1c64486e32ebddad25ce49036f09d17350a53544e67033d24dcaba69a4f57d0959e62416b74745d79dbce987e583519c27f74e07a4c5d10a8c9ee274d2527240ccd8271d93be8cbf3c4f6d2a5462750db3b7a6498b56763a6a530c083c8ce4a5c329aec39749dd38af6fd6990b9dcc98b96e890edbcd3c4edead401299d032324749df4534a819ce04e1b5e23aaa1a646e04ee6aa01c1e72649ac984ee6c888942444440111100f0cc5a6731300d0eb396ad39dcc26a748043d7a323ebdacb054a539aa5080562b597a271d7e18adb3283eb1996b7b69a5ad20148afd9aa6dcb2bea3b7b0cf28f66e9af305bd676f609743691f239b768ab6b6d3f7f730ecd46f7d95efec56a8f0c55d9540f50c4e8a761e893eb6736ada4c4dc86a3653ba8da4914b69d094201cb46de76d2a536a529bd52018a24dcab0ab330201e813d888027989ec403535153e0262688e937c49046dfd99653a7624739156dc1190a91d7276e72cd88c48c8d615a5156472d7a05974e7136db52d0a067336e27b25b32121ae78731adde7a3126625a1371dc435723ad2cc52d4e79fbe7b655fbd624a9183b667715cf385503948726f3612b194444a922222008888027862201e62624444035949835388806b34a6068c4403cee63b988807a28cc852888066b4e6c54888066166616220190111100f62220088880222200888802222008888022220088880222200888807ffd9
2	\\x89504e470d0a1a0a0000000d494844520000012c000000a808030000006df5233d0000015f504c5445000000f7e018fffffff9df180000047b7b7b9b9b9beaeaea15100afcdf18fbe41847411cfee426aea229c6c6c6c2c2c2d9c82defe02b17535e01000d1cd6f59f9b32cdc84a1483b100000819cee81ba5be1fa3b8134a6116a6dd186c7a1780abdfdfdf6f6c36efe84e177a86b1b1b1494949666666a5962b8c8c8cf6f6f6848484d5d5d59494942c2c2c3a3a3aa9a9a9535353e796336543251b1b1b5d5d5dc48230363636764e2365402070707025252558585819c3e1da8c2b16698c1d8595945f2a135572605a2c8a8431eae24a188fc1124b61292413149bd29e622319424c1b85a9163d50010417246b891baadadd9442cc8e438584490d26370918214f351f3f3f2223150e312012b6b55756522e724f2d8f6239d1c739ead532c1af303930177c6f246a6625f4dc35867b31a58e2c323020938f3316444d0d2b412e1a111d1b0d2bb8c89e9e5278723c9b6e41eeeb60453f2d112f3368623bccca585216d1ca00000a4849444154789ced9d8f7bd3b819c7df288e9db8a9ddd0eb2e5c8133608738ceafc35947d28d0dcadadd5de1367edd1dac0910aeb075dc36c6ffffec95e436ca0f27759f340eb53e3c6dac5732b1be8ff4ea95924a001289442291482412c992e264a2e3b03b6ba2692be66a2c8606898ecdee2c8ba66accd590482412c96951465e258a22b53835a8d5bd2f43f87a9f16809b5f6d6e6e7e3581cdefe27efa058362ed7ef9f564bedf67f9d736c3489c58d35d9202b29b4a240b46f6b9c82821d712a5f8707d7dfd21b28e17549b617d9431c112ab1f0e768fae0ef861176dd9bf7e33e06fb4d4e31b028f637ee4f840b19e5c19b0fb94da6edf19f08c1af6ae9ff0e6fa5edccfbcdc24b6df492492e5433aa428b0d17077f7ca384fd972d7f3eb0259801f6f0fb8f353dc4fbf60ee5e0de1877b6ccde16731c87a01f05288c2bef97bdc4fbf688a348c9fc03acb9d11be27a9179f7e59592e404b2412c9e746c608a3c5f2aba2a91ef3c3c64dc6302713885516f2132f96442291482e28d9b311f763c7c346e12c1c246abde184d5dc59584ba8587a3a32297d2deec78e01e56c62a5932b562a3a7a62bba114ebd448b12220c58a80142b0252ac0848b12220c58ac03cc56ab8cea9deb3ad11e236e65b8f85304fb16c722ab12a4453558f5861f90d636c51c3b64f5fa3732406b15c8dfe2e9366483e21ad5193669dba42e7c9e2c5aa1395bd86ae8955d4315362c5da22d1fb5462c5028d6c477d4acb8a7ac7b9700e62b54dcbabe06bbdd16666a741cd15433378ba49883df8b876ab6159b6c38a3b8e6155836eb8dde8f8aa65a91d7a83ea6a6af09fc5cafcc5c271cef4888157aecbcc1e01a869c433b5c05bd52d428ca0116608f10c42334a44259a6bf2f2e8ff4bae6b60416c856d9760ce12c41a7317cbb74a40372229d118813630872ae168541c837478c9964708ab7c93783ebe98152a16bd07f1a8c665e29669be4b95bbc0dd90d2615ab020c124feb1b54432c7978ec5fcbc2766068e3f108ba732ac357e660e5e58819fe9b35484d5b54cda816ce067d068b3a61660d1d2acbb724ac799815881f0c483cf4dac743a37d06aaa58759758086f18ae851d9276bd36a1564d14ab44b09f11534807cd2e102b1803dca5172b9dea77917e2acd84d20b6bbdd5de5a41675953c4aad3aa32bfc4c55249fd4435649b8ad50c9acc36dd1a89b51bcea8583c8cf7999c4b2d564ebfa5148bb042a549a7f31baf58d9a39d823ed96735d8d445a3ce98573f883cb3ae45e8d65a1d3e0eb6512c9f68fc1e9bfa7373e0e646c5e232aaccbaec62d1cc953c6d498515bea901eab3b7a64f12ab4e0732df0e5c3656bf137443ec84bc9fb91ab6b726eb8619e266b250b3d94cba43dc12f5f6deb8589ad1a15a59cc44b21039929d3f21ddf044ac741ab50a3678c09fa3eec496d572e98e63cc593b2e715d723c98f981eb69d3488954a99b8292464e4ab3988b10b72d8ac5e32cc7a039bc7db5e865fc5fb00871f003b1f455508a4c1bf6f25a9fecb3dad5f2f12a42a65ade8276d0bd4a81b156a9567cbfcdb7bb6b95ab9593ee8709169cd7824cd8a6f7d0d170bb5c3e6e4e4db55c9b73cdcf40b8580a132b97bf4f9bd5deea410f7b23bce98688356fcaa79b672e965962a5fb59282ad0d373b9c2ca8f3d7d5a9c354f3e4fb10a0aa59b4be572dd829e9b1667cd93cf532c6c59d80d3750a6f420771162852da4c6c84cb1f4fb6c4b8377c7ad6a4162d5339d737e8733305bac5b3c6ec8be5bd37516a3a6e547616162a50baf8ef7d17a73a04bb1a68a85ca50afa514a93caffb6c3894624d168b4e7dba2f68d362edebd51a76c5747ab258aa5dc51f9c05364c9c23674cd32fdb8d2cd43198a78bc28ded528346afbe0a6851c167c5ea74212253812cb365a9ad0ab5326c619aa54c3b33e1bd6261b658e8b6f4d5e7c18647c5bd6e2a542c0bccb607660935b3cb19c3af8151575568680ee0e46f8b64caa4069e51b38034b0b0d7069c0b35e9bcc8b0c0776df0c0cb40bde38163806a35c1a2253cf027bc572ccc9ceef02f91a67af7a9a108f0560ff55996e335bd2a1503b60ca3b6add64cd56c82e1d860d8f5865a29ab0dc73631df341d0f352957b858cd865af24dbbc96c65df83ba099e63fbac846b2fc1149a332e168fd1076231634ed70fdeb03f2bcf1672a162a9dbd85c3cb07c689aa892d936db16ce9b4d970a66662ad596613b544c033c2c06758d8b657b9e29d8a8584d17efd2c0c106b86045a630a16531b1366826174bd7e9379a733c8850602dbc65e18f07d546dbaa5a75077fb5ccad966938605305db954ab554363a5cac0c818651d5e8f28cdac21bb58e016d022ab5790daf6d34f12e2c6181a62ec187609c31b1f42e554b58cfd2bbbf14b888fd232a564f0f138bae1ad4d06543ad9445ef5caab3145afd5a0d3ae0fb1d1ffd4f8dfda385eb2dbaea527730173afeb10d3d54ab4e2fb33596aa3b4bb333ffb05869bdb0b38ef3c094be43335fe4d37a7e230b3b2c1ad5fbd9e9625d7886c52af4f6b03df575fdc11e1dfb76f2a9b5e7b4d44e01fb62e12d0b4e31789062a5f8421fea71f4f6ed110d13b011e9072c2005e5facedb3d166cbd0a77f0179ea19695ebef9dec108cc2ec15f8faf2f17447a18ba5ab7939dd099ad64131d8778636a21e5b15dd81a2c2e4a2eb5af03aa5cbe90e172ba7af1d42b079d17a2fcf87c71e35f1c6b5fe0b3749b1b85af9d5fb74405f79d7d583a84bcff7debc4293f2026d8b5a295d4a46e22c1a62e9fd7e1707c460ad8f46a318bf17bafdfc894d8a35f8f207aa811ab1894f9a1973383b4ca7b9219d4aa883473f7496af1c2533ce42b16ee9f9e8e809fd83f2c395b3f03c91629db9cec9142b89b596482412894422590077ff22b00f70e9f7032e5f0378f90781db713f6dccec3f7a74f798474f003efe51e03d28cffe2490b4cdf267307dff77b9cff954460ec39262492492a562fa19ad497759e2917d577751accdcb617c4cfa4132f08f7b024f51ac4bd7c25040f9e7ef0464d4350365e2657288e08912a98f4422595ec69dd214373576cadac844f282b93876daeffefe3e3dce90bed0d37edf5f125046d222ef010eef0b1c01fc744738fd307bc1c482e1f30dd939d2fffa62c0e527f0f0f217215c7e0a1fc4c30f7f05f8b718b3debe605a151528ae072794d343cab99199383c2d18048aa3ffdb051367be0c9d79c8bfa1ab0892257e2629919c0ad95122a014f9d1c85782f391e9aac38beb61245c5b6542e8f0e9c6641efce7bf713f6eccc8112b02f46f9886d38a18100cae154549bab24aa00e8b8f82dd0886822765a870c229161531881c695830941cc94b1ce30b03b3d2490623851d8143808f3705de037c27a63fc6fdbc31f3e1c683136efc0fe09af8e1d735809b23e92433a3db29634b0bc9455106a3213714677ce768218fb5b428e3a1d5907a204a9ae8d150223937b6d5e8f02da21dd1b4845b3f9e03aaab45c5e5872b64843bddca8cb7914824920573f26157b0fea00cac30f2b9d88564ac82d36b3c5e7c6af28281b5bf7257e009d6f7f146184700cfbe1578067028e6ff1a7775ce1714ebde9f05f651ac9f7f13c2a74380dbbf157809f0fc9350e043dcd5395fc61ccd8c6e38d370b199e0b4a228a0842624128944229148249231fe0f2f31885c0b539f0e0000000049454e44ae426082
\.


--
-- TOC entry 5139 (class 0 OID 36469)
-- Dependencies: 224
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- TOC entry 5136 (class 0 OID 36450)
-- Dependencies: 221
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
1	css.jfif	d3a8064e9d9550056002a90a1a2aed3d5567dda5	.jfif	image	image/jpeg	6467	\N	2024-05-22T07:20:14.702Z	2024-05-22T07:20:14.702Z	\N	1
2	js.png	25f8487e10d727a83ba076c86cb1fde16631e7c5	.png	image	image/png	3052	\N	2024-05-22T07:28:45.096Z	2024-05-22T07:28:45.096Z	\N	1
\.


--
-- TOC entry 5140 (class 0 OID 36482)
-- Dependencies: 225
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- TOC entry 5176 (class 0 OID 36890)
-- Dependencies: 261
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- TOC entry 5174 (class 0 OID 36818)
-- Dependencies: 259
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
artalk	f	{"server":"","siteName":""}
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- TOC entry 5142 (class 0 OID 36492)
-- Dependencies: 227
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
\.


--
-- TOC entry 5143 (class 0 OID 36500)
-- Dependencies: 228
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
asciidoc	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- TOC entry 5145 (class 0 OID 36509)
-- Dependencies: 230
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2024-05-21T09:39:17.525Z	2024-05-21T09:39:17.525Z	/
2	Guests	["read:pages","read:assets","read:comments"]	[{"id":"guest","roles":["read:pages","read:assets","read:comments"],"match":"START","deny":false,"path":"","locales":[]}]	t	2024-05-21T09:39:17.530Z	2024-05-21T09:39:17.530Z	/
\.


--
-- TOC entry 5146 (class 0 OID 36518)
-- Dependencies: 231
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page","goadmin":"Administration"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Page Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.","editExternal":"Edit on {{name}}"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully.","pageExtensions":"Page Extensions","pageExtensionsHint":"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.","editMenuExternalName":"Button Site Name","editMenuExternalNameHint":"The name of the external site to display on the edit button. Do not include the \\"Edit on\\" prefix.","editMenuExternalIcon":"Button Icon","editMenuExternalIconHint":"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.","editMenuExternalUrl":"Button URL","editMenuExternalUrlHint":"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )","editShortcuts":"Edit Shortcuts","editFab":"FAB Quick Edit Menu","editFabHint":"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.","editMenuBar":"Edit Menu Bar","displayEditMenuBar":"Display Edit Menu Bar","displayEditMenuBarHint":"Display the edit menu bar in the page header.","displayEditMenuBtn":"Display Edit Button","displayEditMenuBtnHint":"Display a button to edit the current page.","displayEditMenuExternalBtn":"Display External Edit Button","displayEditMenuExternalBtnHint":"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.","footerOverride":"Footer Text Override","footerOverrideHint":"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options","tocHeadingLevels":"Default TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels by default."},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages","exportTitle":"Export to Disk","exportSubtitle":"Save content to tarball for backup / migration"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.","smtpName":"Client Identifying Hostname","smtpNameHint":"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify.","configSaveSuccess":"Comments configuration saved successfully."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags.","toc":"TOC","tocTitle":"Table of Contents","tocUseDefault":"Use Site Defaults","tocHeadingLevels":"TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2024-05-21T09:39:17.517Z	2024-05-22T08:22:04.699Z
\.


--
-- TOC entry 5147 (class 0 OID 36527)
-- Dependencies: 232
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- TOC entry 5131 (class 0 OID 36428)
-- Dependencies: 216
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2024-05-21 16:37:42.84+07
2	2.1.85.js	1	2024-05-21 16:37:42.842+07
3	2.2.3.js	1	2024-05-21 16:37:42.847+07
4	2.2.17.js	1	2024-05-21 16:37:42.848+07
5	2.3.10.js	1	2024-05-21 16:37:42.849+07
6	2.3.23.js	1	2024-05-21 16:37:42.849+07
7	2.4.13.js	1	2024-05-21 16:37:42.851+07
8	2.4.14.js	1	2024-05-21 16:37:42.855+07
9	2.4.36.js	1	2024-05-21 16:37:42.856+07
10	2.4.61.js	1	2024-05-21 16:37:42.856+07
11	2.5.1.js	1	2024-05-21 16:37:42.859+07
12	2.5.12.js	1	2024-05-21 16:37:42.86+07
13	2.5.108.js	1	2024-05-21 16:37:42.86+07
14	2.5.118.js	1	2024-05-21 16:37:42.861+07
15	2.5.122.js	1	2024-05-21 16:37:42.865+07
16	2.5.128.js	1	2024-05-21 16:37:42.866+07
\.


--
-- TOC entry 5133 (class 0 OID 36435)
-- Dependencies: 218
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- TOC entry 5148 (class 0 OID 36536)
-- Dependencies: 233
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"9b1417bf-7d9f-43d9-8c9d-a0afbd74755e","kind":"link","label":"Home","icon":"mdi-home","targetType":"home","target":"/","visibilityMode":"all","visibilityGroups":null},{"id":"1d87a029-4dba-4c7b-8fe5-b6764bc6ea2e","kind":"link","label":"Slicing Figma","icon":"mdi-chevron-right","targetType":"external","target":"/en/Slicing-figma","visibilityMode":"all","visibilityGroups":[]},{"id":"fcab764f-d220-4b38-b819-45866f35daa9","kind":"link","label":"CSS (Cascade Style Sheet)","icon":"mdi-chevron-right","targetType":"external","target":"/en/css","visibilityMode":"all","visibilityGroups":[]},{"id":"72812a96-047b-45a4-8d3b-37b329610b14","kind":"link","label":"HTML (Hyper Text Markup Language)","icon":"mdi-chevron-right","targetType":"external","target":"/en/html","visibilityMode":"all","visibilityGroups":[]},{"id":"9392afd5-331d-4533-bc8b-340afed21587","kind":"link","label":"Java Script","icon":"mdi-chevron-right","targetType":"external","target":"/en/javascript","visibilityMode":"all","visibilityGroups":[]}]}]
\.


--
-- TOC entry 5150 (class 0 OID 36544)
-- Dependencies: 235
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage	Homepage website	f	t			updated	1	<p><span class="text-huge">HOMEPAGE WEBSITE</span></p>\n<hr>\n<p>haihaihai</p>\n	html	2024-05-22T07:04:13.855Z	ckeditor	en	1	2024-05-21T10:02:46.411Z	{}
2	css	6e399cc0c9138e1f1b7c5ac32c405d22407b9577	Untitled Page		f	t			updated	3	<p><span class="text-huge">CSS (Cascading Style Sheet)</span></p>\n<hr>\n<p style="text-align:justify;"><i>Cascading Style Sheets </i>(CSS) merupakan bahasa pemrograman yang digunakan untuk menentukan bagaimana dokumen dan <i>website </i>akan disajikan. CSS dibuat oleh Word Wide Web Consortium (W3C) pada 1996.</p>\n<p style="text-align:justify;">&nbsp;</p>\n<p style="text-align:justify;">Jadi, CSS berisi kumpulan perintah yang digunakan untuk menjelaskan tampilan halaman situs <i>web </i>dalam <i>mark-up language</i>, seperti HTML yang terkenal sebagai bahasa pemrograman standar dan sering digunakan dalam proses pembuatan <i>website</i>. CSS hadir sebagai pemisah konten dari tampilan visualnya di situs di mana tentunya berpengaruh pada tampilan sebuah <i>website</i>.</p>\n<figure class="image"><img src="/css.jfif"></figure>\n	html	2024-05-22T07:21:04.369Z	ckeditor	en	1	2024-05-22T07:20:32.176Z	{}
\.


--
-- TOC entry 5167 (class 0 OID 36652)
-- Dependencies: 252
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- TOC entry 5152 (class 0 OID 36556)
-- Dependencies: 237
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
\.


--
-- TOC entry 5169 (class 0 OID 36669)
-- Dependencies: 254
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- TOC entry 5155 (class 0 OID 36573)
-- Dependencies: 240
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	css	1	CSS	f	f	\N	\N	3	en	[]
2	home	1	Homepage	f	f	\N	\N	1	en	[]
3	html	1	HTML	f	f	\N	\N	4	en	[]
4	javascript	1	Javascript Page	f	f	\N	\N	5	en	[]
5	Slicing-figma	1	Slicing Figma Page	f	f	\N	\N	2	en	[]
\.


--
-- TOC entry 5154 (class 0 OID 36563)
-- Dependencies: 239
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Homepage	Homepage website	f	t	\N			<p><span class="text-huge">Home Page</span></p>\n<p>Selamat datang di website Forustech</p>\n<hr>\n<p><span class="text-big">Selamat datang di website wiki.forustech.com , website yang berisi tentang kumpulan tutorial dalam pemrogaman. Dalam industri digital, pemrogaman adalah ilmu yang sedang banyak di gunakan di beberapa perusahaan besar maupun startup.&nbsp;</span></p>\n	<p><span class="text-huge">Home Page</span></p>\n<p>Selamat datang di website Forustech</p>\n<hr>\n<p><span class="text-big">Selamat datang di website wiki.forustech.com , website yang berisi tentang kumpulan tutorial dalam pemrogaman. Dalam industri digital, pemrogaman adalah ilmu yang sedang banyak di gunakan di beberapa perusahaan besar maupun startup.&nbsp;</span></p>\n	[]	html	2024-05-21T10:02:44.979Z	2024-05-22T07:04:16.364Z	ckeditor	en	1	1	{"js":"","css":""}
2	Slicing-figma	0b8e1a6c4f33df3aa5ea5d2b9103f7def5beabe6	Slicing Figma Page		f	t	\N			# SLICING FIGMA\nFigma kali ini membawa sebuah fitur baru yakni mode develop. Mode Develop dalam Figma adalah fitur terbaru yang dirancang khusus untuk membantu programmer dalam proses slicing atau konversi desain ke kode. Mode Develop memungkinkan kita melihat desain dalam tampilan yang lebih fokus pada elemen-elemen yang dapat diimplementasikan ke dalam kode, dan menyediakan berbagai alat yang membantu dalam proses tersebut. Berikut adalah beberapa fitur yang ada dalam Mode Develop di Figma:\n1. Inspect Design Dalam Mode Develop, Kita dapat dengan mudah memeriksa elemen-elemen desain seperti warna, ukuran, font, dan properti lainnya. kita dapat melihat atribut-atribut ini dengan detail, sehingga memudahkan kita dalam mengekstrak nilai-nilai tersebut untuk diimplementasikan ke dalam kode.\n2. Slicing Mode Develop memungkinkan kita untuk melakukan slicing pada desain dengan mudah. kita dapat mengidentifikasi elemen-elemen tertentu yang perlu dijadikan gambar atau kode, dan dengan sekali klik, Figma akan melakukan slicing otomatis dan menghasilkan output yang dapat digunakan dalam pengembangan.\n3. Ekspor Kode CSS atau SVG Dalam Mode Develop, kita dapat menyimpan kode CSS atau SVG dari elemen-elemen desain. Ini memungkinkan kita untuk menghasilkan kode yang siap digunakan dalam pengembangan, sehingga mempercepat proses implementasi desain ke dalam kode. 	<h1 class="toc-header" id="slicing-figma"><a href="#slicing-figma" class="toc-anchor">¶</a> SLICING FIGMA</h1>\n<p>Figma kali ini membawa sebuah fitur baru yakni mode develop. Mode Develop dalam Figma adalah fitur terbaru yang dirancang khusus untuk membantu programmer dalam proses slicing atau konversi desain ke kode. Mode Develop memungkinkan kita melihat desain dalam tampilan yang lebih fokus pada elemen-elemen yang dapat diimplementasikan ke dalam kode, dan menyediakan berbagai alat yang membantu dalam proses tersebut. Berikut adalah beberapa fitur yang ada dalam Mode Develop di Figma:</p>\n<ol>\n<li>Inspect Design Dalam Mode Develop, Kita dapat dengan mudah memeriksa elemen-elemen desain seperti warna, ukuran, font, dan properti lainnya. kita dapat melihat atribut-atribut ini dengan detail, sehingga memudahkan kita dalam mengekstrak nilai-nilai tersebut untuk diimplementasikan ke dalam kode.</li>\n<li>Slicing Mode Develop memungkinkan kita untuk melakukan slicing pada desain dengan mudah. kita dapat mengidentifikasi elemen-elemen tertentu yang perlu dijadikan gambar atau kode, dan dengan sekali klik, Figma akan melakukan slicing otomatis dan menghasilkan output yang dapat digunakan dalam pengembangan.</li>\n<li>Ekspor Kode CSS atau SVG Dalam Mode Develop, kita dapat menyimpan kode CSS atau SVG dari elemen-elemen desain. Ini memungkinkan kita untuk menghasilkan kode yang siap digunakan dalam pengembangan, sehingga mempercepat proses implementasi desain ke dalam kode.</li>\n</ol>\n	[{"title":"SLICING FIGMA","anchor":"#slicing-figma","children":[]}]	markdown	2024-05-22T07:11:22.029Z	2024-05-22T07:11:24.051Z	markdown	en	1	1	{"js":"","css":""}
3	css	6e399cc0c9138e1f1b7c5ac32c405d22407b9577	CSS		f	t	\N			<p><span class="text-huge">CSS (Cascading Style Sheet)</span></p>\n<hr>\n<p style="text-align:justify;"><i>Cascading Style Sheets </i>(CSS) merupakan bahasa pemrograman yang digunakan untuk menentukan bagaimana dokumen dan <i>website </i>akan disajikan. CSS dibuat oleh Word Wide Web Consortium (W3C) pada 1996.</p>\n<p style="text-align:justify;">&nbsp;</p>\n<p style="text-align:justify;">Jadi, CSS berisi kumpulan perintah yang digunakan untuk menjelaskan tampilan halaman situs <i>web </i>dalam <i>mark-up language</i>, seperti HTML yang terkenal sebagai bahasa pemrograman standar dan sering digunakan dalam proses pembuatan <i>website</i>. CSS hadir sebagai pemisah konten dari tampilan visualnya di situs di mana tentunya berpengaruh pada tampilan sebuah <i>website</i>.</p>\n<figure class="image"><img src="/css.jfif"></figure>\n	<p><span class="text-huge">CSS (Cascading Style Sheet)</span></p>\n<hr>\n<p style="text-align:justify;"><i>Cascading Style Sheets </i>(CSS) merupakan bahasa pemrograman yang digunakan untuk menentukan bagaimana dokumen dan <i>website </i>akan disajikan. CSS dibuat oleh Word Wide Web Consortium (W3C) pada 1996.</p>\n<p style="text-align:justify;">&nbsp;</p>\n<p style="text-align:justify;">Jadi, CSS berisi kumpulan perintah yang digunakan untuk menjelaskan tampilan halaman situs <i>web </i>dalam <i>mark-up language</i>, seperti HTML yang terkenal sebagai bahasa pemrograman standar dan sering digunakan dalam proses pembuatan <i>website</i>. CSS hadir sebagai pemisah konten dari tampilan visualnya di situs di mana tentunya berpengaruh pada tampilan sebuah <i>website</i>.</p>\n<figure class="image"><img src="/css.jfif"></figure>\n	[]	html	2024-05-22T07:20:30.256Z	2024-05-22T07:21:06.255Z	ckeditor	en	1	1	{"js":"","css":""}
4	html	d5b81c7eed3e6b55b69fbde2b159137fb47c6801	HTML	About Html	f	t	\N			# HTML\nHyper Text Markup Language\n\nCascading Style Sheets (CSS) merupakan bahasa pemrograman yang digunakan untuk menentukan bagaimana dokumen dan website akan disajikan. CSS dibuat oleh Word Wide Web Consortium (W3C) pada 1996.\n\n \n\nJadi, CSS berisi kumpulan perintah yang digunakan untuk menjelaskan tampilan halaman situs web dalam mark-up language, seperti HTML yang terkenal sebagai bahasa pemrograman standar dan sering digunakan dalam proses pembuatan website. CSS hadir sebagai pemisah konten dari tampilan visualnya di situs di mana tentunya berpengaruh pada tampilan sebuah website.\n	<h1 class="toc-header" id="html"><a href="#html" class="toc-anchor">¶</a> HTML</h1>\n<p>Hyper Text Markup Language</p>\n<p>Cascading Style Sheets (CSS) merupakan bahasa pemrograman yang digunakan untuk menentukan bagaimana dokumen dan website akan disajikan. CSS dibuat oleh Word Wide Web Consortium (W3C) pada 1996.</p>\n<p>Jadi, CSS berisi kumpulan perintah yang digunakan untuk menjelaskan tampilan halaman situs web dalam mark-up language, seperti HTML yang terkenal sebagai bahasa pemrograman standar dan sering digunakan dalam proses pembuatan website. CSS hadir sebagai pemisah konten dari tampilan visualnya di situs di mana tentunya berpengaruh pada tampilan sebuah website.</p>\n	[{"title":"HTML","anchor":"#html","children":[]}]	markdown	2024-05-22T07:24:04.507Z	2024-05-22T07:24:06.573Z	markdown	en	1	1	{"js":"","css":""}
5	javascript	3f04628d8a5e2b61d3196251e003e168462ce23d	Javascript Page	javascript 	f	t	\N			<h1>Javascript</h1>\n<p style="text-align:justify;">JavaScript merupakan bahasa pemrograman populer yang digunakan untuk membuat website interaktif dan dinamis. Adapun dinamis yang dimaksud di sini berarti konten di dalamnya dapat bergerak dan tampil secara otomatis tanpa harus dimuat ulang manual oleh pengguna. Dapat dikatakan juga bahwa JavaScript merupakan kunci yang perlu dikuasai para <i>web developer </i>untuk menciptakan website yang dapat berinteraksi atau memahami pengunjung di situs tersebut.&nbsp;</p>\n<p style="text-align:justify;">Saat ini, JavaScript digunakan untuk membuat berbagai macam aplikasi web, mulai dari website yang sederhana hingga website yang kompleks, seperti sosial media, <i>e-commerce, </i>gim, dan masih banyak lagi contoh lainnya.</p>\n<p style="text-align:justify;">Pada awalnya, JavaScript dikembangkan pada tahun 1995 oleh seorang programmer bernama Brendan Eich. Pada saat itu, Eich bekerja untuk perusahaan Netscape Communications dan diberi tugas untuk membuat bahasa pemrograman yang dapat berjalan di browser Netscape Navigator.&nbsp;</p>\n<figure class="image"><img src="/js.png">\n  <figcaption>javascript</figcaption>\n</figure>\n<p style="text-align:justify;">Awalnya, bahasa pemrograman ini disebut Mocha, kemudian diubah namanya menjadi LiveScript, dan akhirnya diubah lagi menjadi JavaScript. Nama "JavaScript" sebenarnya adalah pilihan pemasaran, karena bahasa ini diluncurkan pada saat popularitas bahasa pemrograman Java sedang melambung.&nbsp;</p>\n<p style="text-align:justify;">JavaScript awalnya digunakan untuk membuat efek-efek visual kecil pada halaman web dan validasi formulir. Namun, seiring berjalannya waktu, JavaScript telah berkembang menjadi bahasa pemrograman yang sangat kuat dan populer, digunakan untuk membuat aplikasi web berbasis browser, aplikasi mobile, game, dan bahkan untuk pengembangan back-end dengan bantuan <i>framework</i>, seperti <a href="https://www.biznetgio.com/news/apa-itu-react-js"><strong>React.js</strong></a> maupun <a href="https://www.biznetgio.com/news/apa-itu-node-js"><strong>Node.js</strong></a>. Saat ini, JavaScript adalah salah satu bahasa pemrograman paling populer di dunia, digunakan oleh jutaan pengembang di seluruh dunia. &nbsp;&nbsp;</p>\n	<h1 class="toc-header" id="javascript"><a href="#javascript" class="toc-anchor">¶</a> Javascript</h1>\n<p style="text-align:justify;">JavaScript merupakan bahasa pemrograman populer yang digunakan untuk membuat website interaktif dan dinamis. Adapun dinamis yang dimaksud di sini berarti konten di dalamnya dapat bergerak dan tampil secara otomatis tanpa harus dimuat ulang manual oleh pengguna. Dapat dikatakan juga bahwa JavaScript merupakan kunci yang perlu dikuasai para <i>web developer </i>untuk menciptakan website yang dapat berinteraksi atau memahami pengunjung di situs tersebut.&nbsp;</p>\n<p style="text-align:justify;">Saat ini, JavaScript digunakan untuk membuat berbagai macam aplikasi web, mulai dari website yang sederhana hingga website yang kompleks, seperti sosial media, <i>e-commerce, </i>gim, dan masih banyak lagi contoh lainnya.</p>\n<p style="text-align:justify;">Pada awalnya, JavaScript dikembangkan pada tahun 1995 oleh seorang programmer bernama Brendan Eich. Pada saat itu, Eich bekerja untuk perusahaan Netscape Communications dan diberi tugas untuk membuat bahasa pemrograman yang dapat berjalan di browser Netscape Navigator.&nbsp;</p>\n<figure class="image"><img src="/js.png">\n  <figcaption>javascript</figcaption>\n</figure>\n<p style="text-align:justify;">Awalnya, bahasa pemrograman ini disebut Mocha, kemudian diubah namanya menjadi LiveScript, dan akhirnya diubah lagi menjadi JavaScript. Nama "JavaScript" sebenarnya adalah pilihan pemasaran, karena bahasa ini diluncurkan pada saat popularitas bahasa pemrograman Java sedang melambung.&nbsp;</p>\n<p style="text-align:justify;">JavaScript awalnya digunakan untuk membuat efek-efek visual kecil pada halaman web dan validasi formulir. Namun, seiring berjalannya waktu, JavaScript telah berkembang menjadi bahasa pemrograman yang sangat kuat dan populer, digunakan untuk membuat aplikasi web berbasis browser, aplikasi mobile, game, dan bahkan untuk pengembangan back-end dengan bantuan <i>framework</i>, seperti <a class="is-external-link" href="https://www.biznetgio.com/news/apa-itu-react-js"><strong>React.js</strong></a> maupun <a class="is-external-link" href="https://www.biznetgio.com/news/apa-itu-node-js"><strong>Node.js</strong></a>. Saat ini, JavaScript adalah salah satu bahasa pemrograman paling populer di dunia, digunakan oleh jutaan pengembang di seluruh dunia. &nbsp;&nbsp;</p>\n	[{"title":"Javascript","anchor":"#javascript","children":[]}]	html	2024-05-22T07:29:13.743Z	2024-05-22T07:29:15.759Z	ckeditor	en	1	1	{"js":"","css":""}
\.


--
-- TOC entry 5156 (class 0 OID 36582)
-- Dependencies: 241
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPivotTable	f	{}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
asciidocCore	t	{"safeMode":"server"}
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
\.


--
-- TOC entry 5157 (class 0 OID 36590)
-- Dependencies: 242
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"6.x","hosts":"","verifyTLSCertificate":true,"tlsCertPath":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- TOC entry 5177 (class 0 OID 36893)
-- Dependencies: 262
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- TOC entry 5158 (class 0 OID 36598)
-- Dependencies: 243
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
certs	{"jwk":{"kty":"RSA","n":"wlPReYIDlS7KsQ7B2NYpY0dXXdgFGNsy67HTUqccPQAfIPrpK3h5AxXqBXWkDKeaLvFZ33jcaASvVFnZl-9wmn0zvc_9J56E_gR92tN9JZxWsBwzgJTFFzBaAfYbrIvHXVx9CQRYTLjTjFPkdDouCIFpwGkSf9GOKVgOh7MbPFtks4HtCNNbU0OoMfUwGz57nBwDJlBV1EAUIV3B07drWSTpWH30WiyBBrgnQXHhBlekui1bL7KXi5o0BrpZ4Rh1irjknPE_T3-EYXwDfnuJo0_DK7n5ht3b1AzATkovNsB8MOt12uQsbh7fSv08-NXy7kFsx329MA0LCauEc3Mfow","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAwlPReYIDlS7KsQ7B2NYpY0dXXdgFGNsy67HTUqccPQAfIPrpK3h5\\nAxXqBXWkDKeaLvFZ33jcaASvVFnZl+9wmn0zvc/9J56E/gR92tN9JZxWsBwzgJTF\\nFzBaAfYbrIvHXVx9CQRYTLjTjFPkdDouCIFpwGkSf9GOKVgOh7MbPFtks4HtCNNb\\nU0OoMfUwGz57nBwDJlBV1EAUIV3B07drWSTpWH30WiyBBrgnQXHhBlekui1bL7KX\\ni5o0BrpZ4Rh1irjknPE/T3+EYXwDfnuJo0/DK7n5ht3b1AzATkovNsB8MOt12uQs\\nbh7fSv08+NXy7kFsx329MA0LCauEc3MfowIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,6DBA4A9AD462A09F66B8063601161763\\n\\nM57vxjjLthcCP+reb8wM5o1mWeM+6E5pUgdCZG/A8tFyJ7OrRJzUG2nCBGzjHJAF\\njyr3i2POtuVPv7BV4KEF3316eg/Fa5ynDavXZP88NptxCk/8P00B89n7PTu8j+hy\\nYc72oKw1J7hGJx2Ju26JjQrgVdOCT6+yiEYSsXztjmwM4ILGaYXtrAK4x6CGh/9g\\nGRsKJbWoZ6xo9U10KqMfLWmievFlfHXNEGC47D1GtEDybAbtX2L2tlkPNqMBDEqa\\ni4f4A5tPRvnddoamX998WUOgvxhnXrXvcufBBWo6Q3FBA9TLPgdHFkkMzpbO18gf\\nJVYz1ezxiFuWYqR7IpU7KmxufnEi/G+U3GcbdwJM6F2pW9zDmZifGGhNbMtqKB/i\\noP4vGd0dHO2W8x6m9hmTQ17t7tuWXBpfSblqtFTTa7sEsbv65dZMi39BqY4KUhZF\\nyR571wnT0reAyR7Q84JXLL1aDUQBz0/pY7SB/uYBopl60h39loEP5n2l5FEhSYYP\\nmnHqaR4X0EPTPw5k0QMvOeUOa0lO+pS1npJjTPBuGNe5ofS+APYryEit2rMQjgNJ\\nUSsoseZe4kg1AlC2F8wyAKn4zzegWwQjb9ty704f9dXuXWVRiK8PcZdchqErajEg\\n7PaG+tSCemKTD8caQ/tBS8SQg/LO1Y+LUtyaLRnHK8eyJaJ9Bt5Q4J/prz2t4TG+\\ne1AWD7H+mNT7HET2zZSDwMaIHnvuLHpTO7OdQIlN+NaX+R3orgQce8CbAMveJmPV\\nxfpqKouMVK2dYiZ54b7mFddqy1OoB3bH8rxvlU6a386zmXlhrVXy1WHsECMqfrg6\\nvmXqIk8DTFawo2o7pC8XZXpE3ONtgaCn2kCc8hmsLPUV7cNtpO5wv8RIuWJ89PUR\\nylvwzBtWZj0aKakVe1J/0Rx8qGu9NFFvCvIZCP2G6LRupUFO5d+YfmVH0IWUStvB\\nO+4Ry0NdGn1b2b/2qAxtrJckuXXRWjVFpFAI+MCp+jlyOPtmmhZlfMbE2kk/aklf\\n3acS+5FM9YOAEGUTyGhUtX5hh+k+W+NWMBe/kK8G3wcnbd2KtwQ8C7rJ63uR9vCo\\nMGsNShStToJ9X9EKlVgC0qbl6CRv7pe4VMgavz81+Fd+scmdzqODnKBToEZwrcLo\\nSYP+M6tLHRFLE0FwOv2i3+vcBss/wj/ez48+6XNegqpDscYkl9Io+GSGxJ8njRvO\\nkgbxFCUX2T5NRjQCrQTsbqSjiWRLWq07YJfOwRSlMNmpAixrvT1XauUnPDB6RPU/\\nlKStiF2CRGp1gxEbiFA1ghTY4hERm7cob9dTR/p+GxW4caQbIvavVxLdF+PsED77\\n/VUBDvPUPcoJ5mk3Fh6lcdxoqmWAUIHStLIz2VTmogaia3wnboAuA+IJx4l6XIVm\\n1ySUJ2ZSQEZQTl93aFo8+O40H1o79qpzy79CU63qNCo5WvQgRli22xJgekQ4/sTj\\n3FWAt4JVI4xs/AXA5ndANx/0h+Oa4t99HBSmmP+OFOSaQmjJ8Tz2j4Lr/jaY7BqY\\nfJJNvr2ymT6qjrFyKh+f4O4atpszSXWGrY3LIo7rw3/Z9bVDRVq5YuBVurmFVWqj\\n-----END RSA PRIVATE KEY-----\\n"}	2024-05-21T09:39:17.418Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2024-05-21T09:39:17.429Z
logo	{"hasLogo":false,"logoIsSquare":false}	2024-05-21T09:39:17.435Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"name":"","secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2024-05-21T09:39:17.439Z
sessionSecret	{"v":"0d9faca8333fa449233ebeed7388b7f536d48a78cb84dfcd041eb33a23a38528"}	2024-05-21T09:39:17.445Z
telemetry	{"isEnabled":true,"clientId":"ea29542c-7230-4ea3-9cc8-6059ffe7b589"}	2024-05-21T09:39:17.447Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2024-05-21T09:39:17.449Z
host	{"v":"https://wiki.forustech.com"}	2024-05-21T10:06:38.624Z
title	{"v":"Wiki.js"}	2024-05-21T10:06:38.627Z
company	{"v":""}	2024-05-21T10:06:38.629Z
contentLicense	{"v":""}	2024-05-21T10:06:38.631Z
footerOverride	{"v":""}	2024-05-21T10:06:38.633Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2024-05-21T10:06:38.635Z
logoUrl	{"v":"https://static.requarks.io/logo/wikijs-butterfly.svg"}	2024-05-21T10:06:38.638Z
pageExtensions	{"v":["md","html","txt"]}	2024-05-21T10:06:38.640Z
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2024-05-21T10:06:38.641Z
editShortcuts	{"editFab":true,"editMenuBar":false,"editMenuBtn":true,"editMenuExternalBtn":true,"editMenuExternalName":"GitHub","editMenuExternalIcon":"mdi-github","editMenuExternalUrl":"https://github.com/org/repo/blob/main/{filename}"}	2024-05-21T10:06:38.643Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2024-05-21T10:06:38.644Z
security	{"securityOpenRedirect":true,"securityIframe":true,"securityReferrerPolicy":true,"securityTrustProxy":false,"securitySRI":true,"securityHSTS":false,"securityHSTSDuration":300,"securityCSP":false,"securityCSPDirectives":""}	2024-05-21T10:06:38.646Z
uploads	{"maxFileSize":5242880,"maxFiles":10,"scanSVG":true,"forceDownload":true}	2024-05-21T10:06:38.647Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":["en"],"rtl":false}	2024-05-21T10:09:26.243Z
nav	{"mode":"MIXED"}	2024-05-22T07:29:35.030Z
\.


--
-- TOC entry 5159 (class 0 OID 36605)
-- Dependencies: 244
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","gitBinaryPath":""}	PT5M	{"status":"pending","message":"","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"","lastAttempt":null}
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
\.


--
-- TOC entry 5161 (class 0 OID 36615)
-- Dependencies: 246
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5175 (class 0 OID 36835)
-- Dependencies: 260
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- TOC entry 5171 (class 0 OID 36686)
-- Dependencies: 256
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
\.


--
-- TOC entry 5163 (class 0 OID 36626)
-- Dependencies: 248
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- TOC entry 5165 (class 0 OID 36635)
-- Dependencies: 250
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2024-05-21T09:39:18.091Z	2024-05-21T09:39:18.091Z	local	en	markdown	\N		
1	aravikaprakusiya@gmail.com	Administrator	\N	$2a$12$uWaI2HqwU.0D1u0cbK/Er.j02S1sKEbhU4V8Ci.BB/p2cSzZf/BIC	f	\N			\N	America/New_York	f	t	t	f	2024-05-21T09:39:17.707Z	2024-05-21T09:39:17.707Z	local	en	markdown	2024-05-22T08:24:37.656Z		
\.


--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 257
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 1, false);


--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 223
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 220
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assets_id_seq', 2, true);


--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 226
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 229
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 2, true);


--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 215
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 251
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 234
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 2, true);


--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 236
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 1, false);


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 253
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 1, false);


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 238
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pages_id_seq', 5, true);


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 245
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 255
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 2, true);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 247
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 249
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4898 (class 2606 OID 36448)
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- TOC entry 4953 (class 2606 OID 36812)
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 36467)
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 36476)
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 36460)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- TOC entry 4906 (class 2606 OID 36490)
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- TOC entry 4955 (class 2606 OID 36825)
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- TOC entry 4908 (class 2606 OID 36499)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 36507)
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- TOC entry 4912 (class 2606 OID 36517)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 36526)
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- TOC entry 4916 (class 2606 OID 36535)
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- TOC entry 4896 (class 2606 OID 36440)
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- TOC entry 4894 (class 2606 OID 36433)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4918 (class 2606 OID 36542)
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- TOC entry 4947 (class 2606 OID 36657)
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 36554)
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 36561)
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- TOC entry 4949 (class 2606 OID 36674)
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- TOC entry 4927 (class 2606 OID 36581)
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- TOC entry 4925 (class 2606 OID 36572)
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- TOC entry 4929 (class 2606 OID 36589)
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- TOC entry 4931 (class 2606 OID 36597)
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- TOC entry 4960 (class 2606 OID 36899)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- TOC entry 4933 (class 2606 OID 36604)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- TOC entry 4935 (class 2606 OID 36613)
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- TOC entry 4937 (class 2606 OID 36622)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 36624)
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- TOC entry 4957 (class 2606 OID 36841)
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- TOC entry 4951 (class 2606 OID 36691)
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- TOC entry 4941 (class 2606 OID 36633)
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 36650)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4945 (class 2606 OID 36802)
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- TOC entry 4923 (class 1259 OID 36742)
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- TOC entry 4958 (class 1259 OID 36900)
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- TOC entry 4963 (class 2606 OID 36477)
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- TOC entry 4961 (class 2606 OID 36707)
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- TOC entry 4962 (class 2606 OID 36702)
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- TOC entry 4964 (class 2606 OID 36717)
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- TOC entry 4965 (class 2606 OID 36712)
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- TOC entry 4966 (class 2606 OID 36732)
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- TOC entry 4967 (class 2606 OID 36722)
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- TOC entry 4968 (class 2606 OID 36727)
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- TOC entry 4981 (class 2606 OID 36658)
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- TOC entry 4982 (class 2606 OID 36663)
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- TOC entry 4969 (class 2606 OID 36737)
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- TOC entry 4970 (class 2606 OID 36753)
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- TOC entry 4971 (class 2606 OID 36758)
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- TOC entry 4972 (class 2606 OID 36743)
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- TOC entry 4973 (class 2606 OID 36748)
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- TOC entry 4983 (class 2606 OID 36675)
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- TOC entry 4984 (class 2606 OID 36680)
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- TOC entry 4974 (class 2606 OID 36773)
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- TOC entry 4975 (class 2606 OID 36768)
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- TOC entry 4976 (class 2606 OID 36763)
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- TOC entry 4985 (class 2606 OID 36697)
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4986 (class 2606 OID 36692)
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4977 (class 2606 OID 36778)
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- TOC entry 4978 (class 2606 OID 36796)
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- TOC entry 4979 (class 2606 OID 36791)
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- TOC entry 4980 (class 2606 OID 36786)
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


-- Completed on 2024-06-24 14:35:01

--
-- PostgreSQL database dump complete
--

