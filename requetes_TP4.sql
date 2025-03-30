-- Creation de la table DEPT
create table DEPT (
    DeptNo INT primary key,
    DName VARCHAR(50),
    Loc VARCHAR(50)
);

-- Creation de la table EMP
create table EMP (
    EmpNo INT primary key,
    EName varchar(50),
    Job varchar(50),
    MGR INT, 
    HireDate date,
    Sal int,
    Comm int,
    DeptNo INT
);


-- Creation de la table SALGRADE
create table SALGRADE (
    Grade INT primary key,
    LoSal int,
    HiSal int
);


-- Ajout des contraintes pour EMP
alter table EMP
add constraint C_deptno 
foreign key (DeptNo) references DEPT(DeptNo);

alter table EMP
add constraint C_mgr 
foreign key (MGR) references EMP(EmpNo);


-- Ajout des données 
insert into SALGRADE (Grade, LoSal, HiSal) values (1, 700, 1200);
insert into SALGRADE (Grade, LoSal, HiSal) values (2, 1201, 1400);
insert into SALGRADE (Grade, LoSal, HiSal) values (3, 1401, 2000);
insert into SALGRADE (Grade, LoSal, HiSal) values (4, 2001, 3000);
insert into SALGRADE (Grade, LoSal, HiSal) values (5, 3001, 9999);

insert into DEPT (DeptNo, DName, Loc) values (10, 'ACCOUNTING', 'NEW YORK');
insert into DEPT (DeptNo, DName, Loc) values (20, 'RESEARCH', 'DALLAS');
insert into DEPT (DeptNo, DName, Loc) values (30, 'SALES', 'CHICAGO');
insert into DEPT (DeptNo, DName, Loc) values (40, 'OPERATIONS', 'BOSTON');

insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7839, 'KING', 'PRESIDENT', null, '17/11/81', 5000, null, 10);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7566, 'JONES', 'MANAGER', 7839, '02/04/81', 2975, null, 20);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7782, 'CLARK', 'MANAGER', 7839, '09/06/81', 2450, null, 10);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7698, 'BLAKE', 'MANAGER', 7839, '01/05/81', 2850, null, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7499, 'ALLEN', 'SALESMAN', 7698, '20/02/81', 1600, 300, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7521, 'WARD', 'SALESMAN', 7698, '22/02/81', 1250, 500, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7654, 'MARTIN', 'SALESMAN', 7698, '28/09/81', 1250, 1400, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7844, 'TURNER', 'SALESMAN', 7698, '08/09/81', 1500, 0, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7788, 'SCOTT', 'ANALYST', 7566, '19/04/87', 3000, null, 20);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7902, 'FORD', 'ANALYST', 7566, '03/12/81', 3000, null, 20);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7369, 'SMITH', 'CLERK', 7902, '17/12/80', 800, null, 20);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7876, 'ADAMS', 'CLERK', 7788, '23/05/87', 1100, null, 20);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7900, 'JAMES', 'CLERK', 7698, '03/12/81', 950, null, 30);
insert into emp(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) values (7934, 'MILLER', 'CLERK', 7782, '23/01/82', 1300, null, 10);



-- R1
SELECT * FROM EMP;

-- R2
SELECT * FROM emp WHERE sal < 1000;

-- R3
SELECT * FROM emp WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 20);

-- R4
SELECT * FROM emp 
where Job = (select job from emp where ename = 'FORD') 
  and Sal = (select sal from emp where ename = 'FORD');

-- R5
select * from emp where comm < 0.25 * Sal;


-- R6
select SUM(Sal) AS salaire_tot from emp where DeptNo = 30;


-- R7
select EName, Job from emp where Sal = (SELECT MAX(Sal) FROM EMP);


-- R8
SELECT COUNT(*) AS NbrEmployes FROM EMP WHERE DeptNo = 10;


-- R9
SELECT DeptNo, MAX(Sal) AS Sal_Max 
FROM EMP 
GROUP BY DeptNo;

-- R10
SELECT DeptNo, Job, AVG(Sal) AS Salaire_Moyen 
FROM EMP GROUP BY DeptNo, Job;

-- R11
SELECT COUNT(*) AS Nbr_emp_max
FROM EMP
WHERE DeptNo = (
    SELECT DeptNo
    FROM EMP
    GROUP BY DeptNo
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- R12
SELECT MGR AS No_Mng, (SELECT EName FROM EMP WHERE EmpNo = MGR) AS Nom_Mng, COUNT(*) AS Nbr_Subs
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY MGR
ORDER BY COUNT(*) DESC
LIMIT 1;


-- R13
SELECT DeptNo, COUNT(*) AS nbr_emp
FROM EMP
GROUP BY DeptNo
ORDER BY COUNT(*) DESC
LIMIT 1;


-- R14
SELECT DeptNo
FROM DEPT
WHERE DeptNo NOT IN (SELECT DISTINCT DeptNo FROM EMP);


-- R15
SELECT EName
FROM EMP e
WHERE Sal > (
    SELECT AVG(Sal)
    FROM EMP
    WHERE DeptNo = e.DeptNo
);


-- R16
SELECT DeptNo, EName, HireDate
FROM EMP
WHERE HireDate = (
    SELECT MIN(HireDate)
    FROM EMP AS e2
    WHERE e2.DeptNo = EMP.DeptNo
);

-- R17
SELECT EName, Sal
FROM EMP
ORDER BY Sal DESC
LIMIT 3;

-- R18
SELECT DName
FROM DEPT
WHERE DeptNo IN (
    SELECT DeptNo
    FROM EMP
    GROUP BY DeptNo
    HAVING COUNT(*) > 3
);


-- R19
SELECT d.DName, s.Grade
FROM DEPT d
JOIN EMP e ON d.DeptNo = e.DeptNo
JOIN SALGRADE s ON e.Sal BETWEEN s.LoSal AND s.HiSal
GROUP BY d.DName, s.Grade
ORDER BY d.DName;

-- R20
SELECT d.DName, MIN(e.Sal) AS min_Sal
FROM DEPT d
JOIN EMP e ON d.DeptNo = e.DeptNo
WHERE d.DeptNo = (
    SELECT DeptNo
    FROM EMP
    GROUP BY DeptNo
    ORDER BY AVG(Sal) DESC
    LIMIT 1
)
GROUP BY d.DName;


-- R22
SELECT *
FROM DEPT
WHERE DeptNo NOT IN (
    SELECT DISTINCT DeptNo
    FROM EMP
    WHERE Job = 'SALESMAN'
);


-- R22
SELECT e.EmpNo, e.EName
FROM EMP e
WHERE e.DeptNo IN (
    SELECT DeptNo
    FROM EMP
    GROUP BY DeptNo
    HAVING COUNT(*) < 4
);


-- R23
-- Création de la vue
CREATE VIEW Dept30Employees AS
SELECT *
FROM EMP
WHERE DeptNo = 30;

-- Affichage du contenu de la vue
SELECT * FROM Dept30Employees;





-- Exercice 2

-- creation des tables
create table ETUDIANT (
    numE int primary key not null,
    nom varchar(8),
    prenom varchar(8),
    dateNais date,
    email varchar(30) );
    
create table COURS (
    numC int primary key not null,
    formation varchar(20),
    nom varchar(30),
    nbcredit int );

create table NOTES(
    numE int,
    numC int,
    notefinal int,
	primary key (numE, numC) );

create table STATUT (
    numE int,
    annee int,
    formation varchar(20),
    statut varchar(10)
);

-- ajout des contraintes
alter table notes
add constraint C_numE
foreign key (numE) references etudiant(numE);

alter table notes
add constraint C_numC
foreign key (numC) references cours(numC);

alter table statut
add constraint C_prim
primary key (numE, annee, formation);

alter table statut
add constraint C_numE
foreign key (numE) references etudiant(numE);



-- insertion des donnees
insert into etudiant(numE, nom, prenom, dateNais, email) values
(3999133, 'Martin','Amandine','04-10-1990','martin.a@hotmail.fr'),
(3891012, 'Denis','Nicolas','21-03-1991','nicolasd@gmail.com'),
(3996423, 'Clément','Jacques','01-12-1993','jacquesc@yahoo.com'),
(3984125, 'Benoit','Amélie','09-05-1992','-'),
(4000014, 'Hubert','Emmanuel','18-08-1993','mhubert@hotmail.com'),
(4000021, 'Collet','Sarah','30-09-1994','sarah.collet@gmail.com'),
(3997862, 'Vincent','Georges','15-04-1993','gvincent@hotmail.com');

insert into cours(numC, formation, nom, nbcredit) values
(1, 'L1-Informatique', 'Base de données', 6),
(2, 'L1-Informatique', 'Programmation', 6),
(3, 'L1-Informatique', 'Algèbre', 3),
(4, 'L1-Informatique', 'Systèmes d’exploitation', 3),
(5, 'L2-Informatique', 'Génie logiciel', 3),
(6, 'L2-Informatique', 'Analyse de données', 6),
(7, 'L2-Informatique', 'Web', 6),
(8, 'L3-Informatique', 'Intelligence artificielle', 3),
(9, 'L3-Informatique', 'Projet', 12);

insert into Notes(numE,numC, notefinal) values
(4000014, 5, 15), (4000014, 7, 12), (3999133, 8, 11),
(3999133, 9, 7), (3891012, 8, 12), (3891012, 9, 14),
(3996423, 1, 10), (3996423, 2, 15), (3996423, 3, 17),
(3996423, 4, 9), (3984125, 5, 12), (3984125, 7, 5),
(4000021, 1, 15), (4000021, 2, 10), (4000021, 3, 6),
(4000021, 4, 11), (3997862, 2, 16), (3997862, 3, 11);
 
insert into statut(numE, annee, formation,statut) values
(4000014, 2011, 'L1-Informatique','Validé'),
(4000014, 2012, 'L2-Informatique','En_cours'),
(3999133, 2012, 'L3-Informatique','En_cours'),
(3891012, 2012, 'L3-Informatique','En_cours'),
(3996423, 2011, 'L1-Informatique','Nvalidé'),
(3984125, 2012, 'L2-Informatique','En_cours'),
(4000021, 2012, 'L1-Informatique','En_cours'),
(3997862, 2012, 'L1-Informatique','En_cours');


-- R1
insert into NOTES(numE, numC, notefinal)
select e.numE, c.numC, 15 from ETUDIANT e, COURS c
where e.prenom = 'Georges' and c.nom = 'Base de données';


-- R2
select c.nom as Nom_C, e.nom as Nom_E, n.notefinal as Note
from NOTES n
join ETUDIANT e on n.numE = e.numE
join COURS c on n.numC = c.numC
where n.notefinal = (
    select MAX(n2.notefinal)
    from NOTES n2 where n2.numC = n.numC );


-- R3
delete from NOTES
where numC = (select numC from COURS where nom = 'Web');

delete from COURS where nom = 'Web';


-- R4
update STATUT s
set statut = 'Validé' where s.annee = 2012 
and s.statut = 'En_cours'
and exists ( select 1 from NOTES n
    join COURS c on n.numC = c.numC
    where n.numE = s.numE and c.formation = s.formation
    group by n.numE
    having AVG(n.notefinal) > 10 and MIN(n.notefinal) >= 8 
    and COUNT(distinct n.numC) = (select COUNT(*) from COURS where formation = s.formation)
);

