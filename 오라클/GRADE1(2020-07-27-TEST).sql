-- 학생정보 테이블
CREATE TABLE tbl_student(     
    st_num	CHAR(5)		PRIMARY KEY,    -- 학번
    st_name	nVARCHAR2(20)	NOT NULL,   -- 학생이름
    st_tel	VARCHAR2(20)	NOT NULL,	-- 전화번호
    st_addr	nVARCHAR2(125),		        -- 주소
    st_grade	NUMBER	NOT NULL,	    -- 학년
    st_code	CHAR(4)	NOT NULL	        -- 학과
);

-- 학과정보 테이블
CREATE TABLE tbl_dept(
    d_code	CHAR(3)		PRIMARY KEY,            -- 학과코드
    d_name	nVARCHAR2(20)	UNIQUE NOT NULL,	-- 학과명
    d_prof	nVARCHAR2(20)		                -- 담당교수
);


-- 학생성적 테이블
CREATE TABLE tbl_score(
    sc_num	CHAR(5)	NOT NULL,           -- 학번
    sc_sub	nVARCHAR2(30)	NOT NULL,   -- 과목명
    sc_score	NUMBER(3)	NOT NULL,   -- 점수
    CONSTRAINT sc_pk PRIMARY KEY (sc_num, sc_sub)
);


INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20001', '길한수', '010-2217-7851', '경남 김해시 어방동 1088-7', 3, '008');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20002', '강이찬', '010-4311-1533', '강원도 속초시 대포동 956-5', 1, '006');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20003', '개원훈', '010-6262-7441', '경북 영천시 문외동 38-3번', 1, '009');

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20004', '경시현', '010-9794-9856', '서울시 구로구 구로동 3-35번지', 1, '006');    

INSERT INTO tbl_student 
    (st_num, st_name, st_tel, st_addr, st_grade, st_code)
VALUES
    ('20005', '공동영', '010-8811-7761', '강원도 동해시 천곡동 1077-3', 2, '010');    
    


INSERT INTO tbl_dept  (d_code, d_name, d_prof) VALUES ('001', '컴퓨터공학', '토발즈');
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES ('002', '전자공학', '이철기');    
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES ('003', '법학', '킹스필드');



INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '데이터베이스', 71);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '수학', 63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001', '미술', 50);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '데이터베이스', 84);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '음악', 75);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002', '국어', 52);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '수학', 89);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '영어', 63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003', '국어', 70);
    
SELECT * FROM tbl_student;    



SELECT sc_num 
FROM tbl_score
WHERE sc_score < 60;



SELECT st_num
FROM tbl_student
WHERE st_name = '공동영';

UPDATE tbl_student
SET st_addr = '광주광역시 북구 중흥동 경양로 170번'
WHERE st_num = '20005';


SELECT st_num
FROM tbl_student
WHERE st_name = '개원훈';

DELETE FROM tbl_student
WHERE st_num = '20003';


SELECT  sc_num AS 학번, SUM(sc_score) AS 총점, ROUND(AVG(sc_score),2) AS 평균
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;




SELECT  SC.sc_num AS 학번, ST.st_name AS 학생이름, ST.st_tel AS 전화번호, SUM(SC.sc_score) AS 총점, ROUND(AVG(SC.sc_score),2) AS 평균
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num 
GROUP BY SC.sc_num, ST.st_name, ST.st_tel
ORDER BY SC.sc_num;

--DROP TABLE tbl_student;
--DROP TABLE tbl_score;
--DROP TABLE tbl_dept;

SELECT * FROM tbl_student;
SELECT * FROM tbl_score;

SELECT sc_num,
     SUM(DECODE(sc_sub, '국어', sc_score, 0)) AS 국어,   
     SUM(DECODE(sc_sub, '영어', sc_score, 0)) AS 영어,
     SUM(DECODE(sc_sub, '수학', sc_score, 0)) AS 수학,
     SUM(DECODE(sc_sub, '음악', sc_score, 0)) AS 음악,
     SUM(DECODE(sc_sub, '미술', sc_score, 0)) AS 미술,
     SUM(DECODE(sc_sub, '소프트웨어공학', sc_score, 0)) AS 소프트웨어공학,
     SUM(DECODE(sc_sub, '데이터베이스', sc_score, 0)) AS 데이터베이스
FROM tbl_score
GROUP BY sc_num
ORDER BY sc_num;

-----------------------------------------------------------

CREATE  VIEW view_score
AS
(   SELECT sc_num, 국어, 영어, 수학, 음악, 미술, 소프트웨어공학, 데이터베이스
    FROM tbl_score
    PIVOT (
        SUM(sc_score)
        FOR sc_sub IN ('국어' AS 국어, '영어' AS 영어, '수학' AS 수학, '음악' AS 음악, '미술' AS 미술,
                        '소프트웨어공학' AS 소프트웨어공학, '데이터베이스' AS 데이터베이스)
    )
);

SELECT * FROM view_score;
DROP VIEW view_score;


--SELECT 
--       SUM("국어" + "영어" + "수학" + "음악" + "미술" + "소프트웨어공학" + "데이터베이스") AS 총점,
--       AVG("국어" + "영어" + "수학" + "음악" + "미술" + "소프트웨어공학" + "데이터베이스") AS 평균
--FROM view_score
--GROUP BY sc_num;

SELECT *
FROM view_score SC,
       (SELECT 
        SUM("국어" + "영어" + "수학" + "음악" + "미술" + "소프트웨어공학" + "데이터베이스") AS 총점,      
        AVG("국어" + "영어" + "수학" + "음악" + "미술" + "소프트웨어공학" + "데이터베이스") AS 평균
        FROM view_score
        GROUP BY sc_num
);

--------------------------------------------

SELECT SC.sc_num, ST.st_name, SC.국어, SC.영어, SC.수학, SC.음악, SC.미술, SC.소프트웨어공학, SC.데이터베이스,
       SUM(SC.국어 + SC.영어 + SC.수학 + SC.음악 + SC.미술 + SC.소프트웨어공학 + SC.데이터베이스) AS 총점
FROM(
    SELECT sc_num, 국어, 영어, 수학, 음악, 미술, 소프트웨어공학, 데이터베이스
        FROM tbl_score
        PIVOT (
            SUM(sc_score)
            FOR sc_sub IN ('국어' AS 국어, '영어' AS 영어, '수학' AS 수학, '음악' AS 음악, '미술' AS 미술, 
            '소프트웨어공학' AS 소프트웨어공학, '데이터베이스' AS 데이터베이스)
        )
) SC
    LEFT JOIN tbl_student ST
        ON ST.st_num = SC.sc_num
ORDER BY SC.sc_num;