SELECT *
FROM EMP
WHERE MGR IS NULL 
AND COMM IS NOT NULL
CREATE USER SCOTT DEF
;

SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE DEPTNO IN (20, 30);

SELECT ename, sal, job
FROM EMP
WHERE JOB IN ('ANALYST', 'SALESMAN') AND SAL >= 2500
;
-- 사원명의 길이와 byte 크기를 조회
SELECT LENGTH(ENAME), LENGTHB(ENAME) 
FROM EMP
;

SELECT ' a안 녕b ', LENGTH(' a안 녕b '), LENGTHB(' a안 녕b ')
FROM DUAL
;

SELECT trim(' a안 녕b ') || '안녕', LENGTH(trim(' a안 녕b ')), LENGTHB(trim(' a안 녕b '))
FROM DUAL
;

SELECT RTRIM(LTRIM(ENAME, 'S'), 'S') FROM EMP;

SELECT CONCAT(ename, COMM) FROM emp;

SELECT sal||'달러' FROM EMP;
SELECT CONCAT(sal, '달러')
FROM emp;

SELECT replace(ename, 'SM', 'A')
FROM emp;

SELECT  ename, INSTR(ename, 'R', -1, 1)
FROM emp;

SELECT hiredate, ADD_MONTHS(hiredate, 1) FROM emp; 

SELECT sysdate, TO_CHAR(sysdate, 'yyyy.mm.dd') FROM dual;

SELECT sysdate, TO_CHAR(sysdate, 'yyyy.mm.dd (dy)') FROM dual;


SELECT ename, TO_CHAR(empno,'000000') , TO_CHAR(sal, 'L999,999,999,999') 
FROM emp;

SELECT TO_NUMBER('1,000,000', '99,999,999') * 5 숫자로형변환
FROM DUAL;

--if(substr(emp_no, 8, 1) == 2){
--	RETURN "여";
--} ELSE if(substr(emp_no, 8, 1) == 4){
--	RETURN "여";
--	if(substr(emp_no, 8, 1) == 1){
--	RETURN "남";
--} ELSE if(substr(emp_no, 8, 1) == 3){
--	RETURN "남";
--} ELSE {
--	RETURN "그외";
--}
--
--switch(substr(emp_no, 8, 1)) {
--	CASE 1;

SELECT AVG(SAL) 평균급여 FROM EMP;

SELECT MAX(SAL) 최고급여 FROM EMP;

-- 부서별 평균 급여 조회
SELECT AVG(SAL) 평균급여, DEPTNO 부서 FROM EMP GROUP BY DEPTNO;
SELECT SUM(SAL) 평균급여, DEPTNO 부서 FROM EMP GROUP BY DEPTNO;
SELECT MAX(SAL) 평균급여, DEPTNO 부서 FROM EMP GROUP BY DEPTNO;
SELECT MIN(SAL) 평균급여, DEPTNO 부서 FROM EMP GROUP BY DEPTNO;
SELECT COUNT(SAL) 평균급여, DEPTNO 부서 FROM EMP GROUP BY DEPTNO;
-- ****************************************************************************************************

SELECT *
FROM SALGRADE s 
;
-- 학생용 SCOTT 명령어들
SELECT *
FROM EMP 
;
SELECT EMPNO, ENAME, SAL
FROM EMP
;
SELECT ENAME, MGR, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=20 AND SAL>1500
;
SELECT ENAME, MGR, SAL, DEPTNO
FROM EMP
--WHERE ENAME = 'SMITH'
WHERE ENAME = 'SMITH'
;
SELECT EMPNO, ENAME, SAL
FROM EMP
;
SELECT EMPNO
FROm EMP
;

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
;
-- * 보다 컬럼명을 나열하는 것이 속도면에서 좋음.
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;
SELECT * FROM bonus;


-- Q: 사원명과 연봉과 보너스포함한 연봉을 조회
SELECT ENAME 사원명, SAL*12 연봉, SAL*12 + NVL(COMM, 0) "보너스 포함 연봉"
FROM EMP
;
SELECT ENAME, NVL(COMM, 0), NVL(COMM, 100)
FROM EMP
;

SELECT ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1500 AND 2799
;
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= 1500 AND SAL > 2800
;

SELECT *
FROM EMP
--WHERE DEPTNO != 20
--WHERE DEPTNO <> 20
--WHERE DEPTNO ^= 20
--WHERE  DEPTNO NOT IN (20)
WHERE DEPTNO != 20 
AND COMM IS NULL
;

--10, 20, 30 부서를 사원 정보를 조회
SELECT *
FROM EMP
--WHERE DEPTNO = 10 OR DEPTNO = 20 OR DEPTNO = 30
WHERE DEPTNO IN (10, 20, 30)
;
--10, 20, 30 부서를 제외한 사원 정보를 조회
SELECT *
FROM EMP
--WHERE NOT (DEPTNO = 10 OR DEPTNO = 20)
--WHERE  DEPTNO !=10 AND DEPTNO !=20
WHERE DEPTNO NOT IN (10, 20, 30)
;
SELECT S.GRADE, E.ENAME, E.SAL 
	FROM EMP e JOIN SALGRADE s 
		ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
	WHERE E.SAL >= 
	-- 다중 행 결과물과 >= 비교 안됨.(950, 1266, 1550, 2879, 5000)
		(
		SELECT AVG(SAL)
			FROM EMP e2 JOIN SALGRADE s2
				ON E2.SAL BETWEEN S2.LOSAL AND S2.HISAL 
			WHERE S2.GRADE = S.GRADE 
			--GROUP BY S2.GRADE 
		) 
;

CREATE OR REPLACE
VIEW view_emp_salgrade
AS
SELECT
	e.EMPNO ,
	e.ENAME ,
	JOB ,
	MGR ,
	HIREDATE ,
	SAL ,
	COMM ,
	DEPTNO ,
	grade ,
	losal ,
	hisal
FROM
	EMP e
JOIN SALGRADE s 
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL 
;

SELECT
	GRade,
	ENAME
	-- select 컬럼명으로는 group by에 사용된 컬럼명 작성가능, 그리고 그룹함수 사용가능.
FROM
	EMP e
JOIN (
	SELECT
		FLOOR(min(e2.sal) * 0.9) minsal ,
		FLOOR(AVG(e2.sal) * 1.1) maxsal ,
		FLOOR(AVG(e2.sal)) avgsal,
		s2.GRADE
	FROM
		EMP e2
	JOIN SALGRADE s2 ON
		e2.SAL BETWEEN s2.LOSAL AND s2.HISAL
	GROUP BY
		s2.GRADE ,
		s2.LOSAL ,
		s2.HISAL 
	) m
	ON
	e.sal BETWEEN minsal AND maxsal
;

SELECT
	EMPNO ,
	ENAME ,
	SAL ,
	SAL + CASE
		loc
WHEN 'NEW YORK' THEN sal * 0.02
		WHEN 'DALLAS' THEN sal * 0.05
		WHEN 'CHICAGO' THEN sal * 0.03
		WHEN 'BOSTON' THEN sal * 0.07
	END
AS SAL_SUBSIDY
FROM
	EMP e
JOIN DEPT d
		USING (deptno)
ORDER BY SAL_SUBSIDY DESC;

SELECT EMPNO ,ENAME ,SAL 
FROM EMP e 
WHERE sal > ALL (SELECT sal FROM emp WHERE JOB = 'SALESMAN')
;


--관리자로 등록되어 있는 사원들을 조회
SELECT EMPNO , ENAME 
FROM EMP e 
WHERE EXISTS (SELECT EMPNO FROM EMP E2 WHERE E2.EMPNO = E.MGR)
;

SELECT DISTINCT E.EMPNO , E.ENAME 
FROM EMP e JOIN EMP E2
ON E.EMPNO = E2.MGR
;

-- join 대비 상관쿼리 사용시 속도 향상

SELECT e.*,
-- 스칼라 서브쿼리
(SELECT TRUNC(avg(sal)) FROM emp e2 WHERE e2.DEPTNO = e.DEPTNO ) AS "평균"
FROM EMP e 
;

SELECT ENAME , DEPTNO ,
	(SELECT DNAME FROM dept d WHERE d.DEPTNO = e.DEPTNO) AS "dnamd"
	, (SELECT LOC FROM dept d WHERE d.DEPTNO = e.DEPTNO) AS "loc"
FROM EMP e
;

-- 급여가 1000미만인 직원, 2000 미만인 직원 조회 - 중복 포함 결과
SELECT EMPNO , ENAME , SAL 
FROM EMP e 
WHERE SAL < 1000
UNION ALL 
SELECT EMPNO , ENAME , SAL 
FROM EMP e 
WHERE SAL < 2000
;

-- 급여가 1000 초과인 직원, 2000 미만인 직원 조회 - intersect
SELECT EMPNO , ENAME , SAL 
FROM EMP e 
WHERE SAL > 1000
INTERSECT 
SELECT EMPNO , ENAME , SAL 
FROM EMP e 
WHERE SAL < 2000
;

-- 2000 미만인 직원을 제외하고 조회 - minus
SELECT EMPNO , ENAME , SAL 
FROM EMP e
minus
SELECT EMPNO , ENAME , SAL 
FROM EMP e 
WHERE SAL < 2000
;
-- not exists
SELECT EMPNO , ENAME , SAL 
FROM EMP e
WHERE NOT EXISTS (SELECT e2.sal FROM emp e2 WHERE e2.SAL > 2000)
;
SELECT * FROM USER_constraints;
SELECT * FROM USER_tables;
SELECT * FROM USER_views;

-- ****************************************************************************************************
-- 2023/07/13
-- CREATE

CREATE TABLE emp_copy1 AS SELECT * FROM emp; -- 첫 번째 복사 TABLE - 물리적 공간
SELECT * FROM emp_copy1;

CREATE VIEW view_emp1 AS SELECT * FROM emp; -- 두 번째 복사 VIWE - 논리적 공간
SELECT * FROM view_emp1;

-- DESC EMP; 테이블을 확인하는 건데 디비버에선 사용이 안됨

INSERT INTO emp VALUES(8000, 'EJKIM', 'KH', 7888, SYSDATE, 3000, 700, 40); -- RECODE 추가

COMMIT; -- INSERT 하면 반드시 COMMIT 해주어야 함

INSERT INTO emp_copy1 VALUES(8001, 'EJKIM', 'KH', 7888, SYSDATE, 3000, 700, 40); -- RECODE 추가

COMMIT; -- INSERT 하면 반드시 COMMIT 해주어야 함

INSERT INTO view_emp1 VALUES(8002, 'EJKIM', 'KH', 7888, SYSDATE, 3000, 700, 40); -- RECODE 추가

COMMIT; -- INSERT 하면 반드시 COMMIT 해주어야 함

CREATE TABLE emp_copy20 AS -- 첫 번째 복사 TABLE - 물리적 공간
SELECT EMPNO , ENAME 사원명, JOB, HIREDATE  , SAL 
FROM EMP
WHERE deptno = 20
;

SELECT * FROM emp_copy20; -- 테이블 확인

SELECT * FROM USER_CONSTRAINTS;



-- ALTER : 테이블에 정의된 내용을 수정(컬럼명, 자료형, CONSTRAINTS, 컬럼 추가도 가능)할 때 사용 -> TABLE 구조 변경 , DROP : 객체(USER, TABLE	)를 삭제할 때 사용

--insert into emp (컬럼명1, 컬럼명2, ...) value (값1, 값2, ...);
INSERT INTO emp (ENAME, EMPNO, JOB, MGR, HIREDATE, DEPTNO)
	values('EJK', 8003, 'T', 7788, SYSDATE, 40);
SELECT * FROM EMP;
INSERT INTO emp (ENAME, EMPNO, JOB, MGR, HIREDATE, DEPTNO)
	values('EJK2', 8004, 'F', 7789, SYSDATE, 40);

COMMIT;

UPDATE EMP
	SET MGR = 7788
	WHERE ENAME = 'EJK2'
	--UPDATE 명령문의 WHERE절에는 컬럼명PK=값
	--WHERE 절에는 컬럼명PK=값 ==> RESULTSET 은 단일행
	
-- 20번 부서의 MGR가 SMITH 7908로 조직개편
UPDATE EMP
	SET MGR = 7908
	WHERE DEPTNO = 20
; -- 결과 5
UPDATE EMP
	SET MGR = 7908
	WHERE DEPTNO = 70
; -- 결과 0
	-- DQL - SELECT 명령어의 결과는 RESULT SET 모양으로 출력되고, 
	-- DML - INSERT/UPDATE/DELETE 결과는 정수 모양으로 출력된다.

ROLLBACK -- 최근 CUMMIT으로 테이블 상태를 되돌린다

SELECT * FROM EMP;
-- 여러 DML 명령어 들은 묶어서 하나의 행동(일)처리를 하고자 할 때 COMMIT / ROLLBACK 을 적절히 사용.
-- 1 DML 명령어가 하나의 행동(일) 처리 단위라면 DML - COMMIT;
-- 2 이상

COMMIT;
SELECT * FROM EMP;
SELECT * FROM DEPT;

-- INSERT ALL
-- 20번 부서에 신입사원 EJ3 (8005), EJ4(5006)을 투입함.
INSERT INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ3', 8005, 20);
INSERT INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ4', 8006, 20);

INSERT ALL
	INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ5', maxempno + 1, 20)
	INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ6', maxempno + 2, 20)
SELECT MAX(EMPNO) maxempno FROM EMP
;

-- 새로운 부서 50번이 만들어지고 그 부서에 신입사원 EJ3 (8005), EJ (5006) 을 투입함
INSERT ALL
	INTO DEPT (deptno) VALUES (newdeptno)
	INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ7', (SELECT MAX(EMPNO) maxempno FROM EMP) + 1, newdeptno)
	INTO EMP (ENAME, EMPNO, DEPTNO) VALUES('EJ8', (SELECT MAX(EMPNO) maxempno FROM EMP) + 2, newdeptno)
SELECT MAX(deptno) + 10 newdeptno FROM DEPT
;

-- ****************************************************************************************************
-- 23/07/14
-- VIEW ****************************
-- VIEW테이블 생성
CREATE OR REPLACE VIEW VIEW_T1
	AS SELECT * FROM EMP
;

-- T2테이블이 없으에도 VIEW 생성
CREATE OR REPLACE FORCE VIEW VIEW_T2
	AS SELECT * FROM T2
;

-- VIEW_EMP_READONLY 읽기 전용 VIEW 테이블
CREATE OR REPLACE VIEW VIEW_EMP_READONLY
	AS 
	SELECT * FROM EMP
	WITH READ ONLY	
;

-- SQL Error [42399] [99999]: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다. - 오류
INSERT INTO VIEW_EMP_READONLY (EMPNO, ENAME, DEPTNO) VALUES(8100, 'EJEJ', 30)
;

--
CREATE OR REPLACE VIEW VIEW_EMP_CHECKOPTION
	AS
	SELECT * FROM EMP
	WHERE DEPTNO = 30
	WITH CHECK OPTION -- CHECK를 하여 DEPTNO를 VIEW에서 UPDATE가 되지 않게 설정
;

SELECT * FROM VIEW_EMP_CHECKOPTION
;

--UPDATE 시도 => SQL Error [1402] [44000]: ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다 - 오류
UPDATE VIEW_EMP_CHECKOPTION SET DEPTNO = 20 WHERE EMPNO = 7499
;
--WITH CHECK 되지 않은 부분은 변경이 가능
UPDATE VIEW_EMP_CHECKOPTION SET COMM = 350 WHERE EMPNO = 7499
;
--TABLE을 이용한 UPDATE는 가능
UPDATE EMP SET DEPTNO = 20 WHERE EMPNO = 7499
;

-- SEQUENCE 면접 ********************

-- 표현식은 PPT 자료 확인 10장 p.2 외우기, ALTER 부분도 외우기

-- SEQUENCE 순자척으로 정수 값을 자동으로 생성하는 객체롤 자동 번호 발생기 역할을 함
-- SEQUENCE 생성
CREATE SEQUENCE SEQ_T1;

-- CURRVA을 +1 해준다 - UNIQUE 값으로 넣기 편함 ex.게시판, 상품번호
-- INSERT 과 함께 사용함
-- SEQUENCE 이름을 지을 때 SEQ_테이블명_컬럼명
-- 예를 들어 EMP테이블에 EMPNO에 적용 - SEQ_EMP_EMPNO
-- INSERT INTO EMP VALUES ( SEQ_EMP_EMPNO.nextval , "홍길동", ...); 커맨트에 ..._SEQ 삽입
SELECT SEQ_T1.NEXTVAL FROM DUAL
;

SELECT SEQ_T1.CURRVAL FROM DUAL
;

-- SQUENCE 정보 확인
SELECT * FROM USER_SEQUENCES;

-- 수정 표현식은 PPT 자료 확인 10장 p.6

-- INDEX 면접에 많이 물어봄 ********************
-- INDEX 객체는 TABLE 객체에서 정보를 가져옴. 테이블 객체가 사라져도 무관. SEQUENCE도 마찬가지. CONSTRAINT는 예외
-- PK로 제야조건을 걸면 PK로 인해 INDEX 자동 생성
-- 오라클 객체로 내부 구조는 B*트리 형식으로 구성
-- 장점 : 검색 속도가 빨라지고 부하 감소, 시스템 전체 성승 향상
-- 단점 : INDEX를 위한 저장공간이 필요. 변경 작업이 일어날 경우 부하가 걸려 오히려 성능저하
-- 사용용도
-- 1.1 인덱스가 필요한 경우
-- 테이블의 행의 수가 많을 경우
-- WHERE문에 특정 컬럼이 많이 사용될 때
-- 검색 결과가 전체 데이터의 2~4% 정도일 때
-- JOIN에 자주 사용되는 컬럼
-- NULL을 포함하는 행이 많은 컬럼일 경우


-- 1.2 인덱스가 불필요한 경우
-- 데이터가 적은(수천 건 미만) 경우
-- 조회 보다 삽입, 수정, 삭제 처리가 많은 테이블일 경우
-- 조회 결과가 정테 행의 15% 이상 조회할 것으로 예상되는 경우

-- INDEX 정보 확인
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;

-- 첫 번째 방법. 함수 기반 INDEX
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);
-- WHERE 절에 SAL*12 > 5000 처럼 조건문에 사용이 빈번할 때 INDEX를 걸어줌
CREATE INDEX IDX_EMP_SAL ON EMP(SAL * 12);

-- WHERE 절에 SAL > 5000 AND COMM > 200 처럼 조건문에 사용이 빈번할 때 INDEX를 걸어줌
CREATE INDEX IDX_EMP_SAL_COMM ON EMP(SAL,COMM);
SELECT * FROM EMP WHERE SAL > 3000 AND COMM IS NOT NULL;

-- 두 번째 방법. BITMAB 기반 INDEX - 도메인의 종류가 적을 때 동일한 데이터가 많은 경우 - GENDER 남여
CREATE BITMAP INDEX IDX_EMP_SAL ON EMP(SAL);
CREATE BITMAP INDEX IDX_EMP_SAL_COMM ON EMP(SAL,COMM);

-- I. UNIQUE
-- 	INSERT 오류체크빠름.
-- II. NON-UNIQUE

-- INDEX 재생성  외우기
ALTER INDEX PK_EMP REBUILD;

-- SYNONYM ****************************
-- SYNONYM 사용자가 다른 사용자의 객체를 참조할 때 사용
CREATE SYNONYM EMP FOR EMPLOYEE;

-- ****************************************************************************************************
-- 23/07/17


create sequence seq_tb1_c1 start with 10 increment by 10 maxvalue 90 minvalue 10 nocycle cache 20; -- 예를 들어 작성
select seq_tb1_c1.currval from dual;
--ORA-02289: 시퀀스가 존재하지 않습니다.
--02289. 00000 -  "sequence does not exist"
--*Cause:    The specified sequence does not exist, or the user does
--           not have the required privilege to perform this operation.
--*Action:   Make sure the sequence name is correct, and that you have
--           the right to perform the desired operation on this sequence.
--551행, 8열에서 오류 발생
--nextval을 정의 해야함
select seq_tb1_c1.nextval from dual;

-- role객체
alter session set "_ORACLE_SCRIPT"=true; -- 세션 세팅 권한 부여
create role role_scott_manager; -- role 구조식
create user kh2 identified kh2;

grant connect, resource to kh2;
--connect -- 롤이름
--권한들의 묶음 -- 롤
--create session -- 접속권한
--공간 space 를 사용하는 권한들 묶어서 resource 롤에 지정함

--grant 권한1, 권한2, ..., 롤명1, 롤명2, ... to role_scott_manager; 만들어진 role에 권한을 부여
--grant role_scott_manager to kh2; 만들어진 user에 권한을 부여

-- revoke create view from role_scott_manager; grant role_scott_manager 문에 정의된 권한을 삭제













































