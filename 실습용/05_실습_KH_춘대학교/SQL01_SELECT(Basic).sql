select *
from tb_department
;
select *
from TB_STUDENT
;
select *
from TB_CLASS
;
select *
from tb_professor
;
-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"로 표시하도록 한다.
select department_name as "학과 명" , capacity "계열"
from tb_department
;

-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
select d.department_name||'의 정원은 ' ||count(*)||'명 입니다.' as "학과별 정원"
from tb_department d
     left join TB_STUDENT s --left join을 사용해 처음 선언한 데이터를 기준으로 표시.
        on d.department_no = s.department_no -- 컬럼값이 같으면 표시.
GROUP by d.department_name -- 그냥 count문을 사용하면 전체 갯수만 가져오므로, 유형별로 갯수를 표시할 수 있게끔 그룹화 시킴.
;

-- 3. "국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 누구인가?
select student_name
from TB_STUDENT su
    join tb_department de
        using (department_no) -- 공통된 칼럼이 2개 이상일 때 사용.
where department_no = 001 and su.absence_yn = 'Y' and su.student_ssn like '_______2%'
;

-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다.
select student_name
from TB_STUDENT
where student_no in ('A513079','A513090','A513091','A513110','A513119')
order by student_name desc -- order by를 이용하여 기준이 되는 컬럼을 오름차순으로 표시. 뒤에 desc가 붙으면 내림차순.
;

-- 5. 입학 정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오.
select department_name, category
from tb_department
where capacity between 20 and 30 -- between을 사용하면 조건문을 간결하게 표시.
;

-- 6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
select professor_name
from tb_professor
where department_no is null -- is null문은 'null'이 존재하면 표시.
;

-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않는 학생이 있는지 확인하고자 한다.
select *
from TB_STUDENT
where department_no is null or department_no = 000 --  is null문은 'null'이 존재하면 표시.
;

-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데 선수과목이 존재하는 과목들은
--어떤 과목인지 과목번호를 조회해보시오.
select class_no
from TB_CLASS
where preattending_class_no is not null --  is not null문은 'null'이 존재하지 않으면 표시.
;

-- 9. 춘 대학에는 어떤 계열(category)들이 있는지 조회해보시오.
select DISTINCT category
from tb_department
order by category -- 오름차순으로 표시.
;

-- 10. 02학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외한 재학중인 학생들의
--학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
select student_no, student_name, student_ssn
from TB_STUDENT
where EXTRACT(year from entrance_date) = 2002 and absence_yn = 'N' and student_address like '전주시%' -- EXTRACT는 date를 년, 월, 일을 표시
;