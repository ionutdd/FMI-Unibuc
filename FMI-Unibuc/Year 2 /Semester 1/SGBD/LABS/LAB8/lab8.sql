
-- e2

DECLARE
 medie1 NUMBER(10,2);
 medie2 NUMBER(10,2);
 FUNCTION medie (v_dept employees.department_id%TYPE) 
 RETURN NUMBER IS
 rezultat NUMBER(10,2);
 BEGIN
 SELECT AVG(salary) 
 INTO rezultat 
 FROM employees
 WHERE department_id = v_dept;
 RETURN rezultat;
 END;
 
 FUNCTION medie (v_dept employees.department_id%TYPE,
 v_job employees.job_id %TYPE) 
 RETURN NUMBER IS
 rezultat NUMBER(10,2);
 BEGIN
 SELECT AVG(salary) 
 INTO rezultat 
 FROM employees
 WHERE department_id = v_dept AND job_id = v_job;
 RETURN rezultat;
 END;
BEGIN
 medie1:=medie(80);
 DBMS_OUTPUT.PUT_LINE('Media salariilor din departamentul 80' 
 || ' este ' || medie1);
 medie2 := medie(80,'SA_MAN');
 DBMS_OUTPUT.PUT_LINE('Media salariilor managerilor din'
 || ' departamentul 80 este ' || medie2);
END;
        

create table info_zad
    (
        utilizator varchar2(50),
        data date,
        comanda varchar2(50),
        nr_linii number(5),
        eroare varchar2(200)
    );
    
create or replace function f2_info_zad(v_nume employees.last_name%TYPE DEFAULT 'Bell')
return number is
    salariu employees.salary%type; 
begin
    select salary into salariu
    from employees
    where last_name = v_nume;
    
    if salariu is not null then 
        insert into info_zad (utilizator, data, comanda, nr_linii, eroare)
        values (v_nume, sysdate,'Functia f2_info_zad', 1, 'Inserare cu succes');
        return salariu;
    else
        insert into info_zad (utilizator, data, comanda, nr_linii, eroare)
        values (v_nume, SYSDATE, 'Functia f2_info_zad', 0, 'Nu exist? angajati cu numele dat');
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
    end if;
exception 
    when too_many_rows then
        insert into info_zad (utilizator, data, comanda, nr_linii, eroare)
        values (v_nume, SYSDATE, 'Functia f2_info_zad', 0, 'Exista mai multi angajati cu numele dat');
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
    when others then
        insert into info_zad (utilizator, data, comanda, nr_linii, eroare)
        values (v_nume, SYSDATE, 'Functia f2_info_zad', 0, 'Alta eroare!');
        RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END f2_info_zad;
    


DECLARE
  v_result NUMBER;
BEGIN
  v_result := f2_info_zad('Bell');
  DBMS_OUTPUT.PUT_LINE('Rezultatul functiei: ' || v_result);
END;


DECLARE
  v_result NUMBER;
BEGIN
  v_result := f2_info_zad('King');
  DBMS_OUTPUT.PUT_LINE('Rezultatul functiei: ' || v_result);
END;
/




--e2 proc

create or replace procedure p4_info_ido(v_nume employees.last_name%TYPE) is
  salariu employees.salary%TYPE;
begin
  select salary into salariu 
  from employees
  where last_name = v_nume;
  
  if salariu is not null then
    insert into info_ido (utilizator, data, comanda, nr_linii, eroare)
    values (v_nume, SYSDATE, 'Procedura p4_info_ido', 1, 'Inserare cu succes');
    DBMS_OUTPUT.PUT_LINE('Salariul este ' || salariu);
    else
    insert into info_ido (utilizator, data, comanda, nr_linii, eroare)
    values (v_nume, SYSDATE, 'Procedura p4_info_ido', 0, 'Nu exist? angajati cu numele dat');
    RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat');
  end if;
exception
  when TOO_MANY_ROWS then
    insert INTO info_ido (utilizator, data, comanda, nr_linii, eroare)
    values (v_nume, SYSDATE, 'Procedura p4_info_ido', 0, 'Exista mai multi angajati cu numele dat');
    RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat');
  when other then
    insert into info_ido (utilizator, data, comanda, nr_linii, eroare)
    values (v_nume, SYSDATE, 'Procedura p4_info_ido', 0, 'Alta eroare!');
    RAISE_APPLICATION_ERROR(-20002, 'Alta eroare!');
END p4_info_ido;
/

BEGIN
 p4_info_ido('Bell');
END;

BEGIN
 p4_info_ido('King');
END;
  

/

   

--e3



create or replace function f3_ido (
    oras locations.city%TYPE
) return number is
    v_raspuns         NUMBER;
    v_error         VARCHAR2(100);
    v_utilizator  info_ido.utilizator%TYPE;
begin
    select user into v_utilizator from dual;

    if oras is null then
        insert into info_ido (utilizator, data, eroare)
        values (v_utilizator, sysdate, 'City Null');

        return 0;
    end if;

    select count(*)
    into v_raspuns
    from employees e
    join departments d on (e.department_id = d.department_id)
    join locations l on (l.location_id = d.location_id)
    where
        (select count(*) from job_history where employee_id = e.employee_id ) >= 2;

    if v_raspuns = 0 then
        v_error := 'No emp';
    end if;

    insert into info_ido (utilizator, data, nr_linii, eroare)
    values (v_utilizator, sysdate, v_raspuns, v_error);

    return v_raspuns;
end;



DECLARE
  v_result NUMBER;
BEGIN
  v_result := f3_ido('Boston'); -- Înlocuie?te 'NumeOras' cu ora?ul dorit
END;
/


-- tema e4 si e7