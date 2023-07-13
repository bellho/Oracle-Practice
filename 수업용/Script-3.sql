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
SELECT dep
