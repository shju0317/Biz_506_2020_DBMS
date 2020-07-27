-- �л����� ���̺�
CREATE TABLE tbl_student(     
    st_num	CHAR(5)		PRIMARY KEY,    -- �й�
    st_name	nVARCHAR2(20)	NOT NULL,   -- �л��̸�
    st_tel	VARCHAR2(20)	NOT NULL,	-- ��ȭ��ȣ
    st_addr	nVARCHAR2(125),		        -- �ּ�
    st_grade	NUMBER	NOT NULL,	    -- �г�
    st_code	CHAR(4)	NOT NULL	        -- �а�
);

-- �а����� ���̺�
CREATE TABLE tbl_dept(
    d_code	CHAR(3)		PRIMARY KEY,            -- �а��ڵ�
    d_name	nVARCHAR2(20)	UNIQUE NOT NULL,	-- �а���
    d_prof	nVARCHAR2(20)		                -- ��米��
);


-- �л����� ���̺�
CREATE TABLE tbl_score(
    sc_num	CHAR(5)	NOT NULL,           -- �й�
    sc_sub	nVARCHAR2(30)	NOT NULL,   -- �����
    sc_score	NUMBER(3)	NOT NULL,   -- ����
    CONSTRAINT sc_pk PRIMARY KEY (sc_num, sc_sub)
);


INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20001', '���Ѽ�', '010-2217-7851', '�泲 ���ؽ� ��浿 1088-7', 3, '008');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20002', '������', '010-4311-1533', '������ ���ʽ� ������ 956-5', 1, '006');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20003', '������', '010-6262-7441', '��� ��õ�� ���ܵ� 38-3��', 1, '009');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20004', '�����', '010-9794-9856', '����� ���α� ���ε� 3-35����', 1, '006');    

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20005', '������', '010-8811-7761', '������ ���ؽ� õ� 1077-3', 2, '010');    
    


INSERT INTO tbl_dept  (d_code, d_name, d_prof) VALUES ('001', '��ǻ�Ͱ���', '�����');
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES ('002', '���ڰ���', '��ö��');    
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES ('003', '����', 'ŷ���ʵ�');



INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '�����ͺ��̽�', 71);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '����', 63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '�̼�', 50);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '�����ͺ��̽�', 84);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '����', 75);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '����', 52);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '����', 89);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '����', 63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '����', 70);
    
SELECT * FROM tbl_student;    



SELECT sc_num 
FROM tbl_score
WHERE sc_score < 60;



SELECT st_num
FROM tbl_student
WHERE st_name = '������';

UPDATE tbl_student
SET st_addr = '���ֱ����� �ϱ� ���ﵿ ���� 170��'
WHERE st_num = '20005';


SELECT st_num
FROM tbl_student
WHERE st_name = '������';

DELETE FROM tbl_student
WHERE st_num = '20003';


SELECT  sc_num AS �й�, SUM(sc_score) AS ����, ROUND(AVG(sc_score),2) AS ���
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;




SELECT  SC.sc_num AS �й�, ST.st_name AS �л��̸�, ST.st_tel AS ��ȭ��ȣ, SUM(SC.sc_score) AS ����, ROUND(AVG(SC.sc_score),2) AS ���
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num 
GROUP BY SC.sc_num, ST.st_name, ST.st_tel
ORDER BY SC.sc_num;

--DROP TABLE tbl_student;
--DROP TABLE tbl_score;
--DROP TABLE tbl_dept;

SELECT * FROM tbl_student;
SELECT * FROM tbl_score;

SELECT sc_num,
     SUM(DECODE(sc_sub, '����', sc_score, 0)) AS ����,   
     SUM(DECODE(sc_sub, '����', sc_score, 0)) AS ����,
     SUM(DECODE(sc_sub, '����', sc_score, 0)) AS ����,
     SUM(DECODE(sc_sub, '����', sc_score, 0)) AS ����,
     SUM(DECODE(sc_sub, '�̼�', sc_score, 0)) AS �̼�,
     SUM(DECODE(sc_sub, '����Ʈ�������', sc_score, 0)) AS ����Ʈ�������,
     SUM(DECODE(sc_sub, '�����ͺ��̽�', sc_score, 0)) AS �����ͺ��̽�
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;

-----------------------------------------------------------

CREATE  VIEW view_score
AS
(   SELECT sc_num, ����, ����, ����, ����, �̼�, ����Ʈ�������, �����ͺ��̽�
    FROM tbl_score
    PIVOT (
        SUM(sc_score)
        FOR sc_sub IN ('����' AS ����, '����' AS ����, '����' AS ����, '����' AS ����, '�̼�' AS �̼�,
                        '����Ʈ�������' AS ����Ʈ�������, '�����ͺ��̽�' AS �����ͺ��̽�)
    )
);

SELECT * FROM view_score;
DROP VIEW view_score;


--SELECT 
--       SUM("����" + "����" + "����" + "����" + "�̼�" + "����Ʈ�������" + "�����ͺ��̽�") AS ����,
--       AVG("����" + "����" + "����" + "����" + "�̼�" + "����Ʈ�������" + "�����ͺ��̽�") AS ���
--FROM view_score
--GROUP BY sc_num;

SELECT *
FROM view_score SC,
       (SELECT 
        SUM("����" + "����" + "����" + "����" + "�̼�" + "����Ʈ�������" + "�����ͺ��̽�") AS ����,      
        AVG("����" + "����" + "����" + "����" + "�̼�" + "����Ʈ�������" + "�����ͺ��̽�") AS ���
        FROM view_score
        GROUP BY sc_num
);

--------------------------------------------

SELECT SC.sc_num, ST.st_name, SC.����, SC.����, SC.����, SC.����, SC.�̼�, SC.����Ʈ�������, SC.�����ͺ��̽�,
       SUM(SC.���� + SC.���� + SC.���� + SC.���� + SC.�̼� + SC.����Ʈ������� + SC.�����ͺ��̽�) AS ����
FROM(
    SELECT sc_num, ����, ����, ����, ����, �̼�, ����Ʈ�������, �����ͺ��̽�
        FROM tbl_score
        PIVOT (
            SUM(sc_score)
            FOR sc_sub IN ('����' AS ����, '����' AS ����, '����' AS ����, '����' AS ����, '�̼�' AS �̼�, 
            '����Ʈ�������' AS ����Ʈ�������, '�����ͺ��̽�' AS �����ͺ��̽�)
        )
) SC
    LEFT JOIN tbl_student ST
        ON ST.st_num = SC.sc_num
ORDER BY SC.sc_num;