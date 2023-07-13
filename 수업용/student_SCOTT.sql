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































