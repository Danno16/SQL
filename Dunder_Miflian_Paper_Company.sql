/*--------------------------------------------------------------------------------------------------
								Step 1 - Create Employee Table
---------------------------------------------------------------------------------------------------*/

CREATE TABLE employee (
	emp_id 			INT PRIMARY KEY,
	first_name 		VARCHAR(40),
	last_name  		VARCHAR(40),
	birth_day 		DATE,
	sex 			VARCHAR(1),
	salary 			INT,
	super_id 		INT,
	branch_id 		INT
);

SELECT * FROM employee;
/*--------------------------------------------------------------------------------------------------
						Step 2 - Create branch Table - with FOREIGN KEY to Employee Table
---------------------------------------------------------------------------------------------------*/
CREATE TABLE branch (
	branch_id 		INT PRIMARY KEY,
    branch_name		VARCHAR(40),
    mgr_id 			INT,
    mgr_start_date	DATE,
    FOREIGN KEY 	(mgr_id)
	 REFERENCES 	employee(emp_id)
     ON DELETE SET NULL
)

SELECT * FROM branch;

/*--------------------------------------------------------------------------------------------------
							tep 3 - Alter Employee Table with FOREIGN KEYs
					We need to set the Foreign Key to the Employee Table since it points the the
                    branch table and we can only create this after we create the branch table.
---------------------------------------------------------------------------------------------------*/

ALTER TABLE 		employee
ADD FOREIGN KEY 	(branch_id) 
REFERENCES 			branch(branch_ID)
ON DELETE SET NULL;

ALTER TABLE 		employee
ADD FOREIGN KEY		(super_id)
REFERENCES			employee(emp_id)
ON DELETE SET NULL;

/*--------------------------------------------------------------------------------------------------
						Step 4 - Create Client Table - with FOREIGN KEY to Branch Table
---------------------------------------------------------------------------------------------------*/
CREATE TABLE client (
	client_id 			INT PRIMARY KEY,
    client_name 		VARCHAR(40),
    branch_id 			INT,
    FOREIGN KEY 		(branch_id)
		REFERENCES 		branch(branch_id)
        ON DELETE SET NULL
    );

/*--------------------------------------------------------------------------------------------------
								Step 5 - Create Works_With Table - 
				NOTE -  This has 2 primary keys with FOREIGN KEY to Employee and Client Tables
					    Since it has 2 primary keys, it has to be added as PRIMARY KEY
---------------------------------------------------------------------------------------------------*/
CREATE TABLE works_with (	
    emp_ID				INT,
    client_id 			INT,
    total_sales			INT,
    PRIMARY KEY			(emp_ID, client_id),
    FOREIGN KEY			(emp_ID)    REFERENCES 	employee(emp_id)  ON DELETE CASCADE,
    FOREIGN KEY			(client_id)	REFERENCES  client(client_id) ON DELETE CASCADE 
    );
    
SELECT * FROM works_with;
/*--------------------------------------------------------------------------------------------------
								Step 6 - Create Branch_Supplier Table - 
				NOTE -  This has 2 primary keys with FOREIGN KEY to Employee and Client Tables
					    Since it has 2 primary keys, it has to be added as PRIMARY KEY
---------------------------------------------------------------------------------------------------*/
CREATE TABLE branch_supplier (
	branch_id 			INT,
    supplier_name 		VARCHAR(40),
    supply_type 		VARCHAR(40),
    PRIMARY KEY			(branch_id, supplier_name),
    FOREIGN KEY			(branch_id)	
		REFERENCES  	branch(branch_id) 
        ON DELETE CASCADE 
    );
    
SELECT * FROM branch_supplier;

/*--------------------------------------------------------------------------------------------------
						Step 7 - Add Data to Tables - Employee and Branch
---------------------------------------------------------------------------------------------------*/    
    
INSERT INTO employee VALUES (100, 'David','Wallace','1967-11-17','M',250000, NULL, NULL); 
SELECT * FROM employee;
	/*Since there is a FOREIGN KEY to branch table, we have to leave branch_id 
			as null then we can add the branch ID after we enter a row in the branch table. 
---------------------------------------------------------------------------------------------------------- */
INSERT INTO branch VALUES(1,'CORPORATE', 100, '2006-02-09');
SELECT * FROM branch;
/*---------------------------------------------------------------------------------------------------------*/        
UPDATE employee SET branch_id = 1 where emp_id = 100;  /*	NOTE this is where we change the branch_ID to 1*/
SELECT * FROM employee;
/*---------------------------------------------------------------------------------------------------------*/  
INSERT INTO employee VALUES (101,'Jan','Levinson','1961-05-11','F', 110000, 100, 1);
SELECT * FROM employee;
/*---------------------------------------------------------------------------------------------------------*/  
INSERT INTO employee VALUES (102, 'Michael','Scott','1964-01-01','M',75000, NULL, NULL); 
INSERT INTO branch VALUES(2,'Scranton', 102, '1992-04-06');
SELECT * FROM employee;
/*---------------------------------------------------------------------------------------------------------*/ 
INSERT INTO branch VALUES(2,'Scranton', 102, '1992-04-06');
SELECT * FROM branch;
/*---------------------------------------------------------------------------------------------------------*/ 
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;
UPDATE employee SET super_id = 100 WHERE emp_id = 102;
SELECT * FROM employee;
/*---------------------------------------------------------------------------------------------------------*/ 
INSERT INTO employee VALUES (103,'Angela','Martin','1971-08-20','F', 63000, 102, 2);
INSERT INTO employee VALUES (104,'Kelly','Kapoor','1980-01-21','F', 55000, 102, 2);
INSERT INTO employee VALUES (105,'Stanley','Hudson','1958-03-17','M', 69000, 102, 2);
/*---------------------------------------------------------------------------------------------------------*/ 
INSERT INTO employee VALUES (106,'Josh','Porter','1969-02-10','M', 63000, 100, null);
SELECT * FROM employee;
UPDATE employee set salary = 78000 WHERE emp_id = 106;

/*---------------------------------------------------------------------------------------------------------*/
INSERT INTO branch VALUES(3,'Stanford', 106, '1998-02-13');
SELECT * FROM branch;

INSERT INTO branch values(4,'Buffalo', null, null);
 
/*---------------------------------------------------------------------------------------------------------*/
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;
SELECT * FROM employee;
/*---------------------------------------------------------------------------------------------------------*/
INSERT INTO employee VALUES (107,'Andy','Benard','1973-08-10','F', 65000, 106, 3);
INSERT INTO employee VALUES (108,'Jim','Helpart','1978-04-09','F', 71000, 106, 3);

/*--------------------------------------------------------------------------------------------------
						Step 7 - Add Data to Tables - Client
---------------------------------------------------------------------------------------------------*/ 
INSERT INTO client VALUES (400, 'Dunmore Highschool',2);
INSERT INTO client VALUES (401, 'Lakawana County',2);
INSERT INTO client VALUES (402, 'FedEx',3);
INSERT INTO client VALUES (403, 'John Daily Law, LLC',3);
INSERT INTO client VALUES (404, 'Scranton WhitePages',2);
INSERT INTO client VALUES (405, 'Times Newspaper',3);
INSERT INTO client VALUES (406, 'FedEx',2);
SELECT * FROM client;

/*--------------------------------------------------------------------------------------------------
						Step 8 - Add Data to Tables - Works Width
---------------------------------------------------------------------------------------------------*/ 
INSERT INTO works_with VALUES (105, 400, 55000);
INSERT INTO works_with VALUES (102, 401, 267000);
INSERT INTO works_with VALUES (108, 402, 22500);
INSERT INTO works_with VALUES (107, 403, 5000);
INSERT INTO works_with VALUES (108, 403, 12000);
INSERT INTO works_with VALUES (105, 404, 33000);
INSERT INTO works_with VALUES (107, 405, 26000);
INSERT INTO works_with VALUES (102, 406, 15000);
INSERT INTO works_with VALUES (105, 406, 130000);
SELECT * FROM works_with;

drop table works_with;

/*--------------------------------------------------------------------------------------------------
						Step 9 - Add Data to Tables - Branch Supplier
---------------------------------------------------------------------------------------------------*/ 
INSERT INTO branch_supplier VALUES (2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-Ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T. Forms and Lables', 'Custom Frames');
INSERT INTO branch_supplier VALUES (3, 'Uni-Ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stanford Lables', 'Custom Forms');
SELECT * FROM branch_supplier;

/*--------------------------------------------------------------------------------------------------
								Step 10 - Checking the Tables
---------------------------------------------------------------------------------------------------*/ 
SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;

/*--------------------------------------------------------------------------------------------------
									Step 11 - Queries
---------------------------------------------------------------------------------------------------*/ 
SELECT *										/* shows all employees by salary (decending)							*/
FROM employee
ORDER BY salary desc;

SELECT *										/* shows all employees by sex, first_name, last Name)							*/
FROM employee
ORDER BY sex, first_name, last_name;

SELECT first_name, last_name					/* shows all employees first and last name)							*/
FROM employee
ORDER BY first_name;

SELECT first_name AS FIRST, last_name AS LAST	/* shows all employees first and last name - change header name)							*/
FROM employee
ORDER BY first_name;

SELECT DISTINCT SEX								/*	GROUPS )							*/
FROM employee;

SELECT DISTINCT branch_id						/*	GROUPS )							*/
FROM employee;

/*--------------------------------------------------------------------------------------------------
									Step 12 - Functions
---------------------------------------------------------------------------------------------------*/ 
SELECT COUNT(emp_id)							/* Counts Employees						*/
FROM employee;

SELECT COUNT(super_id)							/* Counts Super_IDs						*/
FROM employee;

SELECT COUNT(emp_id)							/* Counts Females born after 1970		*/
FROM employee
WHERE  sex = 'F' and birth_day > '1970-01-01'; 

SELECT AVG(salary)								/* Finds Average Female Salary					*/
FROM employee
WHERE  sex = 'F';

SELECT AVG(salary)								/* Finds Average Male Salary					*/
FROM employee
WHERE  sex = 'M';

SELECT SUM(salary)								/* Finds Sum of all Salaries					*/
FROM employee;

SELECT COUNT(sex), sex							/*	Displays how many are in each group			*/			
FROM employee
GROUP BY sex;

SELECT emp_ID, SUM(total_sales)					/*	Shows Total Sales for each employee			*/
FROM works_with
GROUP BY emp_ID;

SELECT client_id, SUM(total_sales)				/*	Shows Total Sales for each employee			*/
FROM works_with
GROUP BY client_id;

/*--------------------------------------------------------------------------------------------------
			Step 13 - Using WildCards (% = Any Number of  Charcters; _ = one Character 
---------------------------------------------------------------------------------------------------*/ 
SELECT * 										/*	Finds all clients names with an LLC */
FROM client
WHERE client_name LIKE '%LLC';

SELECT *										/*  Find branch supplies that is in the lable business */
FROM branch_supplier							
WHERE supplier_name LIKE '%LABLES';	


SELECT *										/*  Find Employee born in August */
FROM employee									/* since the date format is yyyy-mm-dd we are using:   */
WHERE birth_day LIKE '____-08%';				/* we will use 4x _ (1 charactor),1x -,08 then wild card   */

SELECT * 										/*	Finds all clients names with an School */
FROM client
WHERE client_name LIKE '%school%';

/*--------------------------------------------------------------------------------------------------
									Step 14 - Using Unions 
			Union Rules 1 - 	When selecting from one table and union another table has to be 
								the same number of columns.alter
			Union Rules 2 - 	Have to have the same data type (cannot have INT with VARCHAR)
								
								
---------------------------------------------------------------------------------------------------*/ 
SELECT first_name     							/* 	Gets first name from employee Table			*/		
FROM employee;

SELECT branch_name								/* 	Gets Branch name from Branch Table			*/	
FROM branch;
/*---------------------------------------------------------------------------------------------------------*/
SELECT first_name     							/* 	Gets first name and branch all in one list		*/		
FROM employee
UNION
SELECT branch_name								
FROM branch;

/*---------------------------------------------------------------------------------------------------------*/
SELECT first_name     					/* 	Gets first name, branch, and client name all in one list		*/		
FROM employee
UNION
SELECT branch_name								
FROM branch
UNION
SELECT client_name								
FROM client;

/*---------------------------------------------------------------------------------------------------------*/

SELECT supplier_name					/*	Pretty much the same thing but with supplier and branch names */				
FROM branch_supplier
UNION
SELECT client_name								
FROM client;

/*---------------------------------------------------------------------------------------------------------*/

SELECT supplier_name, branch_id				/*	This will include the branchs they are associated with */				
FROM branch_supplier
UNION
SELECT client_name, branch_id								
FROM client;

/*---------------------------------------------------------------------------------------------------------*/

SELECT supplier_name, branch_supplier.branch_id				/* Same Query but easier to read*/				
FROM branch_supplier
UNION
SELECT client_name, client.branch_id								
FROM client;

/*---------------------------------------------------------------------------------------------------------*/
 SELECT sum(salary)											/* Quick summary of Income vs Expenses  		*/
 FROM employee
 UNION
 SELECT sum(total_sales)
 FROM works_with;
 
 /*--------------------------------------------------------------------------------------------------
									Step 15 - Joins
	 JOIN		 - inner join (when they have shared column in common).
	 LEFT JOIN	 - includes all record, even if there is no corosponding link from the FIRST TABLE idnetified.
	 RIGHT JOIN	 - includes all record, even if there is no corosponding linkfrom the SECOND TABLE  idnetified.
---------------------------------------------------------------------------------------------------*/ 
/*					Find the names of the branch managers		*/
SELECT 		employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM  		employee
JOIN 		branch
ON 			employee.emp_id = branch.mgr_id;
/*---------------------------------------------------------------------------------------------------------*/
/*					Finds all employees and if they are a branch manager bring in the branch	*/
SELECT 		employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM 		employee
LEFT JOIN  	branch
ON 			employee.emp_id = branch.mgr_id;  
/*---------------------------------------------------------------------------------------------------------*/
/*					Finds all mgr_ids and bring in the emp_id even if they did not match	*/
SELECT 		employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM 		employee
RIGHT JOIN 	branch
ON 			employee.emp_id = branch.mgr_id;  

/*---------------------------------------------------------------------------------------------------------*/
/*							Finds all employees and there branches	*/
SELECT 		employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM 		employee
LEFT JOIN  	branch
ON 			employee.branch_id = branch.branch_id;
/*---------------------------------------------------------------------------------------------------------*/
/*							Show all employees and there managers				*/
SELECT		employee.emp_id, employee.first_name, employee.last_name;
/*---------------------------------------------------------------------------------------------------------*/
/*					By employee show their salary vs sales		*/
SELECT 		employee.emp_id, employee.first_name, employee.last_name, 
			employee.salary, works_with.total_sales
FROM    	employee
JOIN    	works_with
ON 			employee.emp_id = works_with.emp_ID;       

 /*--------------------------------------------------------------------------------------------------
									Step 16 - Nested Queries (Multiple Queries)
---------------------------------------------------------------------------------------------------*/ 

/*		  Find all employees that sold over 30,000 to a single client with employees name - using JOIN  */
SELECT		works_with.emp_ID, works_with.total_sales, employee.first_name, employee.last_name
FROM		works_with
JOIN    	employee
ON			works_with.emp_id = employee.emp_id		
WHERE		works_with.total_sales > 30000;	

/*		      Find all employees that sold over 30,000 to a single client with employees name - using NESTED   */
SELECT		employee.first_name, employee.last_name
FROM		employee
WHERE		employee.emp_id IN (
			SELECT works_with.emp_id
            FROM works_with
            WHERE works_with.total_sales > 30000
            );

/*		      find all clients who are handled by the branch that Michael scott manages   */
SELECT		client.client_name
FROM		client
WHERE 		client.branch_id =	(
	SELECT		branch.branch_id
	FROM		branch
	WHERE		branch.mgr_id = 102
    LIMIT		1	
);

/*--------------------------------------------------------------------------------------------------
									Step 17 - ON DELETE AND CASCADE
	ON DELETE SET NULL - When you do a link, if there is no corosponding element it is going to set to null but
		WILL BRING IN AS MUCH INFORMATION AS IT CAN.
    ON DELETE CASCADE - When you do a link, if there is no corosponding element it's going to 
			DELETE THE ENTIRE ROW IN THE DATABASE
            
    ON DELETE SET NULL - is okay to use when it' just a FOREIGN KEY.
    
    ON DELETE CASTCADE - is what we use when it's a PRIMARY/FOREIGN KEY.  So it cannot have a null 
						 value which is what ON DELETE SET NULL does.
            
---------------------------------------------------------------------------------------------------*/ 
/* Okay lets give an example.  When we created the branch table, you will notice that when set the 
	 FOREIGN KEY we included  - ON DELETE SET NULL 

CREATE TABLE branch (
	branch_id 		INT PRIMARY KEY,
    branch_name		VARCHAR(40),
    mgr_id 			INT,
    mgr_start_date	DATE,
    FOREIGN KEY 	(mgr_id)
	 REFERENCES 	employee(emp_id)
     ON DELETE SET NULL
)

So if we delete Michael Scott (emp_id = 102) the fields that includes Michael Scott will be null

Lets look at the before - SELECT * FROM employee;
	100		David		Wallace		967-11-17	M	250000		1
	101		Jan			Levinson	1961-05-11	F	110000	100	1
	102		Michael		Scott		1964-01-01	M	75000	100	2
	103		Angela		Martin		1971-08-20	F	63000	102	2
	104		Kelly		Kapoor		1980-01-21	F	55000	102	2
	105		Stanley		Hudson		1958-03-17	M	69000	102	2
	106		Josh		Porter		1969-02-10	M	78000	100	3
	107		Andy		Benard		1973-08-10	M	65000	106	3
	108		Jim			Helpart		1978-04-09	M	71000	106	3
	
Now we'll delete michael scott (emp_id = 102) */

delete from employee
WHERE emp_id = 102;


 /*	Now if we look at the Branch table you will see the Scranton now shows null.  Because we delete emp_id (102)
	which was pointed to branch id (2) - we used the FOREIGN KEY	*/

SELECT * FROM branch;
/*		1	CORPORATE	100		2006-02-09
		2	Scranton	null	1992-04-06
		3	Stanford	106		1998-02-13
		4	Buffalo		
        
 And if you look at the Employee Table you will see what was Super_ID = 102 is now null.       
*/
SELECT * FROM employee;
/*	100		David	Wallace		1967-11-17	M	250000	null			1
	101		Jan		Levinson	1961-05-11	F	110000	100				1
	103		Angela	Martin		1971-08-20	F	63000	null(was 102)	2
	104		Kelly	Kapoor		1980-01-21	F	55000	null(was 102)	2
	105		Stanley	Hudson		1958-03-17	M	69000	null(was 102)	2
	106		Josh	Porter		1969-02-10	M	78000	100				3
	107		Andy	Benard		1973-08-10	M	65000	106				3
	108		Jim		Helpart		1978-04-09	M	71000	106				3  
    
								
Now let's try the branch supplier since it has ON DELETE CASCADE.  So we'll try and delete branch supply 2
CREATE TABLE branch_supplier (
	branch_id 			INT,
    supplier_name 		VARCHAR(40),
    supply_type 		VARCHAR(40),
    PRIMARY KEY			(branch_id, supplier_name),
    FOREIGN KEY			(branch_id)	
		REFERENCES  	branch(branch_id) 
        ON DELETE CASCADE 
    );
 So we'll try and delete branch supply 2.
 
 Before the change:*/
 SELECT * FROM branch_supplier;
 /*		2	Hammer Mill				Paper
		2	J.T. Forms and Lables	Custom Frames
		2	Uni-Ball				Writing Utensils
		3	Hammer Mill				Paper
		3	Patriot Paper			Paper
		3	Stanford Lables	Custom 	Forms
		3	Uni-Ball				Writing Utensils
		
 Now we'll delete branch id 2							*/       
 DELETE FROM branch_supplier
 WHERE branch_id = 2;
 /* 		Now Lets take a look
		3	Hammer Mill				Paper
		3	Patriot Paper			Paper
		3	Stanford Lables	Custom 	Forms
		3	Uni-Ball	Writing 	Utensils

Notice it deletes the whole record - So, ON DELETE CASCADE  is used when it is a PRIMARY KEY.

Now lets rebuild the records

First thing I did was to Delete the branch_supplier table and REBUILD it, then ran the INSERT INTO records (above).

Then I did updates on the given records in employee table
*/
update employee set super_id = 100 where emp_id = 102; 
update employee set super_id = 102 where emp_id = 103; 
update employee set super_id = 102 where emp_id = 104; 
update employee set super_id = 102 where emp_id = 105; 
select * from employee;

/*--------------------------------------------------------------------------------------------------
									Step 18 - Triggers
       A trigger is a block of code that will define a certain action that should be preformed when
       a certain operation gets preformed on the database.
  
---------------------------------------------------------------------------------------------------*/ 
	

        