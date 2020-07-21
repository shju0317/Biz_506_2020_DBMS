-- ����� user1 ȭ���Դϴ�.

-- ǥ�� SQL
-- CASE WHEN ���ǹ� THEN true�� �� �� ELSE false�� �� �� END
-- DECODE(Į��,���ǰ� true�� ��, false�� ��)
SELECT io_bcode, 
	SUM(CASE WHEN io_inout = '����' THEN io_amt ELSE 0 END) AS �����հ�,
	SUM(CASE WHEN io_inout = '����' THEN io_amt ELSE 0 END) AS �����հ�
FROM tbl_iolist
GROUP BY io_bcode;

-- ����Ŭ���� ���Ŀ� PK�� �����ϴ� ���
-- ������ PK�� ������ �ߺ��������� �ʴ´�
-- PK_iolist : ����Ŭ������ ���Ǵ� PK�� ã�� ����
--             Ȥ�� PK�� ������ ���� ���� �� �ʿ��� �̸�
ALTER TABLE tbl_iolist ADD CONSTRAINT PK_iolist PRIMARY KEY (io_seq, io_date);
ALTER TABLE tbl_iolist DROP PRIMARY KEY;

CREATE TABLE tbl_test(
    t_seq NUMBER PRIMARY KEY,
    t_name nVARCHAR2(20)
);

-- ����Ŭ���� TABLE�� AUTO_INCREMENT ������ ����.
-- ���� �Ϸù�ȣ�� ���� Į���� ����Ͽ� PK�� ����� ���� ���� ����� ����� ��Ȳ�� �ȴ�.
-- INSERT�� ������ ������ ������ ����� �Ϸù�ȣ���� ��ȸ�ϰ� +1�� �����Ͽ� �ٽ� INSERT �����ϴ� ����
-- �ݺ��ؾ� �ϱ� ������

-- ������ ����Ŭ���� SEQUENCE��� �ٸ� DBMS�� ���� Ư���� ��ü�� �ִ�.
-- �� ��ü�� ��ü.NEXTVAR �̶�� Ư���� ȣ���ڰ� �ִµ�
-- �� ȣ���ڸ� ȣ���� ������(SELECT, INSERT ��) ���ο� ������ �ִ� ��������
-- ������ ������ ��Ģ�� ���� �ڵ� �����Ͽ� �����Ѵ�.
-- �� ��ü.NEXTVAL �� ������ �ִ� ����
-- INSERT�� ������ �� PK�� seqĮ���� �������ϸ� AUTO_INCREMENT ȿ���� �� �� �ִ�.
CREATE SEQUENCE seq_test
START WITH 1    -- ���ʿ� �����ϴ� ��
INCREMENT BY 1; -- ȣ��� ������ ������ ��

INSERT INTO tbl_test(t_seq, t_name)
VALUES (seq_test.NEXTVAL, 'ȫ�浿');

SELECT * FROM tbl_test;






