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

COMMIT;