-- 여기는 user1 화면입니다.

SELECT * FROM tbl_student;

--------------------------------------------------------------------------------
-- [ SELECTION 연산 ]
-- 전체 데이터에서 필요한 record만 추출하기
--------------------------------------------------------------------------------
-- PK칼럼에 1개의 조건을 부여하여 조회하기
-- 반드시 1개의 결과값(Record)만 나타난다.
SELECT * FROM tbl_student
WHERE st_num = '20010';

-- (일반)칼럼에 1개의 조건을 부여하여 조회하기
-- (일반)칼럼에 조건을 부여하여 조회한 결과는
-- 지금 1개의 레코드만 보일지라도 이 결과는 리스트형으로 출력된다.
SELECT * FROM tbl_student
WHERE st_name = '남동예';

-- PK칼럼에 2개 이상의 조건을 부여하여 조회하기
-- 만약 결과가 1개의 레코드만 보일지라도 결과는 리스트형으로 출력된다(취급한다).
SELECT * FROM tbl_student
WHERE st_num = '20010' OR st_num = '20020' OR st_num = '20030';

-- 1개의 칼럼에 다수의 OR조건을 부여하여 SELECTION을 할 때는
-- IN연산자를 사용할 수 있다.
SELECT * FROM tbl_student
WHERE st_num  IN ('20010', '20020', '20030');

-- 1개의 칼럼값을 범위로 제한하는 SELECTION을 할 때
-- 부등호연산 숫자 칼럼에만 적용되는 것이 원치
-- 문자열일 경우에도 저장된 데이터의 길이가 모두 같고
-- 패턴이 같으면 문자열도 부등호 연산이 가능하다.
SELECT * FROM tbl_student
WHERE st_num >= '20010' AND st_num <= '20030';

-- 범위를 지정할 때 시작값과 종료값이 포함되는 연산을 수행할 때는
-- BETWEEN 연산자를 사용할 수 있다.
SELECT * FROM tbl_student
WHERE st_num BETWEEN '20010' AND '20020';


--------------------------------------------------------------------------------
-- [ PROJECTION ]
-- Table에 있는 칼럼 중에서 내가 보고자 하는 칼럼만 나타나도록 제한하는 것
--------------------------------------------------------------------------------

SELECT st_num, st_name, st_dept 
FROM tbl_student;

-- PROJECTION
-- PROJECTION 연산
SELECT * FROM tbl_score;
SELECT sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
        (sc_kor + sc_eng + sc_math + sc_music + sc_art) AS 총점,
        -- ROUND : 실수(float) 값을 반올림하는 함수
        -- ROUND(값) : 소수점 이하 반올림하고 정수로 표현
        -- ROUND(값, 자릿수) : 자릿수+1에서 반올림하여 자릿수자리까지 소수점 표현
        ROUND((sc_kor + sc_eng + sc_math + sc_music + sc_art) / 5, 2) AS 평균,
        
        -- 무조건 자르기(절사)
        -- TRUNC(값) : 소수점 이하 모두 버리기
        -- TRUNC(값, 자릿수) : 자릿수+1 이하 모두 버리기
        TRUNC((sc_kor + sc_eng + sc_math + sc_music + sc_art) / 5) AS 평균1
FROM tbl_score;

SELECT SUM(sc_kor) AS 국어총점, 
       SUM(sc_eng) AS 영어총점, 
       SUM(sc_math) AS 수학총점, 
       SUM(sc_music) AS 음악총점, 
       SUM(sc_art) AS 미술총점,
       SUM(sc_kor + sc_eng + sc_math + sc_music + sc_art) AS 총점,
       AVG(ROUND((sc_kor + sc_eng + sc_math + sc_music + sc_art) / 5, 3)) AS 평균
FROM tbl_score;    

SELECT AVG(sc_kor) AS 국어평균, 
       AVG(sc_eng) AS 영어평균, 
       AVG(sc_math) AS 수학평균, 
       AVG(sc_music) AS 음악평균, 
       AVG(sc_art) AS 미술평균,
       AVG(ROUND((sc_kor + sc_eng + sc_math + sc_music + sc_art) / 5, 3)) AS 평균
FROM tbl_score;

-- sc_kor 칼럼의 값을 기준으로 전체 리스트를 오름차순 정렬
SELECT *
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'
ORDER BY sc_kor;

-- 계산을 위한 '총점'칼럼을 PROJECTION에서 선언하고
-- '총점' 칼럼을 기준으로 오름차순 정렬
SELECT sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor + sc_eng + sc_math + sc_music + sc_art) AS 총점
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'
ORDER BY 총점;

-- '총점' 칼럼을 기준으로 내림차순 정렬(DESCENDING)
SELECT sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor + sc_eng + sc_math + sc_music + sc_art) AS 총점
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010'
ORDER BY 총점 DESC;

-- 학생의 이름의 오름차순(가나다순, ABC순)으로 전체리스트를 정렬하여 보여달라
SELECT * 
FROM tbl_student
WHERE st_num BETWEEN '20001' AND '20010'
ORDER BY st_name; 

-- 2개 이상의 칼럼을 정렬 수행
-- st_dept을 기준으로 오름차순 정렬을 수행하고
-- st_dept 칼럼 값이 같으면 그 범위(그룹, 파티션) 내에서
-- st_name을 기준으로 내림차순 정렬하라
SELECT * 
FROM tbl_student
WHERE st_num BETWEEN '20001' AND '20010'
ORDER BY st_dept, st_name DESC; 

-- st_dept 칼럼값이 같은 레코드끼리 묶고
-- 묶인 레코드의 개수를 세어라
-- 부분합 연산
SELECT st_dept, COUNT(st_dept)
FROM tbl_student
GROUP BY st_dept;

-- 그룹 count를 수행하고
-- st_dept 칼럼을 기준으로 오름차순 정렬
SELECT st_dept, COUNT(st_dept)
FROM tbl_student
GROUP BY st_dept
ORDER BY st_dept;


-- [ SUBSTR ]
-- 오라클에서만 사용하는 문자열 함수
-- sc_num칼럼에 담긴 문자열을 1번째부터 4번째 글자까지 잘라서 보여라
SELECT SUBSTR(sc_num, 1, 4)
FROM tbl_score;

SELECT SUBSTR(sc_num, 1, 4)
FROM tbl_score
GROUP BY SUBSTR(sc_num, 1, 4);

-- [ 코드(코드블록) ]
-- 학번을 다음과 같이 구성
-- 20001 ~ 20100
-- 어떤 칼럼에 값을 정할 때 규칙을 만들고 해당 칼럼을 PK로 삼아서
-- 레코드의 유일함을 보증하는 용도로 사용하는 값들

-- (학과)코드
-- 학과 : D001 ~ D010
-- 규칙을 정해서 만들고 학과 레코드의 유일함을 보증하는 용도로 사용한다.



















