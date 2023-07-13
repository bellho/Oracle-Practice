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

UPDATE EMP
	SET MGR = 7902
	WHERE ENAME = 'EJK2'
;


-- VIEW

























