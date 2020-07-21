-- 여기는 user1 화면입니다

-- [ 이상현상 ]
-- 추가이상, 변경(수정)이상, 삭제이상
-- DBMS에 저장하는 혹은 저장된 데이터를 관리할 때(SELECT 외의 CUD에서)
-- 문제가 발생하여 원본데이터가 무결성을 잃는 상황

-- 추가이상 방지 : PRIMARY KEY, UNIQUE, NOT NULL
-- 이러한 제약조건을 설정하여 잘못된 데이터가 INSERT되는 현상을 막는다.
-- PK로 설정된 칼럼은 천재지변으로 문제가 발생하지 않는 한 저장된 값은 
-- 변경, 삭제를 금해야 한다.
-- 필요없는 데이터가 발생하는 경우 데이터를 삭제하는 대신
-- 특정한 칼럼을 하나 마련하고, 그 칼럼에 데이터의 사용유무를 등록하여
-- 관리하는 것이 실무상 원칙이다.

-- 변경&삭제이상 방지 : 특별한 경우가 아니면 2개 이상의 Record에 변화가
-- 발생하지 않도록 코드나 관리를 설계해야 한다.

-- 어떤 테이블에 변경될 가능성이 1이라도 존재하는 칼럼이 있는데
-- 여기에 동일한 값들이 중복되어 저장되어 있을 때
-- 이 칼럼의 값은 여러 Record가 변경, 삭제되는 일이 생길 수 있다.
-- 더불어 이러한 변경, 삭제를 수행하는 동안 데이터에 문자가 발생할 수도 있다.

-- [ 데이터베이스의 정규화]
-- : 설계차원에서 변경, 삭제 이상을 막기 위한 조치



-------------------------------------------------------------------------------
-- [ 학과정보 ]
-------------------------------------------------------------------------------
DROP TABLE tbl_dept;


CREATE TABLE tbl_dept(
    d_code	CHAR(4)		PRIMARY KEY,
    d_name	nVARCHAR2(20) NOT NULL,	
    d_prof	nVARCHAR2(20),
    d_assist nVARCHAR2(20),	
    d_tel   VARCHAR2(20),
    d_addr	nVARCHAR2(125)		

);

SELECT * FROM tbl_dept;

-- 학생정보를 조회하면서 학과 테이블과 연결하여 조회
-- 기본 SELECT*를 시작
-- FROM절에 보고자하는 주 Table(Master)를 작성
-- LEFT JOIN절에 보조정보가 담긴 Table을 작성
-- ON 두 테이블의 연관관계를 설정하는 키를 지정
-- SELECT에 필요한 칼럼들을 나열
SELECT st_num, st_name, st_dept, d_name, d_prof, d_tel, st_grade, st_tel, st_addr
FROM tbl_student
    LEFT JOIN tbl_dept
        ON st_dept = d_code;

-- JOIN이 된 후에 보조테이블의 칼럼을 WHERE조건설정을 하여 SELECTION을 수행할 수 있다.
SELECT st_num, st_name, st_dept, d_name, d_prof, d_tel, st_grade, st_tel, st_addr
FROM tbl_student
    LEFT JOIN tbl_dept
        ON st_dept = d_code
WHERE d_name = '법학';        


-------------------------------------------------------------------------------
-- [ alias ]
-------------------------------------------------------------------------------
-- 다수의 Table을 JOIN으로 설정하다보면
-- 다른 table의 같은 칼럼이름이 존재할 수 있다.
-- 보통은 칼럼에 Prefix를 붙여 그 부분을 명확하게 하지만
-- table이 많아지다 보면 같은 이름의 칼럼이 존재할 수 있다.
-- 이러한 상황에서 JOIN을 수행하면 칼럼을 제대로 인식하지 못하여
-- 오류가 발생하는 경우가 있다(실제로 많다).
-- 이런 경우 Table에 Alias를 설정하여 주면 오류를 막을 수 있다.
-- [Table] AS [alias] 형식으로 작성
-- 단, 오라클에서는 AS키워드를 사용하지 않는다.
SELECT ST.st_num, ST.st_name, ST.st_dept, 
        DT.d_name, DT.d_prof, DT.d_tel, 
        ST.st_grade, ST.st_tel, ST.st_addr
FROM tbl_student ST
    LEFT JOIN tbl_dept DT
        ON ST.st_dept = DT.d_code
WHERE d_name = '법학';        

-------------------------------------------------------------------------------
-- [ VIEW 생성 ]
-------------------------------------------------------------------------------
-- SELECT 명령문을 사용하여 복잡한 Query를 작성하고
-- 작성된 Query를 자주 사용하게 될 것으로 예상이 되면
-- 이 Query로 View를 생성해 보관할 수 있다.

-- View는 실제 Table과 똑같이 SELECT명령을 통해 데이터를 조회할 수 있다.
-- 하지만 View는 실제 데이터를 가지고 있지 않다.
-- 원본 Table로부터 Query를 실행하여 (보통 임시저장소에 저장해두고)
-- 결과를 보여주는 역할을 한다.

CREATE VIEW view_score
AS        
(        
    SELECT SC.sc_num, ST.st_name, ST.st_tel, ST.st_dept,
            DT.d_name, DT.d_prof, DT.d_tel,
            SC.sc_kor, SC.sc_eng, SC.sc_math, SC.sc_music, SC.sc_art
    FROM tbl_score SC
        LEFT JOIN tbl_student ST
            ON ST.st_num = SC.sc_num
        LEFT JOIN tbl_dept DT
            ON ST.st_dept = DT.d_code
);

SELECT *
FROM view_score;
        
SELECT *
FROM view_score
WHERE sc_num BETWEEN '20001' AND '20010'
ORDER BY sc_num;

SELECT SUBSTR(sc_num,1,4) AS NUM,
    SUM(sc_kor), SUM(sc_eng), SUM(sc_math)
FROM view_score    
GROUP BY SUBSTR(sc_num,1,4);
        
SELECT *
FROM tbl_student;

DROP VIEW view_sim_student;


-- 중요정보를 보면 안되는 사용자가 있을 때
-- 보여줘도 문제 없는 칼럼만 PROJECTION한 쿼리를 만들고
-- 이 쿼리를 View생성해 두면
-- 권한이 제한된 사용자는 꼭 필요한 정보만을 보게 되어
-- 보안, 개인정보 보호 등의 용도로 사용할 수 있다.
CREATE VIEW view_sim_student
AS
(
    SELECT ST.st_num, ST.st_name, ST.st_dept, DT.d_name
    FROM tbl_student ST
        LEFT JOIN tbl_dept DT
            ON ST.st_dept = DT.d_code
);      

SELECT * FROM view_sim_student
ORDER BY st_num;        
        
        
        
        
        
        
        
        