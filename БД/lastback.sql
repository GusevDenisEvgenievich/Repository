PGDMP     8                    {            store    15.4    15.4 :    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            L           1262    24576    store    DATABASE     y   CREATE DATABASE store WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE store;
                postgres    false            M           0    0    SCHEMA public    ACL     2   GRANT ALL ON SCHEMA public TO "Директор";
                   pg_database_owner    false    5            �            1255    25678 g   add_schedule(date, character varying, integer, integer, time without time zone, time without time zone) 	   PROCEDURE     �  CREATE PROCEDURE public.add_schedule(IN data date, IN day character varying, IN class integer, IN sub integer, IN s_time time without time zone, IN e_time time without time zone)
    LANGUAGE plpgsql
    AS $$
begin
insert into schedule values(data,day,class,sub,s_time, e_time);
if(select data>now()) 
then commit;
	 raise notice 'Расписание обновлено';
else rollback;
	 raise notice 'Отмена ввода';
end if;
end;
$$;
 �   DROP PROCEDURE public.add_schedule(IN data date, IN day character varying, IN class integer, IN sub integer, IN s_time time without time zone, IN e_time time without time zone);
       public          postgres    false            �            1255    25789    add_schedule_fun()    FUNCTION     �  CREATE FUNCTION public.add_schedule_fun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
dat_int integer;
dat varchar;
id_sub integer;
s_time time;
e_time time;
   BEGIN
   SELECT EXTRACT(DOW FROM (SELECT ddate FROM schedule ORDER BY ddate DESC LIMIT 1)) into dat_int;
   SELECT id_subject FROM schedule ORDER BY ddate DESC LIMIT 1 into id_sub;
   CASE WHEN dat_int=1 THEN dat='Понедельник';
        WHEN dat_int=2 THEN dat='Вторник';
		WHEN dat_int=3 THEN dat='Среда';
		WHEN dat_int=4 THEN dat='Четверг';
		WHEN dat_int=5 THEN dat='Пятница';
		WHEN dat_int=6 THEN dat='Суббота';
   END case;
   CASE WHEN id_sub=1 THEN s_time='8:30'; e_time='9:15';
   		WHEN id_sub=2 THEN s_time='9:25'; e_time='10:10';
		WHEN id_sub=3 THEN s_time='8:30'; e_time='9:15';
		WHEN id_sub=4 THEN s_time='10:30'; e_time='11:15';
		WHEN id_sub=5 THEN s_time='11:30'; e_time='12:15';
		WHEN id_sub=6 THEN s_time='8:30'; e_time='9:15';
		WHEN id_sub=7 THEN s_time='11:30'; e_time='12:15';
		WHEN id_sub=8 THEN s_time='13:10'; e_time='10:10';
		WHEN id_sub=9 THEN s_time='12:25'; e_time='13:10';
		WHEN id_sub=10 THEN s_time='9:25'; e_time='10:10';
   END case;
   UPDATE schedule SET week_day = dat WHERE ddate=(SELECT ddate FROM schedule ORDER BY ddate DESC LIMIT 1);
   UPDATE schedule SET start_time = s_time, end_time = e_time WHERE ddate=(SELECT ddate FROM schedule ORDER BY ddate DESC LIMIT 1);
   return new;
   END;
$$;
 )   DROP FUNCTION public.add_schedule_fun();
       public          postgres    false            �            1255    25663    lesson_qty(character varying)    FUNCTION     ,  CREATE FUNCTION public.lesson_qty(lesson character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	select count(*) from (select subject.name from subject, schedule
	where subject.id=schedule.id_subject and date_part('week',schedule.ddate)=date_part('week',now()) and name=lesson) as lessons
$$;
 ;   DROP FUNCTION public.lesson_qty(lesson character varying);
       public          postgres    false            �            1255    25675 l   new_schedule_test(date, character varying, integer, integer, time without time zone, time without time zone) 	   PROCEDURE     o  CREATE PROCEDURE public.new_schedule_test(IN data date, IN day character varying, IN class integer, IN sub integer, IN s_time time without time zone, IN e_time time without time zone)
    LANGUAGE plpgsql
    AS $$
begin
if (select exists (select start_time from schedule where ddate=data and id_subject=sub))=true
then raise notice 'Урок у учителя';
else
	if (select exists (select start_time from schedule where ddate=data and id_class=class))=true
	then raise notice 'Урок у класса';
	else
		CASE
           WHEN class>=1 AND class<=4 
		    	THEN if (select count(*) from schedule where ddate=data and id_class=class)>4
					then raise notice 'Превышен лимит уроков';
					else insert into schedule values(data,day,class,sub,s_time, e_time);
				end if;
           WHEN class>=5 AND class<=9 
		    	THEN if (select count(*) from schedule where ddate=data and id_class=class)>6
					then raise notice 'Превышен лимит уроков';
					else insert into schedule values(data,day,class,sub,s_time, e_time);
				end if;
		   WHEN class>=10 AND class<=11 
		    	THEN if (select count(*) from schedule where ddate=data and id_class=class)>8
					then raise notice 'Превышен лимит уроков';
					else insert into schedule values(data,day,class,sub,s_time, e_time);
				end if;
    	END case;
	end if;
end if;
end;
$$;
 �   DROP PROCEDURE public.new_schedule_test(IN data date, IN day character varying, IN class integer, IN sub integer, IN s_time time without time zone, IN e_time time without time zone);
       public          postgres    false            �            1255    25660    students_age(integer, integer)    FUNCTION     �   CREATE FUNCTION public.students_age(down integer, up integer) RETURNS integer
    LANGUAGE sql
    AS $$
	select count(*) from (select date_part('year',now())-date_part('year',birthday) as age from students) as count
	where age>=down and age<=up
$$;
 =   DROP FUNCTION public.students_age(down integer, up integer);
       public          postgres    false            �            1255    25608    teacher(character varying)    FUNCTION     �   CREATE FUNCTION public.teacher(subject_name character varying) RETURNS SETOF text
    LANGUAGE sql
    AS $$
	SELECT full_name FROM employees WHERE id = (select id_employee from subject where name=subject_name);
$$;
 >   DROP FUNCTION public.teacher(subject_name character varying);
       public          postgres    false            �            1255    25625 )   teacher_schedule(character varying, date)    FUNCTION     8  CREATE FUNCTION public.teacher_schedule(teacher character varying, dat date) RETURNS SETOF text
    LANGUAGE sql
    AS $$
	SELECT subject.name FROM subject, schedule, employees
	WHERE subject.id_employee=employees.id and schedule.id_subject=subject.id and employees.full_name=teacher and schedule.ddate=dat
$$;
 L   DROP FUNCTION public.teacher_schedule(teacher character varying, dat date);
       public          postgres    false            �            1255    25666 *   update_student(character varying, integer) 	   PROCEDURE     K  CREATE PROCEDURE public.update_student(IN student_name character varying, IN class integer)
    LANGUAGE plpgsql
    AS $$
begin
if (SELECT COUNT(*) FROM students where id_class=class)<25 
	then UPDATE students SET id_class=class where full_name=student_name;
	else RAISE NOTICE 'Класс переполнен';
end if;
end;
$$;
 [   DROP PROCEDURE public.update_student(IN student_name character varying, IN class integer);
       public          postgres    false            �            1259    25430    classes    TABLE     �   CREATE TABLE public.classes (
    id integer NOT NULL,
    id_classroom_teacher integer,
    id_type integer,
    students_quantity integer,
    letter character(1),
    description json
);
    DROP TABLE public.classes;
       public         heap    postgres    false            N           0    0    TABLE classes    ACL     �   GRANT SELECT ON TABLE public.classes TO "Директор";
GRANT UPDATE ON TABLE public.classes TO "Завуч";
GRANT SELECT ON TABLE public.classes TO "Диспетчер";
          public          postgres    false    215            �            1259    25425    classes_types    TABLE     _   CREATE TABLE public.classes_types (
    id integer NOT NULL,
    name character varying(50)
);
 !   DROP TABLE public.classes_types;
       public         heap    postgres    false            O           0    0    TABLE classes_types    ACL     �   GRANT SELECT ON TABLE public.classes_types TO "Директор";
GRANT UPDATE ON TABLE public.classes_types TO "Завуч";
GRANT SELECT ON TABLE public.classes_types TO "Диспетчер";
          public          postgres    false    214            �            1259    26108 	   employees    TABLE     �   CREATE TABLE public.employees (
    id integer NOT NULL,
    full_name character varying(150),
    age integer,
    gender character varying(20),
    phone character varying(20),
    post character varying(150)
);
    DROP TABLE public.employees;
       public         heap    postgres    false            P           0    0    TABLE employees    ACL     v   GRANT SELECT ON TABLE public.employees TO "Директор";
GRANT SELECT ON TABLE public.employees TO "Завуч";
          public          postgres    false    219            �            1259    25446    students    TABLE     @  CREATE TABLE public.students (
    full_name character varying(150) NOT NULL,
    birthday date,
    gender character varying(20),
    address character varying(100),
    father_full_name character varying(150),
    mather_full_name character varying(150),
    id_class integer,
    add_inform character varying(500)
);
    DROP TABLE public.students;
       public         heap    postgres    false            Q           0    0    TABLE students    ACL     t   GRANT SELECT ON TABLE public.students TO "Директор";
GRANT UPDATE ON TABLE public.students TO "Завуч";
          public          postgres    false    216            �            1259    26131 	   inform_7b    VIEW     C  CREATE VIEW public.inform_7b AS
 SELECT students.full_name,
    to_char((students.birthday)::timestamp with time zone, 'dd.mm.yyyy'::text) AS to_char,
    students.gender,
    students.address,
    students.father_full_name,
    students.mather_full_name,
    classes.id_type,
    classes.letter,
    students.add_inform
   FROM public.students,
    public.classes
  WHERE ((students.id_class = classes.id) AND (students.id_class = ( SELECT classes_1.id
           FROM public.classes classes_1
          WHERE ((classes_1.letter = 'Б'::bpchar) AND (classes_1.id_type = 7)))));
    DROP VIEW public.inform_7b;
       public          postgres    false    216    216    216    216    215    216    215    215    216    216    216            R           0    0    TABLE inform_7b    ACL     >   GRANT SELECT ON TABLE public.inform_7b TO "Директор";
          public          postgres    false    222            �            1259    26123    qty_in_classes    VIEW     �   CREATE VIEW public.qty_in_classes AS
 SELECT classes.id_type,
    classes.letter,
    count(*) AS count
   FROM public.students,
    public.classes
  WHERE (students.id_class = classes.id)
  GROUP BY classes.id_type, classes.letter;
 !   DROP VIEW public.qty_in_classes;
       public          postgres    false    215    216    215    215            S           0    0    TABLE qty_in_classes    ACL     C   GRANT SELECT ON TABLE public.qty_in_classes TO "Директор";
          public          postgres    false    220            �            1259    26097    schedule    TABLE     �   CREATE TABLE public.schedule (
    ddate date NOT NULL,
    week_day character varying(50),
    id_class integer,
    id_subject integer,
    start_time time without time zone,
    end_time time without time zone
);
    DROP TABLE public.schedule;
       public         heap    postgres    false            T           0    0    TABLE schedule    ACL     t   GRANT SELECT ON TABLE public.schedule TO "Директор";
GRANT UPDATE ON TABLE public.schedule TO "Завуч";
          public          postgres    false    218            �            1259    26127    qty_subjects_7b    VIEW     �   CREATE VIEW public.qty_subjects_7b AS
 SELECT count(*) AS "qty_7Б"
   FROM public.schedule
  WHERE (schedule.id_class = ( SELECT classes.id
           FROM public.classes
          WHERE ((classes.letter = 'Б'::bpchar) AND (classes.id_type = 7))));
 "   DROP VIEW public.qty_subjects_7b;
       public          postgres    false    218    215    215    215            U           0    0    TABLE qty_subjects_7b    ACL     D   GRANT SELECT ON TABLE public.qty_subjects_7b TO "Директор";
          public          postgres    false    221            �            1259    26090    subject    TABLE     �   CREATE TABLE public.subject (
    id integer NOT NULL,
    name character varying(100),
    description character varying(500),
    id_employee integer
);
    DROP TABLE public.subject;
       public         heap    postgres    false            V           0    0    TABLE subject    ACL     �   GRANT SELECT ON TABLE public.subject TO "Директор";
GRANT UPDATE ON TABLE public.subject TO "Завуч";
GRANT SELECT ON TABLE public.subject TO "Диспетчер";
          public          postgres    false    217            W           0    0    COLUMN subject.name    ACL     I   GRANT SELECT(name),UPDATE(name) ON TABLE public.subject TO "Завуч";
          public          postgres    false    217    3414            X           0    0    COLUMN subject.id_employee    ACL     W   GRANT SELECT(id_employee),UPDATE(id_employee) ON TABLE public.subject TO "Завуч";
          public          postgres    false    217    3414            �            1259    26141    schedule_7b    VIEW     1  CREATE VIEW public.schedule_7b AS
 SELECT schedule.ddate,
    schedule.week_day,
    classes.id_type,
    classes.letter,
    subject.name,
    schedule.start_time,
    schedule.end_time
   FROM public.schedule,
    public.classes,
    public.subject
  WHERE ((schedule.id_class = classes.id) AND (schedule.id_subject = subject.id) AND (schedule.id_class = ( SELECT classes_1.id
           FROM public.classes classes_1
          WHERE ((classes_1.letter = 'Б'::bpchar) AND (classes_1.id_type = 7)))) AND ((schedule.week_day)::text = 'Вторник'::text));
    DROP VIEW public.schedule_7b;
       public          postgres    false    215    215    215    218    218    218    218    218    218    217    217            Y           0    0    TABLE schedule_7b    ACL     @   GRANT SELECT ON TABLE public.schedule_7b TO "Директор";
          public          postgres    false    224            �            1259    26136    schedule_voronin    VIEW     �  CREATE VIEW public.schedule_voronin AS
 SELECT schedule.ddate,
    schedule.week_day,
    classes.id_type,
    classes.letter,
    subject.name,
    schedule.start_time,
    schedule.end_time
   FROM public.schedule,
    public.classes,
    public.subject
  WHERE ((schedule.id_class = classes.id) AND (schedule.id_subject = subject.id) AND (schedule.id_subject IN ( SELECT s.id
           FROM public.subject s,
            public.employees e
          WHERE ((s.id_employee = e.id) AND ((e.full_name)::text = 'Воронин Максим Артемьевич'::text)))) AND (schedule.ddate >= '2023-12-11'::date) AND (schedule.ddate <= '2023-12-16'::date));
 #   DROP VIEW public.schedule_voronin;
       public          postgres    false    219    215    215    215    217    217    217    218    218    218    218    218    218    219            Z           0    0    TABLE schedule_voronin    ACL     E   GRANT SELECT ON TABLE public.schedule_voronin TO "Директор";
          public          postgres    false    223            �            1259    26146    subject_list    VIEW     �   CREATE VIEW public.subject_list AS
 SELECT s.name AS subjects
   FROM public.subject s,
    public.employees e
  WHERE ((s.id_employee = e.id) AND ((e.full_name)::text = 'Воронин Максим Артемьевич'::text));
    DROP VIEW public.subject_list;
       public          postgres    false    217    219    219    217            [           0    0    TABLE subject_list    ACL     A   GRANT SELECT ON TABLE public.subject_list TO "Директор";
          public          postgres    false    225            B          0    25430    classes 
   TABLE DATA           l   COPY public.classes (id, id_classroom_teacher, id_type, students_quantity, letter, description) FROM stdin;
    public          postgres    false    215   ;Z       A          0    25425    classes_types 
   TABLE DATA           1   COPY public.classes_types (id, name) FROM stdin;
    public          postgres    false    214   �Z       F          0    26108 	   employees 
   TABLE DATA           L   COPY public.employees (id, full_name, age, gender, phone, post) FROM stdin;
    public          postgres    false    219   [       E          0    26097    schedule 
   TABLE DATA           _   COPY public.schedule (ddate, week_day, id_class, id_subject, start_time, end_time) FROM stdin;
    public          postgres    false    218   5\       C          0    25446    students 
   TABLE DATA           �   COPY public.students (full_name, birthday, gender, address, father_full_name, mather_full_name, id_class, add_inform) FROM stdin;
    public          postgres    false    216   ]       D          0    26090    subject 
   TABLE DATA           E   COPY public.subject (id, name, description, id_employee) FROM stdin;
    public          postgres    false    217   �b       �           2606    25438 (   classes classes_id_classroom_teacher_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_id_classroom_teacher_key UNIQUE (id_classroom_teacher);
 R   ALTER TABLE ONLY public.classes DROP CONSTRAINT classes_id_classroom_teacher_key;
       public            postgres    false    215            �           2606    25440    classes classes_id_type_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_id_type_key UNIQUE (id_type);
 E   ALTER TABLE ONLY public.classes DROP CONSTRAINT classes_id_type_key;
       public            postgres    false    215            �           2606    25436    classes classes_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.classes DROP CONSTRAINT classes_pkey;
       public            postgres    false    215            �           2606    25429     classes_types classes_types_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.classes_types
    ADD CONSTRAINT classes_types_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.classes_types DROP CONSTRAINT classes_types_pkey;
       public            postgres    false    214            �           2606    26112    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    219            �           2606    26101    schedule schedule_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (ddate);
 @   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_pkey;
       public            postgres    false    218            �           2606    25452    students students_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (full_name);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public            postgres    false    216            �           2606    26096    subject subject_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.subject DROP CONSTRAINT subject_pkey;
       public            postgres    false    217            �           2606    25441    classes classe_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classe_fk FOREIGN KEY (id_type) REFERENCES public.classes_types(id);
 ;   ALTER TABLE ONLY public.classes DROP CONSTRAINT classe_fk;
       public          postgres    false    214    3225    215            �           2606    26113    employees employees_classes_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_classes_fk FOREIGN KEY (id) REFERENCES public.classes(id_classroom_teacher);
 H   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_classes_fk;
       public          postgres    false    219    215    3227            �           2606    26118    employees employees_subject_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_subject_fk FOREIGN KEY (id) REFERENCES public.subject(id);
 H   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_subject_fk;
       public          postgres    false    217    219    3235            �           2606    26102    schedule schedule_fk    FK CONSTRAINT     x   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_fk FOREIGN KEY (id_subject) REFERENCES public.subject(id);
 >   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_fk;
       public          postgres    false    217    3235    218            �           2606    25453    students students_fk    FK CONSTRAINT     v   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_fk FOREIGN KEY (id_class) REFERENCES public.classes(id);
 >   ALTER TABLE ONLY public.students DROP CONSTRAINT students_fk;
       public          postgres    false    215    3231    216            B   �   x�u�;�0�z����Ɖ�,������#q��Bg�܈4t���iFa�<cx�s>�G����1l�U��_N|��/-j_Đ�XOU�4q(4�z�Z�؋t�Ӯ��V��E�/U����n-"?1��      A   0   x��I   İw+�a��$!6���`8�.����x���jB�+��d�      F     x�mP[J�0�NV�H�M�t/.���3�Q�Q`���>�-��#o���r�=/R�ő+1�Ô`��7�\s�5y'�EǍ����P/w��֖��9�;m����Ȭ���Z!���%�x���jQ��t2����gҢPx�.�x��ӳ�5B|�Dby����c,Y��>����;E�nf���T�e'����%.	c���\�&�9*�ҙ��*f�C�:��칡��)��j:�/W�Rjs�|������3��/P� �      E   �   x�}�]
�P��ǽ3sU����HAOA���^�G�"�0wGE!e�2�|��QV��"d'k�c�=��؞�"!G�{Ǟ���b�tp)�1l�	e�O)#a�tz�c�#;C��Q�R��N�.V�~�[ڝ8$�z�>�� =�����|'��Ͳ�+���¥�R�|�!�%[1�(AI��g���ʿ9���*ӊ��_��(��e      C   �  x��WmR�H�m�b~�*LY���6�:o��E �$�?d#�W��Ѿ~=�F�٥\P��t�~��e����.mj6�c?b)�3,d6u=c�t=7p���X6:��E�v԰w���r}��7�7���1u�}c��~������s�>�\O).Np[b�V��nv`:��&Q�ݰ[,��%�^��e���c���̍�<��@_b����+c'��b�T��d�����$�I�U���;C�q�$�Zpiig����7�9��X�OZ�n���	��0�b��G�ct�q<=i��W�E%ג��t��b+���IF��-c"38�+�<j������0�y��ќ�1��Z"�K��
�5ŷ������=�얅�gr�Ɣ7��g�K�(��/>�&5��?c����$M��,��D��g�2�t�cE��G���G0s�k3w'� 	LHf�T3��6BB'��ވ�!��\�O�7�W,L�@&��<�	��ʧR�Ge�C2e>Y���K9�c!���^	G���K����wǀa���o�gBlPe���/�n�z��y���1��/���:.�� ��H
D�≩��r�88b�q�x׳;�'�=#�~�'pWloA�iU#5	[�L�h�4�6���݊v+x$��y��r�l�9VzQV>�Q2熩S��{�� �9l��F���yJj����%���8P��4�`uHt��%�X�A3�7� I��A��"e�3,�Ҙ6.�J�vLː�rL̐x��ttA1�1ܜŴ�k��[A�#���~�j��w'm����Ƞ����S|a��T��`B(�`�-$���R\����aU���V^(���a�����*��"pe"�r�O���v�^�+S�If� 2S���ɾ
�3+�g��<m)yU��Me���,M��������1'��NEyO�'^o6;��h���5��҂e��)�ln��!�P�x[��׆SB&B�� �a�
�L��Pg$�ؗٺ$�JV,b�%5gS���x����6��ε}�7�.����E]d+:�)9���0*R��
�H�C�J'D�)޾�3�Jv����(��B��ǣsX��p�TRSR������1{�Ч�����)�#����~�1,Qb�V��S�IzQLE>�m��-�1]����J�����;H�g�I�ܔ���˨ۨ��ա��O�S�TG:��I�ጣ(�<	?z�b�,����ZBT�r�4�\f�S�!+��o�*�K<���p�y�|�1��N0s����E���Eh_k����ݰI�<_�p��bx`XS25����/4s~�h�&P�ST�P~��|��  B���|�_Gy�Ԛ�tOuW���m_����ͣ\ʎ���ɗ~���T�X�����q�K��޽�k�w��'��d�5��^n����#5:��bY�++�^�G�����%���      D   |  x��T[nA��=��B8w�0�ĉ� $@B�|p���'���znDu���?@��;=���U�;ur/峓2�F~ɘj<��I��N�F��i�.�t^�8mq�,M�ɀ�>�=������K��xM�~[&<yy���Չ��2���~!=`k\����8�3��@zD�%	c�B|�"�ߚ8�ħK�g]e��XK[��N�D9�a��aҠ������A�`������g�ဵ"�5.ݥ���V���g�'��Z��
e@�3'��K��(�;sM����x�z�"ӌ�h-�֤_�OK���K �K�)5b}��R�����
����B�tN~f'#9��3�Q{����~(���6�����ꕓo �� 9({�P_ػ�T5 c���Q%�����j���J=����E���H��;����5�׎Ŷ�	�E�s[[6��G��\����z�}��nJc����]��jޝTot��{s|��5E����C��c-�mQ�а&�b���w��R�Il�n��`�Vu4��`#L�Hu�1��|4�QRMKj���T ������>�R�]�c���Gӎ`
P,�s�G�Ͻbԙ��Pb���o����4�Z��`޽���7�͵|     