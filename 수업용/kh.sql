SELECT * FROM user_tables;
SELECT * FROM EMPLOYEE;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM NATIONAL;
SELECT * FROM SAL_GRADE;
SELECT * FROM EMP;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000
;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%'
;

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '이%'
;

SELECT EMP_NAME, PHONE
FROM EMPLOYEE 
WHERE PHONE LIKE '___4%'
;

-- 사원명의 길이와 byte 크기를 조회
SELECT EMP_NAME, LENGTH(emp_name) len, LENGTHB(emp_name) bytelen
FROM EMPLOYEE 
;

SELECT EMAIL, INSTR(EMAIL, '@', -1, 1)-1||'자리' 위치
FROM EMPLOYEE
;

SELECT INSTR('ORACLEWELCOMEO', 'O', -1, 1)
FROM DUAL
;

SELECT SYSDATE 현재시간
FROM DUAL;

SELECT emp_name, emp_no, decode(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성 별" 
FROM EMPLOYEE 
;

SELECT emp_name, emp_no,
	decode(SUBSTR(emp_no, 8, 1), 2, '여', 4, '여', 1, '남', 3, '남', '그 외')
FROM EMPLOYEE;

SELECT emp_name, emp_no,
	CASE to_number(substr(emp_no, 8, 1))
		WHEN 2 THEN '여'
		WHEN 4 THEN '여'
		WHEN 1 THEN '남'
		WHEN 3 THEN '남'
		ELSE '그 외'
	END
	AS "성 별"
FROM EMPLOYEE
;

SELECT AVG(SALARY) "평균급여" FROM EMPLOYEE;

SELECT FLOOR(AVG(SALARY)) "평균급여" FROM EMPLOYEE;

SELECT FLOOR(AVG(SALARY)) "평균급여" FROM EMPLOYEE;

SELECT dept_code, SUM(SALARY), AVG(SALARY), COUNT(dept_code)
FROM EMPLOYEE 
GROUP BY emp_name
ORDER BY dept_code asc
;

SELECT
FROM EMPLOYEE 
;
DROP USER_NOTNULL;

CREATE TABLE USER_NOTNULL(
	USER_NO NUMBER NOT NULL,
	USER_ID VARCHAR2(20) NOT NULL,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
	);


INSERT INTO USER_NOTNULL VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678','hong123@kh.or.kr');

--INSERT INTO USER_NOTNULL VALUES(2, NULL, NULL, NULL, NULL, '010-1234-5678','hong123@hk.kr');

SELECT *
FROM user_notnull;

CREATE TABLE USER_UNIQUE(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR(20),
	EMAIL VARCHAR(50)
	);

INSERT INTO USER_UNIQUE VALUES (1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong123@kh.or.kr');
SELECT * FROM USER_UNIQUE;

CREATE TABLE USER_UNIQUE2(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	UNIQUE (USER_ID)
);
INSERT INTO USER_UNIQUE2 VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE2 VALUES(1, 'user01','pass01',NULL,NULL,'010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE2 VALUES(1, NULL ,'pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE2 VALUES(1, NULL ,'pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');

SELECT *
FROM USER_UNIQUE2;

CREATE TABLE USER_UNIQUE3(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	UNIQUE (USER_NO , USER_ID)
);

DROP TABLE USER_UNIQUE3;

INSERT INTO USER_UNIQUE3 VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2, 'user01','pass01',NULL,NULL,'010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2, 'user02','pass02',NULL,NULL,'010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2, 'user01','pass01',NULL,NULL,'010-1234-5678','hong123@kh.or.kr');

SELECT * FROM USER_UNIQUE3;

CREATE TABLE USER_PRIMARYKEY(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);

CREATE TABLE USER_PRIMARYKEY2(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	PRIMARY KEY (USER_NO)
);

INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_PRIMARYKEY2 VALUES(1, 'user02','pass02','이순신','남','010-1234-5678','hong123@kh.or.kr');
INSERT INTO USER_PRIMARYKEY2 VALUES(NULL, 'user03','pass03','유관순','여','010-1234-5678','hong123@kh.or.kr');

SELECT * FROM USER_PRIMARYKEY;
SELECT * FROM USER_PRIMARYKEY2;

CREATE TABLE USER_GRADE(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '일반회원');
INSERT INTO USER_GRADE VALUES(30, '일반회원');

SELECT *FROM USER_GRADE;

CREATE TABLE USER_FOREIGNKEY(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER NOT NULL,
	FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);
INSERT INTO USER_FOREIGNKEY VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr',10);
INSERT INTO USER_FOREIGNKEY VALUES(2, 'user02','pass02','이순신','남','010-1234-5678','hong123@kh.or.kr',20);
INSERT INTO USER_FOREIGNKEY VALUES(3, 'user03','pass03','유관순','여','010-1234-5678','hong123@kh.or.kr',30);
INSERT INTO USER_FOREIGNKEY VALUES(4, 'user04','pass04','신사임당','여','010-1234-5678','hong123@kh.or.kr',NULL);
INSERT INTO USER_FOREIGNKEY VALUES(5, 'user05','pass05','안중근','남','010-1234-5678','hong123@kh.or.kr',50);

SELECT * FROM USER_FOREIGNKEY;

DROP TABLE USER_FOREIGNKEY2;

CREATE TABLE USER_FOREIGNKEY2(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE SET NULL
);
INSERT INTO USER_FOREIGNKEY2 VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr',10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2, 'user02','pass02','이순신','남','010-1234-5678','hong123@kh.or.kr',20);
INSERT INTO USER_FOREIGNKEY2 VALUES(3, 'user03','pass03','유관순','여','010-1234-5678','hong123@kh.or.kr',30);
INSERT INTO USER_FOREIGNKEY2 VALUES(4, 'user04','pass04','신사임당','여','010-1234-5678','hong123@kh.or.kr',NULL);
INSERT INTO USER_FOREIGNKEY2 VALUES(5, 'user05','pass05','안중근','남','010-1234-5678','hong123@kh.or.kr',50);

SELECT * FROM USER_FOREIGNKEY2;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 10;

CREATE TABLE USER_FOREIGNKEY(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE SET DELETE CASCADE
);

CREATE TABLE USER_CHECK(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR(10) CHECK(GENDER IN ('남', '여')),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);

DROP TABLE USER_CHECH;

INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');

-- 6_CREATE 

CREATE TABLE EMPLOYEE_COPY
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE);

-- 7_DML
INSERT INTO EMPLOYEE 
VALUES(1, '홍길동', '820114-1010101', 'hong_kd@kh.or.kr','01099998888','D5','J2','S4',3800000, NULL, '200', sysdate , NULL, DEFAULT)

UPDATE EMPLOYEE 
SET EMP_ID =290
WHERE EMP_NAME = '홍길동';

DELETE FROM EMPLOYEE 
WHERE EMP_NAME = '홍길동';

-- INSERT : 테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문
-- 예시 1.
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
VALUES(900, '장채현', '901123-1080503', 'jang_ch@kh.or.kr','01055569512','D1','J8','S3',4300000, 0.2, '200', sysdate,NULL,default);

-- 예시 2.
CREATE TABLE EMP_01(
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(30),
	DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01(
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT *
FROM EMPLOYEE e 

-- INSERT ALL : INSERT 시 서브쿼리가 사용하는 테이블이 같은 경우 두 개 이상의 테이블에 INSERT ALL을 이용하여 한 번에 삽입 가능(단, 각 서브쿼리의 조건절이 같아야 함)
-- 예시 1.
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0;

--INSERT ALL 예시 2.
INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1';

--INSERT ALL 예시 2.
CREATE TABLE EMP_OLD
AS SELECT EMP_ID,
			EMP_NAME,
			HIRE_DATE ,
			SALARY
FROM EMPLOYEE
WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID,
			EMP_NAME,
			HIRE_DATE ,
			SALARY
FROM EMPLOYEE
WHERE 1 = 0;

INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
			INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
			INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, SALARY
FROM EMPLOYEE;

-- UPDATE 테이블에 기록된 컬럼 값을 수정하는 구문으로 테이블 전체 행 개수는 변화 없음
-- UPDATE 예시 1.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

-- UPDATE 예시 2.
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,
			EMP_NAME ,
			DEPT_CODE ,
			SALARY ,
			BONUS 
	FROM EMPLOYEE;

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식','방명수');

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME='유재식'),
	BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME='유재식')
WHERE EMP_NAME = '방명수';

-- UPDATE 예시 3.
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식', '방명수');

-- UPDATE 예시 4.
UPDATE
	EMP_SALARY
SET
	BONUS = 0.3
WHERE
	EMP_ID IN (
	SELECT
		EMP_ID
	FROM
		EMPLOYEE
	JOIN DEPARTMENT ON
		(DEPT_ID = DEPT_CODE)
	JOIN LOCATION ON
		(LOCATION_ID = LOCAL_CODE)
	WHERE LOCAL_NAME LIKE 'ASIA%'
);

SELECT * FROM EMP_SALARY;

--DELETE 테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
--DELETE 예시 1.
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '장채현';

DELETE FROM DEPARTMENT d 
WHERE DEPT_ID = 'D1';


--TRUNCATE 테이블 전체 행 삭제 시 사용하며 DELETE보다 수행 속도가 빠르고 ROLLBACK을 통해 복구 불가능 또한 DELETE와 마찬가지로 FOREIGN KEY 제약조건일 때는 적용 불가능하기 때문에 제약 조건을 비활성화 해야 삭제할 수 있음
--예시 1.
TRUNCATE TABLE EMP_SALARY;
SELECT * FROM EMP_SALARY;

ROLLBACK;

-- 8_DDL

-- ALTER : 테이블에 정의된 내용을 수정(컬럼명, 자료형, CONSTRAINTS, 컬럼 추가도 가능)할 때 사용 -> TABLE 구조 변경 , DROP : 객체(USER, TABLE	)를 삭제할 때 사용

-- 컬럼 추가
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '한국');

SELECT *
FROM DEPT_COPY;

-- 제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DTITLE_UNQ UNIQUE(DEPT_TITLE);
ALTER TABLE DEPT_COPY
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

SELECT
	UC.CONSTRAINT_NAME,
	UC.CONSTRAINT_TYPE,
	UC.TABLE_NAME,
	UCC.COLUMN_NAME,
	UC.SEARCH_CONDITION
FROM
	USER_CONSTRAINTS UC
JOIN
	USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME ='DEPT_COPY';

--컬럼수정
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;

--컬럼삭제
CREATE TABLE TB1(
	PK NUMBER PRIMARY KEY,
	FK NUMBER REFERENCES TB1,
	COL1 NUMBER,
	CHECK(PK > 0 AND COL1 > 0)
);

ALTER TABLE TB1
DROP COLUMN PK;

ALTER TABLE TB1
DROP COLUMN PK CASCADE CONSTRAINT;

-- 제약조건 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DID_PK
DROP CONSTRAINT DCOPY_DTITLE_UNQ
MODIFY LNAME NULL;

-- 컬럼 이름 변경
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 제약조건 이름 변경
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007211 TO UF_UP_NN;

-- 테이블 이름 변경
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;

-- DROP 테이블 삭제
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;

-- 9_ORACLE OBJECT VIEW

-- VIEW SELECT 쿼리의 실행 결과를 화면에 저장한 논리적 가상 테이블 실제 테이블과는 다르게 실질적 데이터를 저장하고 있진 않지만 사용자는 테이블을 사용하는 것과 동일하게 사용 가능
-- VIEW 
-- 예시 1.
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, EDPT_TITLE, NATIONAL_NAME
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
	LEFT JOIN LOCATEION ON (LOCATION_ID = LOCAL_CODE)
	LEFT JOIN NATIONL USING (NATIONAL_CODE);








