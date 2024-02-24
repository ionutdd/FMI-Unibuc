SELECT *
FROM member;

SELECT *
FROM title;

SELECT *
FROM title_copy;

SELECT * 
FROM rental;

SELECT *
FROM reservation;

SELECT COUNT(status), COUNT(DISTINCT(r.title_id))
FROM title_copy c, title t, rental r
WHERE status like 'RENTED'
AND t.title_id = c.title_id
AND t.category = (SELECT category
                  FROM title 
                  GROUP BY category
                  HAVING COUNT(category) = (SELECT MAX(COUNT(category))
                                            FROM title
                                            GROUP BY category))
AND r.title_id IN (SELECT title_id 
                   FROM title 
                   WHERE category = (SELECT category
                                     FROM title 
                                     GROUP BY category
                                     HAVING COUNT(category) = (SELECT MAX(COUNT(category))
                                                               FROM title
                                                               GROUP BY category)));
                                                               
                                                               
                                                               
--rezolvare corecta ex 4
SELECT category, count(*), count(DISTINCT t1.title_id)
FROM rental r1
JOIN title t1 ON r1.title_id = t1.title_id
GROUP BY category
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM rental R
                        JOIN title t ON 
                                    r.title_id = t.title_id
                        GROUP BY category);
        
        
--rezolvare corecta ex 5                        
SELECT t.title_id, COUNT(t.title_id)  
FROM title t, title_copy c
WHERE t.title_id = c.title_id
AND (t.title_id, copy_id) NOT IN (SELECT title_id, copy_id
                                    FROM rental
                                    WHERE act_ret_date IS NULL)
GROUP By t.title_id;


--rezolvare corecta ex 6
SELECT (CASE 
            WHEN ((c.title_id, c.copy_id) NOT IN (SELECT title_id, copy_id
                                            FROM rental
                                            WHERE act_ret_date IS NULL)) 
                THEN 'AVAILABLE'
            ELSE
                'RENTED'
        END) AS "TRUE STATUS", c.status, t.title, c.copy_id 
FROM title t, title_copy c
WHERE t.title_id = c.title_id;
                
   
   
--TEMA      
                
--7a                
                
SELECT COUNT(status) 
FROM (SELECT status, CASE 
                        WHEN ((t.title_id, c.copy_id) NOT IN (SELECT title_id, copy_id
                                                              FROM rental
                                                              WHERE act_ret_date IS NULL))
                          THEN 'AVAILABLE'
                          ELSE 'RENTED'
                        END AS "Exemplare neeronate"
      FROM title t
      JOIN title_copy c ON t.title_id = c.title_id)
WHERE status != "Exemplare neeronate";



--7b
CREATE TABLE title_copy_IDO AS SELECT * FROM title_copy;

SELECT *
FROM title_copy_IDO;

SELECT *
FROM title_copy;

UPDATE title_copy_IDO SET status = CASE 
                                        WHEN (title_id, copy_id) NOT IN (SELECT title_id, copy_id
                                                                         FROM rental
                                                                         WHERE act_ret_date IS NULL)
                                            THEN 'AVAILABLE'
                                            ELSE 'RENTED'
                                        END;
                                        
--8                                     
SELECT (CASE 
            WHEN(SELECT COUNT(*)
                 FROM rental ren, reservation res
                 WHERE ren.title_id = res.title_id 
                 AND ren.member_id = res.member_id 
                 AND book_date != res_date) <= 0
        THEN 'DA'
        ELSE 'NU'
        END) AS "Imprumutate la aceeasi data?"
FROM dual;


SELECT * FROM rental;
SELECT * FROM title_copy_IDO;
SELECT * FROM reservation;
SELECT * FROM title_copy;


--12a

SELECT (SELECT COUNT(*) 
        FROM rental
        WHERE TO_CHAR(book_date, 'DD-MM-YY') = '01-10-23') AS "ALIAS 1",
       (SELECT COUNT(*) 
        FROM rental
        WHERE TO_CHAR(book_date, 'DD-MM-YY') = '02-10-23') AS "ALIAS 2"
FROM dual;



--12b

SELECT r.book_date, COUNT(t.status)
FROM rental r, title_copy_IDO t
WHERE t.copy_id = r.copy_id AND t.title_id = r.title_id AND EXTRACT(DAY FROM r.book_date) <= 2
GROUP BY r.book_date;


--12c

SELECT A.DATA, NVL(B.nr_imp, 0)
FROM (SELECT TRUNC(SYSDATE, 'MONTH') + (level - 1) DATA
      FROM dual
      CONNECT BY level <= EXTRACT(DAY FROM LAST_DAY(SYSDATE))) A
LEFT JOIN (SELECT book_date, count(*) AS "NR_IMP"
           FROM rental
           WHERE TO_CHAR(SYSDATE, 'MM-YY') = TO_CHAR (book_date, 'MM-YY')
           GROUP BY book_date) B ON TO_CHAR(A.DATA, 'DD-MM-YY') = TO_CHAR(b.book_date, 'DD-MM-YY')
ORDER BY A.data;








