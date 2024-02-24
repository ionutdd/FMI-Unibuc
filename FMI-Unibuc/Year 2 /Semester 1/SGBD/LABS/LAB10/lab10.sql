--pachete

--ex 1 pachet cu functii

CREATE OR REPLACE PACKAGE 
    pachet1_ido AS 
    FUNCTION f_numar 
        (v_dept DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER;
    FUNCTION f_suma 
        (v_dept DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER;
END pachet1_ido;
/

CREATE OR REPLACE PACKAGE BODY 
    pachet1_ido AS 
    FUNCTION f_numar
        (v_dept DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER IS nr NUMBER;
    BEGIN 
        SELECT COUNT(*) INTO nr
            FROM employees
            WHERE department_id = v_dept;
        RETURN nr;
    END f_numar;

    FUNCTION f_suma 
        (v_dept DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER IS 
        suma NUMBER;
    BEGIN 
        SELECT SUM(salary + salary * NVL(commission_pct, 0)) INTO suma
        FROM employees
        WHERE department_id = v_dept;
        RETURN suma;
    END f_suma;
END pachet1_ido;
/

SELECT pachet1_ido.f_numar(10)
FROM DUAL;



--ex 2 pachet cu proceduri si functie


CREATE OR REPLACE PACKAGE pachet2_*** AS
 PROCEDURE p_dept (v_codd dept_***.department_id%TYPE,
 v_nume dept_***.department_name%TYPE,
 v_manager dept_***.manager_id%TYPE,
 v_loc dept_***.location_id%TYPE);
 PROCEDURE p_emp (v_first_name emp_***.first_name%TYPE,
 v_last_name emp_***.last_name%TYPE,
 v_email emp_***.email%TYPE,
 v_phone_number emp_***.phone_number%TYPE:=NULL,
 v_hire_date emp_***.hire_date%TYPE :=SYSDATE,
 v_job_id emp_***.job_id%TYPE,
 v_salary emp_***.salary%TYPE :=0,
 v_commission_pct emp_***.commission_pct%TYPE:=0,
 v_manager_id emp_***.manager_id%TYPE,
 v_department_id emp_***.department_id%TYPE);
SGBD An II Sem. I Lect. Univ. Dr. Gabriela Mihai
3
 FUNCTION exista (cod_loc dept_***.location_id%TYPE,
 manager dept_***.manager_id%TYPE)
 RETURN NUMBER;
END pachet2_***;
/
CREATE OR REPLACE PACKAGE BODY pachet2_*** AS
FUNCTION exista(cod_loc dept_***.location_id%TYPE,
 manager dept_***.manager_id%TYPE)
 RETURN NUMBER IS
 rezultat NUMBER:=1;
 rez_cod_loc NUMBER;
 rez_manager NUMBER;
 BEGIN
 SELECT count(*) INTO rez_cod_loc
 FROM locations
 WHERE location_id = cod_loc;

 SELECT count(*) INTO rez_manager
 FROM emp_***
 WHERE employee_id = manager;

 IF rez_cod_loc=0 OR rez_manager=0 THEN
 rezultat:=0;
 END IF;
RETURN rezultat;
END;
PROCEDURE p_dept(v_codd dept_***.department_id%TYPE,
 v_nume dept_***.department_name%TYPE,
 v_manager dept_***.manager_id%TYPE,
 v_loc dept_***. location_id%TYPE) IS
BEGIN
 IF exista(v_loc, v_manager)=0 THEN
 DBMS_OUTPUT.PUT_LINE('Nu s-au introdus date coerente pentru
tabelul dept_***');
 ELSE
 INSERT INTO dept_***
 (department_id,department_name,manager_id,location_id)
 VALUES (v_codd, v_nume, v_manager, v_loc);
 END IF;
 END p_dept;
PROCEDURE p_emp
(v_first_name emp_***.first_name%TYPE,
 v_last_name emp_***.last_name%TYPE,
 v_email emp_***.email%TYPE,
 v_phone_number emp_***.phone_number%TYPE:=null,
 v_hire_date emp_***.hire_date%TYPE :=SYSDATE,
 v_job_id emp_***.job_id%TYPE,
 v_salary emp_***.salary %TYPE :=0,
SGBD An II Sem. I Lect. Univ. Dr. Gabriela Mihai
4
 v_commission_pct emp_***.commission_pct%TYPE:=0,
 v_manager_id emp_***.manager_id%TYPE,
 v_department_id emp_***.department_id%TYPE)
AS
 BEGIN
 INSERT INTO emp_***
 VALUES (sec_***.NEXTVAL, v_first_name, v_last_name, v_email,
 v_phone_number,v_hire_date, v_job_id, v_salary,
 v_commission_pct, v_manager_id,v_department_id);
END p_emp;
END pachet2_***;
/ 


--Apelare 

BEGIN
 pachet2_***.p_dept(50,'Economic',99,2000);
 pachet2_***.p_emp('f','l','e',v_job_id=>'j',v_manager_id=>200,
 v_department_id=>50);
END;
/
SELECT * FROM emp_*** WHERE job_id='j';
ROLLBACK; 



--3

--Cursor in interiorul unui pachet

CREATE OR REPLACE PACKAGE BODY pachet3_*** AS
CURSOR c_emp(nr NUMBER) RETURN employees%ROWTYPE
 IS
 SELECT *
 FROM employees
 WHERE salary >= nr;
FUNCTION f_max (v_oras locations.city%TYPE) RETURN NUMBER IS
 maxim NUMBER;
BEGIN
 SELECT MAX(salary)
 INTO maxim
 FROM employees e, departments d, locations l
 WHERE e.department_id=d.department_id
 AND d.location_id=l.location_id
 AND UPPER(city)=UPPER(v_oras);
 RETURN maxim;
END f_max;
END pachet3_***;
/
DECLARE
 oras locations.city%TYPE:= 'Toronto';
 val_max NUMBER;
 lista employees%ROWTYPE;
BEGIN
 val_max:= pachet3_***.f_max(oras);
 FOR v_cursor IN pachet3_***.c_emp(val_max) LOOP
 DBMS_OUTPUT.PUT_LINE(v_cursor.last_name||' '||
 v_cursor.salary);
 END LOOP;
END;
/

--Tema ex 1



