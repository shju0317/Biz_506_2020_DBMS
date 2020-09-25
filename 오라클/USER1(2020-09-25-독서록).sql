-- USER1 독서록 프로젝트
DROP TABLE tbl_member;

CREATE TABLE tbl_member(
    M_USERID	VARCHAR2(30)	PRIMARY KEY,
    M_PASSWORD	nVARCHAR2(255)	NOT NULL,	
    M_NAME	    nVARCHAR2(30),
    M_TEL	    nVARCHAR2(30),
    M_ADDRESS	nVARCHAR2(125),	
    M_ROLL	    nVARCHAR2(20),
    
    -- ENABLE칼럼에 문자열 0 또는 1 이외의 값은 저장하지 말라
    -- CHECK 제약사항 등록
    ENABLE	    CHAR(1)	DEFAULT '0' CONSTRAINT enable_veri CHECK(ENABLE= '0' OR ENABLE='1'),
    AccountNonExpired	    CHAR(1),	
    AccountNonLocked	    CHAR(1),		
    CredentialsNonExpired	CHAR(1)		
);