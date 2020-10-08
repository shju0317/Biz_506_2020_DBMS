-- ReadBookV2

SELECT * FROM tbl_member;
DELETE FROM tbl_member WHERE m_userid = 'admin';
COMMIT;

UPDATE tbl_member SET enabled = '1' WHERE m_userid = 'admin11';