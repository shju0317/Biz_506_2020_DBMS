-- USER1 독서록 프로젝트
DROP TABLE tbl_member;

CREATE TABLE tbl_member(
    M_USERID	VARCHAR2(30)	PRIMARY KEY,
    M_PASSWORD	nVARCHAR2(255)	NOT NULL,	
    M_NAME	    nVARCHAR2(30),
    M_TEL	    VARCHAR2(30),
    M_EMAIL	    VARCHAR2(30),
    M_ADDRESS	nVARCHAR2(125),	
    M_ROLL	    VARCHAR2(20),
    
    -- ENABLE칼럼에 문자열 0 또는 1 이외의 값은 저장하지 말라
    -- CHECK 제약사항 등록
    ENABLED	    CHAR(1)	DEFAULT '0' 
                CONSTRAINT enable_veri CHECK(ENABLED= '0' OR ENABLED='1'),
    AccountNonExpired	    CHAR(1),	
    AccountNonLocked	    CHAR(1),		
    CredentialsNonExpired	CHAR(1)		
);

CREATE TABLE tbl_authority(
    seq	        NUMBER		PRIMARY KEY,
    M_USERID	VARCHAR2(30)	NOT NULL,	
    M_ROLE	    VARCHAR2(30)	NOT NULL	
);

CREATE SEQUENCE seq_authority
START WITH 1 INCREMENT BY 1;

COMMIT;

ROLLBACK;

DELETE FROM tbl_member;
DELETE FROM tbl_authority;

SELECT * FROM tbl_member;
SELECT * FROM tbl_authority;

-- 한 개의 table에 여러 개의 데이터를 INSERT할 때 사용하는 다중 INSERT SQL이다.
-- seq값으로 PK 설정을 해두면 SQL 작동을 하지 않는다.
INSERT ALL
    INTO tbl_member (m_userid, m_password) VALUES ('user1', 1)
    INTO tbl_member (m_userid, m_password) VALUES ('user2', 1)
    INTO tbl_member (m_userid, m_password) VALUES ('user3', 1)
    INTO tbl_member (m_userid, m_password) VALUES ('user4', 1)
SELECT * FROM dual;

-- SEQ 값을 시퀀스의 NEXTVAL 값으로 설정하는 TABLE의 경우 다중 INSERT 오류가 발생한다.
INSERT ALL INTO tbl_authority (m_userid, m_role) VALUES ('admin','ADMIN')
    INTO tbl_authority (m_userid, m_role) VALUES ('admin1','ADMIN')
    INTO tbl_authority (m_userid, m_role) VALUES ('admin2','ADMIN')
    INTO tbl_authority (m_userid, m_role) VALUES ('admin3','ADMIN')
SELECT * FROM dual;

DELETE FROM tbl_authority;

-- 오라클에서 SEQ PK칼럼을 가진 TABLE에 다중 INSERT문을 수행하기 위해서
-- 1. 추가할 데이터를 갖는 가상의 TABLE을 생성
-- 2. 가상 TABLE 생성 SQL을 서브쿼리로 묶는다.
-- 3. 서브쿼리 부모 SQL에서 SEQ.NEXTVAL 실행하여 UNIQUE한 SEQ를 생성
-- 4. 생성된 가상테이블 데이터를 INSERT문을 사용하여 TABLE에 추가
-- 5. 생성된 가상 테이블의 데이터를 tbl_authority 테이블에 복사하는 코드
INSERT INTO tbl_authority (seq,m_userid,m_role)
SELECT SEQ_AUTHORITY.NEXTVAL, SUB.* FROM
(
-- 가상테이블
    SELECT 'user11' AS USERNAME, 'ROLE_ADMIN' AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user11' AS USERNAME, 'ROLE_USER' AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user12' AS USERNAME, 'ROLE_ADMIN'AS AUTHORITY FROM DUAL
    UNION ALL
    SELECT 'user12' AS USERNAME, 'ROLE_USER'AS AUTHORITY FROM DUAL
) SUB;

SELECT * FROM tbl_authority;

DELETE FROM tbl_member;
DELETE FROM tbl_authority;
COMMIT;

SELECT * FROM tbl_member;
SELECT * FROM tbl_authority;

SELECT * FROM tbl_member M
    LEFT JOIN tbl_authority A
        ON M.m_userid = A.m_userid;

UPDATE tbl_member SET enabled = 1 WHERE m_userid = 'user';

