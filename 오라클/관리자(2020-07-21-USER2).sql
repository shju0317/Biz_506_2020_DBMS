-- ����� ������ ȭ���Դϴ�.

-- ���ο� TableSpace�� ����ڸ� ����ϱ�
-- TableSpace : user2Ts
-- user : user2, password : user2
-- C:\bizwork\workspace\oracle_data
CREATE TABLESPACE user2Ts
DATAFILE 'C:/bizwork/workspace/oracle_data/user2.dbf'
SIZE 1M AUTOEXTEND ON NEXT 10K;

CREATE USER user2 IDENTIFIED BY user2
DEFAULT TABLESPACE user2Ts;

GRANT DBA TO user2;
