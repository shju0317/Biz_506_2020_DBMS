-- ReadBookV2

SELECT * FROM tbl_member;
DELETE FROM tbl_member WHERE m_userid = 'admin';
COMMIT;

UPDATE tbl_member SET enabled = '1' WHERE m_userid = 'admin11';


CREATE TABLESPACE tsDEPT
DATAFILE 'C:/bizwork/workspace/oracle_data/tsDEPT.dbf'
SIZE 1M AUTOEXTEND ON NEXT 500K;

CREATE USER user1 IDENTIFIED BY 1234 
DEFAULT TABLESPACE tsDEPT; 

GRANT DBA TO user1;