-- ****************************************************************************************************
-- 23/07/18
-- pl/sql
set serveroutput on; --스크립트 화면에 결과값 출력
set serveroutput off; --스크립트 화면에 결과값 출력 끄기

begin -- 시작
    dbms_output.put_line('hello world');
    dbms_output.put_line('hello world2');
end; -- 끝
/

-- 변수의 선언과 초기화, 변수 값 출력
declare
    emp_id number;
    emp_name varchar2(30);
begin
    emp_id := 888;
    emp_name := '배장남';
    dbms_output.put_line('emp_id : ' || emp_id);
    dbms_output.put_line('emp_name : ' || emp_name);
end;
/

--레퍼런스 변수의 선언과 초기화, 변수 값 출력
DECLARE
    emp_id employee.emp_id%type;
    emp_name employee.emp_name%type;
BEGIN
    select emp_id, emp_name
    into emp_id, emp_name
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('emp_id : ' || emp_id);
    dbms_output.put_line('emp_name : ' || emp_name);    
end;
/

--한 행에 대한 ROWTYPE변수의 선언과 초기화, 값 출력
DECLARE
    e employee%rowtype;
BEGIN
    select * into e
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('emp_id : ' || e.emp_id);
    dbms_output.put_line('emp_name : ' || e.emp_name);    
    dbms_output.put_line('emp_id : ' || e.emp_no);
    dbms_output.put_line('emp_name : ' || e.salary);    

end;
/

DECLARE
    type emp_id_table_type is table of employee.emp_id%TYPE
    index by binary_integer;
    type emp_name_table_type is table of employee.emp_name%TYPE
    index by binary_integer;
    
    emp_id_table emp_id_table_type;
    emp_name_table emp_name_table_type;
    
    i BINARY_INTEGER := 0;
BEGIN
    FOR k in (select emp_id, emp_name from employee) loop
        i := i + 1;
        emp_id_table(i) := k.emp_id;
        emp_name_table(i) := k.emp_name;
    end loop;
    for j in 1..i loop
        dbms_output.put_line('EMP_ID : ' || emp_id_table(j) ||
        ',EMP_NAME : ' || emp_name_table(j));
            end loop;
end;
/

declare
    type emp_record_type is record(
        emp_id employee.emp_id%type,
        emp_name employee.emp_name%type,
        dept_title department.dept_title%type,
        job_name job.job_name%type
    );
    
    emp_record emp_record_type;
begin
    select emp_id, emp_name, dept_title, job_name
    into emp_record
    from employee e, department d, job j
    where e.dept_code = d.dept_id
        and e.job_code = j.job_code
        and emp_name = '&emp_name';
        
    dbms_output.put_line('사번 : ' || emp_record.emp_id);
    dbms_output.put_line('이름 : ' || emp_record.emp_name);
    dbms_output.put_line('부서 : ' || emp_record.dept_title);
    dbms_output.put_line('직급 : ' || emp_record.job_name);

end;
/

declare
        emp_id employee.emp_id%type;
        emp_name employee.emp_name%type;
        salary employee.salary%type;
        bonus employee.bonus%type;
begin
    select emp_id, emp_name, salary, bonus
    into emp_id, emp_name, salary, bonus
    from employee
    where emp_id = '&emp_id';
        
    dbms_output.put_line('사번 : ' || emp_id);
    dbms_output.put_line('이름 : ' || emp_name);
    dbms_output.put_line('급여 : ' || salary);

    if(bonus = 0 or bonus is null)
        then  dbms_output.put_line('보너스를 지급받지 않는 사원입니다.');
    end if;
        dbms_output.put_line('보너스율 : ' || nvl(bonus, 0) * 100 || '%');
end;
/

declare
        emp_id employee.emp_id%type;
        emp_name employee.emp_name%type;
        dept_title department.dept_title%type;
        national_code location.national_code%TYPE;
        
        team varchar2(20);
begin
    select emp_id, emp_name, dept_title, national_code
    into emp_id, emp_name, dept_title, national_code
    from employee e, department d, location l
    where e.dept_code = d.dept_id
        and d.location_id = l.local_code
        and emp_id = '&emp_id';
    
    if(national_code = 'KO') then team := '국내팀';
    else team := '해외팀';
    end if;
    
    dbms_output.put_line('사번 : ' || emp_id);
    dbms_output.put_line('이름 : ' || emp_name);
    dbms_output.put_line('부서 : ' || dept_title);
    dbms_output.put_line('소속 : ' || team);
end;
/

DECLARE
    score int;
    grade varchar2(2);
BEGIN
    score := '&score';
    
    if score >= 90 then grade := 'A';
    ELSIF SCORE >= 80 then grade := 'B';
    ELSIF SCORE >= 70 then grade := 'C';
    ELSIF SCORE >= 60 then grade := 'D';
    else grade := 'F';
    END IF;
    
    dbms_output.put_line('당신의 점수는 ' ||score||'점이고, 학점은 '||grade||'학점입니다.');
END;
/

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n:= n + 1;
        
        if n > 5 then exit;
        end if;
    end loop;
end;
/

begin
    for n in (select * from EMPLOYEE) loop
        dbms_output.put_line(n.emp_name);
    end loop;
end;
/

begin
    for n in reverse 1 ..5 loop
        dvms_output.put_line(n);
    end loop;
end;
/

declare
    n number := 1;
begin
    while n <= 5 loop
        dbms_output.put_line(n);
        n := n + 1;
    end loop;
end;
/

declare
    dup_empno exception;
    pragma exception_init(dup_empno, -00001);
begin
    update EMPLOYEE
    set emp_id = '&사번'
    where emp_id = 200;
exception
    when dup_empno
    then dbms_output.put_line('이미 존재하는 사번입니다.');
end;
/

create or replace procedure pro_dept_insert
--declare
is
-- 프로시저 비긴 안에 insert문을 삽입할 수 있다
DECLARE
--    dno dept.deptno%type;
--    dnm dept.dnameo%type;
--    dloc dept.loc%type;
BEGIN
    INSERT INTO DEPT VALUES('&DEPTNO','&부서명','&지역');
    commit;
END;
/
BEGIN
    FOR i IN 1 ..9 LOOP
        FOR j IN 1 ..9 LOOP
            DBMS_OUTPUT.PUT_LINE(i || ' × ' || j || ' = ' || i * j );
        END LOOP;
    END LOOP;
END;
/


















