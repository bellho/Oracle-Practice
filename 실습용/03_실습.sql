SELECT *
FROM DEPT d
;
--Q. 1
--아래와 같이 조회
SELECT EMPNO , ENAME , JOB ,MGR ,HIREDATE ,SAL ,COMM ,DEPTNO , S.GRADE
FROM EMP e 
	JOIN SALGRADE s 
		ON SAL > S.LOSAL AND SAL < S.HISAL -- 여기 부분은 잘 모르겠다
ORDER BY S.GRADE , EMPNO
;

--Q. 2
--아래와 같이 조회
SELECT EMPNO , ENAME , JOB ,MGR ,HIREDATE, SAL ,COMM ,DEPTNO , S.GRADE
FROM EMP e 
	JOIN SALGRADE s 
		ON SAL > S.LOSAL AND SAL < S.HISAL -- 여기 부분은 잘 모르겠다
WHERE S.GRADE != 5
ORDER BY S.GRADE DESC
;

--Q. 3
--DEPTNO가 20,30인 부서 사람들의 등급별 평균연봉
--조건 :
--1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
--2. 연봉 계산은 SAL*12+COMM
--3. 순서는 평균연봉이 내림차순으로 정렬한다.
SELECT DISTINCT S.GRADE, ROUND(AVG(SAL * 12 + NVL(COMM , 0))) AS "평균연봉"
FROM EMP e
	JOIN SALGRADE s 
		ON SAL > S.LOSAL AND SAL < S.HISAL  -- 여기 부분은 잘 모르겠다
WHERE S.GRADE != 5
GROUP BY grade 
ORDER BY "평균연봉" DESC;
;

--Q. 4
--조건 :
--1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 조회
--2. 연봉 계산은 SAL*12+COMM
--3. 순서는 평균연봉이 내림차순으로 정렬한다.
SELECT DISTINCT DEPTNO, ROUND(AVG(SAL * 12 + NVL(COMM , 0))) AS "평균연봉"
FROM EMP e 
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
ORDER BY DEPTNO
;

--Q. 5
--사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.MGR ,
	E2.ENAME AS "MABAGER"
FROM
	EMP e
JOIN EMP e2 
		ON
	E.MGR = E2.EMPNO
ORDER BY E.EMPNO;

--Q. 6
--사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
--단, Select 절에 SubQuery를 이용하여 풀이
SELECT E.EMPNO , E.ENAME , E.JOB , E.MGR ,(SELECT E2.ENAME FROM EMP e2 WHERE E.MGR = E2.EMPNO)
FROM EMP e
;

--Q. 7
--MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번부서인 사원 조회
SELECT EMPNO , ENAME , JOB , MGR , HIREDATE , SAL , COMM , DEPTNO 
FROM EMP e 
WHERE SAL > (SELECT E2.SAL FROM EMP e2 WHERE ENAME = 'MARTIN') AND (E.deptno = 20 OR E.deptno = 30)
;

--Q. 8
--‘RESEARCH’부서의 사원 이름과 매니저 이름을 나타내시오.
SELECT 
	e.ENAME,
	e2.ENAME AS "MANAGER" ,
FROM EMP e 
JOIN EMP e2 , DEPT d 
	ON e.MGR = e2.EMPNO , e.deptno=d.deptno AND d.dname IN 'RESEARCH';






