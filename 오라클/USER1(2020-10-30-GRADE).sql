-- SpMVC_Grade

CREATE TABLE tbl_grade(
    id	    NUMBER		PRIMARY KEY,
    g_sid	VARCHAR(4)	NOT NULL,	
    g_name	nVARCHAR2(30)	NOT NULL,	
    g_kor	NUMBER,		
    g_eng	NUMBER,		
    g_math	NUMBER,		
    g_total	NUMBER,		
    g_avg	NUMBER			
);


DROP TABLE tbl_grade;

CREATE SEQUENCE seq_grade
START WITH 1 INCREMENT BY 1;

SELECT * FROM tbl_grade;

DELETE FROM tbl_grade;

INSERT INTO tbl_grade(
            id,g_sid,g_name,g_kor,g_eng,g_math,g_total,g_avg
		) VALUES (
			SEQ_GRADE.NEXTVAL, 'S111','신현주',100,100,90,290,95);

COMMIT;