PGDMP                      }            kv_ex1    15.8    16.4 #               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    28733    kv_ex1    DATABASE     z   CREATE DATABASE kv_ex1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE kv_ex1;
                postgres    false            �            1259    29074 
   book_types    TABLE     ]   CREATE TABLE public.book_types (
    id integer NOT NULL,
    name character varying(155)
);
    DROP TABLE public.book_types;
       public         heap    postgres    false            �            1259    29073    book_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.book_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.book_types_id_seq;
       public          postgres    false    215                       0    0    book_types_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.book_types_id_seq OWNED BY public.book_types.id;
          public          postgres    false    214            �            1259    29081    books    TABLE     g  CREATE TABLE public.books (
    id integer NOT NULL,
    author character varying(155),
    name character varying(155),
    id_type integer,
    obloshka character varying(50),
    pages_number integer,
    year integer,
    isbn character varying(11),
    izdatelstvo character varying(255),
    price numeric(10,2),
    anotation character varying(255)
);
    DROP TABLE public.books;
       public         heap    postgres    false            �            1259    29080    books_id_seq    SEQUENCE     �   CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.books_id_seq;
       public          postgres    false    217                        0    0    books_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;
          public          postgres    false    216            �            1259    29095    readers    TABLE     �   CREATE TABLE public.readers (
    id integer NOT NULL,
    first_name character varying(155),
    name character varying(155),
    second_name character varying(155)
);
    DROP TABLE public.readers;
       public         heap    postgres    false            �            1259    29094    readers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.readers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.readers_id_seq;
       public          postgres    false    219            !           0    0    readers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.readers_id_seq OWNED BY public.readers.id;
          public          postgres    false    218            �            1259    29102    video_books    TABLE     �   CREATE TABLE public.video_books (
    id integer NOT NULL,
    id_reader integer,
    id_book integer,
    out_data date,
    in_data date
);
    DROP TABLE public.video_books;
       public         heap    postgres    false            �            1259    29101    video_books_id_seq    SEQUENCE     �   CREATE SEQUENCE public.video_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.video_books_id_seq;
       public          postgres    false    221            "           0    0    video_books_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.video_books_id_seq OWNED BY public.video_books.id;
          public          postgres    false    220            t           2604    29077    book_types id    DEFAULT     n   ALTER TABLE ONLY public.book_types ALTER COLUMN id SET DEFAULT nextval('public.book_types_id_seq'::regclass);
 <   ALTER TABLE public.book_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            u           2604    29084    books id    DEFAULT     d   ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);
 7   ALTER TABLE public.books ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            v           2604    29098 
   readers id    DEFAULT     h   ALTER TABLE ONLY public.readers ALTER COLUMN id SET DEFAULT nextval('public.readers_id_seq'::regclass);
 9   ALTER TABLE public.readers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            w           2604    29105    video_books id    DEFAULT     p   ALTER TABLE ONLY public.video_books ALTER COLUMN id SET DEFAULT nextval('public.video_books_id_seq'::regclass);
 =   ALTER TABLE public.video_books ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221                      0    29074 
   book_types 
   TABLE DATA           .   COPY public.book_types (id, name) FROM stdin;
    public          postgres    false    215   N&                 0    29081    books 
   TABLE DATA           }   COPY public.books (id, author, name, id_type, obloshka, pages_number, year, isbn, izdatelstvo, price, anotation) FROM stdin;
    public          postgres    false    217   �'                 0    29095    readers 
   TABLE DATA           D   COPY public.readers (id, first_name, name, second_name) FROM stdin;
    public          postgres    false    219   �(                 0    29102    video_books 
   TABLE DATA           P   COPY public.video_books (id, id_reader, id_book, out_data, in_data) FROM stdin;
    public          postgres    false    221   +)       #           0    0    book_types_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.book_types_id_seq', 1, false);
          public          postgres    false    214            $           0    0    books_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.books_id_seq', 1, false);
          public          postgres    false    216            %           0    0    readers_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.readers_id_seq', 1, false);
          public          postgres    false    218            &           0    0    video_books_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.video_books_id_seq', 1, false);
          public          postgres    false    220            y           2606    29079    book_types book_types_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.book_types
    ADD CONSTRAINT book_types_id_key UNIQUE (id);
 F   ALTER TABLE ONLY public.book_types DROP CONSTRAINT book_types_id_key;
       public            postgres    false    215            {           2606    29088    books books_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.books DROP CONSTRAINT books_id_key;
       public            postgres    false    217            }           2606    29100    readers readers_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.readers
    ADD CONSTRAINT readers_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.readers DROP CONSTRAINT readers_id_key;
       public            postgres    false    219                       2606    29107    video_books video_books_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.video_books
    ADD CONSTRAINT video_books_id_key UNIQUE (id);
 H   ALTER TABLE ONLY public.video_books DROP CONSTRAINT video_books_id_key;
       public            postgres    false    221            �           2606    29089    books books_id_type_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_id_type_fkey FOREIGN KEY (id_type) REFERENCES public.book_types(id);
 B   ALTER TABLE ONLY public.books DROP CONSTRAINT books_id_type_fkey;
       public          postgres    false    215    217    3193            �           2606    29113 $   video_books video_books_id_book_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.video_books
    ADD CONSTRAINT video_books_id_book_fkey FOREIGN KEY (id_book) REFERENCES public.books(id);
 N   ALTER TABLE ONLY public.video_books DROP CONSTRAINT video_books_id_book_fkey;
       public          postgres    false    221    3195    217            �           2606    29108 &   video_books video_books_id_reader_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.video_books
    ADD CONSTRAINT video_books_id_reader_fkey FOREIGN KEY (id_reader) REFERENCES public.readers(id);
 P   ALTER TABLE ONLY public.video_books DROP CONSTRAINT video_books_id_reader_fkey;
       public          postgres    false    219    3197    221               L  x�]Rm��@�=��n�)*�e#h�5^�%����kэi;}��^�A����4r�VO��;���x*�� ��-h�Pw��Z:Zy-��-QЃ�@�MN
餒_ZY�.W$7����;�1��/{�r���9FFF��4A��;03�qt�1k�\���k2m=(Epj妥s~���+�R9��<�_i��Ǥ��5h���q�{Jp�l1f�<+���)����a�=�'�bʖR>]DZM����\���rz�>F�2�Ⱦ���z�����~�m$�`����j����J�4Ƭa�D��d�ᦣ�f#�4���t_�D��=�x         �   x���K
�@���)<A�d����èkA7�(��(>P|�����]�n�	y|�-na�,Lp�#L{LX�N�4�L�:�F8kٌ�n@����26	�8`-X�'%}�E]9.���N�{O�4�R��#<�L�{�d1y{��K�q��Ѷh
%����1F-�@���5��n)�n�%��V�y������%�돦3���ｗؖ�aE��:E         �   x�M�M
�@Fי���Ìݸp#� .���v<�ˍ̄�n��^��p&�(���A�<�=/z����7�6,��F��ȕƔlm�3�n��qm)ܦ�o����U.�_jt��u��e�v������Bg��{�Y�!��         R   x�m���0��.E�� �`��?���c�9��<��9��"��N���Y��%��.�Z|Aϲ�g.���� � ��     