create or replace NONEDITIONABLE procedure pro_dept_insert
--DECLARE
is
    maxdno dept.deptno%type;
    dno dept.deptno%type;
--  
--  
begin
    select max(deptno) into maxdno from dept;
    insert into dept (dname, deptno, loc) values ('EJ5', maxdno + 1, '서울');
    insert into dept (dname, deptno, loc) values ('EJ5', maxdno + 2, '서울');
    -- procedure 는 update, delete, select 등 모두 활용 가능함.
    commit;
end;

-- 사원번호를 전달받아서 이름, 급여, 업무를 반환함.
create or replace procedure PRO_EMP_ARG_TEST(ARG_EMPNO IN EMP.EMPNO%TYPE, ARG_ENAME OUT EMP.ENAME%TYPE)
is
begin
    -- proceduer는 returne 없음.
    -- function는 returne 없음
    dbms_output.put_line('ARG_EMPNO : ' || ARG_EMPNO);
    ARG_ENAME := '확인';
    dbms_output.put_line('ARG_EMPNO : ' || ARG_EMPNO);
end;
/

EXEC pro_dept_insert;
select * from dept;
-- 바인드 변수 선언
variable VAR_emp_name varchar2(30);
variable VAR_salary varchar2(30);
variable VAR_phone varchar2(30);
-- procedure 실행
exec PRO_EMPLOYEE_AGR_TEST(200, :VAR_emp_name, :VAR_salary, :VAR_phone);
-- 출력
print VAR_emp_name;
print VAR_emp_salary;
print VAR_emp_phone;

CREATE OR REPLACE PROCEDURE PRO_EMPLOYEE_AGR_TEST
    ( ARG_EMP_NO in employee.emp_no%type
    ,ARG_EMP_NAME out employee.emp_name%type
    ,ARG_SALARY out employee.salary%type
    ,ARG_PHONE out employee.phone%type
    )
is
begin
    select  emp_name, salary, phone
    into  ARG_EMP_NAME, ARG_SALARY, ARG_PHONE
    from employee
    where emp_no = ARG_EMP_NO;
end;
/

create or replace procedure pro_all_emp
is
begin
    for e in (select * from employee) loop
        dbms_output.put_line(e.emp_name);
        PRO_EMPLOYEE_AGR_TEST(e.emp_id, e.emp_name, e.salary, e.phone);
    end loop;
end;
/

exec pro_all_emp;

    select  emp_name, salary, phone
    from employee;
create or replace procedure pro_aaa
is
begin
    dbms_output.put_line('aaa');
end;
/
exec pro_aaa;