-- MySQL에서 사용자는 기본적으로 root로 시작한다.
# 이것도 주석

-- [ 오라클과 차이점 ]
-------------------------------------------------
-- 구분 		 		오라클			MySQL
-------------------------------------------------
-- 저장소  		TableSpace			Database
-- Schema 		User				Database
-- 데이터저장 		User.Table형식		Table
-- User의 개념 	Scheme			login하는 Account
-------------------------------------------------

-- 1. MySQL 데이터를 저장하기 위해서 최초로 Database를 생성
-- 2. 생성된 Database를 사용가능하도록 Open하는 절차 필요
-- 3. 사용자 login권한과 접속하는 용도의 Account

DROP DATABASE myDB;

-- [ MySQL CAHRACTER SET ]
-- 저장하는 문자열의 코드길이(Byte)와 관련된 설정
-- MySQL 5.x(5.7)에서는 한글 Locale 설정의 기본값이 Lathin이어서
-- 한글과 같은 UNICODE 저장에 상당히 문제가 되었던 적이 있다.
-- 최근에는 기본 문자 Locale UTF8M4 라는 방식으로 거의 통일되었다.
-- 따라서 별도로 CHARACTER SET을 지정하지 않아도 문제가 없다.
-- 오래된 MySQL 버전에서는 DATABASE를 생성할 때 CHARACTER SET을
-- 명시해주었으나 최근 버전에서는 오히려 명시하면 경고를 띄운다.

-- 현재 PC에 설치된 MySQL 서버에 myDB라고 하는 Scheme(Database)를 생성
CREATE DATABASE myDB; -- DEFAULT CHARACTER SET UTF8;

-- [ MySQL 칼럼 Type ]
-- 문자열 : CHAR(개수), VARCHAR(개수)
--   CHAR : 고정된 문자열을 저장하는 칼럼(코드 등의 데이터)
-- 	 	  : 255까지 가능
--   VARCHAR : 한글을 포함한 가변형 문자열을 저장하는 칼럼 
-- 		   	 : 655365까지 가능
-- 정수형 : INT(4byte, 2^32), BIGINT(8byte, 실제크기는 무제한), TINYINT(1byte, -128~127, 0~255), 
-- 		  SMALLINT(0~65535), MEDIUMINT(0~1677215) 
-- 정수형의 경우 자릿수를 명시하지 않으면 최대지원 크기까지 저장 가능.
-- 실제 저장을 해보면 INT형은 정수 11자리를 넘어가면 저장이 안된다.
-- 실수형 : FLOAT(길이, 소수점)(4byte), DECIMAL(길이, 소수점), DOUBLE(길이, 소수점)(8byte)

-- MySQL에서는 데이터와 관련된 DDL, DML, DCL 등의 명령을 수행하기 전에
-- 사용할 Scheme를 Open하는 절차가 반드시 필요하다.
-- myDB 데이터베이스 open하기
USE myDB;

DROP TABLE tbl_student;

CREATE TABLE tbl_student(
	st_num	CHAR(5)		PRIMARY KEY,
	st_name	VARCHAR(20)	NOT NULL,	
	st_dept	VARCHAR(20),		
	st_grade	INT,		
	st_tel	VARCHAR(20),		
	st_addr	VARCHAR(125),		
	st_age	INT		
);

DESC tbl_student;

SELECT * FROM tbl_student;

CREATE TABLE tbl_score(
	sc_num	  CHAR(4)	NOT NULL,
	sc_scode  CHAR(4)	NOT NULL,
	sc_sname  VARCHAR(30),
	sc_score  INT	
);

-- [ PROJECTION ]
SELECT st_num, st_name, st_tel FROM tbl_student;

-- [ SELECTION ]
SELECT st_num, st_name
FROM tbl_student
WHERE st_num BETWEEN '20001' AND '20010';

SELECT * FROM tbl_dept;

SELECT ST.st_num, ST.st_name, ST.st_dept, D.d_name, D.d_prof
FROM tbl_student ST
	LEFT JOIN tbl_dept D
		ON ST.st_dept = D.d_code;

SELECT COUNT(*) FROM tbl_iolist;
SELECT io_bcode FROM tbl_iolist;

-- DECODE()
SELECT io_bcode, 
	SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '매입합계',
	SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) AS '매출합계'
FROM tbl_iolist
GROUP BY io_bcode;

SELECT 
	SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '매입합계',
	SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) AS '매출합계',
    SUM(CASE WHEN io_inout = '매출' THEN io_amt ELSE 0 END) - SUM(CASE WHEN io_inout = '매입' THEN io_amt ELSE 0 END) AS '이익금'
FROM tbl_iolist;

-- 현재 스키마의 TABLE 리스트
SHOW TABLES;

-- 현재 MySQL server에 만들어진 스키마(database)리스트
SHOW DATABASES;

DESC tbl_score;

---------------------------------------------------
-- [ tbl_score 테이블에 데이터 추가하기 ]
---------------------------------------------------
-- 만약 학번 20001인 학생의 국어(D001), 영어(D002), 수학(D003) 점수를 입력한다고 하면
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2001','D001','국어',80);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2001','D002','영어',80);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2001','D003','수학',70);

INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2002','D001','국어',89);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2002','D002','영어',88);
INSERT INTO tbl_score(sc_num, sc_scode, sc_sname, sc_score)
VALUES('2002','D003','수학',72);

SELECT * FROM tbl_score;

-- 한개의 칼럼으로 PK를 만들 때는 설계할 때 고려를 하고
-- TABLE을 생성할 때 만드는 것이 편리하다.

-- 두 개 이상의 복합키를 만들 때는 보통 테이블 설계가 완료되고
-- TABLE을 만들고 데이터가 추가되는 과정에서 생성되는 경우가 많다.
-- 두개 이상의 후보키를 묶어서 PK로 설정하는 복합키 PK
ALTER TABLE tbl_score ADD PRIMARY KEY(sc_num, sc_scode);
ALTER TABLE tbl_score DROP PRIMARY KEY;
SELECT * FROM tbl_score;

-- 어떤 TABLE을 만들었는데, 이 테이블에 PK를 설정하려고 봤더니
-- 단일키로 PK를 설정하기가 매우 어렵게 되었다.
-- 복합키로 PK를 설정해야 하는데 왠지 그러기가 싫다.
-- 임의로 실제 데이터와는 관계가 없이 별도의 PK만을 위한 칼럼을 만들고
-- 그 칼럼에 일련번호와 같은 값을 채워서 PK로 삼고 싶다.
-- INSERT보다는 UPDATE, DELETE의 무결성을 위한 설정

-- [ AUTO_INCREMENT, AUTO INCREMENT ]
-- 

-- 이미 사용중인 테이블에 일련번호를 채울 pk만을 위한 칼럼을 생성하는 방법
ALTER TABLE tbl_score ADD sc_seq BIGINT PRIMARY KEY AUTO_INCREMENT;
DESC tbl_score;
SELECT * FROM tbl_score;
-- 설계를 하면서 일련번호를 채울 PK만을 위한 칼럼을 생성하는 방법
DROP TABLE tbl_score;
CREATE TABLE tbl_score(
	sc_seq BIGINT PRIMARY KEY AUTO_INCREMENT,
	sc_num	  CHAR(4)	NOT NULL,
	sc_scode  CHAR(4)	NOT NULL,
	sc_sname  VARCHAR(30),
	sc_score  INT	
);

SELECT * FROM tbl_score;

INSERT INTO tbl_score(sc_num, sc_scode, sc_name, sc_score)
VALUES('20003','D001','국어',90);

INSERT INTO tbl_score(sc_seq, sc_num, sc_scode, sc_name, sc_score)
VALUES(10, '20003','D001','국어',90);