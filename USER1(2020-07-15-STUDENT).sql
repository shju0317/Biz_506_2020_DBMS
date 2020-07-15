--
SELECT st_dept FROM tbl_student
GROUP BY st_dept;

CREATE TABLE tbl_student(
    st_num CHAR(5) PRIMARY KEY,
    st_name VARCHAR2(20),
    st_dept CHAR(4),
    st_grade NUMBER(1),
    st_tel VARCHAR2(20),
    st_addr VARCHAR2(125),
    st_age NUMBER(3)
);

DROP TABLE tbl_student; 

SELECT * FROM tbl_student;

CREATE TABLE tbl_dept (
    d_code CHAR(4) PRIMARY KEY,
    d_name nVARCHAR2(20) NOT NULL UNIQUE,
    d_prof nVARCHAR2(20)
);


INSERT INTO tbl_dept (d_name, d_code) VALUES ('관광학', 'D001');
INSERT INTO tbl_dept (d_name, d_code) VALUES ('국어국문','D002');
INSERT INTO tbl_dept (d_name, d_code) VALUES ('법학','D003');
INSERT INTO tbl_dept (d_name, d_code) VALUES ('전자공학','D004');
INSERT INTO tbl_dept (d_name, d_code) VALUES ('컴퓨터공학','D005');

SELECT * FROM tbl_dept;

SELECT st_num, st_name, st_dept, d_name, st_grade
FROM tbl_student
    LEFT JOIN tbl_dept
        ON st_dept = d_code
WHERE st_num BETWEEN '20001' AND '20010';

-- 기존의 관광학 학과 이름이 관광정보학으로 변경되었다.
-- 학생정보를 조회할 때 관광학으로 되어있는 항목을 모두 관광정보학으로 변경해라

-- 학생테이블에 학과이름이 등록되어 있는 경우
UPDATE tbl_student
SET st_dept = '관광정보학'
WHERE st_dept = '관광학';
-- 이 Query는 다수의(2개이상)의 레코드를 변경하는 쿼리로
-- 가급적 사용하지 말라는 코드이다.
-- 많은 위험요소를 가지고 있기 때문에

-- 학생테이블에는 학과코드정보를 저장해 두고
-- 별도로 학과테이블을 만들어 관리하고 있다.
-- 이런 상황이 되면 학과명을 바꿀 때
UPDATE tbl_dept
SET d_name = '관광정보학'
WHERE d_code = 'D001';

SELECT st_num, st_name, st_dept, d_name, st_grade
FROM tbl_student
    LEFT JOIN tbl_dept
        ON st_dept = d_code
WHERE st_num BETWEEN '20001' AND '20010';

CREATE TABLE tbl_score(
sc_num	CHAR(5)		PRIMARY KEY,
sc_kor	NUMBER(3)		,
sc_eng	NUMBER(3)		,
sc_math	NUMBER(3)		,
sc_music	NUMBER(3)	,
sc_art NUMBER(3)
);

SELECT * FROM tbl_score;

SELECT sc_num, st_name, st_dept, d_name, sc_kor, sc_eng
FROM tbl_score
        LEFT JOIN tbl_student
            ON sc_num = st_num
        LEFT JOIN tbl_dept
            ON st_dept = d_code
WHERE sc_num BETWEEN '20001' and '20010';
