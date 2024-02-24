SELECT COUNT(First_Name)
FROM employees;

CREATE TABLE emp_ido 
AS SELECT * FROM employees;  --Se creeaza tot dar fara constrangeri!

SELECT * FROM emp_ido;

--11
COMMENT ON TABLE emp_ido IS 'Informatii despre angajati'; --putem ad comentarii intr-o baza (nefolosit mai niciodata)

--12
SELECT COMMENTS FROM user_tab_comments  --putem vedea si comentariile
WHERE COMMENTS IS NOT NULL
AND COMMENTS like '%Informatii%'; 

--13
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY HH:MI:SS'; --setam data din dual in formatul acesta
SELECT SYSDATE FROM DUAL;

--14
SELECT EXTRACT(YEAR FROM SYSDATE) --ni-l da ca integer
FROM DUAL;

--15
SELECT EXTRACT(MONTH FROM SYSDATE), EXTRACT(YEAR FROM SYSDATE)  --acum luam luna si anul numai asa, pt ca EXTRACT ia numai o singura val
FROM DUAL;

--16
SELECT * FROM user_tables --vedem asa toate tabelele, astfel incat sa o extragem doar pe cea pe care o vrem noi
WHERE TABLE_NAME LIKE '%EMP_IDO%';


--Grija mare la comentarii unde le punem! Putem face rularea asta si modifica si fisierul.
--17 
SET PAGESIZE 0; --21
SET FEEDBACK OFF; --21
SPOOL C:\USERS\IONUT\lab1.TXT 
SELECT 'DROP TABLE ' || TABLE_NAME || ';'
FROM USER_TABLES
WHERE TABLE_NAME LIKE 'EMP_%';
SPOOL OFF;

SELECT * FROM Departments;

--23
SET PAGESIZE 0; 
SET FEEDBACK OFF;
SPOOL C:\USERS\IONUT\lab1_test.TXT 
SELECT 'INSERT INTO ' || 'DEPARTMENTS ' || 'VALUES (' || DEPARTMENT_ID  || ',''' || DEPARTMENT_NAME  || ''',' || NVL(TO_CHAR(MANAGER_ID), 'NULL')  || ',' || LOCATION_ID ||')'
FROM DEPARTMENTS;
SPOOL OFF;



--ex din tema

SPOOL C:\USERS\IONUT\tema1.TXT 
SELECT 'DROP TABLE ' || TABLE_NAME || ';'
FROM USER_TABLES
WHERE TABLE_NAME LIKE 'UTI%'
OR TABLE_NAME LIKE 'RATING'
OR TABLE_NAME LIKE 'PARTIDE'
OR TABLE_NAME LIKE 'ANALIZA'
OR TABLE_NAME LIKE 'MUTARI'
OR TABLE_NAME LIKE 'PARTIDEINFO'
OR TABLE_NAME LIKE 'CONVERSATII'
OR TABLE_NAME LIKE 'PUZZLES'
OR TABLE_NAME LIKE 'PRIETENIE'
OR TABLE_NAME LIKE 'TURNEE'
OR TABLE_NAME LIKE 'PLATI'
OR TABLE_NAME LIKE 'MESAJ'
OR TABLE_NAME LIKE 'NOTIFICARI';
SPOOL OFF;

SPOOL C:\USERS\IONUT\tema1_test.TXT 
SELECT 'INSERT INTO ' || 'UTILIZATORI ' || 'VALUES ('|| ID_UTILIZATOR  || ',''' || USERNAME  || ''',' || EMAIL  || ',' || PAROLA ||')'
FROM UTILIZATORI;
SPOOL OFF;


