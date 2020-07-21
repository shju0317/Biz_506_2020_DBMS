-- ����� USER1 ȭ���Դϴ�.
-- tbl_iolist���� ��ǰ��, �ŷ�ó��, �ŷ�óCEO Į���� �����Ͱ� �Ϲ� ���ڿ� ���·� ����Ǿ� �ִ�.
-- �� �����ʹ� ���� Į���� �ߺ��� �����Ͱ� �־ ������ �������鿡�� �����ϴ�.
-- ���� � ��ǰ�� ��ǰ���� ������ �ʿ��� ���
-- ��ǰ���� UPDATE�ؾ� �ϴµ�, 2�� �̻��� ���ڵ带 ������� UPDATE������ �ʿ��ϴ�.
-- 2�� �̻��� ���ڵ带 UPDATE�����ϴ� ���� �������� ���Ἲ�� ��ĥ �� �ִ� ������ �ȴ�.
-- �̷��� ������ �����ϱ� ���� ������ ���� ����ȭ�� �����Ѵ�.

-- ��ǰ�� ������ ������ ���̺�� �и��ϰ�, ��ǰ������ ��ǰ�ڵ带 �ο��� ��
-- tbl_iolist�� �����ϴ� ������� ����Ȱ�� �����Ѵ�.

-- tbl_iolist�κ��� ��ǰ�� ����Ʈ�� ��������
-- ��ǰ�� Į���� GROUP BY�Ͽ� �ߺ����� ���� ��ǰ����Ʈ�� �����Ѵ�.
SELECT io_pname , 
        MIN(DECODE(io_inout, '����', io_price, 0)) AS ���Դܰ�,
        MAX(DECODE(io_inout, '����', io_price, 0)) AS ����ܰ�
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

--SELECT DISTINCT io_pname FROM tbl_iolist
--ORDER BY io_pname;

-----------------------------------------------------------------------------------------
-- [ ��ǰ���� ���̺� ]
-----------------------------------------------------------------------------------------
CREATE TABLE tbl_product(
    p_code	  CHAR(5)   PRIMARY KEY,
    p_name	  nVARCHAR2(125)    NOT NULL,	
    p_iprice  NUMBER,		
    p_oprice  NUMBER,		
    p_vat	  CHAR(1)   DEFAULT '1'
);

SELECT * FROM tbl_product;

/*
���Ը��� ���̺��� ��ǰ����(�̸�, �ܰ�) �κ��� �����Ͽ� ��ǰ���� ���̺��� �����ߴ�.
���Ը��� ���̺��� ��ǰ�̸� Į���� �����ϰ�
��ǰ���� ���̺�� JOIN�� �� �ֵ��� �����ؾ� �Ѵ�.

���� ���Ը��� ���̺��� ��ǰ�̸��� ����ְ�
��ǰ���� ���̺��� ��ǰ�ڵ�, ��ǰ�̸�, ���Դܰ�, ����ܰ� �� ����ִ�.

���Ը��� ���̺��� ��ǰ�̸��� �ش��Ѵ� ��ǰ�ڵ鸣 ���Ը��� ���̺� UPDATE�ϰ�
���Ը��� ���̺��� ��ǰ�̸� Į���� ������ �� JOIN�� �����Ͽ� �����͸� Ȯ���غ���.
*/

-- ���Ը��� ���̺��� ��ǰ��� ��ǰ���� ���̺��� ��ǰ���� JOIN�ؼ� 
-- ���Ը��� ���̺��� ��ǰ���� ��ǰ������ ��� �ִ��� Ȯ���ϱ�
SELECT IO.io_pname,  P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name;

-- �� �ڵ带 �����Ͽ� P.p_name�׸� (null)���� �ִٸ� ��ǰ���� ���̺��� �߸� ������� ���̴�.
-- ��ǰ���� ���̺��� �����ϰ� ������ �ٽ� �����ؾ� �Ѵ�.

-- ������ �����ϱ� nullã�� ���絥?��
-- ���� ��� �߿� P.p_name �׸��� ���� NULL�� ����Ʈ�� ������
-- ��������� �����̶�� ����Ʈ�� �Ѱ��� ����� �Ѵ�.
SELECT IO.io_pname,  P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
WHERE P.p_name IS NULL; -- <-> IS NOT NULL

-- ���� ��ǰ�����Ͱ� �̻������ �˾����� ���Ը��� ���̺� ��ǰ�ڵ带 ������ Į���� �߰�����.
-- [ ALTER TABLE ]
-- ���̺��� ����(Į�� �߰�, ����) ����, Į���� Ÿ�Ժ��� ���� �����ϴ� ���
-- ��ǰ���̺��� p_codeĮ���� ���� type���� io_pcodeĮ���� �߰�

-- ALTER TABLE�� �� ��
-- �̹� ���� �����Ͱ� INSERT�Ǿ� �ִ� ���¿��� Į���� �߰��ϸ�
-- �߰��ϴ� Į���� �翬�� �ʱⰪ�� NULL�� �ȴ�.
-- �� ������� Į���� �߰��ϸ� ���� Į�� �߰��� �ȵȴ�.
-- �� ����� ���� �����Ͱ� 1���� ���� ���� ����
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) NOT NULL);

-- [ NOT NULL ���� �߰��ϱ� ]
-- 1. p_code Į���� �߰�, ���ڿ��̹Ƿ� �⺻������ ��ĭ�� �߰�(���� Į���̸� �⺻������ 0�� �߰�)
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) DEFAULT ' ');
-- 2. p_code Į���� ���������� NOT NULL�� ����
ALTER TABLE tbl_iolist MODIFY (io_pcode CONSTRAINT io_pcode NOT NULL);

-- Į�� �߰��ϱ�
ALTER TABLE tbl_iolist ADD io_pcode CHAR(5);
-- Į�� �����ϱ�
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;
-- Į�� NOT NULL���� �߰��ϱ�
ALTER TABLE tbl_iolist MODIFY (io_pcode CONSTRAINT io_pcode NOT NULL);
-- Į�� TYPE �����ϱ�
ALTER TABLE tbl_iolist MODIFY (io_pcode CHAR(10));
-- Į�� TYPE �����ϱ� ���ǻ���
-- Į���� TYPE�� ������ �� 
-- ���ڿ� <=> ����ó�� 
-- TYPE�� ������ �ٸ� ���� ������ �߻��ϰų� �����͸� ��� ���� �� �ִ�.
-- CHAR <=> (n)VARCHAR2
-- ���ڿ��� ���̰� ������ ������ ��ȯ�� �̷������.
-- CAHR <=> nVARCHAR2�� ����� ���ڿ��� UNICODE(�ѱ� ��)�̸� �ſ� �����ؾ� �Ѵ�.
-- ���� ���̰� �ٸ��� ������ ������, ���������� ����� ����Ǵ���
-- �����Ͱ� �߸��ų�, ���ڿ��� �� �� ���� ������ �����Ǵ� ��찡 �߻��� �� �ִ�.

-- Į���̸� �����ϱ�
ALTER TABLE tbl_iolist RENAME COLUMN io_pcode TO io_pcode1; -- io_pcode�̸��� io_pcode1���� ����

-- ��ǰ�������� ���Ը����� �� ���ڵ��� ��ǰ��� ��ġ�ϴ� ��ǰ�ڵ带 ã�Ƽ�
-- ���Ը������� ��ǰ�ڵ�(io_pcode)Į���� UPDATE�ϱ�

-- UPDATE ����� SubQuery�� ������
-- 1. SubQuery���� ���� iolist�� io_pnameĮ���� ���� �䱸�ϰ� �ִ�.
-- 2. tbl_iolist�� ���ڵ带 ��ü SELECT�� �����Ѵ�.
-- 3. SELECT�� List���� io_pnameĮ�� ���� SubQuery�� �����Ѵ�.
-- 4. SubQuery�� ���޹��� io_pname���� tbl_product���̺��� ��ȸ�Ѵ�.
--    �� �� SubQuery�� �ݵ�� �Ѱ��� Į��, �Ѱ��� VO�� �����ؾ� �Ѵ�.
-- 5. �� ����� ���� iolist�� ���ڵ��� io_pcodeĮ���� UPDATE�� �����Ѵ�.
UPDATE tbl_iolist IO
SET io_pcode =
(
    SELECT p_code
    FROM tbl_product P
    WHERE P.p_name =  IO.io_pname
);

SELECT io_pcode FROM tbl_iolist;

-- iolist�� pcode�� ���������� UPDATE�Ǿ����� ����
SELECT IO.io_pcode, IO.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_prodUct P
        ON IO.io_pcode = P.p_code
WHERE P.p_name IS NULL;

--------------------------------------------------------------------------------------
-- [ �ŷ�ó������ ����ȭ ]
--------------------------------------------------------------------------------------
-- �ŷ�ó��, CEOĮ���� ���̺� ����ִ�.
-- �� Į���� �����Ͽ� �ŷ�ó ������ ����
-- ����� ������ �� �ŷ�ó���� ���� ceo�� �ٸ��� �ٸ� ȸ��� ����
-- �ŷ�ó��� ceo�� ������ ���� ȸ��� ���� �����͸� �����.
SELECT io_dname, io_dceo
FROM tbl_iolist
GROUP BY io_dname, io_dceo
ORDER BY io_dname;


CREATE TABLE tbl_buyer(
    b_code	CHAR(4)		PRIMARY KEY,
    b_name	nVARCHAR2(125)	NOT NULL,	
    b_ceo	nVARCHAR2(125)	NOT NULL,	
    b_tel	VARCHAR2(20)		
);

SELECT * FROM tbl_buyer;

-- b_telĮ���� ���� �ߺ���(2�� �̻�)�� ���ڵ尡 �ִ�?
SELECT b_tel, COUNT(*) FROM tbl_buyer
GROUP BY b_tel
HAVING COUNT(*) > 1;

-- iolist�� ����� dname, dceo Į������ �ŷ�ó�������� �����͸� ��ȸ�ϰ�
-- iolist�� �ŷ�ó�ڵ� Į������ UPDATE

ALTER TABLE tbl_iolist ADD (io_bcode CHAR(4) DEFAULT ' ');
ALTER TABLE tbl_iolist MODIFY (io_bcode CONSTRAINT io_bcode NOT NULL);

DESC tbl_iolist;

-- iolist�� buyer���̺� ���� �ŷ�ó��, ��ǥ�ڸ� Į������ JOIN�� �����Ͽ� ������ ����
-- �����Ͱ� �Ѱ��� ��µ��� �ʾƾ� �Ѵ�.
SELECT *
FROM tbl_iolist IO
    LEFT JOIN tbl_buyer B
        ON IO.io_dname = B.b_name
WHERE B.b_name IS NULL;        

-- [ iolist �� �ŷ�ó �ڵ� UPDATE ]
-- ���� ������ tbl_buyer ���̺��� �ŷ�ó���� ���� ��ǥ�ڰ� �ٸ� �����Ͱ� �ִ�.
-- �� �����Ϳ��� �ŷ�ó������ ��ȸ�� �ϸ� ��µǴ� ���ڵ�(row)�� 2�� �̻��� ��찡 �߻��Ѵ�.
-- ���� �� ������ �����ϸ� ORA-01427: single-row subquery returns more than one row ������ �߻��Ѵ�
-- �� ������ �ŷ�ó��� CEO ���� ���ÿ� �����Ͽ� 1���� row���� Sub query���� ����� ������ �ؾ� �Ѵ�.
UPDATE tbl_iolist IO
SET io_bcode =
(
    SELECT b_code
    FROM tbl_buyer B
    WHERE B.b_name = io.io_dname 
            AND B.b_ceo = IO.io_dceo
);

SELECT io_bcode, io_dname, b_code, b_name
FROM tbl_iolist IO
    LEFT JOIN tbl_buyer B
        ON IO.io_bcode = B.b_code
WHERE b_code IS NULL OR b_name IS NULL;

-- �����͸� tbl_product, tbl_buyer ���̺�� �и� ������
-- tbl_iolist���� io_pname, io_dname, io_dceo Į���� �ʿ䰡 �����Ƿ� �����Ѵ�.
ALTER TABLE tbl_iolist DROP COLUMN io_pname;
ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;

CREATE VIEW view_iolist
AS
(
SELECT io_seq, io_date, 
        io_bcode, b_name,b_ceo,b_tel, 
        io_pcode, p_name,p_iprice, p_oprice,
        io_inout,
        DECODE(io_inout,'����',io_price,0) AS ���Դܰ�, 
        DECODE(io_inout,'����',io_amt,0) AS ���Աݾ�,
        DECODE(io_inout,'����',io_price,0) AS ����ܰ�, 
        DECODE(io_inout,'����',io_amt,0) AS ����ݾ�
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON io.io_pcode = P.p_code
    LEFT JOIN tbl_buyer B
        ON io.io_bcode = b.b_code
);


SELECT * FROM view_iolist
WHERE io_date BETWEEN '2019-01-01' AND '2019-01-31'
ORDER BY io_date ;














