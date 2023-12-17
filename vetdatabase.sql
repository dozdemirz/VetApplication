PGDMP  3    2                {            vet    16.1    16.1 G    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16781    vet    DATABASE     w   CREATE DATABASE vet WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_Turkey.1254';
    DROP DATABASE vet;
                postgres    false            �            1259    16784    animals    TABLE     k  CREATE TABLE public.animals (
    animal_id bigint NOT NULL,
    animal_name character varying(255) NOT NULL,
    animal_birth date,
    animal_breed character varying(255) NOT NULL,
    animal_color character varying(255),
    animal_gender character varying(255) NOT NULL,
    animal_species character varying(255) NOT NULL,
    customer_id integer NOT NULL
);
    DROP TABLE public.animals;
       public         heap    postgres    false            �            1259    16782    animals_animal_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.animals_animal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.animals_animal_id_seq;
       public          postgres    false    217            �           0    0    animals_animal_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.animals_animal_id_seq OWNED BY public.animals.animal_id;
          public          postgres    false    215            �            1259    16783    animals_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.animals_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.animals_customer_id_seq;
       public          postgres    false    217            �           0    0    animals_customer_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.animals_customer_id_seq OWNED BY public.animals.customer_id;
          public          postgres    false    216            �            1259    16796    appointment    TABLE     �   CREATE TABLE public.appointment (
    appointment_id bigint NOT NULL,
    appointment_date timestamp(6) without time zone NOT NULL,
    animal_id integer NOT NULL,
    doctor_id integer NOT NULL
);
    DROP TABLE public.appointment;
       public         heap    postgres    false            �            1259    16794    appointment_animal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointment_animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.appointment_animal_id_seq;
       public          postgres    false    221            �           0    0    appointment_animal_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.appointment_animal_id_seq OWNED BY public.appointment.animal_id;
          public          postgres    false    219            �            1259    16793    appointment_appointment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointment_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.appointment_appointment_id_seq;
       public          postgres    false    221            �           0    0    appointment_appointment_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.appointment_appointment_id_seq OWNED BY public.appointment.appointment_id;
          public          postgres    false    218            �            1259    16795    appointment_doctor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointment_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.appointment_doctor_id_seq;
       public          postgres    false    221            �           0    0    appointment_doctor_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.appointment_doctor_id_seq OWNED BY public.appointment.doctor_id;
          public          postgres    false    220            �            1259    16806    available_date    TABLE     �   CREATE TABLE public.available_date (
    available_date_id bigint NOT NULL,
    available_date date NOT NULL,
    doctor_id integer NOT NULL
);
 "   DROP TABLE public.available_date;
       public         heap    postgres    false            �            1259    16804 $   available_date_available_date_id_seq    SEQUENCE     �   CREATE SEQUENCE public.available_date_available_date_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.available_date_available_date_id_seq;
       public          postgres    false    224            �           0    0 $   available_date_available_date_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.available_date_available_date_id_seq OWNED BY public.available_date.available_date_id;
          public          postgres    false    222            �            1259    16805    available_date_doctor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.available_date_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.available_date_doctor_id_seq;
       public          postgres    false    224                        0    0    available_date_doctor_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.available_date_doctor_id_seq OWNED BY public.available_date.doctor_id;
          public          postgres    false    223            �            1259    16814    customer    TABLE     C  CREATE TABLE public.customer (
    customer_id bigint NOT NULL,
    customer_address character varying(255) NOT NULL,
    customer_city character varying(20) NOT NULL,
    customer_mail character varying(70) NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_phone character varying(100) NOT NULL
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    16813    customer_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.customer_customer_id_seq;
       public          postgres    false    226                       0    0    customer_customer_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;
          public          postgres    false    225            �            1259    16823    doctor    TABLE     5  CREATE TABLE public.doctor (
    doctor_id bigint NOT NULL,
    doctor_address character varying(255) NOT NULL,
    doctor_city character varying(20) NOT NULL,
    doctor_mail character varying(70) NOT NULL,
    doctor_name character varying(255) NOT NULL,
    doctor_phone character varying(100) NOT NULL
);
    DROP TABLE public.doctor;
       public         heap    postgres    false            �            1259    16822    doctor_doctor_id_seq    SEQUENCE     }   CREATE SEQUENCE public.doctor_doctor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.doctor_doctor_id_seq;
       public          postgres    false    228                       0    0    doctor_doctor_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.doctor_doctor_id_seq OWNED BY public.doctor.doctor_id;
          public          postgres    false    227            �            1259    16833    vaccine    TABLE       CREATE TABLE public.vaccine (
    vaccine_id bigint NOT NULL,
    protection_finish_date date NOT NULL,
    protection_start_date date NOT NULL,
    vaccine_code character varying(255) NOT NULL,
    vaccine_name character varying(255) NOT NULL,
    animal_id integer NOT NULL
);
    DROP TABLE public.vaccine;
       public         heap    postgres    false            �            1259    16832    vaccine_animal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vaccine_animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.vaccine_animal_id_seq;
       public          postgres    false    231                       0    0    vaccine_animal_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.vaccine_animal_id_seq OWNED BY public.vaccine.animal_id;
          public          postgres    false    230            �            1259    16831    vaccine_vaccine_id_seq    SEQUENCE        CREATE SEQUENCE public.vaccine_vaccine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.vaccine_vaccine_id_seq;
       public          postgres    false    231                       0    0    vaccine_vaccine_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.vaccine_vaccine_id_seq OWNED BY public.vaccine.vaccine_id;
          public          postgres    false    229            8           2604    16787    animals animal_id    DEFAULT     v   ALTER TABLE ONLY public.animals ALTER COLUMN animal_id SET DEFAULT nextval('public.animals_animal_id_seq'::regclass);
 @   ALTER TABLE public.animals ALTER COLUMN animal_id DROP DEFAULT;
       public          postgres    false    217    215    217            9           2604    16788    animals customer_id    DEFAULT     z   ALTER TABLE ONLY public.animals ALTER COLUMN customer_id SET DEFAULT nextval('public.animals_customer_id_seq'::regclass);
 B   ALTER TABLE public.animals ALTER COLUMN customer_id DROP DEFAULT;
       public          postgres    false    217    216    217            :           2604    16799    appointment appointment_id    DEFAULT     �   ALTER TABLE ONLY public.appointment ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment_appointment_id_seq'::regclass);
 I   ALTER TABLE public.appointment ALTER COLUMN appointment_id DROP DEFAULT;
       public          postgres    false    221    218    221            ;           2604    16800    appointment animal_id    DEFAULT     ~   ALTER TABLE ONLY public.appointment ALTER COLUMN animal_id SET DEFAULT nextval('public.appointment_animal_id_seq'::regclass);
 D   ALTER TABLE public.appointment ALTER COLUMN animal_id DROP DEFAULT;
       public          postgres    false    219    221    221            <           2604    16801    appointment doctor_id    DEFAULT     ~   ALTER TABLE ONLY public.appointment ALTER COLUMN doctor_id SET DEFAULT nextval('public.appointment_doctor_id_seq'::regclass);
 D   ALTER TABLE public.appointment ALTER COLUMN doctor_id DROP DEFAULT;
       public          postgres    false    220    221    221            =           2604    16809     available_date available_date_id    DEFAULT     �   ALTER TABLE ONLY public.available_date ALTER COLUMN available_date_id SET DEFAULT nextval('public.available_date_available_date_id_seq'::regclass);
 O   ALTER TABLE public.available_date ALTER COLUMN available_date_id DROP DEFAULT;
       public          postgres    false    224    222    224            >           2604    16810    available_date doctor_id    DEFAULT     �   ALTER TABLE ONLY public.available_date ALTER COLUMN doctor_id SET DEFAULT nextval('public.available_date_doctor_id_seq'::regclass);
 G   ALTER TABLE public.available_date ALTER COLUMN doctor_id DROP DEFAULT;
       public          postgres    false    223    224    224            ?           2604    16817    customer customer_id    DEFAULT     |   ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);
 C   ALTER TABLE public.customer ALTER COLUMN customer_id DROP DEFAULT;
       public          postgres    false    225    226    226            @           2604    16826    doctor doctor_id    DEFAULT     t   ALTER TABLE ONLY public.doctor ALTER COLUMN doctor_id SET DEFAULT nextval('public.doctor_doctor_id_seq'::regclass);
 ?   ALTER TABLE public.doctor ALTER COLUMN doctor_id DROP DEFAULT;
       public          postgres    false    227    228    228            A           2604    16836    vaccine vaccine_id    DEFAULT     x   ALTER TABLE ONLY public.vaccine ALTER COLUMN vaccine_id SET DEFAULT nextval('public.vaccine_vaccine_id_seq'::regclass);
 A   ALTER TABLE public.vaccine ALTER COLUMN vaccine_id DROP DEFAULT;
       public          postgres    false    231    229    231            B           2604    16837    vaccine animal_id    DEFAULT     v   ALTER TABLE ONLY public.vaccine ALTER COLUMN animal_id SET DEFAULT nextval('public.vaccine_animal_id_seq'::regclass);
 @   ALTER TABLE public.vaccine ALTER COLUMN animal_id DROP DEFAULT;
       public          postgres    false    230    231    231            �          0    16784    animals 
   TABLE DATA           �   COPY public.animals (animal_id, animal_name, animal_birth, animal_breed, animal_color, animal_gender, animal_species, customer_id) FROM stdin;
    public          postgres    false    217   �U       �          0    16796    appointment 
   TABLE DATA           ]   COPY public.appointment (appointment_id, appointment_date, animal_id, doctor_id) FROM stdin;
    public          postgres    false    221   xV       �          0    16806    available_date 
   TABLE DATA           V   COPY public.available_date (available_date_id, available_date, doctor_id) FROM stdin;
    public          postgres    false    224   �V       �          0    16814    customer 
   TABLE DATA           ~   COPY public.customer (customer_id, customer_address, customer_city, customer_mail, customer_name, customer_phone) FROM stdin;
    public          postgres    false    226   "W       �          0    16823    doctor 
   TABLE DATA           p   COPY public.doctor (doctor_id, doctor_address, doctor_city, doctor_mail, doctor_name, doctor_phone) FROM stdin;
    public          postgres    false    228   7X       �          0    16833    vaccine 
   TABLE DATA           �   COPY public.vaccine (vaccine_id, protection_finish_date, protection_start_date, vaccine_code, vaccine_name, animal_id) FROM stdin;
    public          postgres    false    231   YY                  0    0    animals_animal_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.animals_animal_id_seq', 5, true);
          public          postgres    false    215                       0    0    animals_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.animals_customer_id_seq', 1, false);
          public          postgres    false    216                       0    0    appointment_animal_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.appointment_animal_id_seq', 1, false);
          public          postgres    false    219                       0    0    appointment_appointment_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.appointment_appointment_id_seq', 5, true);
          public          postgres    false    218            	           0    0    appointment_doctor_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.appointment_doctor_id_seq', 1, false);
          public          postgres    false    220            
           0    0 $   available_date_available_date_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.available_date_available_date_id_seq', 5, true);
          public          postgres    false    222                       0    0    available_date_doctor_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.available_date_doctor_id_seq', 1, false);
          public          postgres    false    223                       0    0    customer_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.customer_customer_id_seq', 5, true);
          public          postgres    false    225                       0    0    doctor_doctor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.doctor_doctor_id_seq', 5, true);
          public          postgres    false    227                       0    0    vaccine_animal_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.vaccine_animal_id_seq', 1, false);
          public          postgres    false    230                       0    0    vaccine_vaccine_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.vaccine_vaccine_id_seq', 5, true);
          public          postgres    false    229            D           2606    16792    animals animals_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (animal_id);
 >   ALTER TABLE ONLY public.animals DROP CONSTRAINT animals_pkey;
       public            postgres    false    217            F           2606    16803    appointment appointment_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);
 F   ALTER TABLE ONLY public.appointment DROP CONSTRAINT appointment_pkey;
       public            postgres    false    221            H           2606    16812 "   available_date available_date_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.available_date
    ADD CONSTRAINT available_date_pkey PRIMARY KEY (available_date_id);
 L   ALTER TABLE ONLY public.available_date DROP CONSTRAINT available_date_pkey;
       public            postgres    false    224            J           2606    16821    customer customer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    226            L           2606    16830    doctor doctor_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (doctor_id);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public            postgres    false    228            N           2606    16841    vaccine vaccine_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.vaccine
    ADD CONSTRAINT vaccine_pkey PRIMARY KEY (vaccine_id);
 >   ALTER TABLE ONLY public.vaccine DROP CONSTRAINT vaccine_pkey;
       public            postgres    false    231            S           2606    16862 #   vaccine fkcphlsnwa208me208efvjl8mi7    FK CONSTRAINT     �   ALTER TABLE ONLY public.vaccine
    ADD CONSTRAINT fkcphlsnwa208me208efvjl8mi7 FOREIGN KEY (animal_id) REFERENCES public.animals(animal_id);
 M   ALTER TABLE ONLY public.vaccine DROP CONSTRAINT fkcphlsnwa208me208efvjl8mi7;
       public          postgres    false    4676    231    217            P           2606    16847 '   appointment fkdy3k7vnx8icftprffg2q9y896    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT fkdy3k7vnx8icftprffg2q9y896 FOREIGN KEY (animal_id) REFERENCES public.animals(animal_id);
 Q   ALTER TABLE ONLY public.appointment DROP CONSTRAINT fkdy3k7vnx8icftprffg2q9y896;
       public          postgres    false    4676    221    217            R           2606    16857 *   available_date fkk0d6pu1wxarsoou0x2e1cc2on    FK CONSTRAINT     �   ALTER TABLE ONLY public.available_date
    ADD CONSTRAINT fkk0d6pu1wxarsoou0x2e1cc2on FOREIGN KEY (doctor_id) REFERENCES public.doctor(doctor_id);
 T   ALTER TABLE ONLY public.available_date DROP CONSTRAINT fkk0d6pu1wxarsoou0x2e1cc2on;
       public          postgres    false    4684    228    224            Q           2606    16852 '   appointment fkoeb98n82eph1dx43v3y2bcmsl    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT fkoeb98n82eph1dx43v3y2bcmsl FOREIGN KEY (doctor_id) REFERENCES public.doctor(doctor_id);
 Q   ALTER TABLE ONLY public.appointment DROP CONSTRAINT fkoeb98n82eph1dx43v3y2bcmsl;
       public          postgres    false    221    4684    228            O           2606    16842 #   animals fkswdwgwh6hoonyfi0wir6cwl68    FK CONSTRAINT     �   ALTER TABLE ONLY public.animals
    ADD CONSTRAINT fkswdwgwh6hoonyfi0wir6cwl68 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 M   ALTER TABLE ONLY public.animals DROP CONSTRAINT fkswdwgwh6hoonyfi0wir6cwl68;
       public          postgres    false    217    4682    226            �   �   x�M��N�0D���,�nQ�-�=P	%H\��x�&q�P�[��m5�7��/����q�C�N�Vs
������c��F��拦��b�n�-��F�����I�
�]��5��q�3�d�d�nI�Mإ�s�>�q�eom6x}_΢U������M~���1g�X�����J<U)�'�!�ɺsHn��Ԙ�;c�/��H�      �   N   x�U��� D�3S���j��:$�M��?%���ƚ�9K��ɹ$��+���GY�L5�o)�K.�̋� � h�      �   <   x�-���@�7�ő1K�^�)�o2,STG���FMo����E+
==��`��      �     x�]�=O�0��󯸽�;�mZ!!*XX.�I18v���=Cy��=֣��@����018r���[3Ysb��7{w�_4�-˓a�|��DE�eU'BC��H�%nv��>4B�;9�&7���]�����ȳT�D�e�l㋧ڑ�]����&kXv��ܖj�w+����Z�1"�(l��	�1�!N�	��r$/��?q�|��[]WUUƈt��`ǿk؅����ɞ3���~��&˲<ϋ�&�?vZxN      �     x�e�1o�0���Ɋ���RUDC�.G85.N�7�_���7Y��>���S����3�q����[c��֘�K���jY֮������fJ)�u#4d�w��4p�Űu���ƛ>�k�^�,՗���o�jl��,ˢ(1"�EQ����pl���X���}oj��n�}~P܎fY��y>��Da�g��B�1�We���:y��6�"�Ո����<�R���N4nl��d�]�d�8�`H�i0�ĸ���a\S�q�xl"ޥ�l��      �   �   x�u�=�0�g�\ ���T��:10uI���*~z�&*��ۓ�}Ϗ����a����t����}��TW`�ȶ�d�*K�`�<]x2=��[qʽ7]V�2�a����KLM42d�.�KF�ūџ_�}��5��?�����v���� �͌@`     