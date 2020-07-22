-- ����� USER2 ȭ���Դϴ�.

---------------------------------------------
-- �ֹ���ȣ    ����ȣ     ��ǰ�ڵ�
---------------------------------------------
-- O00001	    C0032	     P00001
-- O00001	    C0032	     P00002	
-- O00001	    C0032	     P00083
--------------------------------------------

SELECT * FROM tbl_�ֹ�������
ORDER BY �ֹ���ȣ;


DROP TABLE tbl_order;

CREATE TABLE tbl_order(
    O_SEQ	NUMBER		PRIMARY KEY,
    O_NUM	CHAR(6)	    NOT NULL,	
    O_DATE	CHAR(10)	NOT NULL,	
    O_CNUM	CHAR(5)	    NOT NULL,	
    O_PCODE	CHAR(6)	    NOT NULL,	
    O_PNAME	nVARCHAR2(125),	
    O_PRICE	NUMBER,
    O_QTY	NUMBER,		
    O_TOTAL	NUMBER		
);

-- tbl_order Table�� ����鼭 ���⿡ �߰��� �����͵� �߿� 1���� Į�����δ� PK�� ����� ���
-- ������ �Ϸù�ȣ Į���� �ϳ� �߰��ϰ� �� Į���� PK�� �����ߴ�.
-- �� ��Ȳ�� �Ǹ� �����͸� �߰��� �� ������ O_SEQ Į���� ����� �����͵��� ���캸��
-- ��ϵ��� ���� ���ڸ� ���� ���� �� ������ SEQ�� ���ϰ� INSERT�� �����ؾ� �Ѵ�.
-- �̷� ����� �ڵ带 �ſ� �����ϰ� ����� ����� ���� �ȴ�.

-- �̷��� ������ �����ϱ� ���� SEQUENCE��� ��ü�� ����Ͽ�
-- �ڵ����� �Ϸù�ȣ�� ����� ����� ����Ѵ�.
CREATE SEQUENCE seq_order
START WITH 1
INCREMENT BY 1;

-- ǥ�� SQL���� ������ ����� �� ��
-- SELECT 3+4; ��� �ڵ��� �ϸ� 3+4�� ����� Ȯ���� �� �ִ�.
-- �׷��� ����Ŭ������ SELECT��ɹ��� FROM [table]���� ������ ���������� ����.
-- �̷��� �ڵ尡 �ʿ��� �� �ý��ۿ� �̹� �غ�Ǿ� �ִ� DUAL�̶�� DUMMY���̺��� ����ؼ� �ڵ��� �Ѵ�.
SELECT 3+4 FROM DUAL;

-- seq_order ��ü�� NEXTVAL�̶�� ���(�Լ�����)�� ȣ���Ͽ�
-- ��ȭ�Ǵ� �Ϸù�ȣ�� �����޶� �ڵ�
SELECT seq_order.NEXTVAL FROM DUAL;

-- �� seq_order�� NEXTVAL ����� ����Ͽ� INSERT�� ������ �� �Ϸù�ȣ�� �ڵ����� �ο��� �� �ִ�.


INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22', '00001', 'C0032', 'P00001');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22',  '00001', 'C0032', 'P00002');I
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22',  '00001', 'C0032', 'P00003');

---------------------------------------------
-- �ֹ���ȣ    ����ȣ     ��ǰ�ڵ�
---------------------------------------------
-- O00001	    C0032	     P00001
-- O00001	    C0032	     P00002	
-- O00001	    C0032	     P00083
--------------------------------------------

SELECT o_num, o_cnum, o_pcode FROM tbl_order;
-- ���� tbl_order ���̺� ���� ���� �����Ͱ� ���� ��
-- 00001 C0031 P00001 �̷��� �����͸� �߰��Ѵٸ� �ƹ��� ������� ���� �߰��Ǿ� ���� ���̴�.
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22', '00001', 'C0032', 'P00001');

SELECT o_num, o_cnum, o_pcode FROM tbl_order;

-- �ֹ���ȣ, ����ȣ, ��ǰ�ڵ� �� 3���� Į�������� ���� �ߺ��Ǹ� INSERT�� ���� �ʵ��� ���������� �����ؾ� �Ѵ�.
-- [ UNIQUE ]
-- Į���� ���� �ߺ��Ǿ INSERT�� �Ǵ� ���� �����ϴ� ��������
-- �ֹ����̺� UNIQUE���������� �߰�����
ALTER TABLE tbl_order 
    ADD CONSTRAINT UQ_ORDER 
        UNIQUE (o_num, o_cnum, o_pcode);
        
-- UNIQUE�� �߰��ϴµ� �̹� UNIQUE ���ǿ� ����Ǵ� ���� ������ ����������  �߰����� �ʴ´�.
-- ORA-02299: cannot validate (USER2.UQ_ORDER) - duplicate keys found
--  > PK, UNIQUE�� ������ Į���� ���� �߰��ϰų�, �̹� �ߺ��� ���� �ִµ� PK, UNIQUE�� �����Ϸ��� �� �� �߻��ϴ� ����

-- UNIQUE ���������� �߰��ϱ� ���� �������� �߰��� �����͸� �����Ϸ��� ������ ���� SQL�� �����Ѵ�.
-- �� SQL�� �����ϸ�, �����Ǿ�� �ȵǴ� �߿��� �ֹ����� 1���� ���� �����Ǿ� ������.
-- �� ���̺��� �����ʹ� ���Ἲ�� �Ұ� �ȴ�(= �����̻�).
DELETE FROM tbl_order
WHERE o_num = 'O00001' AND o_cnum = 'C0032' AND o_pcode = 'P00001';

-- ������ �Ϸù�ȣ Į���� ������� �ֱ� ������ PK�� �������� ���� ������ �� �ִ�.
SELECT * FROM tbl_order;

DELETE FROM tbl_order
WHERE o_seq = 27;

ALTER TABLE tbl_order 
    ADD CONSTRAINT UQ_ORDER 
        UNIQUE (o_num, o_cnum, o_pcode);

-- �ĺ�Ű �߿� ����Į������ PK�� ������ �� ���� ��Ȳ�� �߻��ϸ�
-- ������ Į������ PK�� �����ϴµ�
-- UPDATE, DELETE�� ������ �� WHERE Į��1 = �� AND Į��2 = �� AND Į��3 = �� ... �� ���� ������ �ο��ؾ� �Ѵ�.
-- �̰��� �����͹��Ἲ�� �����ϴ� �� �ſ� ���� ���� ȯ���̴�.
-- �̷� �� �����Ϳ� ������� SEQĮ���� ����� PK�� ��������


SELECT * FROM tbl_order;

INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22', '00022', 'C0055', 'P00067');


COMMIT;






