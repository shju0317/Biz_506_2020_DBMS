-- 여기는 user1화면입니다.

-------------------------------------------------------------------------------
-- [ PROJECTION, SELECTION ]
-------------------------------------------------------------------------------
-- DB공학에서 논리적인 차원의 DB관련용어
-- 실무에서는 별로 사용하지 않는 단어이기도 하다.

SELECT * FROM tbl_dept;

-- [ PROJECTION ]
SELECT d_code, d_name, d_prof
FROM tbl_dept;

-- [ SELECTION ]
SELECT * FROM tbl_dept
WHERE d_name = '관광학';

-- [ 현재 학과테이블의 학과명 중에 '관광학'을 '관광정보학'으로 변경해보자 ]
-- 1. 내가 변경하고자 하는 조건에 맞는 데이터가 있는지 확인
SELECT * FROM tbl_dept WHERE d_name = '관광학';
-- 2. SELECTION한 결과가 1개의 레코드만 나타나고 있지만, d_name은 PK가 아니다.
--    = 여기에서 보여주는 데이터는 리스트이다.
--    = UPDATE를 할 때 d_name = '관광학' 조건으로 UPDATE를 실행하면 안된다.
--    = UPDATE tbl_dept SET d_name='관광정보학' WHERE d_name='관광학' ( X )
-- 3. 조회된 결과에서 PK가 무엇인지를 파악한다.
-- 4. PK를 조건으로 UPDATE를 수행한다.
UPDATE tbl_dept
SET d_name = '관광정보학'
WHERE d_code = 'D001';

SELECT * FROM tbl_dept;

INSERT INTO tbl_dept(d_code, d_name, d_prof)
VALUES ('D006', '무역학', '장길산');
COMMIT;
-- [ DELETE ] 
-- DBMS의 스키마에 포함된 Table 중에 여러 업무를 수행하는데 필요한 Table을
-- 보통 'Master Data Table'이라고 한다.
-- (학생정보, 학과정보)
-- Master Data는 초기에 INSERT가 수행된 후에 업무가 진행되는 동안
-- 가급적 데이터를 변경하거나, 삭제하는 일이 최소화되어야 하는 데이터앋.
-- Master Data와 Relation을 하여 생성되는 여러 데이터들의 무결성을 위해서
-- Master Data는 변경을 최소화하면서 유지해야 한다.

-- DBMS의 스키마에 포함된 Table 중에 수시로 데이터가 추가, 변경, 삭제가 필요한
-- Table을 보통 'Work Data Table'이라고 한다.
-- Work Data는 수시로 데이터가 추가되고, 여러가지 연산을 수행하여
-- 통계, 집계 등 보고서를 작성하는 기본 데이터가 된다.
-- 통계, 집계 등 보고서를 작성한 후 데이터를 검증하였을 때 이상이 있으면
-- 데이터를 수정, 삭제를 수행하여 정정하는 과정이 이루어진다.
-- Work Data는 Master Table과 Relation을 잘 연동하여 데이터를 INSERT하는 단계부터
-- 잘못된 데이터가 추가되는 것을 막아줄 필요가 있다.
-- 이때 설정하는 조건 중에 '외래키 연관 조건'이 있다.

SELECT * FROM tbl_score;

INSERT INTO tbl_score(sc_kor) VALUE (100);

COMMIT;

UPDATE tbl_score     -- 변경할 테이블
SET sc_kor = 90         -- 변경할 대상 = 값
WHERE sc_num = '20015'; -- 조건(UPDATE에서 WHERE문은 선택사항이나 실무에서는 필수사항으로 인식!)

UPDATE tbl_score
SET sc_kor = 90, sc_math = 90 -- 다수의 칼럼값을 변경하고자 할때 칼럼=값,칼럼=값 형식으로
WHERE sc_num = '20015';


SELECT * FROM tbl_score WHERE sc_num = '20015'; 

UPDATE tbl_score
SET sc_kor = 100; -- WHERE 빼먹었을 때!!! -> ROLLBACK

SELECT * FROM tbl_score;

-- 보통 SQL문으로 CUD(INSERT,UPDATE,DELETE)를 수행하고 난 직후에는
-- Table의 변경된 데이터가 물리적(스토리지)에 반영이 아직 안된 상태이다
-- 스토리지에 데이터 변경이 반영이 되기 전에
-- ROLLBACK명령을 수행하면 변경내용이 모두 제거(취소)된다.
-- ROLLBACK명령을 잘못 수행하면, 정상적으로 변경(CUD)필요한 데이터마저
-- 변경이 취소되어 문제를 일으킬 수 있다.

-- INSERT를 수행하고 난 직후에는 데이터의 변경이 물리적으로 반영될 수 있도록
-- COMMIT명령을 수행하는 것이 좋다.
-- UPDATE나 DELETE는 수행한 직후 반드시 SELECT를 수행하여 원하는 결과가
-- 잘 수행되었는지 확인하는 것이 좋다.
ROLLBACK;
SELECT * FROM tbl_score;

-- '20020' 학번의 학생이 시험응시 못했는데 입력된 성적이 있다.
-- 이 학생의 성적데이터는 삭제되어야 한다.
-- 이 학생이 정말 시험날 결석한 학생인지 확인하는 절차가 필요하다.
-- 이 학생의 학생정보를 확인하고, 만약 이 학생의 성적정보가 등록되어 있다면
-- 삭제를 수행하자
SELECT * FROM tbl_student WHERE st_num = '20020';

-- 아래 Query문을 실행햇을 때
-- 학생정보는 보이는데, 성적정보 칼럼 값들이 모두 (null)로 나타나면
-- 이 학생의 성적 정보는 등록되지 않은 것이다.
-- 따라서 삭제하는 과정이 필요하지 않다.
-- 학생정보와 함께 성적정보 칼럼의 값들이 1개라도 (null)이 아닌 것으로 나타나면
-- 이 학생의 성적정보는 등록된 것이다.
-- 따라서 학생의 성적정보를 삭제해야 한다.
SELECT *
FROM tbl_student ST
    LEFT JOIN tbl_score SC
        ON ST.st_num = SC.sc_num
WHERE ST.st_num = '20020';        

-- sc_num 데이터에 없는 조건을 부여하면 
-- DELETE를 수행하지 않을 뿐 오류가 나지는 않는다.
DELETE FROM tbl_score
WHERE sc_num = '20020';

-- [ 성적데이터의 국어점수가 가장 높은 값과 가장 낮은 값은 무엇일까? ]
SELECT MAX(sc_kor), MIN(sc_kor)
FROM tbl_score;

INSERT INTO tbl_score(sc_num, sc_kor) VALUES sc_kor = 49;

-- [ 국어과목에서 최고점수, 최저점수를 받은 학생은 누구일까? ]
SELECT SC.sc_num, ST.st_name, SC.sc_kor
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num
WHERE SC.sc_kor = 99 OR SC.sc_kor = 50;

-------------------------------------------------------------------------------
-- [ subQuery]
-------------------------------------------------------------------------------
-- 두 번 이상 SELECT를 수행해서 결과를 만들어야 하는 경우
-- 첫번째 SELECT결과를 두번째 SELECT에 주입하여
-- 동시에 두번 이상의 SELECT를 수행하는 방법
-- subquery는 JOIN으로 모두 구현이 가능하다.
-- 하지만 간단한 동작을 요구할 때는 subquery를 사용하는 것이
-- 쉬운 방법이기도 하다.
-- 또한 오라클 관련 정보들(구글링) 중에 JOIN보다는 subquery를
-- 사용한 예제들이 많아서 코딩에 유리한 면이 있다.

-- subqeury를 사용하게 되면 SELECT문이 여러번 실행되기 때문에
-- 약간만 코딩이 변경되어도 상당히 느린 실행결과를 낳게 된다.

-- WHERE절에서 subquery사용하기
-- WHERE 처음에 칼럼명이 오고 (<=>)
-- 오른쪽에 괄호를 포함한 SELECT 쿼리가 나와야 한다.
-- subquery로 작동되는 SELECT문은 기본적으로 1개의 결과만 나와야한다.
-- subquery에 의해 연산된 결과의 값을 기준으로 칼럼에 조건문을 부여하는 방식
-- subquery는 method, 함수를 호출하는 것과 같이 subquery가 return해주는 값을
-- 칼럼과 비교하여 최종결과물을 낸다.
SELECT SC.sc_num, ST.st_name, SC.sc_kor
FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_num = ST.st_num
WHERE SC.sc_kor = 
(
    SELECT MAX(sc_kor) FROM tbl_score
)
OR SC.sc_kor = 
(
    SELECT MIN(sc_kor) FROM tbl_score
);

-- [ 국어점수의 평균을 구하고 평균점수보다 높은 점수를 얻은 학생들은 누구일까? ]
SELECT AVG(sc_kor)
FROM tbl_score;

SELECT *
FROM tbl_score
WHERE sc_kor >= 74.07;

SELECT *
FROM tbl_score
WHERE sc_kor >= 
(
    SELECT AVG(sc_kor) FROM tbl_score
);

-------------------------------------------------------------------------------
-- [ SELECT Query문이 실행되는 순서 ]
-------------------------------------------------------------------------------
-- 1. FROM절이 실행되어 tbl_score테이블의 정보(칼럼정보)를 가져오기
-- 2. WHERE절이 실행되어서 실제 가져올 데이터를 선별
-- 3. GROUP BY절이 실행되어 중복된 데이터를 묶어서 하나로 만든다.
-- 4. SELECT절에 나열된 칼럼에 값을 채워넣고,
-- 5. SELECT절에 정의된 수식을 연산, 결과를 보일 준비
-- 6. ORDER BY는 모든 쿼리가 실행되고 가장 마지막에 연산수행되어 정렬을 한다.

-- WHERE절과 GROUP BY절에서는 Alias로 설정된 칼럼이름을 사용할 수 없다.
-- ORDER BY에서는 Alias로 설정된 칼럼이름을 사용할 수 있다.
-------------------------------------------------------------------------------

-- [ 각 학생의 평균과 전체학생의 평균을 구하여
-- 각 학생의 평균점수가 전체학생의 평균점수보다 높은 리스트 조회하기 ]
SELECT -- 3. 
    sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor + sc_eng + sc_math +sc_music +sc_art ) / 5 AS 학생평균
FROM  -- 1.
    tbl_score 
WHERE -- 2.
(sc_kor + sc_eng + sc_math + sc_music + sc_art ) / 5 
>
(
    SELECT AVG((sc_kor + sc_eng + sc_math + sc_music + sc_art ) / 5)
    FROM tbl_score
);

-- [ 위의 Query를 활용하여 평균을 구하는 조건은 그대로 유지하고
-- 학번이 20020 이전의 학생들만 추출하기 ]
SELECT
    sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor + sc_eng + sc_math +sc_music +sc_art ) / 5 AS 학생평균
FROM
    tbl_score 
WHERE
(sc_kor + sc_eng + sc_math + sc_music + sc_art ) / 5 
>
(
    SELECT AVG((sc_kor + sc_eng + sc_math + sc_music + sc_art ) / 5)
    FROM tbl_score 
) 
AND 
sc_num < '20020';

-- [ 성적테이블에서 학번의 문자열을 자르기 수행하여 반명칭만 추출하기 ]
SELECT SUBSTR(sc_num, 1, 4) AS 반
FROM tbl_score
GROUP BY SUBSTR(sc_num, 1, 4)
ORDER BY 반;

-- [ 추출된 반명칭이 '2006'보다 작은 값을 갖는 반만 추출 ]
-- [ HAVING ]
-- 성질이 WHERE와 매우 비슷하다.
-- 하는 일이 GROUP BY로 묶이거나, 통계함수(SUM,AVG 등)로 생성된 값을 대상으로
-- WHERE연산을 수행하는 키워드
SELECT SUBSTR(sc_num, 1, 4) AS 반
FROM tbl_score
GROUP BY SUBSTR(sc_num, 1, 4)
HAVING SUBSTR(sc_num, 1, 4) < '2006'
ORDER BY 반;

-- 각반의 평균을 구하는 코드
SELECT SUBSTR(sc_num, 1, 4) AS 반, ROUND(AVG((sc_kor + sc_eng + sc_math)/3)) AS 반평균
FROM tbl_score
GROUP BY SUBSTR(sc_num, 1, 4)
HAVING ROUND(AVG((sc_kor + sc_eng + sc_math)/3)) 
>= 
(
    SELECT ROUND(AVG((sc_kor + sc_eng + sc_math)/3)) FROM tbl_score
)
ORDER BY 반;

-- [ 2000~ 2005 = A그룹, 2006~2010 = B그룹일 때,
-- 반이름이 '2005' 이하(A그룹)의 평균을 구하기 ]
SELECT SUBSTR(sc_num, 1, 4) AS 반, ROUND(AVG((sc_kor + sc_eng + sc_math)/3)) AS 반평균
FROM tbl_score
GROUP BY SUBSTR(sc_num, 1, 4)
HAVING SUBSTR(sc_num, 1, 4) <= '2005'
ORDER BY 반;


-- [ HAVING과 WHERE ]
-- 두가지 모두 결과를 SELECTION하는 조건문을 설정하는 방식이다
-- HAVING은 그룹으로 묶이거나 통계함수로 연산된 결괄르 조건으로 설정하는 방식이고
-- WHERE은 아무런 연산이 수행되거 전에 원본 데이터를 조건으로 제한하는 방식이다.
-- 어쩔 수 없이 통계결과를 제한할 때는 HAVING을 써야한다.
-- WHERE절에 조건을 설정하여 데이터를 제한한 후 연산을 수행할 수 있다면
-- 항상 그 방법을 우선으로 사용하자
-- HAVING은 WHERE조건이 없으면 전체데이터를 상대로 상당한 연산을 수행한 후
-- 조건을 설정하므로 상대적으로 WHERE조건을 설정하는 것보다 느리다.
SELECT SUBSTR(sc_num, 1, 4) AS 반, ROUND(AVG((sc_kor + sc_eng + sc_math)/3)) AS 반평균
FROM tbl_score
WHERE SUBSTR(sc_num, 1, 4) <= '2005' 
GROUP BY SUBSTR(sc_num, 1, 4) 
ORDER BY 반;
















