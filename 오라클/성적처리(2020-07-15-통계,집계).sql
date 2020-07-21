-- 여기는 grade 화면입니다.

-------------------------------------------------------------------------------
-- [ 집계, 통계함수 ]
-------------------------------------------------------------------------------
-- SQL에서는 기본적인 명령어, 연산자 등과 함께 많이 사용되는 집계함수가 있다.
-- SUM():합계, COUNT():개수, AVG():평균, MAX():최대값, MIN():최소값
-- 일반적으로 숫자형으로 되어있는 칼럼에 저장된 값을 추출하여
-- 집계, 통계를 수행하는 함수
-- SELECT 칼럼을 감싸는 형태로 사용한다.

-- tbl_student에 저장된 전체 레코드가 몇개인가?
SELECT COUNT(*) FROM tbl_student;
SELECT COUNT(st_num) FROM tbl_student;
SELECT COUNT(st_name) FROM tbl_student;

-- tbl_student의 칼럼중에 st_grade, st_age는 숫자형 칼럼인데,
-- 이 칼럼에 저장된 값의 합계를 구해보자
SELECT st_grade FROM tbl_student;
SELECT SUM(st_grade) FROM tbl_student;
SELECT SUM(st_age) FROM tbl_student;

-- tbl_student의 칼럼 중에 st_grade 칼럼에 저장된 값들의 평균을 구해보자
SELECT AVG(st_grade) FROM tbl_student;
SELECT AVG(st_age) FROM tbl_student;

-- tbl_student의 st_grade 칼럼에 저장된 값 중에서 
-- 최대값(가장 큰 값), 최소값(가장 작은 값)을 구해보자
SELECT MAX(st_grade) FROM tbl_student;
SELECT MIN(st_grade) FROM tbl_student;

-------------------------------------------------------------------------------
-- [ 데이터를 조건별로 묶어서 보고 싶을 때 ]
-------------------------------------------------------------------------------
-- tbl_student 데이터 중에서 학과가 어떠한 학과들이 있는지 알고 싶다.
-- 같은 이름의 학과가 다수 존재하는데, 이들 이름을 1개씩만 추출하여
-- 리스트로 보여준다면, 어떠한 학과가 있는지 알기 쉬울 것이다.
-- st_dept칼럼에 저장된 값들을 같은 값끼리 그룹을 지어라
-- 그 그룹 지은 이름을 1개씩만 나열해달라
SELECT st_dept FROM tbl_student
GROUP BY st_dept;

SELECT st_grade FROM tbl_student
GROUP BY st_grade;

-- st_name칼럼에 중복되어 저장된 값이 없어서 GROUP BY가 의미가 없는 경우도 있다.
SELECT st_name FROM tbl_student
GROUP BY st_name;

-- 데이터를 학과이름으로 그룹을 짓고
-- 각 학과에 소속된 학생들이 몇 명인가를 알고 싶다.
-- st_dept칼럼으로 GROUP을 만들고
-- 각 GROUP에 속하는 레코드가 몇개인가를 카운트하여 보여준다.
SELECT st_dept, COUNT(*) FROM tbl_student
GROUP BY st_dept;

-- 학년별로 소속된 학생이 몇명인가 알고 싶다.
-- st_grade칼럼으로 GROUP을 만들고
-- 각 GROUP에 속하는 레코드가 몇개인가를 카운트하여 보여준다.
SELECT st_grade, COUNT(*) FROM tbl_student
GROUP BY st_grade;

-- COUNT(*)를 쓰는 대신 특정한 칼럼을 사용하여도 된다.
SELECT st_grade, COUNT(st_num) FROM tbl_student
GROUP BY st_grade;

-- COUNT(칼럼명) 문법에서 칼럼명은 중요하지 않다.
SELECT st_grade, COUNT(st_grade) FROM tbl_student
GROUP BY st_grade;

-- 각 학과별로 소속된 학생들의 총 나이합계가 알고 싶다.
SELECT st_dept, SUM(st_age) FROM tbl_student
GROUP BY st_dept;

-- 각 학과별로 소속된 학생들의 평균나이를 알고 싶다.
SELECT st_dept, AVG(st_age) FROM tbl_student
GROUP BY st_dept;

-- 각 학과의 학생들 중에
-- 나이가 가장 많은 학생의 나이와, 가장 적은 학생의 나이를 보여달라
-- 단, 가장 나이가 많은 학생의 이름 또는 가장 나이가 적은 학생의 이름을 찾는데느
-- 이 SQL로는 어렵다.
SELECT st_dept, MAX(st_age), MIN(st_age) FROM tbl_student
GROUP BY st_dept;

-- [ SQL 명령문( Query문) ]
-- 질문 = 정답, 질의 = 장황하게 설명













