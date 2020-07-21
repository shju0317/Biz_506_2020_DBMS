-- 여기는 GRADE 화면

-------------------------------------------------------------------------------
-- 성적일람표 출력
-------------------------------------------------------------------------------
-- 성적정보 Table(tbl_score)에는 학번과 각 과목별 점수가 저장되어 있다.
-- 학생정보 Table(tbl_student)에는 학번과 이름 등이 저장되어 있다.
-- 성적일람표를 보고 싶은데, 학생의 학번과 이름이 포함된 리스트를 보고 싶다.
-- 두 개의 Table(tbl_score, tbl_student)를 연동하여 리스트를 조회해야 한다.
-- 이러한 기법을 JOIN이라고 한다.

SELECT *
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';

SELECT *
FROM tbl_score, tbl_student
WHERE sc_num BETWEEN '20001' AND '20010'
AND sc_num = st_num;

-- [ 완전 JOIN ]
-- sc_score table에 있는 학번의 정보는 반드시 st_student에 있다라는 전제하에
-- 결과가 원하는 대로 나온다.
-- FROM 다음에 JOIN할 Table을 나열하고
-- WHERE절에 두 테이블의 연결점 칼럼을 설정하면 된다.
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE 
-- sc_num BETWEEN '20001' AND '20010'
sc_num = st_num;

-- [ OUTER JOUIN ]
-- 성적 Table에는 1~100까지 데이터가 있고
-- 학생 Table에는 1~50까지만 데이터가 있다.
-- 이러한 상황에서 성적리스트를 확인하면서 학생 정보와 연동하여 보고 싶을 때
-- EQ JOIN을 사용하게 되면 실제 데이터가 1~50까지만 나타나는 현상이 생긴다.
-- 이러한 상황에서 성적Table의 데이터는 모두 확인하면서 
-- 학생Table에 있는 정보만 연결해 보여주는 방식의 JOIN
DELETE FROM tbl_student
WHERE st_num > '20050';

SELECT * FROM tbl_student;


-- [ EQ JOIN ]
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score
    INNER JOIN tbl_student
        ON sc_num = st_num;

-- [ LEFT JOIN ]
-- OUTTER JOIN의 대표적으로 많이 사용하는 JOIN Query
-- 1. JOIN 키워드 왼쪽에는 모든 리스트업할 table을 위치시키고
-- 2. 이 table과 연동하여 정보를 보조적으로 가져올 table을 JOIN 다음에 위치
-- 3. 두 table의 연결점(key)를 ON키워드 다음에 작성해 준다.

-- JOIN 왼쪽 table의 데이터를 모두 보여주고
-- key값으로 오른쪽 table에서 값을 찾은 후
-- 있으면 PROJECTION에 나열된 칼럼 위치에 값을 표시하고
-- 만약 없으면 (null)이라고 표시한다.
-- 왼쪽 table의 데이터가 잘 입력되었나 검증하는 용도로 많이 사용되고
-- 아직 FK설정이 되지않은 table간에 정보를 리스트 업하는 용도로 사용된다.
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score
    LEFT JOIN tbl_student
        ON sc_num = st_num;















