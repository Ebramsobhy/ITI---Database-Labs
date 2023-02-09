                 /* Database Labs */

/* 1- Insert your personal data to the employee table as a new employee in department number 30,
   SSN = 102672, Superssn = 112233. */

insert into employee(SSN, Fname, Lname, Bdate, Address, Gender, Salary, SuperSSN, DNO)
value (102672,'Ebram', 'Sobhy', '1997-04-01', 'Mallawi', 'M', 1000, 112233, 30);

/* 2- Insert another employee with your friend personal data as new employee
   in department number 30, SSN = 102660, but don’t enter any value for salary
   or supervisor number to him but fill all other fields with dummy data. */

insert into employee(SSN, Fname, Lname, Bdate, Address, Gender, DNO)
value (102660, 'Osama', 'Ahmed', '1990-07-10', 'Cairo', 'M',30);

/* 3- In the department table insert new department called "DEPT IT", with id 100,
   employee with SSN = 112233 as a manager for this department. The start date
   for this manager is '1-11-2006' */

insert into departments(Dname, Dnum, MGRSSN, MGRSatrtDate)
value ('DEPT IT', 100, 112233, '2006-11-01');

/* 4- Do what is required if you know that: Mrs.Noha Mohamed(SSN=968574) moved 
   to be the manager of the new department (id = 100), and they give you (use your 
   SSN from question1) her position (Dept. 20 manager) :

   a. First try to update her record in the department table
   b. Update your record to be department 20 manager.
   c. Update your friend data (entered in question2) to be in your teamwork(supervised by you) */

update departments 
set MGRSSN=968574
where Dnum=100;

update departments
set MGRSSN=112233
where Dnum=20;

update employee 
set  SuperSSN =112233 
where SSN=102660;

/* 5- Unfortunately, the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
      so try to delete his data from your database in case you know that your
      friend (SSN entered in question2) will be temporarily in his position.
      Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees
      or works in any projects and handle these cases) */

delete from employee
where SSN=223344;

delete from dependent
where ESSN=223344;

update employee
set SuperSSN=102660
where SuperSSN=223344;

update departments
set MGRSSN=102660
where MGRSSN=223344;

update works_for
set Essn=102660
where Essn=223344;

/* 6- And your salary has been upgraded by 20 percent of its last value. */
update employee
set Salary=Salary*20/100
where SSN=102672;

/* 7- Display all the employees Data. */
select * from employee;

/* 8- Display the employee First name, last name, Salary and Department number. */
select Fname, Lname, Salary, DNO
from employee;

/* 9- Display all the projects names, locations and the department which is responsible about it. */
select Pname, Plocation, Dnum
from project;

/* 10- If you know that the company policy is to pay an annual commission for each employee with specific
       percent equals 10% of his/her annual salary. Display each employee full name (Full name as one column)
       and his annual commission as ANNUAL COMM column (alias). */
select concat(Fname ,' ',Lname) as FullName, (salary*12)*0.1  as ANNUAL 
from employee;

/* 11- Display the employees Id, name who earns more than 1000 LE monthly. */
select SSN, Fname, Lname
from employee
where Salary >= 1000;

/* 12- Display the employees Id, name who earns more than 10000 LE annually. */
select SSN, Fname, Lname
from employee
where Salary*12 >= 10000;

/* 13- Display the names and salaries of the female employees  */
select Fname, Lname, Salary
from employee
where Gender='F';

/* 14- Display each department id, name which managed by a manager with id equals 968574 */ 
select Dnum, Dname
from departments 
where MGRSSN=968574;

/* 15- Display the IDs, names and locations of the pojects which controlled with department 10. */ 
select Pnumber, Pname, Plocation
from project
where Dnum = 10;

/* 16- Display the Department id, name and id and the name of its manager */
select d.Dnum,d.Dname,e.Fname
from departments d,employee e
where d.MGRSSN = e.SSN;

/* 17- Display the name of the departments and the name of the projects under its control. */
select d.Dname,p.Pname
from departments d,project p
where d.Dnum = p.Dnum;

/* 18- Display the full data about all the dependence associated with the name of the
   employee they depend on him/her. */
select d.*,e.Fname
from dependent d , employee e
where e.SSN = d.ESSN;

/* 19- Display (Using Union Function)
        a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
        b. And the male dependence that depends on Male Employee */

select d.*,e.Fname,e.Gender
from dependent d , employee e
where e.SSN = d.ESSN 
and d.Sex = 'F'
and e.Gender = 'F'
union
select d.*,e.Fname,e.Gender
from dependent d , employee e
where e.SSN = d.ESSN 
and d.Sex = 'M'
and e.Gender = 'M';        

/* 20- Display the Id, name and location of the projects in Cairo or Alex city. */
select Pnumber,Pname,Plocation 
from project 
where City IN ('Cairo','Alex');

/* 21- Display the Projects full data of the projects with a name starts with "a" letter. */ 
select * 
from project
where Pname like 'a%';

/* 22- display all the employees in department 30 whose salary from 1000 to 2000 LE monthly */
select * from employee
where DNO=30
and Salary between 1000 and 2000;

/* 23- Retrieve the names of all employees in department 10 who works more than or equal 10 hours.
       per week on "AL Rabwah" project */
select e.Fname , w.hours , p.Pname
from employee e, works_for w,project p
where e.SSN = w.Essn
AND p.Pnumber = w.Pno
AND p.Pname = 'AL Rabwah'
AND e.DNO = 10 AND w.hours>=10;       

/* 24- Find the names of the employees who directly supervised with Kamel Mohamed. */
select e.Fname,s.Fname
from employee e , employee s
where e.SSN = e.SuperSSN
AND s.Fname = 'Kamel Mohamed';

/* 25- For each project, list the project name and the total hours per week (for all employees)
       spent on that project. */
select  p.Pname , e.Fname , sum(hours)
from project p, employee e, works_for w
where e.SSN = w.Essn
and p.Pnumber = w.Pno
group by p.Pname,e.Fname;

/* 26- Retrieve the names of all employees and the names of the projects they are working on,
       sorted by the project name. */
select  p.Pname , e.Fname
from project p, employee e, works_for w
where e.SSN = w.Essn
and p.Pnumber = w.Pno
order by p.Pname;

/* 27- Display the data of the department which has the smallest employee ID over all employees' ID. */ 
select * from departments 
inner join employee 
on (departments.Dnum = employee.DNO)
having min(employee.SSN);

/* 28- For each department, retrieve the department name and the maximum, minimum and
       average salary of its employees. */
select Dname, Min(employee.Salary) as min ,
Max(employee.Salary) as max,
avg(employee.Salary) as avg
from departments inner join employee
on(departments.Dnum = employee.DNO)
group by Dname;

/* 29- List the last name of all managers who have no dependents */ 
select Fname,Lname from employee
inner join departments
on(employee.SSN = departments.MGRSSN)
where employee.SSN not in (select ESSN from dependent);

/* 30- For each department-- if its average salary is less than the average salary of all employees--
       display its number, name and number of its employees. */
select Dnum, Fname , count(SSN), avg(Salary) 
from employee inner join departments
on (employee.DNO = departments.Dnum)
group by Dnum
having avg(Salary) < (select avg(salary) from employee);

/* 31- Retrieve a list of employees and the projects they are working on ordered by department
       and within each department, ordered alphabetically by last name, first name. */
select d.Dname,e.Lname,e.Fname,p.Pname
from departments d, employee e, works_for w, project p
where d.Dnum=e.DNO and e.SSN=w.Essn and w.Pno=p.Pnumber
order by dname,lname,fname;

/* 32- For each project located in Cairo City, find the project number, the controlling department name,
       the department manager last name, address and birthdate. */
select p.Pnumber,d.Dname,e.Lname,e.Address,e.Bdate 
from project p, departments d, employee e
where p.Dnum = d.Dnum 
and e.SSN = d.MGRSSN
and p.City='Cairo';
       