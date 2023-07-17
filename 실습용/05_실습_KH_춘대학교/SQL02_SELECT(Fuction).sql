SELECT
    *
FROM tb_student
;
-- 1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL 문장을 작성하시오.
-- ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
select student_no as "학번", student_name as "이름", TO_char(entrance_date,'yyyy-mm-dd') as "입학년도"
from tb_student
where department_no = 002
order by student_no
;

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. 
-- (* 이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT professor_name, professor_ssn
FROM TB_PROFESSOR
where length(professor_name) <> 3 -- length로 글자수 출력
;

-- 3.춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 
-- 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. 
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
select professor_name as "교수이름", 
    case when extract(month from sysdate) <= substr(professor_ssn,3,2) then 2023-(substr(professor_ssn,1,2)+1900)
        when extract(month from sysdate) > substr(professor_ssn,3,2) then 2023-(substr(professor_ssn,1,2)+1900-1)
        end as "나이"
from tb_professor
order by "나이";

-- 4.교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 
-- 출력 헤더는 '이름' 이 찍히도록 한다. (성이 2자인 경우는 교수는 없다고 가정하시오)
SELECT substr((professor_name) ,2)
FROM TB_PROFESSOR
;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
select student_no, student_name
from tb_student
where (EXTRACT(year from entrance_date) - EXTRACT(year from to_date((substr(student_ssn,1,6)))) > 19)
;

-- 6. 2020 년 크리스마스는 무슨 요일인가?
select to_char(to_date(20201225), 'day')
from  dual
;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까? 
--또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까?
--TO_DATE('99/10/11','YY/MM/DD') - 1999년 10월 11일 / TO_DATE('49/10/11','YY/MM/DD') - 1949년 10월 11일
--TO_DATE('99/10/11','RR/MM/DD') - 1999년 10월 11일 / TO_DATE('49/10/11','RR/MM/DD') - 2049년 10월 11일

--8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
--2000 년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
select student_no , student_name
from tb_student
where student_no not like 'A%'   
;

--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 
--단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT round(avg(point), 1) as "평점"
FROM tb_student
    join tb_grade using (student_no)
where student_no = 'A517178'
;

--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어
--결과값이 출력되도록 하시오.
select department_no , count(DEPARTMENT_NO)
from tb_student
GROUP by department_no
order by 1
;

--11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.
select count(*)
from tb_student
where coach_professor_no is null
;

--12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 
--단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
--소수점 이하 한 자리까지만 표시한다.
select substr(tb_grade.term_no, 1, 4) as "년도", round(avg(point), 1) as "년도 별 평점"
from tb_student
    join tb_grade using (student_no)
where student_no = 'A112113'
GROUP by substr(tb_grade.term_no, 1, 4)
;

--13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
-- 미구현
select department_no , count(absence_yn)
from tb_student
where absence_yn = 'Y'
group by department_no
order by 1
;

--14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 
--어떤 SQL 문장을 사용하면 가능하겠는가?
select e1.student_name , count(*)
from tb_student e1
    join tb_student e2
    on e1.student_name = e2.student_name and e1.student_no <> e2.student_no
GROUP by  e1.student_name
order by e1.student_name
;

--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 
--총 평점을 구하는 SQL 문을 작성하시오. 
--(단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
-- 미구현