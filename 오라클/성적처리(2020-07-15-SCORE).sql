-- 여기는 GRADE 화면

-- [ DEFAULT ]
-- 해당하는 칼럼에 데이터를 지정하지 않고 INSERT 수행하면
-- DEFAULT로 설정된 값을 지정한 것으로 이해하고 INSERT를 수행하라
CREATE TABLE tbl_score(
    sc_num	CHAR(5)		PRIMARY KEY,	
    sc_kor	NUMBER(3) DEFAULT 0,			
    sc_eng	NUMBER(3) DEFAULT 0,			
    sc_math	NUMBER(3) DEFAULT 0,			
    sc_music NUMBER(3) DEFAULT 0,
    sc_art NUMBER(3) DEFAULT 0
);

DROP TABLE tbl_score;

INSERT INTO tbl_score (sc_num) VALUES ('20001');

SELECT * FROM tbl_score;
SELECT COUNT(*) FROM tbl_score;

-------------------------------------------------------------------------------
-- [ 성적정보 Table을 활용한 SELECT ]
-------------------------------------------------------------------------------
-- 학생별 성적의 총점과 평균 계산하여 리스트로 확인하기
-- AS(Alias) : Table의 칼럼명, 연산수식 등에 별명을 부여하여 사용하는 방법
SELECT sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor + sc_eng + sc_math + sc_music + sc_art) AS 총점,
    (sc_kor + sc_eng + sc_math + sc_music + sc_art) / 5 AS 평균
FROM tbl_score;

-- 각 과목별 총점 계산하기 => 집계,통계를 수행한다
SELECT  SUM(sc_kor) AS 국어총점, 
        SUM(sc_eng) AS 영어총점, 
        SUM(sc_math) AS 수학총점, 
        SUM(sc_music) AS 음악총점,
        SUM(sc_art) AS 미술총점
FROM tbl_score;

-- 각 과목별 평균 계산하기
SELECT  AVG(sc_kor) AS 국어평균, 
        AVG(sc_eng) AS 영어평균, 
        AVG(sc_math) AS 수학평균, 
        AVG(sc_music) AS 음악평균,
        AVG(sc_art) AS 미술평균
FROM tbl_score;

-- SELECTION을 적용하여 구현
-- 학번이 20001~20010까지인 학생의 리스트만 보고 싶을 때
SELECT * FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';

-- 학번이 20001~20010까지인 학생들만 추출하여 과목별 총점 계산하기
SELECT  SUM(sc_kor) AS 국어총점, 
        SUM(sc_eng) AS 영어총점, 
        SUM(sc_math) AS 수학총점, 
        SUM(sc_music) AS 음악총점,
        SUM(sc_art) AS 미술총점
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';

-- 학번이 20001~20010까지인 학생들만 추출하여 과목별 평균 계산하기
SELECT  AVG(sc_kor) AS 국어평균, 
        AVG(sc_eng) AS 영어평균, 
        AVG(sc_math) AS 수학평균, 
        AVG(sc_music) AS 음악평균,
        AVG(sc_art) AS 미술평균
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';

-- SUM()함수를 이용하여 각 과목별 총점을 계산하면서
-- 의미없는(DUMY)칼럼을 '==과목총점=='이라는 값으로 만들었다.
-- 통계,집계함수를 사용할 때 통계,집계함수로 묶이지 않은 칼럼은
-- 무조건 GROUP BY절에 칼럼을 나열해 주어야 한다.
SELECT  sc_num AS 학번,
        (sc_kor) AS 국어, 
        (sc_eng) AS 영어, 
        (sc_math) AS 수학, 
        (sc_music) AS 음악,
        (sc_art) AS 미술
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'

UNION ALL

SELECT  '==과목총점==',
        SUM(sc_kor) AS 국어, 
        SUM(sc_eng) AS 영어, 
        SUM(sc_math) AS 수학, 
        SUM(sc_music) AS 음악,
        SUM(sc_art) AS 미술
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'
GROUP BY '==과목총점=='

UNION ALL

SELECT  '==과목평균==', 
        AVG(sc_kor) AS 국어, 
        AVG(sc_eng) AS 영어, 
        AVG(sc_math) AS 수학, 
        AVG(sc_music) AS 음악,
        AVG(sc_art) AS 미술
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'
GROUP BY '==과목평균==';
